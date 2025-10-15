# Claude Code Plugin Examples

Comprehensive collection of Claude Code plugin examples from beginner to advanced, with real-world use cases, tests, and marketplaces.

## 📚 Table of Contents

- [Quick Start](#quick-start)
- [Example Plugins](#example-plugins)
  - [Beginner](#beginner-examples)
  - [Intermediate](#intermediate-examples)
  - [Advanced](#advanced-examples)
- [Installation](#installation)
- [Testing](#testing)
- [Marketplaces](#marketplaces)
- [Real-World Examples](#real-world-examples-from-the-community)
- [Learning Path](#learning-path)

## Quick Start

### Install from Marketplace

```bash
# Start Claude Code
claude

# Add the examples marketplace
/plugin marketplace add /path/to/examples/marketplaces/complete-marketplace

# Browse and install plugins
/plugin

# Or install directly
/plugin install hello-plugin@claude-code-learning-examples
```

### Test All Plugins

```bash
# From examples directory
bash tests/test-all-plugins.sh

# Test specific plugin
bash tests/test-plugin-structure.sh 01-beginner/hello-plugin
```

## Example Plugins

### Beginner Examples

Master the fundamentals of Claude Code plugins.

#### 1. Hello Plugin
**Location:** `01-beginner/hello-plugin/`
**Difficulty:** ⭐ Beginner
**Components:** Commands only

Simple greeting plugin demonstrating basic plugin structure.

**Features:**
- `/greet` - Welcome message with programming jokes
- `/goodbye` - Session summary
- `/motivate` - Coding inspiration

**Learn:**
- ✅ Basic plugin structure
- ✅ Creating simple commands
- ✅ Using frontmatter metadata
- ✅ Writing descriptions

**Install:**
```bash
/plugin install hello-plugin@claude-code-learning-examples
```

---

#### 2. Git Helper Plugin
**Location:** `01-beginner/git-helper-plugin/`
**Difficulty:** ⭐⭐ Beginner
**Components:** Commands with arguments

Git workflow automation demonstrating command arguments.

**Features:**
- `/commit [message]` - Smart git commits
- `/branch [name]` - Branch creation with conventions
- `/status` - Comprehensive repo status
- `/undo [what]` - Safe undo operations
- `/sync` - Remote synchronization

**Learn:**
- ✅ Command arguments (`$ARGUMENTS`, `$1`, `$2`)
- ✅ Tool restrictions (`allowed-tools`)
- ✅ Safety patterns (confirmations)
- ✅ Error handling
- ✅ User interaction

**Install:**
```bash
/plugin install git-helper-plugin@claude-code-learning-examples
```

---

#### 3. Code Snippets Plugin
**Location:** `01-beginner/code-snippets-plugin/`
**Difficulty:** ⭐⭐ Beginner
**Components:** Namespaced commands

Code generation and refactoring with organized command structure.

**Features:**
- `/explain @file` - Code analysis
- `/snippets/function [lang] [name]` - Function templates
- `/snippets/class [lang] [name]` - Class templates
- `/snippets/test @file` - Test generation
- `/refactor/extract` - Extract code to functions
- `/refactor/simplify @file` - Simplify complex code

**Learn:**
- ✅ Namespaced commands (subdirectories)
- ✅ File references (`@filename`)
- ✅ Multi-language support
- ✅ Template generation
- ✅ Code analysis

**Install:**
```bash
/plugin install code-snippets-plugin@claude-code-learning-examples
```

---

### Intermediate Examples

Level up with agents and hooks for automation.

#### 4. Testing Automation Plugin
**Location:** `02-intermediate/testing-plugin/`
**Difficulty:** ⭐⭐⭐ Intermediate
**Components:** Commands + Agents + Hooks + Scripts

Comprehensive testing automation with specialized AI agents.

**Features:**

**Commands:**
- `/test-all` - Run full test suite with coverage
- `/test-file @file` - Test specific files
- `/coverage [path]` - Coverage analysis
- `/watch [pattern]` - Watch mode

**Agents:**
- `/agent test-generator` - Generate comprehensive tests
- `/agent test-debugger` - Debug failing tests (proactive)

**Hooks:**
- Pre-commit: Run tests before commits (blocks if fail)
- Post-test: Check coverage thresholds
- File-modified: Notify on test file changes
- Prompt-submit: Show recent test status

**Learn:**
- ✅ Agent creation and configuration
- ✅ Proactive vs non-proactive agents
- ✅ Hook events and patterns
- ✅ Script integration
- ✅ Multi-framework support

**Install:**
```bash
/plugin install testing-plugin@claude-code-learning-examples
```

---

#### 5. Productivity Plugin
**Location:** `02-intermediate/productivity-plugin/`
**Difficulty:** ⭐⭐⭐ Intermediate
**Components:** Commands + Agents + Hooks

Daily productivity tools for developers.

**Features:**
- `/standup` - Generate daily standup from git activity
- `/review [target]` - Code review with auto-agent invocation
- `/agent code-reviewer` - Specialized reviewer (proactive)

**Learn:**
- ✅ Proactive agents
- ✅ Agent auto-invocation from commands
- ✅ Session hooks
- ✅ Git integration

**Install:**
```bash
/plugin install productivity-plugin@claude-code-learning-examples
```

---

### Advanced Examples

Production-ready plugins with MCP integration.

#### 6. DevOps Automation Plugin
**Location:** `03-advanced/devops-plugin/`
**Difficulty:** ⭐⭐⭐⭐⭐ Advanced
**Components:** Commands + Agents + Hooks + MCP Servers + Scripts

Enterprise DevOps automation with GitHub and Sentry integration.

**Features:**

**Commands:**
- `/deploy/production` - Production deployments
- `/deploy/rollback` - Rapid rollback
- `/monitor/errors` - Sentry error monitoring (MCP)
- `/monitor/health` - System health checks

**Agents:**
- `/agent sre` - Site Reliability Engineer (proactive pre-deploy)
- `/agent incident-responder` - Incident response (proactive on errors)

**MCP Servers:**
- **GitHub** - Repository management, deployments
- **Sentry** - Error monitoring and analysis

**Hooks:**
- Pre-deploy: Validation before Kubernetes deployments
- Post-deploy: Verification after deployments
- Rollback alert: Notifications on rollbacks
- Pod status: Show unhealthy pods

**Learn:**
- ✅ MCP server integration
- ✅ Multiple MCP servers
- ✅ OAuth authentication
- ✅ Production-grade hooks
- ✅ Enterprise patterns
- ✅ Incident response workflows
- ✅ Deployment safety

**Requirements:**
```bash
export GITHUB_TOKEN="ghp_your_token"
export SENTRY_TOKEN="your_sentry_token"
export SENTRY_ORG="your_org"
export SENTRY_PROJECT="your_project"
```

**Install:**
```bash
/plugin install devops-plugin@claude-code-learning-examples
```

---

## Installation

### Option 1: Install from Marketplaces

**Beginner Marketplace:**
```bash
/plugin marketplace add /path/to/examples/marketplaces/beginner-marketplace
/plugin
```

**Intermediate Marketplace:**
```bash
/plugin marketplace add /path/to/examples/marketplaces/intermediate-marketplace
/plugin
```

**Advanced Marketplace:**
```bash
/plugin marketplace add /path/to/examples/marketplaces/advanced-marketplace
/plugin
```

**Complete Marketplace (All Examples):**
```bash
/plugin marketplace add /path/to/examples/marketplaces/complete-marketplace
/plugin
```

### Option 2: Manual Testing

Copy a plugin directory to your project's `.claude/` folder or use as a local marketplace.

## Testing

### Test All Plugins

```bash
cd examples
bash tests/test-all-plugins.sh
```

**Output:**
```
🧪 Testing All Example Plugins
==============================

📚 BEGINNER PLUGINS
===================
✅ All critical tests passed for: hello-plugin
✅ All critical tests passed for: git-helper-plugin
✅ All critical tests passed for: code-snippets-plugin

📚 INTERMEDIATE PLUGINS
=======================
✅ All critical tests passed for: testing-plugin
✅ All critical tests passed for: productivity-plugin

📚 ADVANCED PLUGINS
===================
✅ All critical tests passed for: devops-plugin

==============================
📊 TEST SUMMARY
==============================
Total plugins tested: 6
✅ Passed: 6
❌ Failed: 0

🎉 All plugins passed validation!
```

### Test Individual Plugin

```bash
bash tests/test-plugin-structure.sh 01-beginner/hello-plugin
```

**Tests performed:**
1. ✅ `plugin.json` exists and valid JSON
2. ✅ Required fields present (name, version)
3. ✅ Commands have valid frontmatter
4. ✅ Agents have valid frontmatter
5. ✅ `hooks.json` is valid JSON
6. ✅ `.mcp.json` is valid JSON
7. ✅ Scripts are executable
8. ✅ README.md exists

## Marketplaces

### Marketplace Structure

```
marketplaces/
├── beginner-marketplace/
│   └── .claude-plugin/
│       └── marketplace.json          # 3 beginner plugins
├── intermediate-marketplace/
│   └── .claude-plugin/
│       └── marketplace.json          # 2 intermediate plugins
├── advanced-marketplace/
│   └── .claude-plugin/
│       └── marketplace.json          # 1 advanced plugin
└── complete-marketplace/
    └── .claude-plugin/
        └── marketplace.json          # All 6 plugins
```

### Using Marketplaces

**Add marketplace:**
```bash
/plugin marketplace add /path/to/examples/marketplaces/complete-marketplace
```

**List marketplaces:**
```bash
/plugin marketplace list
```

**Browse plugins:**
```bash
/plugin
```

**Install plugin:**
```bash
/plugin install hello-plugin@claude-code-learning-examples
```

## Real-World Examples from the Community

Based on research of popular Claude Code plugin repositories:

### 1. jeremylongshore/claude-code-plugins
**225 production-ready plugins across 15 categories**

**Categories:**
- Project Health Auditing
- API Development & Debugging
- Design-to-Code Conversion
- DevOps Automation
- Security Analysis
- Documentation Generation

**Notable features:**
- Conversational API Debugger
- Design to Code converter
- Multi-agent orchestration
- MCP server integrations

**Install:**
```bash
/plugin marketplace add jeremylongshore/claude-code-plugins
```

### 2. wshobson/agents
**62 focused plugins with 84 specialized agents**

**Features:**
- Single-purpose agents
- Multi-agent workflow orchestrators
- Development tool integrations
- Intelligent automation

**Install:**
```bash
/plugin marketplace add wshobson/agents
```

### 3. brennercruvinel/CCPlugins
**24 professional commands for enterprise workflows**

**Optimized for:**
- Opus 4 and Sonnet 4 models
- Enterprise-grade development
- Production workflows
- Team collaboration

**Install:**
```bash
/plugin marketplace add brennercruvinel/CCPlugins
```

### 4. hesreallyhim/awesome-claude-code
**Curated list of awesome commands and workflows**

**Features:**
- Community-contributed examples
- CLAUDE.md files
- Best practices
- Workflow templates

**Visit:** https://github.com/hesreallyhim/awesome-claude-code

## Learning Path

### Phase 1: Fundamentals (Week 1-2)
**Goal:** Understand plugin basics

1. **Read:** [Claude Code Plugins Learning Guide](../LEARNING_GUIDE.md)
2. **Install:** hello-plugin
3. **Try:** All hello-plugin commands
4. **Study:** hello-plugin source code
5. **Create:** Your own simple greeting plugin
6. **Test:** Use test-plugin-structure.sh

**Checkpoint:** Can you create a simple command-only plugin?

### Phase 2: Arguments & Organization (Week 3-4)
**Goal:** Master command arguments and structure

1. **Install:** git-helper-plugin
2. **Try:** All git commands with different arguments
3. **Study:** Argument handling (`$ARGUMENTS`, `$1`)
4. **Install:** code-snippets-plugin
5. **Study:** Namespaced commands (subdirectories)
6. **Create:** Plugin with arguments and namespacing
7. **Test:** Validate your plugin

**Checkpoint:** Can you create namespaced commands with arguments?

### Phase 3: Agents & Hooks (Week 5-8)
**Goal:** Add AI agents and automation

1. **Install:** testing-plugin
2. **Try:** test-generator and test-debugger agents
3. **Study:** Agent configuration and system prompts
4. **Study:** Hook events and patterns
5. **Create:** Plugin with at least 1 agent and 2 hooks
6. **Test:** Ensure hooks trigger correctly

**Checkpoint:** Can you create specialized agents?

### Phase 4: MCP Integration (Week 9-12)
**Goal:** Connect to external services

1. **Install:** devops-plugin
2. **Setup:** GitHub and Sentry MCP servers
3. **Try:** Commands that use MCP
4. **Study:** .mcp.json configuration
5. **Study:** Agent coordination with MCP
6. **Create:** Plugin with at least 1 MCP integration

**Checkpoint:** Can you integrate external services via MCP?

### Phase 5: Production (Week 13+)
**Goal:** Build production-ready plugins

1. **Design:** Solve a real problem in your workflow
2. **Build:** Complete plugin with all components
3. **Test:** Comprehensive testing
4. **Document:** README, examples, troubleshooting
5. **Share:** Create marketplace, publish to GitHub
6. **Iterate:** Gather feedback, improve

**Checkpoint:** Have you shipped a production plugin?

## File Structure Reference

### Minimal Plugin (Beginner)
```
my-plugin/
├── .claude-plugin/
│   └── plugin.json              # Required
├── commands/
│   └── hello.md                 # At least one command
└── README.md                    # Recommended
```

### Complete Plugin (Advanced)
```
enterprise-plugin/
├── .claude-plugin/
│   └── plugin.json              # Plugin metadata
├── commands/                    # Slash commands
│   ├── cmd1.md
│   └── category/
│       └── cmd2.md              # Namespaced
├── agents/                      # AI agents
│   ├── specialist1.md
│   └── specialist2.md
├── hooks/                       # Event handlers
│   └── hooks.json
├── .mcp.json                    # MCP servers
├── scripts/                     # Helper scripts
│   ├── script1.sh
│   └── script2.sh
├── tests/                       # Plugin tests
│   └── test.sh
├── docs/                        # Documentation
│   └── usage.md
├── LICENSE
├── CHANGELOG.md
└── README.md
```

## Component Reference

### plugin.json (Required)
```json
{
  "name": "my-plugin",           // Required: kebab-case
  "version": "1.0.0",            // Required: semver
  "description": "...",          // Recommended
  "author": {
    "name": "...",
    "email": "...",
    "url": "..."
  },
  "keywords": ["..."],
  "license": "MIT",
  "homepage": "...",
  "repository": {
    "type": "git",
    "url": "..."
  }
}
```

### Command Frontmatter
```markdown
---
description: Brief command description
allowed-tools: Bash(git:*), Read, Write
---

# Command Content
Your command instructions here.
Use $ARGUMENTS for arguments.
```

### Agent Frontmatter
```markdown
---
description: Agent description
tools: [Read, Write, Bash]
proactive: true                  // or false
---

# Agent System Prompt
Your agent instructions here.
```

### hooks.json
```json
{
  "hooks": [
    {
      "event": "PreToolUse",
      "tool": "Bash(git:commit:*)",
      "command": "bash ./script.sh",
      "description": "...",
      "block_on_error": true,
      "timeout": 30000
    }
  ]
}
```

### .mcp.json
```json
{
  "mcpServers": {
    "github": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-github"],
      "env": {
        "GITHUB_PERSONAL_ACCESS_TOKEN": "${GITHUB_TOKEN}"
      }
    }
  }
}
```

## Troubleshooting

### Plugin Not Loading
```bash
# Check plugin.json validity
cat .claude-plugin/plugin.json | jq .

# Verify structure
ls -la

# Should show:
# .claude-plugin/
# commands/
# (other components)

# Check Claude Code debug logs
claude --debug
```

### Commands Not Appearing
```bash
# List installed plugins
/plugin

# Check command files
ls -la commands/
# All should end in .md

# Verify frontmatter
head -5 commands/mycommand.md
```

### Agents Not Working
```bash
# List agents
/agents

# Check agent frontmatter
head -10 agents/myagent.md

# Verify tools list
grep "tools:" agents/myagent.md
```

### Hooks Not Triggering
```bash
# Test hook script manually
bash scripts/my-hook.sh

# Check hooks.json
cat hooks/hooks.json | jq .

# Run with debug
claude --debug
```

### MCP Servers Not Connecting
```bash
# Check environment variables
env | grep TOKEN

# Test server manually
npx -y @modelcontextprotocol/server-github

# Verify .mcp.json
cat .mcp.json | jq .
```

## Contributing

Found an issue or have an improvement?

1. **Report issues:** Use the issue tracker
2. **Suggest improvements:** Open a discussion
3. **Submit examples:** Create pull requests
4. **Share plugins:** Add to community marketplaces

## License

All example plugins are licensed under MIT License - feel free to use and modify.

## Resources

- **Official Docs:** https://docs.claude.com/en/docs/claude-code/plugins
- **Learning Guide:** [LEARNING_GUIDE.md](../LEARNING_GUIDE.md)
- **Community Plugins:** Search GitHub for "claude-code-plugins"
- **MCP Servers:** https://github.com/modelcontextprotocol/servers

## Summary

This examples directory provides:

- **6 Complete Plugins** - From beginner to advanced
- **4 Marketplaces** - Easy installation options
- **Comprehensive Tests** - Validate plugin structure
- **Real-World Examples** - Community plugin references
- **Learning Path** - Structured progression
- **Full Documentation** - Every plugin documented

**Start your journey:**
```bash
# Install and try the first example
/plugin marketplace add /path/to/examples/marketplaces/complete-marketplace
/plugin install hello-plugin@claude-code-learning-examples
/greet
```

Happy plugin development! 🚀
