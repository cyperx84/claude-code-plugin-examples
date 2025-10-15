# Cloud Storage Plugin ☁️

**Version:** 1.0.0
**Complexity:** ⭐⭐⭐ Intermediate/Advanced
**MCP Integration:** AWS S3

Cloud storage management plugin using AWS S3 MCP for uploads, backups, synchronization, and file operations.

---

## 📋 Overview

Comprehensive cloud storage management with AWS S3 integration for file operations, automated backups, intelligent synchronization, and cost optimization.

### Components

- **3 Commands:** upload, sync, manage
- **1 Agent:** Storage Optimizer (proactive cost & performance optimization)
- **1 MCP Server:** AWS S3 (cloud storage)

### Key Features

✅ **File Operations** - Upload, download, copy, move, delete
✅ **Directory Sync** - Bidirectional synchronization
✅ **Automated Backups** - Scheduled backups with retention
✅ **Cost Optimization** - Storage class selection, lifecycle policies
✅ **Security** - Encryption, access control, versioning
✅ **Performance** - Multipart uploads, compression, CDN integration
✅ **Organization** - Logical structure, naming conventions

---

## 🚀 Installation

### 1. Install Plugin

```bash
/plugin marketplace add ./examples/marketplaces/real-world-marketplace
/plugin install cloud-storage@real-world-examples
```

### 2. AWS Setup

**Create IAM User:**
1. Go to AWS Console → IAM → Users
2. Create user with programmatic access
3. Attach policy: `AmazonS3FullAccess` (or custom policy)
4. Save Access Key ID and Secret Access Key

**Create S3 Bucket:**
```bash
aws s3 mb s3://my-app-storage --region us-east-1
```

### 3. Configure Credentials

```bash
export AWS_ACCESS_KEY_ID="AKIA..."
export AWS_SECRET_ACCESS_KEY="..."
export AWS_REGION="us-east-1"
```

### 4. Verify Installation

```bash
/manage list-buckets
# Should show your S3 buckets
```

---

## 📚 Commands

### 1. `/upload [source] [destination]` - Upload Files

```bash
# Single file
/upload ./report.pdf s3://my-bucket/reports/

# Directory
/upload ./website/ s3://my-bucket/website/ --sync

# Compressed backup
/upload ./database/ s3://my-bucket/backups/ --compress

# Encrypted
/upload ./sensitive/ s3://my-bucket/secure/ --encrypt

# Public file
/upload ./logo.png s3://my-bucket/assets/ --public
```

### 2. `/sync [source] [destination]` - Sync Storage

```bash
# Backup (local → cloud)
/sync ./documents/ s3://my-bucket/docs-backup/

# Restore (cloud → local)
/sync s3://my-bucket/backup/ ./restore/

# Continuous sync
/sync ./data/ s3://my-bucket/data/ --watch

# With filters
/sync ./project/ s3://my-bucket/code/ --exclude "node_modules,*.log"
```

### 3. `/manage [operation]` - Manage Storage

```bash
# List operations
/manage list s3://my-bucket/
/manage size s3://my-bucket/

# File operations
/manage copy s3://bucket1/file s3://bucket2/file
/manage move s3://bucket/old s3://bucket/new
/manage delete s3://bucket/file

# Permissions
/manage public s3://bucket/image.jpg
/manage private s3://bucket/sensitive.doc

# Lifecycle
/manage lifecycle s3://bucket/ --archive-after 30
/manage versioning s3://bucket/ --enable
```

---

## 🤖 Agent: Storage Optimizer

Proactive agent that optimizes storage costs and performance.

**Auto-optimization:**
- Suggests compression for large uploads
- Recommends storage class transitions
- Identifies duplicate files
- Alerts on cost increases
- Optimizes access patterns

```bash
/agent storage-optimizer
# "How can I reduce my S3 costs?"
# "What's the best way to organize my backups?"
```

---

## 🎯 Use Cases

### 1. Website Hosting
```bash
# Deploy website
/upload ./dist/ s3://my-website/ --sync --public

# With CDN
/manage cdn s3://my-website/ --enable
```

### 2. Database Backups
```bash
# Daily backups
/upload ./db-dump.sql s3://backups/daily/$(date +%Y%m%d).sql --compress

# Automated (cron)
0 2 * * * /path/to/plugin upload /var/backups/ s3://backups/daily/
```

### 3. File Storage Service
```bash
# User uploads
/upload ./uploads/ s3://user-files/$(user-id)/ --encrypt

# Public assets
/upload ./public/images/ s3://cdn-assets/ --public --cache
```

### 4. Log Archival
```bash
# Archive old logs
/sync ./logs/ s3://log-archive/ --exclude "*.gz"
/manage lifecycle s3://log-archive/ --glacier-after 30 --delete-after 90
```

---

## 🛡️ Best Practices

### Security
- Enable encryption (server-side or client-side)
- Use IAM roles, not public access
- Enable versioning for important data
- Regular access audits

### Cost Optimization
- Use appropriate storage classes
- Implement lifecycle policies
- Enable compression
- Delete old/unused files
- Monitor storage growth

### Performance
- Use multipart for large files
- Enable CDN for static assets
- Compress before upload
- Organize with logical prefixes

---

## 🐛 Troubleshooting

### Issue: Access Denied
**Solution:** Check IAM permissions, bucket policy, and credentials

### Issue: Slow Uploads
**Solution:** Use multipart uploads, check network, enable compression

### Issue: High Costs
**Solution:** Run storage optimizer, implement lifecycle policies

---

## 📊 Storage Classes

| Class | Use Case | Cost | Retrieval |
|-------|----------|------|-----------|
| STANDARD | Frequent access | High | Instant |
| STANDARD_IA | Infrequent access | Medium | Instant |
| GLACIER | Archive | Low | Minutes-hours |
| DEEP_ARCHIVE | Long-term archive | Lowest | 12+ hours |

---

**Pattern Demonstrated:** Cloud Storage, Backup Automation, Cost Optimization, MCP Integration

☁️ **Start managing cloud storage efficiently!**
