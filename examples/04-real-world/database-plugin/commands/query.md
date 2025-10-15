---
description: Execute SQL queries with AI assistance and optimization
---

# Smart Database Query

Execute query: $ARGUMENTS

## Using PostgreSQL MCP

### 1. Query Understanding

Parse and analyze the query request:
- **Natural Language:** "Show me all users who signed up last month"
- **SQL Query:** `SELECT * FROM users WHERE created_at > '2024-09-01'`
- **Query Type:** SELECT, INSERT, UPDATE, DELETE, CREATE, ALTER

### 2. Safety Checks

**Before Execution:**
```
Safety Analysis:
✅ READ query - Safe to execute
⚠️  UPDATE without WHERE - DANGEROUS! Add confirmation
⚠️  DELETE without WHERE - DANGEROUS! Require explicit confirmation
⚠️  DROP TABLE - CRITICAL! Require double confirmation
⚠️  TRUNCATE - WARNING! Data loss, confirm
```

**Confirmations Required:**
- Any DELETE/UPDATE without WHERE clause
- DROP/TRUNCATE operations
- Schema changes (ALTER)
- Production database operations

### 3. Query Optimization

**EXPLAIN Analysis:**
```sql
-- Auto-run EXPLAIN before executing
EXPLAIN ANALYZE
SELECT * FROM users WHERE email LIKE '%@gmail.com';

-- Show execution plan:
Seq Scan on users  (cost=0.00..1234.56 rows=5000 width=100)
  Filter: (email ~~ '%@gmail.com'::text)
  Rows Removed by Filter: 45000

⚠️  Warning: Sequential scan detected!
Recommendation: Add index on email column
```

**Optimization Suggestions:**
```sql
-- ❌ Inefficient:
SELECT * FROM users WHERE email LIKE '%@gmail.com';
-- Sequential scan, checks all 50,000 rows

-- ✅ Better:
CREATE INDEX idx_users_email ON users(email);
SELECT * FROM users WHERE email LIKE '@gmail.com%';
-- Index scan, faster lookup

-- ✅ Even Better (if exact match):
SELECT * FROM users WHERE email = 'user@gmail.com';
-- Index seek, optimal
```

### 4. Execute Query

**Via PostgreSQL MCP:**
```javascript
// Execute through MCP
const result = await postgres.query(optimizedQuery);

// Return results
{
  rows: [...],
  rowCount: 42,
  executionTime: "125ms",
  fromCache: false
}
```

### 5. Format Results

**Table Format:**
```
┌──────┬─────────────┬───────────────────────┬────────────────────┐
│ id   │ username    │ email                 │ created_at         │
├──────┼─────────────┼───────────────────────┼────────────────────┤
│ 1    │ alice       │ alice@example.com     │ 2024-09-15 10:30   │
│ 2    │ bob         │ bob@example.com       │ 2024-09-16 14:22   │
│ 3    │ charlie     │ charlie@example.com   │ 2024-09-17 09:15   │
└──────┴─────────────┴───────────────────────┴────────────────────┘

Showing 3 of 42 rows (limited for display)
Query executed in: 125ms
```

**JSON Format:**
```json
{
  "data": [
    {"id": 1, "username": "alice", "email": "alice@example.com"},
    {"id": 2, "username": "bob", "email": "bob@example.com"}
  ],
  "meta": {
    "rowCount": 42,
    "executionTime": "125ms",
    "cached": false
  }
}
```

## Natural Language to SQL

**Examples:**

```
You: "Show me users who joined last month"

Generated SQL:
SELECT * FROM users
WHERE created_at >= DATE_TRUNC('month', CURRENT_DATE - INTERVAL '1 month')
  AND created_at < DATE_TRUNC('month', CURRENT_DATE);

You: "Count orders by status"

Generated SQL:
SELECT status, COUNT(*) as count
FROM orders
GROUP BY status
ORDER BY count DESC;

You: "Find top 10 customers by revenue"

Generated SQL:
SELECT
  c.id,
  c.name,
  SUM(o.total) as total_revenue
FROM customers c
JOIN orders o ON c.id = o.customer_id
GROUP BY c.id, c.name
ORDER BY total_revenue DESC
LIMIT 10;
```

## Query History

Track recent queries:
```
Recent Queries:
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

1. [2m ago] SELECT * FROM users WHERE... (125ms, 42 rows)
2. [5m ago] UPDATE orders SET status... (89ms, 5 rows)
3. [10m ago] SELECT COUNT(*) FROM... (45ms, 1 row)

Use /query history 1 to re-run query #1
```

## Example Usage

```bash
# Natural language
/query "show me all users"
/query "count orders by status"

# SQL directly
/query "SELECT * FROM users LIMIT 10"

# With explanation
/query "SELECT * FROM users WHERE created_at > NOW() - INTERVAL '7 days'" --explain

# Export results
/query "SELECT * FROM orders" --export csv

# Dry run (EXPLAIN only)
/query "SELECT * FROM users" --dry-run
```

## Advanced Features

### Query Building

Interactive query builder:
```
You: /query builder

Claude: Let's build a query. Which table?
You: users

Claude: What columns? (or 'all' for *)
You: id, email, created_at

Claude: Any WHERE conditions?
You: created_at > '2024-01-01'

Claude: ORDER BY?
You: created_at DESC

Claude: LIMIT?
You: 10

Generated:
SELECT id, email, created_at
FROM users
WHERE created_at > '2024-01-01'
ORDER BY created_at DESC
LIMIT 10;

Execute? (y/n)
```

### Performance Analysis

```
Query Performance Report:
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Execution Time: 125ms
Rows Examined: 50,000
Rows Returned: 42
Efficiency: 0.08% ⚠️  (very low)

Bottlenecks:
1. Sequential scan on users table
2. No index on email column
3. Full table scan required

Recommendations:
1. CREATE INDEX idx_users_email ON users(email);
   Estimated improvement: 95% faster

2. Add WHERE clause to limit rows if possible
   Current: All 50,000 rows scanned

3. Consider partitioning users table if > 1M rows
```

### Query Templates

Save and reuse:
```bash
# Save query as template
/query "SELECT * FROM users WHERE status = ?" --save active-users

# Use template
/query template active-users --params "active"

# List templates
/query templates
```
