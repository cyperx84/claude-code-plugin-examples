# PR Reviewer Plugin

🔍 Automated pull request reviews with GitHub integration and AI-powered code analysis

## Overview

A comprehensive PR review system that uses GitHub MCP for real-time data and provides intelligent code quality analysis, security scanning, and collaborative review workflows.

## Features

### Commands

- `/review-pr [number]` - Comprehensive PR review with security & quality analysis
- `/create-pr [title]` - Create PR with auto-generated description
- `/pr-status [filter]` - Real-time PR status dashboard

### Agents

- `/agent code-quality-reviewer` - Deep code quality analysis (proactive)
  - Complexity metrics
  - Design pattern detection
  - Code smell identification
  - Maintainability scoring

### MCP Integration

- **GitHub** - Pull request management, live status, automated actions

## Installation

### Prerequisites

```bash
# GitHub Personal Access Token
export GITHUB_TOKEN="ghp_your_token_here"
```

Get token at: https://github.com/settings/tokens
Required scopes: `repo`, `write:discussion`

### Install Plugin

```bash
/plugin marketplace add ./examples/04-real-world
/plugin install pr-reviewer@real-world-examples
```

## Usage Examples

### Review a Pull Request

```bash
/review-pr 123

# Output:
# 🔍 Reviewing PR #123: "Add user authentication"
#
# Fetching from GitHub...
# ✅ PR found: 12 files, +450/-120 lines
#
# Analyzing...
# ✅ Security scan: 2 critical issues found
# ✅ Quality analysis: Maintainability 72/100
# ⚠️  Performance: N+1 query detected
#
# 🔴 Critical Issues: 2
# 1. Plain text password storage (src/auth/login.ts:45)
# 2. SQL injection risk (src/api/users.ts:78)
#
# 🟡 Major Suggestions: 5
# [Detailed review posted to GitHub]
```

### Create Pull Request

```bash
/create-pr "Add user authentication"

# Or let it auto-generate:
/create-pr

# Process:
# 🔍 Analyzing changes...
# - Type: Feature ✨
# - Files: 12 (+450/-120)
# - Related: #234
#
# Generating description...
# ✅ Created PR #456
# ✅ Auto-assigned: @alice, @bob
# ✅ Labels added: feature, backend
#
# https://github.com/org/repo/pull/456
```

### Check PR Status

```bash
/pr-status mine

# Dashboard:
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━
# 📊 MY PULL REQUESTS
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━
#
# #123 🟢 Add auth | ✅ 2/2 approvals | Ready
# #124 🟡 Fix bug | ⚠️  1/2 approvals | CI failing
# #125 🔴 Update deps | ❌ Changes requested
#
# Summary: 1 ready, 1 in progress, 1 blocked
```

## Real-World Patterns Demonstrated

### 1. MCP Integration Pattern

**Live Data Access:**
```markdown
Uses GitHub MCP to:
- Fetch PR metadata in real-time
- Post reviews automatically
- Update PR status
- Add labels and assignees
- Trigger workflows
```

**Benefits:**
- Always current data
- No API wrapper needed
- OAuth handled by MCP
- Consistent interface

### 2. Multi-Layer Analysis

**Security → Quality → Performance:**
```
1. Security (highest priority)
   - Vulnerability scanning
   - Auth/authorization
   - Input validation

2. Code Quality (maintainability)
   - Complexity analysis
   - Design patterns
   - Code smells

3. Performance (optimization)
   - Query efficiency
   - Algorithm complexity
   - Resource usage
```

### 3. Proactive Agent Pattern

**Code Quality Reviewer activates automatically:**
- When PR review requested
- When files modified
- On git push events

**Provides value without explicit invocation:**
- Continuous monitoring
- Early issue detection
- Consistent standards

### 4. Collaborative Workflow

**GitHub Integration:**
```
Claude ←→ GitHub MCP ←→ GitHub API
   ↓
Reviews, Comments, Status Updates
   ↓
Team Collaboration
```

### 5. Intelligent Automation

**Auto-Detection:**
- PR type (feature, bugfix, etc.)
- Appropriate reviewers
- Relevant labels
- Related issues
- Breaking changes

**Smart Actions:**
- Auto-assign reviewers
- Apply labels
- Link issues
- Trigger CI/CD
- Notify team

## Learning Points

### For Beginners

✅ **MCP Integration** - See how to connect to external services
✅ **Real-Time Data** - Fetch live GitHub data
✅ **Automated Actions** - Post reviews, create PRs
✅ **Status Dashboards** - Display complex data

### For Intermediate

✅ **Proactive Agents** - Automatic activation patterns
✅ **Multi-Criteria Analysis** - Security + Quality + Performance
✅ **Smart Detection** - PR type, reviewers, labels
✅ **Workflow Automation** - End-to-end PR lifecycle

### For Advanced

✅ **OAuth Flow** - MCP handles authentication
✅ **Complex Analysis** - Cyclomatic complexity, pattern detection
✅ **Metrics Tracking** - Maintainability scores, trends
✅ **Team Intelligence** - Learn from past reviews

## File Structure

```
pr-reviewer-plugin/
├── .claude-plugin/
│   └── plugin.json
├── .mcp.json                    # GitHub MCP configuration
├── commands/
│   ├── review-pr.md            # Comprehensive PR review
│   ├── create-pr.md            # Auto-generate PR
│   └── pr-status.md            # Status dashboard
├── agents/
│   └── code-quality-reviewer.md # Deep analysis (proactive)
└── README.md
```

## Configuration

### GitHub MCP Setup

The `.mcp.json` configuration connects to GitHub:

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

**Required:** Set `GITHUB_TOKEN` environment variable

### Customization

Adjust review criteria in commands:
- Security thresholds
- Complexity limits
- Code style rules
- Auto-merge conditions

## Advanced Features

### 1. Template-Based PR Creation

Auto-select templates based on:
- Branch name patterns
- Changed files
- Commit messages

### 2. Review Learning

Agent learns from:
- Accepted/rejected suggestions
- Team preferences
- Project patterns
- Historical reviews

### 3. Metrics Dashboard

Track over time:
- Average review time
- Common issues
- Code quality trends
- Team participation

### 4. Integration Points

Connect with:
- CI/CD systems
- Issue trackers
- Project management
- Communication tools (Slack, Discord)

## Best Practices

### Security Reviews

```
Priority Order:
1. Authentication/Authorization
2. Input validation
3. SQL injection
4. XSS vulnerabilities
5. Exposed secrets
6. Dependency vulnerabilities
```

### Code Quality Standards

```
Thresholds:
- Cyclomatic complexity: ≤10
- Function length: ≤50 lines
- Class length: ≤500 lines
- Parameters: ≤5 per function
- Nesting depth: ≤4 levels
```

### Review Etiquette

✅ **DO:**
- Be constructive
- Provide examples
- Explain reasoning
- Acknowledge good code
- Prioritize by importance

❌ **DON'T:**
- Nitpick trivial issues
- Block for style preferences
- Overwhelm with suggestions
- Be vague or dismissive

## Troubleshooting

### GitHub MCP Not Connecting

```bash
# Check token
echo $GITHUB_TOKEN

# Test MCP manually
npx -y @modelcontextprotocol/server-github

# Verify scopes
# Token needs: repo, write:discussion
```

### Review Not Posting

```bash
# Check permissions
# Need write access to repository

# Verify PR exists
/pr-status 123

# Try draft mode first
/review-pr 123 --draft
```

### Agent Not Activating

```bash
# Check proactive flag
grep "proactive: true" agents/code-quality-reviewer.md

# Manual invocation
/agent code-quality-reviewer

# Check file changes triggered
# Agent activates on file modifications
```

## Real-World Use Cases

### 1. Automated Code Review

**Scenario:** Team of 10 developers, 50+ PRs/week

**Solution:**
- Auto-review all PRs
- Flag critical issues
- Reduce human review time 30%
- Maintain quality standards

### 2. Security Gate

**Scenario:** Ensure no vulnerabilities merged

**Solution:**
- Scan every PR
- Block on critical findings
- Educate developers
- Track vulnerability trends

### 3. Onboarding Tool

**Scenario:** New developers learning codebase

**Solution:**
- Detailed review feedback
- Explain best practices
- Suggest improvements
- Learn project patterns

### 4. Quality Metrics

**Scenario:** Track code quality over time

**Solution:**
- Maintainability scores
- Complexity trends
- Issue frequency
- Improvement areas

## Next Steps

After mastering this plugin:

1. **Customize** - Adjust review criteria for your team
2. **Extend** - Add more MCP integrations (Jira, Slack)
3. **Integrate** - Connect to CI/CD pipeline
4. **Analyze** - Track metrics and trends
5. **Share** - Help other teams improve reviews

## Related Plugins

- **devops-plugin** - Deployment automation
- **testing-plugin** - Test generation
- **security-audit-plugin** - Security scanning
- **documentation-generator** - Auto-docs

---

**Real-World Pattern:** GitHub Integration with Automated Review
**Complexity:** ⭐⭐⭐⭐ Advanced
**MCP:** GitHub
**Best For:** Teams doing code reviews, quality improvement, security focus
