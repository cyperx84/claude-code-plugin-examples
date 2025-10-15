---
description: Run tests in watch mode with auto-rerun
---

# Test Watch Mode

Start test watch mode for: $ARGUMENTS (or all tests if not specified)

**This starts an interactive watch session that:**

1. **Initial test run:**
   - Run all tests (or specified subset)
   - Show results

2. **Watch for changes:**
   - Monitor source files
   - Monitor test files
   - Monitor configuration files

3. **Auto-rerun:**
   - Run affected tests when files change
   - Show only changed test results
   - Maintain pass/fail history

4. **Interactive commands:**
   - `a` - Run all tests
   - `f` - Run only failed tests
   - `p` - Filter by test name pattern
   - `t` - Filter by test file
   - `q` - Quit watch mode
   - `c` - Clear console
   - `u` - Update snapshots

5. **Smart features:**
   - Only run tests for changed files
   - Show test execution time
   - Highlight regression (new failures)
   - Show coverage changes

**Example output:**

```
Watch mode started...

Watching: src/**/*.ts, tests/**/*.test.ts

✓ 142 tests passed (0 changed)
✗ 0 tests failed
⊘ 5 tests skipped

Coverage: 87.3% (no change)

Press a to run all tests.
Press f to run only failed tests.
Press q to quit watch mode.

File changed: src/utils/parser.ts
Running affected tests...

✓ parser.test.ts (12 tests, 324ms)

All tests passed!
Coverage: 87.5% (+0.2%)
```

**Note:** This runs in the background. Use BashOutput to check status.
