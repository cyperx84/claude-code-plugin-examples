# Testing Automation Plugin

Comprehensive testing automation with specialized agents and hooks for quality assurance.

## Features

### Commands
- `/test-all` - Run complete test suite with coverage
- `/test-file @file` - Test specific file with detailed output
- `/coverage [path]` - Analyze coverage and identify gaps
- `/watch [pattern]` - Run tests in watch mode

### Agents
- `/agent test-generator` - Generate comprehensive test suites
- `/agent test-debugger` - Debug failing tests (proactive)

### Hooks
- **Pre-commit** - Run tests before git commits (blocks if tests fail)
- **Post-test** - Check coverage thresholds after test runs
- **File-modified** - Notify when test files change
- **Prompt-submit** - Show recent test status

## Installation

```bash
/plugin marketplace add /path/to/examples/02-intermediate/testing-plugin
/plugin install testing-plugin@local
```

## Usage Examples

### Run All Tests
```bash
# Full test suite with coverage
/test-all

# Output:
# ✓ 142 tests passed
# ✗ 3 tests failed
# Coverage: 87.3%
```

### Test Specific Files
```bash
# Test a source file
/test-file @src/utils/calculator.ts

# Test a test file directly
/test-file tests/auth.test.ts

# Interactive with auto-suggestions
/test-file Calculator
```

### Coverage Analysis
```bash
# Analyze entire project
/coverage

# Analyze specific directory
/coverage src/utils

# Output shows prioritized gaps:
# ❗ Critical: auth.ts: 45.2%
# ⚠️  Medium: parser.ts: 67.8%
# ✓  Good: format.ts: 92.1%
```

### Watch Mode
```bash
# Watch all tests
/watch

# Watch specific pattern
/watch auth

# Interactive commands:
# - Press 'a' to run all
# - Press 'f' for failed tests only
# - Press 'q' to quit
```

### Generate Tests
```bash
# Generate tests for a file
/agent test-generator @src/auth/login.ts

# Output:
# Generated 18 tests covering:
# - Happy path (6 tests)
# - Edge cases (7 tests)
# - Error conditions (5 tests)
# Estimated coverage: 92%
```

### Debug Failing Tests
```bash
# Manual invocation
/agent test-debugger

# Or automatic (proactive when tests fail)
# Agent analyzes failures and suggests fixes:
#
# Test Failure Analysis
# ❌ login > should return token
# Root Cause: Async/await missing
# Fix: Add await to login() call
# Apply fix? (y/n)
```

## Learning Points

This plugin demonstrates:

### ✅ Intermediate Plugin Architecture
- **Commands** - Complex workflows
- **Agents** - Specialized AI assistants
- **Hooks** - Automated quality checks
- **Scripts** - Shell automation

### ✅ Agent Design Patterns

**test-generator (Non-proactive):**
- Invoked explicitly by user
- Generates code (test files)
- Uses Read, Write, Grep, Bash tools
- Detailed system prompt for consistency

**test-debugger (Proactive):**
- Automatically triggered on test failures
- Analyzes and fixes issues
- Uses Edit tool for corrections
- Provides explanations and suggestions

### ✅ Hook Patterns

**PreToolUse - Validation:**
```json
{
  "event": "PreToolUse",
  "tool": "Bash(git:commit:*)",
  "command": "./scripts/pre-commit-tests.sh",
  "block_on_error": true
}
```
Prevents commits if tests fail.

**PostToolUse - Notification:**
```json
{
  "event": "PostToolUse",
  "tool": "Write|Edit",
  "command": "notify-test-file-modified.sh"
}
```
Alerts when test files change.

**UserPromptSubmit - Context:**
```json
{
  "event": "UserPromptSubmit",
  "command": "show-recent-test-status.sh"
}
```
Adds test context to conversations.

### ✅ Script Integration
- Bash scripts for complex logic
- Executable permissions
- Error handling
- Framework detection

### ✅ Multi-Framework Support
- JavaScript/TypeScript (Jest, Vitest)
- Python (pytest)
- Go (testing package)
- Java (JUnit)

## File Structure

```
testing-plugin/
├── .claude-plugin/
│   └── plugin.json
├── commands/
│   ├── test-all.md         # Run full suite
│   ├── test-file.md        # Test specific file
│   ├── coverage.md         # Coverage analysis
│   └── watch.md            # Watch mode
├── agents/
│   ├── test-generator.md   # Generate tests
│   └── test-debugger.md    # Debug failures (proactive)
├── hooks/
│   └── hooks.json          # 4 hooks for automation
├── scripts/
│   ├── pre-commit-tests.sh # Validation script
│   └── coverage-check.sh   # Coverage threshold
└── README.md
```

## Hook Details

### Pre-commit Test Hook
- **Trigger:** Before `git commit`
- **Action:** Run tests for staged files
- **Blocks:** Yes, if tests fail
- **Timeout:** 60 seconds

### Coverage Check Hook
- **Trigger:** After `npm test`
- **Action:** Verify coverage threshold (80%)
- **Blocks:** No (warning only)
- **Timeout:** 10 seconds

### Test File Modified Hook
- **Trigger:** After Write/Edit tools
- **Action:** Notify if test file modified
- **Blocks:** No
- **Timeout:** 1 second

### Test Status Hook
- **Trigger:** User submits prompt
- **Action:** Show recent test results
- **Blocks:** No
- **Timeout:** 5 seconds

## Best Practices Demonstrated

### Agent Development
1. **Clear purpose** - Each agent has one responsibility
2. **Tool restrictions** - Only necessary tools granted
3. **Detailed prompts** - Comprehensive system instructions
4. **Proactive flag** - Appropriate activation behavior

### Hook Development
1. **Safety first** - Timeouts prevent hanging
2. **Error handling** - Graceful failures
3. **Performance** - Quick execution
4. **User feedback** - Clear messages

### Testing Strategies
1. **Coverage goals** - 80% minimum
2. **Test categories** - Happy path, edge cases, errors
3. **AAA pattern** - Arrange, Act, Assert
4. **Isolation** - No shared state between tests

## Troubleshooting

### Tests Not Running
```bash
# Check test framework
cat package.json | grep -E "(jest|vitest|mocha)"

# Verify scripts
ls -la scripts/
chmod +x scripts/*.sh
```

### Hooks Not Working
```bash
# Test hooks manually
bash scripts/pre-commit-tests.sh

# Check hook configuration
cat hooks/hooks.json | jq .
```

### Agent Not Responding
```bash
# Verify agent files
ls -la agents/

# Check markdown format
head agents/test-generator.md
```

## Next Steps

After mastering this example:

1. **Customize** - Adapt to your test framework
2. **Extend** - Add performance testing agents
3. **Integrate** - Connect to CI/CD systems
4. **Advanced** - Move to MCP integration examples
5. **Real-world** - Apply to production projects

## Related Examples

- **Beginner:** git-helper-plugin (commands basics)
- **Intermediate:** productivity-plugin (more agents/hooks)
- **Advanced:** devops-plugin (MCP integration)
