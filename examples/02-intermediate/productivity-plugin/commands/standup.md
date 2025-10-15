---
description: Generate daily standup report from git activity
allowed-tools: Bash(git:log,diff,status), Grep, Read
---

# Daily Standup Report

Generate a standup report based on recent activity.

**Report includes:**

1. **Yesterday** (Last 24 hours):
   - Git commits with messages
   - Files modified
   - Key changes summary

2. **Today** (Planned):
   - Open TODO comments in recently modified files
   - Unfinished work (WIP commits)
   - Branch name hints

3. **Blockers**:
   - Failing tests
   - Merge conflicts
   - Missing dependencies

**Format:**
```markdown
## Standup - [Date]

### ✅ Yesterday
- Implemented user authentication (#123)
- Fixed login bug (#124)
- Updated API documentation

### 🎯 Today
- Complete password reset feature
- Write tests for auth module
- Review PR #125

### 🚧 Blockers
- None
```
