---
description: Get team status, presence, and activity information
---

# Team Status Command

Get team status: $ARGUMENTS (optional: specific user or channel)

**Using Slack MCP to monitor team activity**

## Status Queries

### 1. User Presence

**Check User Status:**
```javascript
const presence = await slack.users.getPresence({
  user: 'U123456'
});

console.log(presence.presence);  // 'active' or 'away'
```

**Batch Check Multiple Users:**
```javascript
const users = ['U123456', 'U789012', 'U345678'];
const presences = [];

for (const user of users) {
  const presence = await slack.users.getPresence({ user });
  const profile = await slack.users.info({ user });

  presences.push({
    user: profile.user.real_name,
    status: presence.presence,
    status_text: profile.user.profile.status_text,
    status_emoji: profile.user.profile.status_emoji
  });
}

// Format and display
presences.forEach(p => {
  console.log(`${p.status_emoji} ${p.user}: ${p.status} - ${p.status_text}`);
});
```

### 2. Channel Activity

**Recent Messages:**
```javascript
const history = await slack.conversations.history({
  channel: 'C123456',
  limit: 10
});

console.log(`Recent messages in channel:`);
history.messages.forEach(msg => {
  console.log(`${msg.user}: ${msg.text}`);
});
```

**Channel Members:**
```javascript
const members = await slack.conversations.members({
  channel: 'C123456'
});

console.log(`Channel has ${members.members.length} members`);

// Get member details
for (const memberId of members.members) {
  const user = await slack.users.info({ user: memberId });
  console.log(`- ${user.user.real_name}`);
}
```

**Channel Info:**
```javascript
const info = await slack.conversations.info({
  channel: 'C123456'
});

console.log(`
Channel: ${info.channel.name}
Topic: ${info.channel.topic.value}
Purpose: ${info.channel.purpose.value}
Members: ${info.channel.num_members}
Created: ${new Date(info.channel.created * 1000).toLocaleDateString()}
`);
```

### 3. Team Overview

**Active Users:**
```javascript
async function getActiveUsers() {
  const users = await slack.users.list();
  const active = [];

  for (const user of users.members) {
    if (user.deleted || user.is_bot) continue;

    const presence = await slack.users.getPresence({ user: user.id });

    if (presence.presence === 'active') {
      active.push({
        name: user.real_name,
        status: user.profile.status_text,
        emoji: user.profile.status_emoji
      });
    }
  }

  return active;
}

const activeUsers = await getActiveUsers();
console.log(`${activeUsers.length} users currently active`);
activeUsers.forEach(u => {
  console.log(`${u.emoji} ${u.name}: ${u.status}`);
});
```

**Team Statistics:**
```javascript
async function getTeamStats() {
  const users = await slack.users.list();

  const stats = {
    total: users.members.filter(u => !u.deleted && !u.is_bot).length,
    active: 0,
    away: 0,
    online: 0
  };

  for (const user of users.members) {
    if (user.deleted || user.is_bot) continue;

    const presence = await slack.users.getPresence({ user: user.id });

    if (presence.presence === 'active') {
      stats.active++;
      stats.online++;
    } else {
      stats.away++;
    }
  }

  return stats;
}

const stats = await getTeamStats();
console.log(`
Team Statistics:
Total members: ${stats.total}
Online: ${stats.online} (${Math.round(stats.online / stats.total * 100)}%)
Active: ${stats.active}
Away: ${stats.away}
`);
```

### 4. Status Dashboard

**Generate Team Dashboard:**
```javascript
async function generateTeamDashboard() {
  const users = await slack.users.list();
  const dashboard = {
    timestamp: new Date().toISOString(),
    users: [],
    channels: []
  };

  // User statuses
  for (const user of users.members) {
    if (user.deleted || user.is_bot) continue;

    const presence = await slack.users.getPresence({ user: user.id });

    dashboard.users.push({
      name: user.real_name,
      username: user.name,
      presence: presence.presence,
      status_text: user.profile.status_text,
      status_emoji: user.profile.status_emoji,
      timezone: user.tz_label,
      is_admin: user.is_admin
    });
  }

  // Channel activity
  const channels = await slack.conversations.list({
    types: 'public_channel,private_channel'
  });

  for (const channel of channels.channels) {
    const history = await slack.conversations.history({
      channel: channel.id,
      limit: 1
    });

    const lastActivity = history.messages[0]
      ? new Date(parseFloat(history.messages[0].ts) * 1000)
      : null;

    dashboard.channels.push({
      name: channel.name,
      members: channel.num_members,
      last_activity: lastActivity,
      topic: channel.topic.value
    });
  }

  return dashboard;
}

const dashboard = await generateTeamDashboard();

// Send dashboard to Slack
await slack.chat.postMessage({
  channel: '#team-status',
  blocks: [
    {
      type: 'header',
      text: {
        type: 'plain_text',
        text: '📊 Team Dashboard'
      }
    },
    {
      type: 'section',
      text: {
        type: 'mrkdwn',
        text: `*Active Users (${dashboard.users.filter(u => u.presence === 'active').length}/${dashboard.users.length})*`
      }
    },
    ...dashboard.users.filter(u => u.presence === 'active').map(u => ({
      type: 'section',
      text: {
        type: 'mrkdwn',
        text: `${u.status_emoji} *${u.name}* - ${u.status_text}`
      }
    }))
  ]
});
```

### 5. On-Call Status

**Check Who's On-Call:**
```javascript
async function getOnCallStatus() {
  // Check for special status emoji or text
  const users = await slack.users.list();
  const onCall = [];

  for (const user of users.members) {
    if (user.deleted || user.is_bot) continue;

    // Check if user has on-call status
    if (user.profile.status_text.includes('on-call') ||
        user.profile.status_emoji === ':fire_engine:') {
      const presence = await slack.users.getPresence({ user: user.id });

      onCall.push({
        name: user.real_name,
        username: user.name,
        presence: presence.presence,
        phone: user.profile.phone
      });
    }
  }

  return onCall;
}

const onCall = await getOnCallStatus();
console.log('Currently on-call:');
onCall.forEach(user => {
  console.log(`🚨 ${user.name} (${user.presence}) - ${user.phone}`);
});
```

### 6. Away Messages & OOO

**Check Out-of-Office:**
```javascript
async function getOOOUsers() {
  const users = await slack.users.list();
  const ooo = [];

  for (const user of users.members) {
    if (user.deleted || user.is_bot) continue;

    // Check for OOO indicators
    if (user.profile.status_text.toLowerCase().includes('ooo') ||
        user.profile.status_text.toLowerCase().includes('vacation') ||
        user.profile.status_emoji === ':palm_tree:' ||
        user.profile.status_emoji === ':airplane:') {
      ooo.push({
        name: user.real_name,
        status: user.profile.status_text,
        emoji: user.profile.status_emoji
      });
    }
  }

  return ooo;
}

const ooo = await getOOOUsers();
console.log('Out of office:');
ooo.forEach(user => {
  console.log(`${user.emoji} ${user.name}: ${user.status}`);
});
```

### 7. Response Time Analysis

**Calculate Average Response Times:**
```javascript
async function analyzeResponseTimes(channel, days = 7) {
  const oldest = Math.floor(Date.now() / 1000) - (days * 24 * 60 * 60);

  const history = await slack.conversations.history({
    channel: channel,
    oldest: oldest
  });

  const responseTimes = [];

  for (let i = 0; i < history.messages.length - 1; i++) {
    const msg = history.messages[i];
    const prevMsg = history.messages[i + 1];

    if (msg.user !== prevMsg.user) {
      const responseTime = parseFloat(prevMsg.ts) - parseFloat(msg.ts);
      responseTimes.push(responseTime);
    }
  }

  const avgResponseTime = responseTimes.reduce((a, b) => a + b, 0) / responseTimes.length;

  return {
    averageSeconds: avgResponseTime,
    averageMinutes: Math.round(avgResponseTime / 60),
    samples: responseTimes.length
  };
}

const analysis = await analyzeResponseTimes('C123456');
console.log(`Average response time: ${analysis.averageMinutes} minutes`);
```

### 8. Activity Report

**Generate Activity Report:**
```javascript
async function generateActivityReport(channel, days = 7) {
  const oldest = Math.floor(Date.now() / 1000) - (days * 24 * 60 * 60);

  const history = await slack.conversations.history({
    channel: channel,
    oldest: oldest,
    limit: 1000
  });

  const activity = {};

  for (const msg of history.messages) {
    if (msg.subtype) continue;  // Skip system messages

    if (!activity[msg.user]) {
      activity[msg.user] = {
        messages: 0,
        reactions_given: 0,
        reactions_received: 0
      };
    }

    activity[msg.user].messages++;

    if (msg.reactions) {
      activity[msg.user].reactions_received += msg.reactions.reduce(
        (sum, r) => sum + r.count, 0
      );
    }
  }

  // Get user names
  const report = [];
  for (const [userId, stats] of Object.entries(activity)) {
    const user = await slack.users.info({ user: userId });
    report.push({
      name: user.user.real_name,
      ...stats
    });
  }

  // Sort by activity
  report.sort((a, b) => b.messages - a.messages);

  return report;
}

const report = await generateActivityReport('C123456', 7);
console.log('Activity Report (Last 7 days):');
report.forEach((user, index) => {
  console.log(`${index + 1}. ${user.name}: ${user.messages} messages, ${user.reactions_received} reactions`);
});
```

## Example Usage

```bash
# Check specific user
/team-status @john.doe

# Check channel activity
/team-status #engineering

# Get active users
/team-status --active

# Get all users presence
/team-status --all

# Check who's on-call
/team-status --on-call

# Get OOO users
/team-status --ooo

# Generate dashboard
/team-status --dashboard

# Activity report
/team-status #channel --activity --days 7
```

## Output Formats

**Console:**
```
Team Status:
✅ John Doe: active - "Working on PR #123"
🌴 Jane Smith: away - "On vacation"
💻 Bob Johnson: active - "In a meeting"
```

**Slack Message:**
```
📊 Team Status

Active (3/10):
✅ John Doe - Working on PR #123
💻 Bob Johnson - In a meeting
🎯 Alice Chen - Focused time

Away (7/10):
🌴 Jane Smith - On vacation
🏠 Tom Wilson - Working from home
```

**JSON:**
```json
{
  "timestamp": "2025-10-15T10:30:00Z",
  "total_users": 10,
  "active_users": 3,
  "away_users": 7,
  "users": [
    {
      "name": "John Doe",
      "presence": "active",
      "status": "Working on PR #123"
    }
  ]
}
```

**Pattern Demonstrated:** Team Monitoring, Presence Detection, Activity Analysis
