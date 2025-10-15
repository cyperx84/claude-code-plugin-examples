# Hello Plugin

A simple greeting plugin to learn the basics of Claude Code plugins.

## Features

- `/greet` - Get a warm welcome with a programming joke
- `/goodbye` - End your session with a summary
- `/motivate` - Get inspirational coding wisdom

## Installation

### From a marketplace:
```bash
/plugin install hello-plugin@your-marketplace
```

### For local testing:
```bash
# Add the parent directory as a marketplace
/plugin marketplace add /path/to/examples/01-beginner/hello-plugin

# Install the plugin
/plugin install hello-plugin@local
```

## Usage Examples

```bash
# Start your coding session
/greet

# Get some motivation
/motivate

# End your session
/goodbye
```

## Learning Points

This plugin demonstrates:
- ✅ Basic plugin structure
- ✅ Creating simple slash commands
- ✅ Using frontmatter for command metadata
- ✅ Writing clear command descriptions

## File Structure

```
hello-plugin/
├── .claude-plugin/
│   └── plugin.json          # Plugin metadata
├── commands/
│   ├── greet.md            # Welcome command
│   ├── goodbye.md          # Farewell command
│   └── motivate.md         # Motivation command
└── README.md               # Documentation
```

## Next Steps

After mastering this example, try:
1. Adding your own custom commands
2. Experimenting with command arguments (see git-helper-plugin)
3. Creating namespaced commands in subdirectories
4. Moving on to intermediate examples with agents and hooks
