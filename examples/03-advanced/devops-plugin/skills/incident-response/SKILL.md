---
name: Incident Response
description: Structured approach to handling production incidents, from detection through resolution and post-mortem analysis
---

# Incident Response

## Purpose

Effective incident response through:
- Rapid incident detection
- Structured response process
- Clear communication
- Root cause analysis
- Prevention strategies

## When to Use

Invoke this skill when:
- Production outage occurs
- Performance degradation detected
- Security incident suspected
- Preparing incident runbooks
- Conducting post-mortems

## Incident Response Framework

### Incident Severity Levels

```
SEV 1 (Critical):
- Complete service outage
- Data loss/corruption
- Security breach
- Revenue impact: High

Response Time: Immediate
Team: Full on-call rotation

SEV 2 (High):
- Partial service degradation
- Major feature broken
- Affecting multiple customers
- Revenue impact: Medium

Response Time: <15 minutes
Team: Primary on-call + specialist

SEV 3 (Medium):
- Minor feature issue
- Affecting some users
- Workaround available
- Revenue impact: Low

Response Time: <1 hour
Team: Primary on-call

SEV 4 (Low):
- Cosmetic issues
- Single user affected
- No revenue impact

Response Time: Next business day
Team: During business hours
```

---

## Incident Response Process

### 1. Detection (Minutes 0-5)

**How Incidents Are Detected**:
```
- Automated alerts (monitoring)
- User reports (support tickets)
- Social media mentions
- Team members noticing issues
- Deployment gone wrong
```

**Initial Assessment**:
```typescript
interface Incident {
  severity: 'SEV1' | 'SEV2' | 'SEV3' | 'SEV4';
  description: string;
  affectedSystems: string[];
  userImpact: string;
  startTime: Date;
}

function assessIncident(alert: Alert): Incident {
  // Determine severity
  const severity = calculateSeverity({
    usersAffected: alert.affectedUsers,
    systemsDown: alert.failingSystems,
    revenueImpact: alert.estimatedRevenueLoss,
  });

  return {
    severity,
    description: alert.message,
    affectedSystems: alert.systems,
    userImpact: estimateUserImpact(alert),
    startTime: new Date(),
  };
}
```

---

### 2. Response (Minutes 5-10)

**Immediate Actions**:
```
1. Acknowledge the incident
2. Determine severity
3. Page appropriate team
4. Create incident channel (#incident-YYYY-MM-DD-description)
5. Assign roles
6. Start incident log
```

**Incident Roles**:
```
Incident Commander (IC):
- Coordinates response
- Makes decisions
- Manages communication

Technical Lead:
- Drives technical investigation
- Implements fixes
- Coordinates engineers

Communications Lead:
- Updates stakeholders
- Posts status updates
- Manages customer communication

Scribe:
- Documents timeline
- Records decisions
- Maintains incident log
```

**Incident Channel Setup**:
```bash
# Slack channel naming
#incident-2025-01-15-auth-service-down

# Pin critical information
- Severity: SEV 1
- Started: 2025-01-15 14:23 UTC
- Roles:
  - IC: @alice
  - Tech Lead: @bob
  - Comms: @charlie
  - Scribe: @dave
- Status Page: https://status.company.com
- War Room: https://zoom.us/incident-room
```

---

### 3. Investigation (Minutes 10-30)

**Systematic Debugging**:
```typescript
class IncidentInvestigation {
  async investigate(incident: Incident): Promise<RootCause> {
    // 1. Check recent changes
    const recentDeploys = await getRecentDeployments({ hours: 2 });
    const recentConfigChanges = await getConfigChanges({ hours: 2 });

    // 2. Review metrics
    const metrics = await getMetrics({
      services: incident.affectedSystems,
      timeRange: { start: incident.startTime, end: new Date() },
    });

    // 3. Analyze logs
    const errors = await searchLogs({
      level: 'ERROR',
      services: incident.affectedSystems,
      since: incident.startTime,
    });

    // 4. Check dependencies
    const dependencyHealth = await checkDependencies(incident.affectedSystems);

    // 5. Form hypothesis
    const hypothesis = this.formHypothesis({
      recentChanges: [...recentDeploys, ...recentConfigChanges],
      metrics,
      errors,
      dependencyHealth,
    });

    return hypothesis;
  }

  formHypothesis(data: InvestigationData): RootCause {
    // Correlate data to find most likely cause
    // ...
  }
}
```

**Common Investigation Queries**:
```
# Check for recent deployments
kubectl rollout history deployment/auth-service

# View recent errors
grep "ERROR" /var/log/app.log | tail -100

# Check resource usage
kubectl top pods -n production

# Analyze traffic patterns
SELECT COUNT(*) FROM requests
WHERE timestamp > NOW() - INTERVAL '1 hour'
GROUP BY status_code;

# Review configuration changes
git log --since="2 hours ago" config/

# Check database connections
SELECT COUNT(*) FROM pg_stat_activity
WHERE state = 'active';
```

---

### 4. Mitigation (Minutes 30-60)

**Mitigation Strategies**:

**Immediate Fixes (Stop the Bleeding)**:
```typescript
// 1. Rollback recent deployment
await rollback(previousVersion);

// 2. Disable problematic feature
await featureFlags.disable('new-feature');

// 3. Scale up resources
await scaleService('auth-service', { replicas: 10 });

// 4. Switch to backup system
await failover('primary-db', 'backup-db');

// 5. Rate limit
await applyRateLimit({ requests: 100, period: '1m' });

// 6. Circuit breaker
await enableCircuitBreaker('external-api', { timeout: '5s' });
```

**Decision Tree**:
```
Is there a recent deployment?
├─ Yes: Rollback immediately
└─ No: Continue investigation

Is resource exhausted (CPU/Memory)?
├─ Yes: Scale up immediately
└─ No: Continue investigation

Is external dependency failing?
├─ Yes: Enable circuit breaker / Use backup
└─ No: Continue investigation

Is database overloaded?
├─ Yes: Enable read replicas / Cache
└─ No: Continue investigation
```

---

### 5. Communication

**Status Updates** (every 15-30 minutes):

```markdown
# Initial Update
**Status**: Investigating
**Impact**: Auth service experiencing high error rates. Users may be unable to log in.
**Started**: 14:23 UTC
**Next Update**: 14:45 UTC

# Progress Update
**Status**: Mitigation in progress
**Impact**: Continuing. We have identified the root cause and are deploying a fix.
**Actions**: Rolling back to previous version (v1.2.3)
**ETA**: Fix expected by 15:00 UTC
**Next Update**: 15:00 UTC

# Resolution Update
**Status**: Resolved
**Impact**: Auth service restored. All functionality operational.
**Resolution**: Rolled back deployment. Root cause: Memory leak in v1.3.0
**Next Steps**: Post-mortem scheduled for tomorrow 10am
```

**Communication Templates**:

```
# SEV 1 - Initial (Immediate)
Subject: [SEV1] Auth Service Outage
Body:
We are experiencing a critical outage affecting user authentication.

Impact: Users unable to log in
Started: 14:23 UTC
Team: Actively investigating

We will provide updates every 15 minutes.

# SEV 1 - Resolution
Subject: [RESOLVED] Auth Service Outage
Body:
The auth service outage has been resolved.

Duration: 37 minutes (14:23 - 15:00 UTC)
Impact: ~10,000 users affected
Resolution: Rolled back to v1.2.3

A detailed post-mortem will follow within 48 hours.

We apologize for the disruption.
```

---

### 6. Resolution

**Verification Checklist**:
```
- [ ] Metrics returned to normal
- [ ] Error rates back to baseline
- [ ] User reports stopped
- [ ] Synthetic monitoring passing
- [ ] Team confirms resolution
- [ ] Waited 30+ minutes (no recurrence)
```

**Resolution Actions**:
```typescript
async function resolveIncident(incidentId: string): Promise<void> {
  // 1. Verify fix
  const verified = await verifyResolution(incidentId);
  if (!verified) {
    throw new Error('Resolution not verified');
  }

  // 2. Update status page
  await statusPage.update({
    status: 'operational',
    message: 'All systems operational',
  });

  // 3. Send resolution notification
  await notify.sendResolution(incidentId, {
    channels: ['slack', 'email', 'status-page'],
  });

  // 4. Update incident record
  await incidents.update(incidentId, {
    status: 'resolved',
    resolvedAt: new Date(),
    resolution: 'Rolled back to previous version',
  });

  // 5. Schedule post-mortem
  await calendar.createEvent({
    title: `Post-Mortem: ${incidentId}`,
    time: '48 hours from now',
    attendees: incident.team,
  });
}
```

---

## Post-Incident Activities

### 1. Post-Mortem (Within 48 hours)

**Template**:
```markdown
# Post-Mortem: Auth Service Outage (2025-01-15)

## Summary
On Jan 15 2025, auth service experienced 37-minute outage affecting ~10,000 users.

## Timeline (UTC)
| Time  | Event |
|-------|-------|
| 14:20 | Deployment of v1.3.0 started |
| 14:23 | Error rates spiked to 45% |
| 14:25 | PagerDuty alert triggered |
| 14:27 | Incident declared SEV 1 |
| 14:30 | Investigation started |
| 14:42 | Root cause identified: Memory leak |
| 14:45 | Rollback initiated |
| 15:00 | Service restored |

## Root Cause
Memory leak in v1.3.0 caused OOM crashes in auth service pods.

Specifically: Unclosed database connections in new auth flow.

## Impact
- Duration: 37 minutes
- Users affected: ~10,000
- Revenue impact: $5,000 (estimated)
- Customer support tickets: 47

## What Went Well
✅ Fast detection (3 minutes)
✅ Clear communication
✅ Swift rollback decision
✅ Team coordination excellent

## What Went Wrong
❌ Memory leak not caught in testing
❌ No gradual rollout (straight to 100%)
❌ Load testing insufficient
❌ Rollback took longer than expected

## Action Items
- [ ] Add memory leak detection to CI (@alice, Jan 20)
- [ ] Implement canary deployments (@bob, Jan 25)
- [ ] Improve load testing (@charlie, Jan 30)
- [ ] Automate rollback (@dave, Feb 5)
- [ ] Add connection pool monitoring (@eve, Jan 22)

## Lessons Learned
1. Always use canary deployments for auth changes
2. Monitor connection pools proactively
3. Load tests should match production traffic
```

---

### 2. Blameless Culture

**DO**:
✅ Focus on systems and processes
✅ Ask "How can we prevent this?"
✅ Celebrate quick response
✅ Learn from mistakes
✅ Assume good intentions

**DON'T**:
❌ Blame individuals
❌ Ask "Who caused this?"
❌ Punish for mistakes
❌ Hide problems
❌ Assume malice

**Example Phrasing**:
```
❌ "Bob deployed broken code"
✅ "Deployment process didn't catch memory leak"

❌ "Why didn't you test this?"
✅ "What testing would have caught this?"

❌ "This is your fault"
✅ "What can we learn from this?"
```

---

## Incident Prevention

### Proactive Measures

```typescript
// 1. Comprehensive monitoring
const monitors = [
  { metric: 'error_rate', threshold: '> 5%', action: 'alert' },
  { metric: 'latency_p95', threshold: '> 1000ms', action: 'alert' },
  { metric: 'memory_usage', threshold: '> 80%', action: 'alert' },
  { metric: 'disk_space', threshold: '> 90%', action: 'alert' },
];

// 2. Chaos engineering
async function chaosTest() {
  // Randomly kill pods
  await killRandomPod();

  // Inject latency
  await injectLatency({ service: 'api', latency: '500ms' });

  // Simulate dependency failure
  await simulateFailure({ service: 'database', duration: '5m' });

  // Measure system resilience
  const resilience = await measureResilience();
  return resilience;
}

// 3. Game days
// Scheduled incident simulations to practice response

// 4. Runbooks
// Documented procedures for common incidents
```

---

## Incident Runbooks

### Database Connection Exhaustion

```markdown
## Symptoms
- Error: "Too many connections"
- Slow queries
- Timeouts

## Quick Fix
1. Scale up connection pool:
   ```
   kubectl set env deployment/api DB_POOL_SIZE=50
   ```

2. Restart stuck connections:
   ```
   SELECT pg_terminate_backend(pid)
   FROM pg_stat_activity
   WHERE state = 'idle'
   AND state_change < NOW() - INTERVAL '1 hour';
   ```

## Investigation
- Check active connections:
  ```
  SELECT COUNT(*) FROM pg_stat_activity;
  ```
- Find long-running queries:
  ```
  SELECT pid, query, state_change
  FROM pg_stat_activity
  WHERE state != 'idle'
  ORDER BY state_change;
  ```

## Prevention
- Implement connection pooling
- Set connection timeouts
- Monitor connection usage
```

---

## Output Format

When guiding incident response:

```
## Incident Response: ${IncidentName}

**Severity**: ${level}

**Immediate Actions**:
1. ${action1}
2. ${action2}

**Investigation Steps**:
- ${step1}
- ${step2}

**Mitigation Options**:
- ${option1}
- ${option2}

**Communication Plan**:
- ${update schedule}
- ${stakeholders}
```

## Related Skills

- `deployment-strategies`: For safe deployments
- `monitoring-setup`: For early detection
- `debugging-techniques`: For root cause analysis
- `communication-patterns`: For stakeholder updates
