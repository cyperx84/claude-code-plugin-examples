---
description: Show comprehensive git repository status
allowed-tools: Bash(git:status,branch,log,diff)
---

# Git Status Command

Provide a comprehensive status of the git repository.

**Information to show:**

1. **Current Branch:**
   - Show the current branch name
   - Show if it's tracking a remote branch
   - Show if ahead/behind remote

2. **Modified Files:**
   - List staged files (green)
   - List unstaged changes (red)
   - List untracked files

3. **Recent Commits:**
   - Show last 3 commits with one-line format
   - Include commit hash, author, and message

4. **Remote Information:**
   - Show configured remotes
   - Show remote tracking status

**Format the output clearly with sections and colors/formatting for readability.**

**Optional: If there are uncommitted changes, ask if they want to:**
- Review the diff
- Commit the changes
- Stash the changes
