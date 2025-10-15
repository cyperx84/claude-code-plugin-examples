---
description: Comprehensive security scan of codebase
allowed-tools: Grep, Read, Bash(npm:audit,pip:*)
---

# Security Scan

Scan for security vulnerabilities: $ARGUMENTS (or entire project)

## Multi-Layer Security Analysis

### 1. Dependency Vulnerabilities

```bash
# npm audit for Node.js
npm audit --json

# pip-audit for Python
pip-audit --format json

# Report:
🔍 Dependency Scan Results
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

🔴 Critical: 2
🟡 High: 5
🟢 Medium: 12
⚪ Low: 8

Critical Vulnerabilities:
1. lodash@4.17.15 - Prototype Pollution
   CVE-2020-8203
   Severity: CRITICAL
   Fix: npm install lodash@4.17.21

2. axios@0.19.0 - Server-Side Request Forgery
   CVE-2020-28168
   Severity: CRITICAL
   Fix: npm install axios@0.21.1
```

### 2. Code Pattern Scanning

**SQL Injection:**
```typescript
// 🔴 CRITICAL: SQL Injection vulnerability
const query = `SELECT * FROM users WHERE id = ${userId}`;
db.execute(query);

// ✅ Safe: Use parameterized queries
const query = `SELECT * FROM users WHERE id = ?`;
db.execute(query, [userId]);
```

**XSS Vulnerabilities:**
```javascript
// 🔴 CRITICAL: XSS vulnerability
element.innerHTML = userInput;

// ✅ Safe: Use textContent or sanitize
element.textContent = userInput;
// Or
element.innerHTML = DOMPurify.sanitize(userInput);
```

**Hardcoded Secrets:**
```javascript
// 🔴 CRITICAL: Exposed API key
const apiKey = "sk_live_1234567890abcdef";

// ✅ Safe: Use environment variables
const apiKey = process.env.API_KEY;
```

### 3. Authentication Issues

```typescript
// 🔴 CRITICAL: Weak password hashing
const hash = md5(password);

// ✅ Safe: Use bcrypt
const hash = await bcrypt.hash(password, 10);

// 🟡 HIGH: Missing rate limiting
app.post('/login', async (req, res) => {
  // No rate limiting - brute force possible
});

// ✅ Better:
const limiter = rateLimit({
  windowMs: 15 * 60 * 1000,
  max: 5
});
app.post('/login', limiter, async (req, res) => {
  // Protected from brute force
});
```

### 4. File System Security

```javascript
// 🔴 CRITICAL: Path traversal
const file = req.query.file;
fs.readFile(`./uploads/${file}`);
// Attacker: ?file=../../../etc/passwd

// ✅ Safe: Validate and sanitize
const file = path.basename(req.query.file);
const safePath = path.join('./uploads', file);
if (!safePath.startsWith('./uploads/')) {
  throw new Error('Invalid path');
}
fs.readFile(safePath);
```

### 5. API Security

```javascript
// 🟡 HIGH: Missing CORS configuration
app.use(cors({
  origin: '*'  // Allows any origin
}));

// ✅ Better:
app.use(cors({
  origin: process.env.ALLOWED_ORIGINS.split(','),
  credentials: true
}));

// 🟡 HIGH: Sensitive data in logs
console.log('User:', user);  // Logs password, tokens, etc.

// ✅ Better:
console.log('User:', { id: user.id, email: user.email });
```

## Scan Results Format

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🛡️  SECURITY AUDIT REPORT
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Scan Date: 2024-10-15 12:00:00
Files Scanned: 156
Lines Analyzed: 45,230

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
📊 SUMMARY
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Total Issues: 27
🔴 Critical: 2 (MUST FIX)
🟡 High: 5 (Should fix)
🟢 Medium: 12 (Consider fixing)
⚪ Low: 8 (Nice to fix)

Security Score: 72/100 (MODERATE)

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🔴 CRITICAL ISSUES
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

1. SQL Injection Vulnerability
   File: src/api/users.ts:45
   Pattern: String concatenation in SQL
   Risk: Complete database compromise
   Fix: Use parameterized queries

2. Hardcoded API Keys
   Files: 3 files
   - src/config.ts:12
   - src/services/payment.ts:8
   - tests/integration.test.ts:34
   Risk: Key exposure, unauthorized access
   Fix: Use environment variables

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🟡 HIGH PRIORITY ISSUES
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

1. Weak Password Hashing (MD5)
   File: src/auth/hash.ts:23
   Fix: Use bcrypt or argon2

2. Missing Rate Limiting
   Files: 5 endpoints
   Risk: Brute force attacks
   Fix: Add express-rate-limit

[Full report continues...]

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🎯 ACTION PLAN
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Immediate (Do Now):
1. Fix SQL injection in users API
2. Remove hardcoded secrets
3. Update vulnerable dependencies

This Week:
1. Implement rate limiting
2. Switch to bcrypt for passwords
3. Add input validation

This Month:
1. Security training for team
2. Set up automated scanning
3. Penetration testing
```

## Example Usage

```bash
# Scan entire project
/scan

# Scan specific directory
/scan src/

# Scan specific file
/scan src/api/users.ts

# Quick scan (dependencies only)
/scan --quick

# Detailed scan (include low priority)
/scan --detailed

# Export report
/scan --export security-report.pdf
```
