---
description: Manage database migrations safely
allowed-tools: Bash(node:*, npm:*), Read, Write
---

# Database Migration Management

Manage migrations: $ARGUMENTS (up, down, create, status)

## Migration Commands

### Create New Migration

```bash
/migrate create add_users_table

# Generates:
migrations/
└── 20241015120000_add_users_table.sql

# With content:
-- Migration: add_users_table
-- Created: 2024-10-15 12:00:00

-- Up Migration
CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  username VARCHAR(255) UNIQUE NOT NULL,
  email VARCHAR(255) UNIQUE NOT NULL,
  created_at TIMESTAMP DEFAULT NOW()
);

CREATE INDEX idx_users_email ON users(email);

-- Down Migration (Rollback)
DROP INDEX IF EXISTS idx_users_email;
DROP TABLE IF EXISTS users;
```

### Run Migrations (Up)

```bash
/migrate up

# Process:
🔍 Checking migration status...
📊 Pending migrations: 3

Migration 1/3: add_users_table
  ✅ Creating users table... Done (45ms)
  ✅ Creating index... Done (12ms)
  ✅ Migration applied successfully

Migration 2/3: add_orders_table
  ✅ Creating orders table... Done (38ms)
  ✅ Adding foreign keys... Done (15ms)
  ✅ Migration applied successfully

Migration 3/3: add_email_verification
  ✅ Adding email_verified column... Done (8ms)
  ✅ Setting default values... Done (125ms)
  ✅ Migration applied successfully

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
✅ All migrations applied successfully!
   Total time: 243ms
   Migrations run: 3
```

### Rollback Migrations (Down)

```bash
/migrate down

# With confirmation:
⚠️  WARNING: Rolling back migration
   Migration: add_email_verification
   This will:
   - Drop email_verified column
   - Remove verification logic

   Data loss possible!

Confirm rollback? (yes/no): yes

Rolling back...
  ✅ Dropping column... Done
  ✅ Rollback complete

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
✅ Rolled back 1 migration

# Rollback specific number
/migrate down 2  # Rollback last 2 migrations
```

### Check Migration Status

```bash
/migrate status

# Output:
Migration Status:
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

✅ Applied (5):
  1. 20241001120000_add_users_table
  2. 20241002140000_add_orders_table
  3. 20241003100000_add_products_table
  4. 20241010093000_add_inventory_table
  5. 20241015120000_add_email_verification

⏳ Pending (2):
  6. 20241016150000_add_payment_methods
  7. 20241017110000_add_shipping_addresses

Last migration: 2024-10-15 12:00:00
Database version: 5
```

## Safe Migration Practices

### Pre-Migration Checks

```
Safety Checklist:
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

✅ Database backup created
✅ Migration tested in development
✅ Rollback plan prepared
✅ No active connections (or acceptable downtime)
⚠️  Large table modification (may take time)
✅ Indexes will be created concurrently
✅ No breaking changes to existing data

Estimated migration time: 2-5 minutes
Proceed? (y/n)
```

### Backup Before Migration

```bash
/migrate up --with-backup

# Creates backup first:
Creating backup...
✅ Backup created: backups/db_backup_20241015_120000.sql
✅ Backup verified (152MB, 1.2M rows)

Proceeding with migration...
```

### Dry Run

```bash
/migrate up --dry-run

# Shows what would happen:
Dry Run Mode - No changes will be made
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Would apply 3 migrations:

1. add_users_table
   - CREATE TABLE users (...)
   - CREATE INDEX idx_users_email
   Estimated time: ~50ms

2. add_orders_table
   - CREATE TABLE orders (...)
   - ALTER TABLE orders ADD CONSTRAINT fk_user
   Estimated time: ~40ms

3. add_email_verification
   - ALTER TABLE users ADD COLUMN email_verified
   - UPDATE users SET email_verified = false
   Estimated time: ~2-5min (50k rows to update)

Total estimated time: 2-5 minutes
```

## Migration Patterns

### Adding Column (Safe)

```sql
-- ✅ Safe - No downtime
ALTER TABLE users
ADD COLUMN phone VARCHAR(20);

-- Set default for existing rows
UPDATE users SET phone = '' WHERE phone IS NULL;
```

### Removing Column (Careful)

```sql
-- ⚠️  Careful - Two-step process

-- Step 1: Make column nullable (if not already)
ALTER TABLE users
ALTER COLUMN old_column DROP NOT NULL;

-- Step 2: In next migration, drop column
ALTER TABLE users
DROP COLUMN old_column;

-- Why two steps? Allows time to verify nothing breaks
```

### Renaming Column (Tricky)

```sql
-- ❌ Don't do this (breaks app immediately):
ALTER TABLE users
RENAME COLUMN old_name TO new_name;

-- ✅ Do this (gradual migration):

-- Migration 1: Add new column
ALTER TABLE users ADD COLUMN new_name VARCHAR(255);
UPDATE users SET new_name = old_name;

-- Deploy code that writes to both columns

-- Migration 2: After verification, drop old column
ALTER TABLE users DROP COLUMN old_name;
```

### Adding Index (Smart)

```sql
-- ❌ Blocks table (bad for production):
CREATE INDEX idx_users_email ON users(email);

-- ✅ Non-blocking (PostgreSQL):
CREATE INDEX CONCURRENTLY idx_users_email ON users(email);

-- ✅ With condition (partial index):
CREATE INDEX CONCURRENTLY idx_active_users
ON users(email) WHERE active = true;
```

## Zero-Downtime Migrations

### Strategy

```
Phase 1: Make changes backwards-compatible
  - Add new columns
  - Write to both old and new

Phase 2: Deploy app code
  - Start reading from new columns
  - Still writing to both

Phase 3: Data migration
  - Copy old data to new columns
  - Verify integrity

Phase 4: Cleanup
  - Stop writing to old columns
  - Remove old columns
```

### Example: Splitting Name Column

```sql
-- Migration 1: Add new columns
ALTER TABLE users ADD COLUMN first_name VARCHAR(100);
ALTER TABLE users ADD COLUMN last_name VARCHAR(100);

-- Populate from existing full_name
UPDATE users
SET first_name = SPLIT_PART(full_name, ' ', 1),
    last_name = SPLIT_PART(full_name, ' ', 2);

-- Deploy code using new columns

-- Migration 2 (after verification): Drop old column
ALTER TABLE users DROP COLUMN full_name;
```

## Advanced Features

### Migration Dependencies

```sql
-- migrations/config.json
{
  "migrations": [
    {
      "name": "add_orders_table",
      "depends_on": ["add_users_table", "add_products_table"]
    }
  ]
}

-- Ensures users and products exist before creating orders
```

### Data Migrations

```sql
-- Not just schema, but data transformation:

-- Migration: normalize_emails
UPDATE users
SET email = LOWER(TRIM(email))
WHERE email != LOWER(TRIM(email));

-- Add constraint to prevent denormalized data
ALTER TABLE users
ADD CONSTRAINT email_normalized
CHECK (email = LOWER(TRIM(email)));
```

### Testing Migrations

```bash
# Test in transaction (rollback after)
/migrate up --test

# Process:
BEGIN TRANSACTION;
  -- Run migration
  -- Verify results
  -- Run test queries
ROLLBACK;

# Reports success/failure without committing
```

## Troubleshooting

### Migration Failed

```
Migration Error:
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Migration: add_email_verification
Step: ALTER TABLE users ADD COLUMN email_verified
Error: column "email_verified" already exists

Status: ❌ FAILED (rolled back)

Resolution:
1. Check if migration partially applied
2. Manual verification: SELECT * FROM users LIMIT 1;
3. Mark as applied if column exists:
   /migrate mark-applied add_email_verification
4. Or fix and retry: /migrate up
```

### Stuck Migration

```bash
# Check locks
/migrate check-locks

# Kill blocking queries (with caution)
/migrate kill-locks

# Force unlock (dangerous!)
/migrate unlock --force
```
