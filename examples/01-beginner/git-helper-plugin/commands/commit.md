---
description: Create a git commit with a message
allowed-tools: Bash(git:add,commit,status,diff)
---

# Git Commit Command

Create a git commit with the message: $ARGUMENTS

**Pre-commit steps:**
1. Show current git status to understand what files are modified
2. Show a git diff to review the changes
3. Ask the user if they want to review the diff before committing

**Commit process:**
1. Stage all modified and new files (or ask which files to stage)
2. Create a commit with the provided message
3. Show the commit hash and message for confirmation

**If no message is provided ($ARGUMENTS is empty):**
- Ask the user for a commit message
- Suggest a message based on the changes if helpful

**Example usage:**
- `/commit "Add user authentication feature"`
- `/commit fix: resolve login bug`
- `/commit` (will prompt for message)
