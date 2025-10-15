---
description: Monitor recent errors from Sentry via MCP
---

# Error Monitoring

Monitor errors from Sentry for: $ARGUMENTS (or last hour if not specified)

**Using Sentry MCP integration to:**

1. **Fetch recent errors:**
   - Query Sentry API via MCP
   - Filter by timeframe
   - Group by issue

2. **Analyze errors:**
   - Count by severity
   - Identify new vs recurring
   - Find error spikes
   - Top affected users

3. **Prioritize:**
   - Critical: User-impacting, high frequency
   - High: Broken functionality
   - Medium: Degraded experience
   - Low: Edge cases

4. **Present findings:**
   ```
   Sentry Error Report (Last 1 hour)
   ================================

   🔴 CRITICAL (2 issues, 45 events)
   └─ Authentication timeout
      └─ 45 events, 23 affected users
      └─ First seen: 42 minutes ago
      └─ Error: "Token validation failed"

   🟡 MEDIUM (1 issue, 12 events)
   └─ Image upload slow
      └─ 12 events, 8 affected users
      └─ First seen: 15 minutes ago

   ✅ Error rate: Normal (0.3% of requests)
   ```

5. **Offer actions:**
   - Invoke `/agent incident-responder` for critical issues
   - Link to Sentry issue page
   - Suggest rollback if needed
   - Create GitHub issue

**Example usage:**
```bash
/monitor/errors
/monitor/errors last 24 hours
/monitor/errors critical only
```
