---
description: Check production system health
allowed-tools: Bash(kubectl:get,describe), Bash(curl:*)
---

# System Health Check

Check production system health for: $ARGUMENTS (or all services if not specified)

**Health indicators:**

1. **Kubernetes Cluster:**
   - Node status (Ready/NotReady)
   - Pod status (Running/Pending/Failed)
   - Resource usage (CPU, Memory)
   - Available capacity

2. **Application Health:**
   - Health endpoint status
   - Response time
   - Error rate (from Sentry MCP)
   - Active connections

3. **Dependencies:**
   - Database connectivity
   - Redis/Cache status
   - External API availability
   - Message queue depth

4. **Recent Deployments:**
   - Last deployment time
   - Deployment status
   - Git SHA and version

**Health Score:**
```
Production Health: 98% ✅

Components:
✅ API Server: Healthy (3/3 pods running)
✅ Worker: Healthy (5/5 pods running)
⚠️  Database: Degraded (high connection count)
✅ Cache: Healthy
✅ External APIs: Healthy

Recent Issues:
- Database connection spike (+40%) - investigating

Recommendations:
- Scale database connections
- Monitor for 10 more minutes
```

**Auto-invoke incident responder if health < 90%**

**Example usage:**
```bash
/monitor/health
/monitor/health api-server
```
