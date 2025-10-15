---
description: Check status of pull requests
---

# PR Status Dashboard

Check PR status: $ARGUMENTS (PR number, "mine", "open", or "all")

## Using GitHub MCP for Real-Time Data

### 1. Query GitHub

Fetch PR information:
- PR state (open, closed, merged)
- CI/CD status
- Review status
- Merge conflicts
- Required checks
- Comments and discussions

### 2. Display Dashboard

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
📊 PULL REQUEST STATUS
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

PR #123: Add user authentication
Author: @username
Status: 🟢 Open | ⏳ Pending Review

┌─ CI/CD STATUS ─────────────────────┐
│ ✅ Tests: Passing (142/142)        │
│ ✅ Lint: No errors                 │
│ ✅ Build: Success                  │
│ ⏳ Security Scan: In progress...   │
└────────────────────────────────────┘

┌─ REVIEW STATUS ────────────────────┐
│ Reviewers:                         │
│ ✅ @alice - Approved               │
│ ⏳ @bob - Pending                  │
│ ❌ @charlie - Changes requested    │
│                                    │
│ Required: 2/3 approvals            │
│ Status: Needs 1 more approval      │
└────────────────────────────────────┘

┌─ MERGE STATUS ─────────────────────┐
│ Base: main                         │
│ Conflicts: ❌ None                 │
│ Behind base: 3 commits             │
│ Suggestion: Rebase recommended     │
└────────────────────────────────────┘

┌─ ACTIVITY ─────────────────────────┐
│ Last updated: 2 hours ago          │
│ Comments: 12                       │
│ Commits: 8                         │
│ Files changed: 12 (+450/-120)      │
└────────────────────────────────────┘

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🎯 NEXT STEPS
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

1. ⏳ Wait for security scan to complete
2. 👤 Ping @bob for review
3. ✅ Address @charlie's comments
4. 🔄 Rebase on main (3 commits behind)
```

### 3. Multiple PR Overview

When checking "mine" or "all":

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
📊 MY PULL REQUESTS
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

#123 🟢 Add user authentication
     ✅ 2/2 approvals | ⏳ CI running | Ready soon

#124 🟡 Fix login bug
     ⚠️  1/2 approvals | ❌ Tests failing | Needs work

#125 🔴 Update dependencies
     ❌ Changes requested | ⏳ 0/2 approvals | Action needed

#126 ⚪ Refactor API
     Draft | Not ready for review

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Summary: 4 PRs (1 ready, 1 in progress, 1 blocked, 1 draft)
```

## Smart Alerts

### Blockers Detection

Automatically identify:
- ❌ **Failed CI/CD** - Tests failing, build broken
- ❌ **Merge conflicts** - Needs rebase/merge
- ❌ **Changes requested** - Reviewer feedback pending
- ⚠️ **Missing approvals** - Need more reviews
- ⚠️ **Stale PR** - No activity for X days
- ⚠️ **Behind base** - Need to sync with main

### Priority Scoring

Calculate urgency:
```
High Priority:
- Hotfixes
- Blocking other PRs
- Production issues
- Deadline approaching

Medium Priority:
- Features
- Most PRs
- Normal workflow

Low Priority:
- Refactoring
- Documentation
- Non-urgent improvements
```

## Example Usage

```bash
# Check specific PR
/pr-status 123

# Check all my PRs
/pr-status mine

# Check all open PRs
/pr-status open

# Check all PRs (including closed)
/pr-status all

# Watch mode (auto-refresh)
/pr-status 123 --watch
```

## Interactive Actions

From status view, offer:
- **Merge** (if ready)
- **Request re-review** (after changes)
- **Close PR** (with reason)
- **Rebase** (if behind)
- **Update branch** (sync with base)
- **View diff** (see changes)
- **View comments** (read feedback)
- **Ping reviewers** (remind for review)

## Integration Features

### Slack/Discord Notifications

When status changes:
```
🔔 PR #123 status changed
✅ All checks passed
👍 Approved by @alice
🚀 Ready to merge!
```

### Auto-Merge

If configured and conditions met:
- All checks passed
- Required approvals received
- No conflicts
- Auto-merge enabled

```
🤖 Auto-merge triggered for PR #123
✅ All conditions met
🚀 Merging to main...
✅ Merged successfully!
🗑️  Branch deleted
```

### Metrics Tracking

Track PR health:
- Average time to first review
- Average time to merge
- Review participation
- CI/CD success rate
