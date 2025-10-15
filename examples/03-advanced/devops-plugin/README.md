# DevOps Automation Plugin

Enterprise-grade DevOps automation with GitHub and Sentry MCP integration for production deployments.

## Features

### Commands
- `/deploy/production` - Production deployment with safety checks
- `/deploy/rollback` - Rapid rollback to previous version
- `/monitor/errors` - View Sentry errors via MCP
- `/monitor/health` - System health checks

### Agents
- `/agent sre` - Site Reliability Engineer (proactive pre-deployment)
- `/agent incident-responder` - Incident response (proactive on errors)

### MCP Integrations
- **GitHub** - Repository management, deployments, issues
- **Sentry** - Error monitoring and analysis

### Hooks
- **Pre-deploy** - Validation before Kubernetes deployments
- **Post-deploy** - Verification after deployments
- **Rollback alert** - Notifications on rollbacks
- **Pod status** - Show unhealthy pods on prompts

## Installation

```bash
# Add marketplace
/plugin marketplace add /path/to/examples/03-advanced/devops-plugin

# Install plugin
/plugin install devops-plugin@local

# Restart Claude Code to activate MCP servers
```

## MCP Configuration

### Required Environment Variables

```bash
# GitHub
export GITHUB_TOKEN="ghp_your_token_here"

# Sentry
export SENTRY_TOKEN="your_sentry_token"
export SENTRY_ORG="your_org_name"
export SENTRY_PROJECT="your_project_name"
```

### Verify MCP Servers

```bash
# Check MCP server status
/mcp

# Should show:
# ✅ github - Connected
# ✅ sentry - Connected
```

## Usage Examples

### Production Deployment

```bash
/deploy/production

# Process:
# 1. SRE agent validates automatically:
#    ✅ Tests passing
#    ✅ Cluster healthy
#    ✅ No critical Sentry errors
#    ✅ Resources sufficient
#
# 2. Deployment executes:
#    - Build Docker image
#    - Run database migrations
#    - Deploy to Kubernetes
#    - Health checks
#    - Monitor for 5 minutes
#
# 3. Result:
#    ✅ Deployed successfully
#    ✅ All pods running
#    ✅ No new errors
```

### Monitor Errors (MCP)

```bash
/monitor/errors

# Output (fetched via Sentry MCP):
# Sentry Error Report (Last 1 hour)
# ================================
#
# 🔴 CRITICAL (2 issues, 45 events)
# └─ Authentication timeout
#    └─ 45 events, 23 affected users
#    └─ Error: "Token validation failed"
#
# 🟡 MEDIUM (1 issue, 12 events)
# └─ Image upload slow
#
# ✅ Error rate: 0.3% (normal)
```

### Rapid Rollback

```bash
/deploy/rollback

# Rolls back to previous version
# Much faster than forward deploy
# Hooks notify team automatically
```

### System Health

```bash
/monitor/health

# Output:
# Production Health: 98% ✅
#
# Components:
# ✅ API Server: 3/3 pods running
# ✅ Worker: 5/5 pods running
# ⚠️  Database: 75% connections
# ✅ Cache: Healthy
#
# Recommendations:
# - Monitor database connections
```

## Learning Points

This plugin demonstrates:

### ✅ MCP Integration
- **Multiple servers** - GitHub + Sentry
- **Environment variables** - Secure credential management
- **OAuth** - Authenticated API access
- **Real-time data** - Live error monitoring

### ✅ Advanced Agent Patterns

**SRE Agent (Proactive):**
- Triggered before deployments
- Comprehensive validation
- Multi-source checks (GitHub, Sentry, Kubernetes)
- Block deployments if issues found

**Incident Responder (Proactive):**
- Triggered on error spikes
- Rapid triage and mitigation
- Root cause analysis
- Post-mortem documentation

### ✅ Production-Grade Hooks

**PreToolUse - Safety:**
```json
{
  "event": "PreToolUse",
  "tool": "Bash(kubectl:apply*)",
  "command": "pre-deploy-validation.sh",
  "block_on_error": true
}
```
Prevents bad deployments.

**PostToolUse - Verification:**
```json
{
  "event": "PostToolUse",
  "tool": "Bash(kubectl:apply*)",
  "command": "post-deploy-checks.sh"
}
```
Ensures deployment success.

### ✅ Enterprise Patterns
- Multi-stage deployments
- Automated rollbacks
- Health monitoring
- Incident response
- Post-mortem workflows

## File Structure

```
devops-plugin/
├── .claude-plugin/
│   └── plugin.json
├── .mcp.json                    # MCP server configuration
├── commands/
│   ├── deploy/
│   │   ├── production.md       # Production deploy
│   │   └── rollback.md         # Rollback
│   └── monitor/
│       ├── errors.md           # Sentry errors (MCP)
│       └── health.md           # Health checks
├── agents/
│   ├── sre.md                  # Pre-deploy validation
│   └── incident-responder.md   # Incident response
├── hooks/
│   └── hooks.json              # 4 production hooks
├── scripts/
│   ├── pre-deploy-validation.sh
│   ├── post-deploy-checks.sh
│   └── notify-rollback.sh
└── README.md
```

## MCP Integration Details

### GitHub MCP Server

**Capabilities:**
- Create/update issues
- Manage pull requests
- Trigger workflows
- Create deployments
- Search code

**Example usage in commands:**
```markdown
Using GitHub MCP, check if CI/CD pipeline passed for current branch.
Create a deployment event after successful deploy.
```

### Sentry MCP Server

**Capabilities:**
- Query errors by timeframe
- Get error details and stack traces
- Analyze error trends
- Get affected user counts
- Create/update issues

**Example usage in commands:**
```markdown
Using Sentry MCP, fetch errors from last hour.
Group by issue and show severity.
```

## Deployment Safety Checklist

**Pre-deployment (Automated by SRE agent):**
- [ ] All tests passing
- [ ] No linting errors
- [ ] Code coverage > 80%
- [ ] Cluster healthy (all nodes ready)
- [ ] Sufficient resources (CPU < 70%, Memory < 80%)
- [ ] No critical Sentry errors (last hour)
- [ ] Error rate normal
- [ ] No ongoing incidents
- [ ] No concurrent deployments

**Post-deployment (Automated by hooks):**
- [ ] All pods running
- [ ] Health checks passing
- [ ] No new Sentry errors
- [ ] Response times normal
- [ ] Error rate stable
- [ ] Smoke tests passed

## Incident Response Protocol

### SEV1 (Critical)
- **Impact:** Service outage, data loss
- **Response:** Immediate mitigation (rollback)
- **Timeline:** Resolve within 1 hour
- **Escalation:** Notify on-call, page team

### SEV2 (High)
- **Impact:** Major feature broken
- **Response:** Mitigate within 2 hours
- **Timeline:** Fix within 4 hours
- **Escalation:** Notify team

### SEV3 (Medium)
- **Impact:** Minor issue, workaround available
- **Response:** Fix in next sprint
- **Timeline:** Fix within 1 week

## Troubleshooting

### MCP Servers Not Connecting

```bash
# Check environment variables
echo $GITHUB_TOKEN
echo $SENTRY_TOKEN

# Test MCP server manually
npx -y @modelcontextprotocol/server-github

# Check Claude Code debug logs
claude --debug
```

### Hooks Not Triggering

```bash
# Test hooks manually
bash scripts/pre-deploy-validation.sh
bash scripts/post-deploy-checks.sh

# Verify hook configuration
cat hooks/hooks.json | jq .

# Check permissions
ls -la scripts/
```

### Agents Not Responding

```bash
# Verify agent files
cat agents/sre.md | head -10

# Check for proactive flag
grep "proactive: true" agents/*.md
```

## Best Practices

### Deployment
1. **Deploy during low-traffic hours**
2. **Deploy one service at a time**
3. **Monitor for 5-10 minutes post-deploy**
4. **Have rollback plan ready**

### Monitoring
1. **Set up alerts for error rate spikes**
2. **Monitor resource usage trends**
3. **Review Sentry daily**
4. **Track deployment frequency**

### Incident Response
1. **Mitigate first, investigate later**
2. **Communicate frequently**
3. **Document everything**
4. **Blameless post-mortems**
5. **Action items with owners**

## Next Steps

- **Customize** - Adapt to your infrastructure
- **Extend** - Add more MCP servers (Datadog, PagerDuty)
- **Integrate** - Connect to CI/CD pipeline
- **Scale** - Multi-region deployments
- **Real-world** - Apply to production

## Related Examples

- **Intermediate:** testing-plugin (agents and hooks)
- **Advanced:** Marketplace examples
- **Real-world:** Full production setup
