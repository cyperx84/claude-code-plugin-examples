---
description: Add automation hooks to an existing plugin
allowed-tools: Write, Read, Edit
---

# Add Hook

Add a hook to plugin: $1

**Hook type:** $2 (PreToolUse, PostToolUse, UserPromptSubmit, etc.)

**Process:**

1. **Gather Hook Details:**
   - Event type (PreToolUse, PostToolUse, etc.)
   - Tool pattern (which tools to hook)
   - Command to execute
   - Should it block on error?
   - Timeout duration

2. **Create/Update hooks.json:**
   ```json
   {
     "hooks": [
       {
         "event": "PreToolUse",
         "tool": "Bash(git:commit:*)",
         "command": "bash ./scripts/pre-commit-check.sh",
         "description": "Run checks before commit",
         "block_on_error": true,
         "timeout": 30000
       }
     ]
   }
   ```

3. **Create Script (if needed):**
   If hook needs a script:
   ```bash
   #!/bin/bash
   # Hook script

   set -e

   echo "Running hook..."

   # Hook logic here

   exit 0
   ```

4. **Make Script Executable:**
   ```bash
   chmod +x scripts/hook-script.sh
   ```

5. **Update Plugin:**
   - Add hook to hooks.json
   - Create script if needed
   - Update README with hook info

6. **Report:**
   ```
   ✅ Added hook: event-name
   📄 File: hooks/hooks.json
   🔧 Script: scripts/hook-script.sh (if created)
   ⚙️  Trigger: [event] on [tool]

   Hook will execute: [command]
   Block on error: [yes/no]
   ```

**Hook Event Types:**
- PreToolUse - Before tool execution
- PostToolUse - After tool success
- UserPromptSubmit - On user message
- SessionStart - When session starts
- SessionEnd - When session ends
- Stop - After Claude responds

**Example Usage:**
```
/add-hook testing-plugin PreToolUse
/add-hook devops-plugin PostToolUse
```
