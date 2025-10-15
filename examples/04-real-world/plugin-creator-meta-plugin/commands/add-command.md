---
description: Add a new command to an existing plugin
allowed-tools: Write, Read, Grep
---

# Add Command

Add a new command to plugin: $1

**Command name:** $2 (or prompt if not provided)

**Process:**

1. **Validate Plugin:**
   - Check that plugin directory exists
   - Verify plugin.json is valid
   - Confirm commands/ directory exists

2. **Gather Command Details:**
   - Command name (kebab-case)
   - Command description
   - What should it do?
   - What arguments does it need?
   - What tools should it use?
   - Should it be namespaced?

3. **Generate Command File:**
   ```markdown
   ---
   description: Brief description of command
   allowed-tools: Read, Write, Bash(git:*)
   ---

   # Command Name

   [Detailed instructions for what Claude should do]

   Use $ARGUMENTS for command arguments.
   Use $1, $2 for specific arguments.

   **Process:**
   1. Step one
   2. Step two
   3. Step three

   **Example usage:**
   - `/command arg1 arg2`
   ```

4. **Update Plugin:**
   - Write command file to commands/
   - If namespaced, create subdirectory
   - Make scripts executable if needed

5. **Update README:**
   - Add command to features list
   - Add usage example
   - Document any new requirements

6. **Report:**
   ```
   ✅ Added command: /command-name
   📄 File: commands/command-name.md
   📝 Updated: README.md

   Test with: /command-name [args]
   ```

**Example Usage:**
```
/add-command my-plugin deploy
/add-command testing-plugin generate-test
```
