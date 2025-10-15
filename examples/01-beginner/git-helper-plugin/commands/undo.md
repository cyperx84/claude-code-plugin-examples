---
description: Undo last commit or changes safely
allowed-tools: Bash(git:reset,restore,log,status)
---

# Git Undo Command

Help the user safely undo changes based on what they specify: $ARGUMENTS

**Safety first! Always show what will be undone before doing it.**

**Options:**

1. **Undo last commit (keep changes):**
   - Use `git reset --soft HEAD~1`
   - Show the commit that will be undone
   - Confirm before executing

2. **Undo last commit (discard changes):**
   - Use `git reset --hard HEAD~1`
   - **WARNING**: This is destructive
   - Show clear warning and require explicit confirmation

3. **Discard unstaged changes:**
   - Use `git restore <file>` or `git restore .`
   - List files that will be affected
   - Confirm before executing

4. **Unstage files:**
   - Use `git restore --staged <file>`
   - List staged files
   - Confirm which to unstage

**If $ARGUMENTS is:**
- "commit" → Undo last commit (keep changes)
- "hard" → Undo last commit (discard changes, with warning)
- "changes" → Discard unstaged changes
- "staging" → Unstage files
- Empty → Ask what they want to undo

**Always show git status after the operation.**
