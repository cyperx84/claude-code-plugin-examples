---
description: Generate documentation from code automatically
allowed-tools: Read, Write, Grep, Bash(typedoc:*, jsdoc:*)
---

# Generate Documentation

Generate docs for: $ARGUMENTS (or entire project)

## Multi-Format Documentation

### 1. API Documentation

From code:
```typescript
/**
 * Creates a new user account
 * @param userData - User registration data
 * @returns Created user with ID
 * @throws {ValidationError} If email invalid
 */
async function createUser(userData: UserData): Promise<User> {
  // Implementation
}
```

Generates:
```markdown
## createUser

Creates a new user account.

### Parameters
- `userData` (UserData): User registration data
  - `email` (string, required): User's email address
  - `password` (string, required): User's password (min 8 chars)
  - `name` (string, optional): User's full name

### Returns
`Promise<User>` - Created user with assigned ID

### Throws
- `ValidationError` - If email format is invalid
- `DuplicateError` - If email already exists

### Example
```typescript
const user = await createUser({
  email: 'user@example.com',
  password: 'SecurePass123',
  name: 'John Doe'
});
console.log(user.id); // '123e4567-e89b-12d3-a456-426614174000'
```
```

### 2. README Generation

Auto-generate README.md:
```markdown
# Project Name

[Auto-detected from package.json]

## Description
[From package.json description + code analysis]

## Features
- ✅ User authentication [detected from auth module]
- ✅ REST API [detected from routes]
- ✅ Database integration [detected from ORM usage]

## Installation
[From package.json scripts + dependencies]

## Usage
[From main entry points + examples in tests]

## API Reference
[Generated from code]

## Contributing
[Template]

## License
[From package.json]
```

### 3. Database Schema Docs

```markdown
# Database Schema

## users Table

| Column | Type | Constraints | Description |
|--------|------|-------------|-------------|
| id | UUID | PRIMARY KEY | Unique user identifier |
| email | VARCHAR(255) | UNIQUE, NOT NULL | User's email |
| created_at | TIMESTAMP | DEFAULT NOW() | Account creation |

### Relationships
- **Has Many** orders (via user_id)
- **Has One** profile (via user_id)

### Indexes
- `idx_users_email` (email) - For login queries
```

## Example Usage

```bash
# Generate all docs
/generate-docs

# Generate API docs only
/generate-docs api

# Generate README
/generate-docs readme

# Generate database schema docs
/generate-docs database

# Interactive mode
/generate-docs --interactive
```

**Pattern Demonstrated:** AI-Powered Documentation Automation
