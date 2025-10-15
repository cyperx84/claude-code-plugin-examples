---
description: Synchronize files between local and cloud storage
---

# Sync Storage

Sync: $ARGUMENTS (source and destination)

**Using AWS S3 MCP for synchronization**

## Sync Strategies

### 1. Local to Cloud (Backup)
```bash
# One-way sync (upload only)
aws s3 sync ./local s3://bucket/remote

# Two-way sync (bidirectional)
aws s3 sync ./local s3://bucket/remote
aws s3 sync s3://bucket/remote ./local

# With dry-run
aws s3 sync ./local s3://bucket/remote --dryrun
```

### 2. Cloud to Local (Restore)
```bash
# Download all
aws s3 sync s3://bucket/backup ./restore

# Specific files
aws s3 sync s3://bucket/backup ./restore --exclude "*" --include "*.sql"

# Resume interrupted download
aws s3 sync s3://bucket/large-files ./downloads
```

### 3. Intelligent Sync
```bash
# Only newer files
aws s3 sync ./local s3://bucket/remote --size-only

# Include/exclude patterns
aws s3 sync ./project s3://bucket/backup \
  --exclude ".git/*" \
  --exclude "node_modules/*" \
  --exclude "*.log" \
  --exclude "*.tmp" \
  --include "*.env.production"

# Delete removed files
aws s3 sync ./local s3://bucket/remote --delete
```

### 4. Scheduled Sync
```bash
# Cron job for daily backup
0 2 * * * /path/to/plugin sync ./data s3://bucket/daily-backup-$(date +\%Y\%m\%d)

# Hourly incremental
0 * * * * /path/to/plugin sync ./logs s3://bucket/logs/$(date +\%Y\%m\%d\%H)
```

## Example Usage

```bash
# Backup website
/sync ./website/ s3://my-bucket/website-backup/

# Restore backup
/sync s3://my-bucket/backup/ ./restore/

# Continuous sync
/sync ./documents/ s3://my-bucket/docs/ --watch --interval 300

# With filters
/sync ./project/ s3://my-bucket/code/ --exclude "node_modules,*.log"
```

**Pattern Demonstrated:** Data Synchronization, Backup/Restore, Incremental Updates
