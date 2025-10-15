---
description: Test REST API endpoints with comprehensive validation
allowed-tools: Bash(curl:*, node:*)
---

# API Endpoint Testing

Test API: $ARGUMENTS (URL or specification)

## Comprehensive Testing

### 1. Quick Test
```bash
/test-api https://api.example.com/users

# Tests:
✅ GET /users (200 OK, 45ms)
✅ Response is valid JSON
✅ Returns array of users
⚠️  No rate limiting detected
⚠️  Missing CORS headers
```

### 2. Full Test Suite

Automatically generates tests for:
- **Happy Path** - Valid requests
- **Error Cases** - Invalid data, auth failures
- **Edge Cases** - Empty, null, large data
- **Security** - Auth, injection, headers
- **Performance** - Response time, load

### 3. Contract Testing

```
API Contract Validation:
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

GET /users
✅ Status: 200 OK
✅ Content-Type: application/json
✅ Response Schema: Valid
⚠️  Missing: pagination metadata
❌ Response Time: 1.2s (expected < 500ms)

POST /users
✅ Status: 201 Created
✅ Validates required fields
✅ Returns created resource
✅ Sets Location header

DELETE /users/:id
✅ Status: 204 No Content
✅ Requires authentication
⚠️  No confirmation step (security risk)
```

## Example Usage

```bash
# Test single endpoint
/test-api GET https://api.example.com/users

# Test with authentication
/test-api https://api.example.com/users --auth "Bearer token"

# Load test
/test-api https://api.example.com/users --load 100

# Generate test suite
/test-api https://api.example.com/openapi.json --generate-tests
```

**Pattern Demonstrated:** API Testing & Validation Automation
