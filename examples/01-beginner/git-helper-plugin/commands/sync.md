---
description: Sync with remote repository (pull and push)
allowed-tools: Bash(git:pull,push,fetch,status)
---

# Git Sync Command

Synchronize the current branch with the remote repository.

**Process:**

1. **Pre-sync checks:**
   - Show current branch
   - Check for uncommitted changes
   - If there are uncommitted changes, ask to commit or stash first

2. **Fetch latest:**
   - Run `git fetch` to get latest remote state
   - Show if remote has new commits

3. **Pull changes:**
   - If remote has changes, pull them
   - Handle merge conflicts if they occur
   - If conflicts, provide guidance on resolving them

4. **Push changes:**
   - If local has commits not on remote, push them
   - Show what's being pushed
   - Confirm push was successful

5. **Summary:**
   - Show sync status
   - List commits pulled (if any)
   - List commits pushed (if any)

**Error handling:**
- If no remote configured, explain and suggest setting one up
- If push rejected, explain why and suggest solutions
- If merge conflicts, provide step-by-step resolution guide
