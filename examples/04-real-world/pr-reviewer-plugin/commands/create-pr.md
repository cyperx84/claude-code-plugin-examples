---
description: Create a pull request with auto-generated description
allowed-tools: Bash(git:*), Read, Grep
---

# Create Pull Request

Create PR for current branch: $ARGUMENTS (title, or auto-generate)

## Process

### 1. Gather Information

**Git Analysis:**
```bash
# Get current branch
git branch --show-current

# Get commits not in main
git log main..HEAD --oneline

# Get changed files
git diff main...HEAD --name-only

# Get full diff
git diff main...HEAD
```

### 2. Analyze Changes

**Automatic Detection:**
- **Type:** Feature | Bugfix | Refactor | Docs | Chore
- **Scope:** Files and modules affected
- **Breaking Changes:** API changes detected
- **Related Issues:** Parse commit messages for #123 references

**Code Analysis:**
- New functions added
- Modified functions
- Deleted code
- New dependencies
- Configuration changes

### 3. Generate PR Description

Create comprehensive description:

```markdown
## 🎯 Purpose

[Auto-generated based on commits and changes]

## 🔧 Changes

### Added
- [New features/functions]

### Modified
- [Updated functionality]

### Removed
- [Deprecated code]

## 🧪 Testing

### Test Coverage
- [New tests added]
- [Modified tests]
- Coverage: X% → Y%

### How to Test
1. [Step-by-step testing instructions]
2. [Expected outcomes]

## 📸 Screenshots

[If UI changes detected]

## ⚠️ Breaking Changes

[If API changes detected]
- Old: `function oldAPI()`
- New: `function newAPI()`
- Migration: [Instructions]

## 📝 Checklist

- [ ] Tests added/updated
- [ ] Documentation updated
- [ ] Breaking changes documented
- [ ] Changelog updated

## 🔗 Related Issues

Closes #XXX
Related to #YYY

## 🤔 Questions for Reviewers

[Auto-generated questions based on complexity]
```

### 4. Create PR via GitHub MCP

```javascript
// Using GitHub MCP
createPullRequest({
  title: "feat: Add user authentication",
  body: generatedDescription,
  head: currentBranch,
  base: "main",
  draft: isDraft,
  labels: autoDetectedLabels,
  assignees: suggestedReviewers
})
```

### 5. Auto-Actions

**Automatic Additions:**
- Add relevant labels (feature, bugfix, etc.)
- Assign suggested reviewers (based on file ownership)
- Link related issues
- Set milestone (if applicable)
- Request specific reviews (if security changes)

**Post-Creation:**
- Share PR link
- Notify team (if configured)
- Trigger CI/CD
- Add to project board

## Smart Features

### Label Detection

Auto-add labels based on:
- **Files changed:** `backend`, `frontend`, `database`, `docs`
- **Type:** `feature`, `bugfix`, `refactor`, `chore`
- **Priority:** `high-priority`, `low-priority`
- **Size:** `small`, `medium`, `large` (based on LOC)

### Reviewer Suggestion

Suggest reviewers based on:
- File ownership (CODEOWNERS)
- Past reviews
- Expertise areas
- Availability

### Template Selection

Auto-select PR template:
- Feature template (for new features)
- Bugfix template (for fixes)
- Hotfix template (for urgent fixes)

## Example Usage

```bash
# Create PR with auto-generated title/description
/create-pr

# Create PR with custom title
/create-pr "Add user authentication system"

# Create draft PR
/create-pr --draft

# Create PR and auto-assign reviewers
/create-pr --auto-assign

# Create PR with specific base branch
/create-pr --base develop
```

## Output Example

```
🔍 Analyzing changes...

Current branch: feature/user-auth
Base branch: main
Commits: 8 commits
Files changed: 12 files (+450/-120 lines)

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
📊 CHANGE ANALYSIS
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Type: Feature ✨
Scope: Authentication, API, Database
Breaking Changes: None
Related Issues: #234

Files:
- src/auth/*.ts (new)
- src/api/users.ts (modified)
- tests/auth/*.test.ts (new)

Generating PR description...
✅ Description generated (450 words)

Creating PR via GitHub MCP...
✅ PR created: https://github.com/org/repo/pull/456

Auto-actions:
✅ Added labels: feature, backend, needs-review
✅ Assigned reviewers: @alice, @bob
✅ Linked issue: #234
✅ CI/CD triggered

PR #456 created successfully! 🎉

Next: Wait for CI/CD, then request review
```

## Advanced Options

### Custom Templates

Use project templates:
```bash
/create-pr --template feature-template
/create-pr --template hotfix-template
```

### Pre-Creation Hooks

Run checks before creation:
- Linting
- Tests
- Security scan
- Dependency check

### Post-Creation Automation

After PR created:
- Notify Slack/Discord
- Update project board
- Create deployment preview
- Schedule review meeting
