---
description: Request code review with automatic agent invocation
---

# Code Review Request

Request a code review for: $ARGUMENTS (or recent changes if not specified)

**Process:**

1. **Identify changes:**
   - If $ARGUMENTS specifies files, review those
   - Otherwise, review uncommitted changes or recent commits

2. **Invoke reviewer agent:**
   - Use `/agent code-reviewer` automatically
   - Provide context about what changed and why

3. **Review focus:**
   - Code quality and maintainability
   - Security vulnerabilities
   - Performance issues
   - Best practices
   - Test coverage

**Usage:**
- `/review` - Review uncommitted changes
- `/review @src/auth.ts` - Review specific file
- `/review last commit` - Review last commit
