---
description: Deploy to production with comprehensive safety checks
allowed-tools: Bash(kubectl:*), Bash(helm:*), Bash(docker:*)
---

# Production Deployment

Deploy to production environment: $ARGUMENTS (defaults to current branch)

**⚠️ CRITICAL: Production deployment requires multiple safety checks**

## Pre-deployment Validation

1. **Invoke SRE Agent:**
   - Use `/agent sre` to run comprehensive pre-deployment checks
   - Agent validates:
     - All tests passing
     - No critical Sentry errors in last hour
     - Production health checks green
     - No ongoing incidents
     - Sufficient cluster resources

2. **GitHub Checks:**
   - Verify CI/CD pipeline passed
   - Check required reviews approved
   - Ensure branch is up to date with main
   - No WIP or draft PRs

3. **Sentry Checks:**
   - Query recent errors using MCP
   - Block if critical errors in last hour
   - Warn if error rate trending up

4. **Manual Confirmation:**
   - Show deployment summary
   - Require explicit "yes" to proceed
   - Timeout after 30 seconds

## Deployment Process

1. **Build:**
   - Build Docker image
   - Tag with git SHA and version
   - Push to container registry
   - Verify image pushed successfully

2. **Database Migrations:**
   - Check for pending migrations
   - Run migrations in transaction
   - Verify migration success
   - Rollback on failure

3. **Deploy Application:**
   - Apply Kubernetes manifests
   - Use rolling update strategy
   - Wait for pods to be ready
   - Monitor pod status

4. **Health Checks:**
   - Wait for health endpoint to return 200
   - Check all pods running
   - Verify service endpoints
   - Test critical user flows

5. **Post-deployment:**
   - Create GitHub deployment event
   - Tag release in Sentry
   - Run smoke tests
   - Monitor error rates for 5 minutes

## Rollback on Failure

If ANY step fails:
1. Immediately stop deployment
2. Rollback to previous version
3. Create incident in GitHub
4. Alert on-call engineer
5. Document failure reason

## Success Criteria

✅ All pods healthy
✅ Health check passing
✅ No new Sentry errors
✅ Response times normal
✅ Error rate stable

**Example usage:**
```bash
/deploy/production
/deploy/production v2.5.0
```
