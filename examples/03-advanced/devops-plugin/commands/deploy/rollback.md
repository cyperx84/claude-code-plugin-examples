---
description: Rollback production deployment to previous version
allowed-tools: Bash(kubectl:*), Bash(helm:*)
---

# Production Rollback

Rollback production deployment to version: $1 (or previous version if not specified)

**Process:**

1. **Identify current and target versions:**
   - Show current deployment
   - List last 5 deployments
   - Confirm rollback target

2. **Pre-rollback checks:**
   - Verify target version exists
   - Check target version health (from logs)
   - Ensure cluster has capacity

3. **Execute rollback:**
   - Use Kubernetes rollout undo
   - Monitor pod replacements
   - Wait for all pods ready

4. **Verification:**
   - Health check passing
   - No new errors in Sentry
   - Critical flows working

5. **Notifications:**
   - Update GitHub deployment status
   - Create Sentry release marker
   - Notify team via hooks

**Safety:** Rollback is much faster than forward deployment (no builds/migrations)

**Example usage:**
```bash
/deploy/rollback
/deploy/rollback v2.4.0
```
