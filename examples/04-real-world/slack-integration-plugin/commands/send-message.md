---
description: Send messages and notifications to Slack channels
---

# Send Slack Message

Send message: $ARGUMENTS (channel and message)

**Using Slack MCP for team communication**

## Messaging Capabilities

### 1. Basic Messages

**Simple Text Message:**
```javascript
await slack.chat.postMessage({
  channel: '#general',
  text: 'Hello team! 👋'
});
```

**Message to User:**
```javascript
await slack.chat.postMessage({
  channel: '@john.doe',
  text: 'Hey John, quick question about the PR...'
});
```

**Thread Reply:**
```javascript
await slack.chat.postMessage({
  channel: '#dev',
  text: 'Adding more context here',
  thread_ts: '1234567890.123456'  // Original message timestamp
});
```

### 2. Rich Formatting

**Markdown-Style Formatting:**
```javascript
await slack.chat.postMessage({
  channel: '#announcements',
  text: '*Bold text* _italic text_ ~strikethrough~',
  mrkdwn: true
});
```

**Links:**
```javascript
await slack.chat.postMessage({
  channel: '#team',
  text: 'Check out <https://example.com|this awesome site>!'
});
```

**Code Blocks:**
```javascript
await slack.chat.postMessage({
  channel: '#dev',
  text: 'Here\'s the bug:\n```javascript\nfunction buggyCode() {\n  return undefined;\n}\n```'
});
```

**Lists:**
```javascript
await slack.chat.postMessage({
  channel: '#tasks',
  text: `• Task 1: Complete feature
• Task 2: Write tests
• Task 3: Deploy to staging`
});
```

### 3. Interactive Blocks

**Rich Message with Blocks:**
```javascript
await slack.chat.postMessage({
  channel: '#deploys',
  text: 'Deployment notification',  // Fallback text
  blocks: [
    {
      type: 'header',
      text: {
        type: 'plain_text',
        text: '🚀 Deployment Started'
      }
    },
    {
      type: 'section',
      fields: [
        {
          type: 'mrkdwn',
          text: '*Environment:*\nProduction'
        },
        {
          type: 'mrkdwn',
          text: '*Commit:*\nabc123'
        },
        {
          type: 'mrkdwn',
          text: '*Branch:*\nmain'
        },
        {
          type: 'mrkdwn',
          text: '*Deployed by:*\n@alice'
        }
      ]
    },
    {
      type: 'context',
      elements: [
        {
          type: 'mrkdwn',
          text: 'Started at: 10:30 AM PST'
        }
      ]
    }
  ]
});
```

**Message with Buttons:**
```javascript
await slack.chat.postMessage({
  channel: '#approvals',
  text: 'PR requires approval',
  blocks: [
    {
      type: 'section',
      text: {
        type: 'mrkdwn',
        text: '*Pull Request #123*\nAdd new authentication feature'
      }
    },
    {
      type: 'actions',
      elements: [
        {
          type: 'button',
          text: {
            type: 'plain_text',
            text: '✅ Approve'
          },
          style: 'primary',
          value: 'approve_123'
        },
        {
          type: 'button',
          text: {
            type: 'plain_text',
            text: '❌ Reject'
          },
          style: 'danger',
          value: 'reject_123'
        },
        {
          type: 'button',
          text: {
            type: 'plain_text',
            text: '👀 Review'
          },
          url: 'https://github.com/repo/pull/123'
        }
      ]
    }
  ]
});
```

### 4. Notifications & Alerts

**Error Alert:**
```javascript
await slack.chat.postMessage({
  channel: '#alerts',
  text: '🚨 Production Error Detected',
  blocks: [
    {
      type: 'header',
      text: {
        type: 'plain_text',
        text: '🚨 Production Error'
      }
    },
    {
      type: 'section',
      fields: [
        {
          type: 'mrkdwn',
          text: '*Error:*\nDatabase connection timeout'
        },
        {
          type: 'mrkdwn',
          text: '*Severity:*\nCritical'
        },
        {
          type: 'mrkdwn',
          text: '*Service:*\nAPI Gateway'
        },
        {
          type: 'mrkdwn',
          text: '*Time:*\n10:45 AM PST'
        }
      ]
    },
    {
      type: 'section',
      text: {
        type: 'mrkdwn',
        text: '```\nError: connect ETIMEDOUT\n  at Connection.connect\n  at Server.listen\n```'
      }
    },
    {
      type: 'actions',
      elements: [
        {
          type: 'button',
          text: {
            type: 'plain_text',
            text: '🔍 View Logs'
          },
          url: 'https://logs.example.com'
        },
        {
          type: 'button',
          text: {
            type: 'plain_text',
            text: '📊 Metrics'
          },
          url: 'https://metrics.example.com'
        }
      ]
    }
  ]
});
```

**Success Notification:**
```javascript
await slack.chat.postMessage({
  channel: '#deployments',
  text: '✅ Deployment Successful',
  blocks: [
    {
      type: 'header',
      text: {
        type: 'plain_text',
        text: '✅ Deployment Complete'
      }
    },
    {
      type: 'section',
      text: {
        type: 'mrkdwn',
        text: 'Successfully deployed to *Production*\nDuration: 3m 24s'
      }
    }
  ]
});
```

### 5. Status Updates

**Build Status:**
```javascript
async function sendBuildStatus(status, details) {
  const emoji = {
    'success': '✅',
    'failure': '❌',
    'running': '⏳'
  }[status];

  const color = {
    'success': 'good',
    'failure': 'danger',
    'running': 'warning'
  }[status];

  await slack.chat.postMessage({
    channel: '#ci-cd',
    text: `${emoji} Build ${status}`,
    attachments: [
      {
        color: color,
        fields: [
          {
            title: 'Branch',
            value: details.branch,
            short: true
          },
          {
            title: 'Commit',
            value: details.commit,
            short: true
          },
          {
            title: 'Duration',
            value: details.duration,
            short: true
          },
          {
            title: 'Tests',
            value: `${details.passed}/${details.total} passed`,
            short: true
          }
        ]
      }
    ]
  });
}

await sendBuildStatus('success', {
  branch: 'main',
  commit: 'abc123',
  duration: '2m 15s',
  passed: 150,
  total: 150
});
```

**Progress Updates:**
```javascript
// Send initial message
const result = await slack.chat.postMessage({
  channel: '#tasks',
  text: 'Migration in progress: 0%'
});

// Update message as progress changes
await slack.chat.update({
  channel: '#tasks',
  ts: result.ts,
  text: 'Migration in progress: 25%'
});

await slack.chat.update({
  channel: '#tasks',
  ts: result.ts,
  text: 'Migration in progress: 50%'
});

await slack.chat.update({
  channel: '#tasks',
  ts: result.ts,
  text: '✅ Migration complete: 100%'
});
```

### 6. Scheduled Messages

**Daily Standup Reminder:**
```javascript
await slack.chat.scheduleMessage({
  channel: '#team',
  text: '👋 Good morning team! Time for daily standup.',
  post_at: getNextStandupTime()  // Unix timestamp
});
```

**Meeting Reminder:**
```javascript
// Schedule for 10 minutes before meeting
const meetingTime = new Date('2025-10-15T14:00:00');
const reminderTime = new Date(meetingTime - 10 * 60 * 1000);

await slack.chat.scheduleMessage({
  channel: '#general',
  text: '📅 Team meeting starting in 10 minutes!',
  post_at: Math.floor(reminderTime.getTime() / 1000)
});
```

### 7. File Attachments

**Upload File:**
```javascript
await slack.files.upload({
  channels: '#reports',
  file: fs.createReadStream('./report.pdf'),
  filename: 'Monthly Report.pdf',
  initial_comment: 'Here\'s the monthly report for October 2025'
});
```

**Share Code Snippet:**
```javascript
await slack.files.upload({
  channels: '#dev',
  content: 'function example() {\n  return "Hello";\n}',
  filetype: 'javascript',
  filename: 'example.js',
  title: 'Example Function'
});
```

### 8. User Mentions & Groups

**Mention User:**
```javascript
await slack.chat.postMessage({
  channel: '#dev',
  text: '<@U123456> can you review this PR?'
});
```

**Mention Channel:**
```javascript
await slack.chat.postMessage({
  channel: '#general',
  text: '<!channel> Urgent: Production down!'
});
```

**Mention Here:**
```javascript
await slack.chat.postMessage({
  channel: '#support',
  text: '<!here> New ticket requires attention'
});
```

**Mention User Group:**
```javascript
await slack.chat.postMessage({
  channel: '#incidents',
  text: '<!subteam^S123456> On-call team needed'
});
```

## Example Usage

```bash
# Simple message
/send-message #general "Hello team!"

# Rich formatted message
/send-message #dev "*Important:* Check out this <https://github.com|PR>"

# Alert notification
/send-message #alerts "🚨 Error in production - Database timeout"

# Status update
/send-message #deploys "✅ Deployment complete - v2.0.0 live"

# Mention user
/send-message #code-review "@john Please review PR #123"

# With blocks
/send-message #announcements --blocks deployment-success.json

# Schedule message
/send-message #team "Meeting reminder" --schedule "2025-10-15 14:00"

# Thread reply
/send-message #support "Additional context" --thread 1234567890.123456
```

## Common Patterns

### Deployment Notifications
```javascript
// Start
await sendMessage('#deploys', '🚀 Deploying v2.0.0 to production...');

// Success
await sendMessage('#deploys', '✅ Deployment successful!');

// Failure
await sendMessage('#deploys', '❌ Deployment failed - rolling back');
```

### Error Monitoring
```javascript
// On error detected
await sendMessage('#alerts', {
  text: '🚨 Error detected',
  severity: 'critical',
  service: 'API',
  action: 'Investigate immediately'
});
```

### Team Updates
```javascript
// Daily summary
await sendMessage('#team', {
  text: '📊 Daily Summary',
  stats: {
    prs: 5,
    deployments: 2,
    issues: 3
  }
});
```

**Pattern Demonstrated:** Team Communication, Notifications, Rich Messaging
