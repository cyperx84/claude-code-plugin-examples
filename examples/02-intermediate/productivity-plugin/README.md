# Productivity Plugin

Daily productivity tools for developers with standup reports and code reviews.

## Features

- `/standup` - Generate daily standup report from git activity
- `/review [target]` - Request code review with automatic agent invocation
- `/agent code-reviewer` - Specialized code reviewer (proactive)

## Installation

```bash
/plugin install productivity-plugin@local
```

## Usage

### Daily Standup
```bash
/standup

# Output:
# ## Standup - October 15, 2025
# ### ✅ Yesterday
# - Implemented user auth (#123)
# ### 🎯 Today
# - Write tests for auth module
# ### 🚧 Blockers
# - None
```

### Code Review
```bash
# Review uncommitted changes
/review

# Review specific file
/review @src/auth.ts

# Review last commit
/review last commit

# Agent automatically provides detailed feedback
```

## Learning Points

- ✅ Proactive agents
- ✅ Agent auto-invocation from commands
- ✅ Session hooks
- ✅ Git integration

## File Structure

```
productivity-plugin/
├── .claude-plugin/plugin.json
├── commands/
│   ├── standup.md
│   └── review.md
├── agents/
│   └── code-reviewer.md (proactive)
└── hooks/hooks.json
```
