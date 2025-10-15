---
description: Create a new Claude Code plugin from scratch
allowed-tools: Write, Bash(mkdir:*,chmod:*)
---

# Create Plugin Command

Create a new Claude Code plugin: $ARGUMENTS

**Process:**

1. **Gather Requirements:**
   - Plugin name (from $ARGUMENTS or ask)
   - Plugin description
   - What commands should it have?
   - Does it need agents?
   - Does it need hooks?
   - Does it need MCP integration?

2. **Generate Structure:**
   ```bash
   mkdir -p my-plugin/.claude-plugin
   mkdir -p my-plugin/commands
   mkdir -p my-plugin/agents
   mkdir -p my-plugin/hooks
   mkdir -p my-plugin/scripts
   ```

3. **Create plugin.json:**
   ```json
   {
     "name": "plugin-name",
     "version": "1.0.0",
     "description": "User-provided description",
     "author": {
       "name": "Author name"
     },
     "keywords": ["generated", "auto-created"],
     "license": "MIT"
   }
   ```

4. **Generate Commands:**
   For each command requested:
   - Create `commands/command-name.md`
   - Add frontmatter with description
   - Add command instructions based on requirements

5. **Generate Agents (if requested):**
   For each agent:
   - Create `agents/agent-name.md`
   - Add frontmatter with tools and proactive flag
   - Write comprehensive system prompt

6. **Generate Hooks (if requested):**
   - Create `hooks/hooks.json`
   - Add requested hook events
   - Create any needed scripts

7. **Generate MCP Config (if requested):**
   - Create `.mcp.json`
   - Add server configurations
   - Document required environment variables

8. **Generate README.md:**
   - Plugin description
   - Features list
   - Installation instructions
   - Usage examples
   - Configuration requirements

9. **Generate Tests:**
   - Create validation script
   - Test plugin structure

10. **Summary:**
    ```
    ✅ Created plugin: my-plugin/
    ├── .claude-plugin/plugin.json
    ├── commands/ (X commands)
    ├── agents/ (Y agents)
    ├── hooks/ (Z hooks)
    ├── scripts/ (N scripts)
    └── README.md

    Next steps:
    1. Review generated files
    2. Customize as needed
    3. Test with: /plugin install my-plugin
    ```

**Example Usage:**
```
/create productivity-plugin with commands for standup and tasks
/create api-tester with GitHub MCP integration
/create security-scanner with proactive agents
```
