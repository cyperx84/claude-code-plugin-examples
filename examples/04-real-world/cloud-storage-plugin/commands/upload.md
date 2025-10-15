---
description: Upload files and directories to cloud storage (S3)
---

# Upload to Cloud Storage

Upload: $ARGUMENTS (file/directory path and destination)

**Using AWS S3 MCP for cloud storage**

## Upload Operations

### 1. Single File Upload
```bash
# Basic upload
aws s3 cp ./file.txt s3://my-bucket/file.txt

# With metadata
aws s3 cp ./file.txt s3://my-bucket/file.txt \
  --metadata "author=john,version=1.0"

# With storage class
aws s3 cp ./file.txt s3://my-bucket/file.txt \
  --storage-class STANDARD_IA  # Infrequent Access (cheaper)
```

### 2. Directory Upload
```bash
# Sync directory
aws s3 sync ./local-dir s3://my-bucket/remote-dir

# With exclusions
aws s3 sync ./project s3://my-bucket/backup \
  --exclude "node_modules/*" \
  --exclude ".git/*" \
  --exclude "*.log"

# Delete removed files
aws s3 sync ./local-dir s3://my-bucket/dir --delete
```

### 3. Backup Operations
```bash
# Database backup
pg_dump mydb | aws s3 cp - s3://my-bucket/backups/db-$(date +%Y%m%d).sql

# Compressed backup
tar -czf - ./data | aws s3 cp - s3://my-bucket/backups/data-$(date +%Y%m%d).tar.gz

# Encrypted backup
tar -czf - ./sensitive | openssl enc -aes-256-cbc -pass pass:$BACKUP_KEY | \
  aws s3 cp - s3://my-bucket/encrypted/backup.tar.gz.enc
```

### 4. Large File Upload (Multipart)
```javascript
// Automatically uses multipart for files > 5GB
await s3.upload({
  Bucket: 'my-bucket',
  Key: 'large-file.zip',
  Body: fs.createReadStream('./large-file.zip'),
  // Track progress
  onProgress: (progress) => {
    console.log(`Uploaded: ${progress.loaded}/${progress.total}`);
  }
});
```

### 5. Secure Uploads
```bash
# Server-side encryption
aws s3 cp file.txt s3://my-bucket/file.txt \
  --server-side-encryption AES256

# With KMS
aws s3 cp file.txt s3://my-bucket/file.txt \
  --server-side-encryption aws:kms \
  --ssekms-key-id arn:aws:kms:region:account:key/key-id

# Client-side encryption (before upload)
openssl enc -aes-256-cbc -in file.txt -out file.enc
aws s3 cp file.enc s3://my-bucket/file.enc
```

## Example Usage

```bash
# Single file
/upload ./report.pdf s3://my-bucket/reports/

# Directory
/upload ./website/ s3://my-bucket/website/ --sync

# Backup
/upload ./database/ s3://my-bucket/backups/$(date +%Y%m%d)/ --compress

# With encryption
/upload ./sensitive/ s3://my-bucket/secure/ --encrypt

# Public file
/upload ./public/logo.png s3://my-bucket/assets/ --public
```

**Pattern Demonstrated:** Cloud Storage, File Operations, Backup Automation
