---
description: Add a specialized agent to an existing plugin
allowed-tools: Write, Read
---

# Add Agent

Add a new agent to plugin: $1

**Agent name:** $2 (or prompt if not provided)

**Process:**

1. **Gather Agent Requirements:**
   - Agent name (kebab-case)
   - Agent purpose/specialization
   - What tools does it need?
   - Should it be proactive?
   - When should it activate?

2. **Generate Agent File:**
   ```markdown
   ---
   description: Agent's specialization and purpose
   tools: [Read, Write, Bash, Grep]
   proactive: true
   ---

   # Agent Name

   You are a specialized [role] focused on [purpose].

   ## Your Expertise
   - Expertise area 1
   - Expertise area 2

   ## When to Activate
   [Conditions for proactive activation]

   ## Your Workflow
   1. Step one
   2. Step two
   3. Step three

   ## Best Practices
   **DO:**
   - ✅ Good practice 1
   - ✅ Good practice 2

   **DON'T:**
   - ❌ Bad practice 1
   - ❌ Bad practice 2
   ```

3. **Configure Proactive Behavior:**
   If proactive:
   - Define trigger conditions
   - Specify when to activate
   - Set activation patterns

4. **Update Plugin:**
   - Write agent file to agents/
   - Update README with agent info
   - Document agent usage

5. **Report:**
   ```
   ✅ Added agent: agent-name
   📄 File: agents/agent-name.md
   🤖 Type: [Proactive/Manual]
   🛠️  Tools: [tool list]

   Invoke with: /agent agent-name
   ```

**Example Usage:**
```
/add-agent testing-plugin test-debugger
/add-agent devops-plugin incident-responder
```
