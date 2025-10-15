---
description: Analyze test coverage and identify gaps
---

# Coverage Analysis

Analyze test coverage and identify gaps for: $ARGUMENTS (or entire project if not specified)

**Process:**

1. **Run coverage analysis:**
   - Execute tests with coverage enabled
   - Generate detailed coverage report
   - Identify uncovered code paths

2. **Coverage breakdown:**
   - Overall coverage percentage
   - Per-file coverage
   - Per-function coverage
   - Branch coverage analysis

3. **Identify gaps:**
   - List uncovered functions
   - Show uncovered lines with context
   - Highlight critical paths without tests
   - Find edge cases not tested

4. **Prioritize:**
   - Critical paths (authentication, payment, etc.)
   - Complex functions (high cyclomatic complexity)
   - Recently changed code
   - Public API functions

5. **Recommendations:**
   - Suggest which files/functions to test first
   - Offer to generate tests using /agent test-generator
   - Estimate effort to reach coverage goals

**Example output:**

```
Coverage Analysis for src/utils/

Overall: 78.4%

High Priority (Critical paths):
❗ src/utils/auth.ts: 45.2% - CRITICAL
   ├─ validateToken(): 0% coverage
   └─ refreshToken(): 0% coverage

Medium Priority (Complex logic):
⚠️  src/utils/parser.ts: 67.8%
   ├─ parseComplexQuery(): 30% coverage
   └─ handleEdgeCases(): 45% coverage

Low Priority:
✓  src/utils/format.ts: 92.1%
✓  src/utils/string.ts: 95.3%

Recommendation:
1. Test auth.ts functions (HIGH PRIORITY)
2. Add edge case tests for parser.ts
3. Target 85% overall coverage (+6.6%)

Generate tests? (y/n)
```
