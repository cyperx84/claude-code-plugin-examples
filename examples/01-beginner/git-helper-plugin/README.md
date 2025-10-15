# Git Helper Plugin

Git workflow automation commands demonstrating command arguments and tool restrictions.

## Features

- `/commit [message]` - Create commits with smart staging
- `/branch [name]` - Create and switch branches with naming conventions
- `/status` - Comprehensive repository status
- `/undo [what]` - Safe undo operations with confirmations
- `/sync` - Synchronize with remote repository

## Installation

```bash
/plugin marketplace add /path/to/examples/01-beginner/git-helper-plugin
/plugin install git-helper-plugin@local
```

## Usage Examples

### Create Commits
```bash
# With message
/commit "Add user authentication"

# Interactive (will prompt for message)
/commit

# Conventional commits
/commit "feat: add login form"
/commit "fix: resolve database connection"
```

### Branch Management
```bash
# Create and switch to new branch
/branch feature/user-profile

# Interactive
/branch
```

### Repository Status
```bash
# Full status overview
/status
```

### Undo Operations
```bash
# Undo last commit (keep changes)
/undo commit

# Discard unstaged changes (with warning)
/undo changes

# Unstage files
/undo staging
```

### Sync with Remote
```bash
# Pull and push changes
/sync
```

## Learning Points

This plugin demonstrates:

- ✅ **Command arguments** - Using `$ARGUMENTS`, `$1`, `$2`, etc.
- ✅ **Tool restrictions** - `allowed-tools` frontmatter
- ✅ **Safety patterns** - Confirmations before destructive operations
- ✅ **Error handling** - Graceful handling of edge cases
- ✅ **User interaction** - Prompting for input when arguments missing
- ✅ **Git workflows** - Common git operations automated

## Security Features

All commands use `allowed-tools` to restrict Claude to only git-related bash commands:
```yaml
allowed-tools: Bash(git:add,commit,status,diff)
```

This ensures commands can't execute arbitrary system commands.

## File Structure

```
git-helper-plugin/
├── .claude-plugin/
│   └── plugin.json
├── commands/
│   ├── commit.md      # With $ARGUMENTS
│   ├── branch.md      # With $1 parameter
│   ├── status.md      # No arguments
│   ├── undo.md        # Optional arguments
│   └── sync.md        # Complex workflow
└── README.md
```

## Best Practices Demonstrated

1. **Safety First**: Always confirm before destructive operations
2. **Clear Communication**: Show what will happen before it happens
3. **Error Handling**: Graceful degradation and helpful error messages
4. **User Guidance**: Suggest next steps and alternatives
5. **Tool Restriction**: Limit tool access for security

## Next Steps

Try creating commands that:
1. Accept multiple arguments (`$1`, `$2`, `$3`)
2. Parse complex argument patterns
3. Chain multiple git operations
4. Integrate with other tools (testing, linting, etc.)
