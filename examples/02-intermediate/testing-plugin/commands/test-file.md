---
description: Run tests for a specific file
---

# Test Specific File

Run tests for the file: $ARGUMENTS

**Process:**

1. **If user provides source file (e.g., @src/utils.ts):**
   - Find corresponding test file
   - If no test file exists, offer to create one using /agent test-generator

2. **If user provides test file:**
   - Run that specific test file
   - Show detailed output

3. **Run tests:**
   - Execute with verbose output
   - Show each test case result
   - Display timing for each test
   - Show console logs if available

4. **Report results:**
   - Summary for this file
   - Individual test case results
   - Any errors or failures with stack traces
   - Suggestions for fixing failures

5. **Interactive options:**
   - Watch mode: Re-run on file changes
   - Debug mode: Run with debugger attached
   - Update snapshots: If snapshot tests
   - Generate missing tests: If coverage gaps

**Example usage:**
- `/test-file @src/utils/parser.ts`
- `/test-file tests/auth.test.ts`
- `/test-file UserComponent`
