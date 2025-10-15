---
description: Perform comprehensive PR review using GitHub MCP
---

# Review Pull Request

Review PR: $1 (PR number or URL)

**Using GitHub MCP integration for live data**

## Process

### 1. Fetch PR Data (via GitHub MCP)

Query GitHub for:
- PR title and description
- Changed files and diffs
- Existing comments
- CI/CD status
- Linked issues
- Branch information

### 2. Automated Analysis

**Code Quality Checks:**
- Syntax and style consistency
- Naming conventions
- Code complexity (cyclomatic complexity)
- Duplicated code detection
- Dead code identification

**Security Analysis:**
- SQL injection vulnerabilities
- XSS vulnerabilities
- Hardcoded credentials
- Unsafe dependencies
- Authentication/authorization issues

**Best Practices:**
- DRY violations
- SOLID principles
- Error handling completeness
- Logging adequacy
- Test coverage

**Performance Review:**
- N+1 queries
- Inefficient algorithms
- Memory leaks
- Resource management

### 3. Generate Review

Create structured review:

```markdown
## PR Review Summary

**Overall Assessment:** ✅ Approved with suggestions | ⚠️ Changes requested | ❌ Blocked

**Key Metrics:**
- Files changed: X
- Lines added: Y / Lines removed: Z
- Complexity increase: N points
- Test coverage: M%

## 🔴 Critical Issues (Must Fix)
1. [Issue with severity, location, and fix]

## 🟡 Major Suggestions (Should Fix)
1. [Suggestion with reasoning]

## 🟢 Minor Improvements (Nice to Have)
1. [Enhancement suggestion]

## ✅ Positive Highlights
1. [Well-implemented features]

## 📝 Detailed File Reviews

### file1.ts
**Lines 45-67:**
- Issue: [Description]
- Severity: High
- Recommendation: [Fix]

### file2.ts
**Lines 12-20:**
- Suggestion: [Description]
- Benefit: [Explanation]
```

### 4. Post to GitHub (via MCP)

Options:
- **Auto-post:** Automatically add review as comment
- **Draft:** Show review for approval first
- **Inline:** Add inline comments on specific lines

### 5. Interactive Actions

After review:
- Request changes on GitHub
- Approve PR
- Add labels (e.g., "needs-tests", "security-review")
- Assign reviewers
- Request re-review after fixes

## Review Criteria

### Security (Highest Priority)
- [ ] No hardcoded secrets
- [ ] Input validation present
- [ ] Authentication verified
- [ ] Authorization checked
- [ ] SQL injection prevented
- [ ] XSS prevented

### Testing
- [ ] New code has tests
- [ ] Existing tests updated
- [ ] Edge cases covered
- [ ] Integration tests included
- [ ] Coverage maintained/improved

### Code Quality
- [ ] Follows project style
- [ ] Naming is clear
- [ ] Functions are focused
- [ ] DRY principle followed
- [ ] Comments where needed

### Documentation
- [ ] README updated if needed
- [ ] API docs updated
- [ ] Breaking changes noted
- [ ] Migration guide included

## Example Usage

```bash
# Review by PR number
/review-pr 123

# Review by URL
/review-pr https://github.com/org/repo/pull/456

# Auto-post review
/review-pr 123 --auto-post

# Draft mode (review first)
/review-pr 123 --draft
```

## Output Example

```
🔍 Reviewing PR #123: "Add user authentication"

Fetching PR data from GitHub...
✅ PR found: 12 files changed, +450/-120 lines

Analyzing code changes...
✅ Security scan complete
✅ Quality analysis complete
✅ Performance review complete

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
📊 PR REVIEW SUMMARY
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Overall: ⚠️  CHANGES REQUESTED

🔴 Critical Issues: 2
🟡 Major Suggestions: 5
🟢 Minor Improvements: 3

Critical Issues:
1. src/auth/login.ts:45 - Password stored in plain text
   Fix: Use bcrypt for password hashing

2. src/api/users.ts:78 - SQL injection vulnerability
   Fix: Use parameterized queries

[Full review posted to GitHub]

Next steps:
- Address critical issues
- Push fixes
- Request re-review with: /review-pr 123 --recheck
```

## Advanced Features

**Smart Detection:**
- Detects PR type (feature, bugfix, refactor)
- Adjusts review criteria accordingly
- References related PRs
- Checks for breaking changes

**Learning Mode:**
- Remembers past reviews
- Learns project patterns
- Adapts to team preferences
- Improves over time

**Integration:**
- Links to CI/CD results
- References issue trackers
- Checks design docs
- Verifies acceptance criteria
