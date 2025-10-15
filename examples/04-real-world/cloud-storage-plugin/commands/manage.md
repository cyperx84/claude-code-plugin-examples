---
description: Manage cloud storage buckets, files, and permissions
---

# Manage Cloud Storage

Manage: $ARGUMENTS (operation and parameters)

**Using AWS S3 MCP for storage management**

## Management Operations

### 1. List Operations
```bash
# List buckets
aws s3 ls

# List files in bucket
aws s3 ls s3://my-bucket/

# Recursive list
aws s3 ls s3://my-bucket/ --recursive

# With file sizes
aws s3 ls s3://my-bucket/ --human-readable --summarize
```

### 2. File Operations
```bash
# Copy within S3
aws s3 cp s3://bucket1/file.txt s3://bucket2/file.txt

# Move file
aws s3 mv s3://bucket/old-path/file.txt s3://bucket/new-path/file.txt

# Delete file
aws s3 rm s3://bucket/file.txt

# Delete directory
aws s3 rm s3://bucket/directory/ --recursive
```

### 3. Permissions Management
```bash
# Make public
aws s3api put-object-acl --bucket my-bucket --key file.txt --acl public-read

# Make private
aws s3api put-object-acl --bucket my-bucket --key file.txt --acl private

# Bucket policy
aws s3api put-bucket-policy --bucket my-bucket --policy file://policy.json

# CORS configuration
aws s3api put-bucket-cors --bucket my-bucket --cors-configuration file://cors.json
```

### 4. Lifecycle Management
```javascript
// Auto-delete old files
const lifecycleConfig = {
  Rules: [
    {
      Id: 'Delete old logs',
      Status: 'Enabled',
      Prefix: 'logs/',
      Expiration: { Days: 30 }
    },
    {
      Id: 'Archive old backups',
      Status: 'Enabled',
      Prefix: 'backups/',
      Transitions: [
        { Days: 30, StorageClass: 'GLACIER' }
      ]
    }
  ]
};

await s3.putBucketLifecycleConfiguration({
  Bucket: 'my-bucket',
  LifecycleConfiguration: lifecycleConfig
});
```

### 5. Versioning
```bash
# Enable versioning
aws s3api put-bucket-versioning \
  --bucket my-bucket \
  --versioning-configuration Status=Enabled

# List versions
aws s3api list-object-versions --bucket my-bucket --prefix file.txt

# Restore previous version
aws s3api copy-object \
  --bucket my-bucket \
  --copy-source my-bucket/file.txt?versionId=VERSION_ID \
  --key file.txt
```

### 6. Storage Analytics
```javascript
// Get bucket size
const getBucketSize = async (bucket) => {
  let totalSize = 0;
  let objects = 0;

  const listObjects = async (continuationToken) => {
    const params = {
      Bucket: bucket,
      ContinuationToken: continuationToken
    };

    const response = await s3.listObjectsV2(params);

    totalSize += response.Contents.reduce((sum, obj) => sum + obj.Size, 0);
    objects += response.Contents.length;

    if (response.IsTruncated) {
      await listObjects(response.NextContinuationToken);
    }
  };

  await listObjects();

  return {
    totalSize: (totalSize / 1024 / 1024 / 1024).toFixed(2) + ' GB',
    totalObjects: objects
  };
};
```

## Example Usage

```bash
# List buckets
/manage list-buckets

# List files
/manage list s3://my-bucket/

# Get bucket size
/manage size s3://my-bucket/

# Make file public
/manage public s3://my-bucket/image.jpg

# Set lifecycle
/manage lifecycle s3://my-bucket/ --delete-after 30

# Enable versioning
/manage versioning s3://my-bucket/ --enable

# Clean old files
/manage clean s3://my-bucket/logs/ --older-than 30days
```

**Pattern Demonstrated:** Resource Management, Permissions, Lifecycle Automation
