---
description: Run all tests with coverage reporting
allowed-tools: Bash(npm:test,run), Bash(pytest:*), Bash(go:test)
---

# Run All Tests

Execute the complete test suite with coverage reporting.

**Process:**

1. **Detect test framework:**
   - Check package.json for JavaScript/TypeScript (Jest, Vitest, Mocha)
   - Check for pytest.ini or setup.py for Python
   - Check for go.mod for Go tests
   - Check for pom.xml or build.gradle for Java

2. **Run tests:**
   - Execute with coverage enabled
   - Show progress in real-time
   - Capture failures and errors

3. **Generate coverage report:**
   - Display coverage summary
   - Highlight files below 80% coverage
   - Show uncovered lines

4. **Report results:**
   - Total tests run
   - Passed/Failed/Skipped counts
   - Execution time
   - Coverage percentage
   - Link to full coverage report

5. **If tests fail:**
   - Show failure details
   - Offer to invoke /agent test-debugger
   - Suggest fixes based on error messages

**Example outputs:**

```
✓ 142 tests passed
✗ 3 tests failed
⊘ 5 tests skipped

Coverage: 87.3%
├─ Statements: 1,234 / 1,412 (87.4%)
├─ Branches: 234 / 289 (81.0%)
├─ Functions: 156 / 178 (87.6%)
└─ Lines: 1,156 / 1,298 (89.1%)

Files below 80%:
└─ src/utils/parser.ts: 67.3%
```
