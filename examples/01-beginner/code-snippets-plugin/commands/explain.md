---
description: Explain code in a file with clear breakdowns
---

# Explain Code Command

Analyze and explain the code that the user references (using @filename syntax).

**Your explanation should include:**

1. **High-Level Purpose:**
   - What does this code do?
   - What problem does it solve?

2. **Code Structure:**
   - Main functions/classes/components
   - Key variables and their purposes
   - Flow of execution

3. **Dependencies:**
   - External libraries used
   - Internal modules imported
   - API calls or external services

4. **Technical Details:**
   - Algorithms or patterns used
   - Performance considerations
   - Edge cases handled

5. **Potential Issues:**
   - Code smells or anti-patterns
   - Security concerns
   - Performance bottlenecks
   - Missing error handling

6. **Suggestions:**
   - Possible improvements
   - Refactoring opportunities
   - Testing recommendations

**Format the explanation clearly with:**
- Headers for each section
- Code snippets for examples
- Line number references (file.ts:42)
- Clear, accessible language

**If the user doesn't provide a file:**
- Ask which file they want explained
- Or offer to explain code from their clipboard
