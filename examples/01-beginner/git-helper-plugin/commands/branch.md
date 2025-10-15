---
description: Create and switch to a new git branch
allowed-tools: Bash(git:branch,checkout,switch)
---

# Git Branch Command

Create and switch to a new git branch named: $1

**Process:**
1. First, show the current branch
2. Check if the requested branch name already exists
3. If it exists, ask if they want to switch to it or choose a different name
4. If it doesn't exist, create it and switch to it
5. Confirm the branch creation and current branch

**Branch naming conventions to suggest:**
- feature/feature-name
- fix/bug-description
- refactor/component-name
- docs/what-docs

**If no branch name provided:**
- Ask the user what they're working on
- Suggest a branch name based on their answer

**Example usage:**
- `/branch feature/user-auth`
- `/branch fix/login-bug`
- `/branch` (will prompt for name)
