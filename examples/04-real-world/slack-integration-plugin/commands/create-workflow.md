---
description: Create automated Slack workflows and integrations
---

# Create Slack Workflow

Create workflow: $ARGUMENTS (workflow description)

**Using Slack MCP for automation**

## Workflow Types

### 1. PR Review Workflow

**Automatic PR Notifications:**
```javascript
// When PR is created
async function onPRCreated(pr) {
  await slack.chat.postMessage({
    channel: '#code-review',
    blocks: [
      {
        type: 'header',
        text: {
          type: 'plain_text',
          text: `🔄 New PR #${pr.number}`
        }
      },
      {
        type: 'section',
        fields: [
          {
            type: 'mrkdwn',
            text: `*Title:*\n${pr.title}`
          },
          {
            type: 'mrkdwn',
            text: `*Author:*\n@${pr.author}`
          },
          {
            type: 'mrkdwn',
            text: `*Files Changed:*\n${pr.files_changed}`
          },
          {
            type: 'mrkdwn',
            text: `*Lines:*\n+${pr.additions}/-${pr.deletions}`
          }
        ]
      },
      {
        type: 'actions',
        elements: [
          {
            type: 'button',
            text: { type: 'plain_text', text: '👀 Review' },
            url: pr.url
          },
          {
            type: 'button',
            text: { type: 'plain_text', text: '✅ Approve' },
            value: `approve_${pr.number}`
          }
        ]
      }
    ]
  });
}

// When PR is approved
async function onPRApproved(pr) {
  await slack.chat.postMessage({
    channel: '#code-review',
    text: `✅ PR #${pr.number} approved by @${pr.reviewer}`,
    thread_ts: pr.slack_thread_id
  });
}

// When PR is merged
async function onPRMerged(pr) {
  await slack.chat.postMessage({
    channel: '#deployments',
    text: `🎉 PR #${pr.number} merged to ${pr.branch}`,
    blocks: [
      {
        type: 'section',
        text: {
          type: 'mrkdwn',
          text: `*${pr.title}* by @${pr.author} merged successfully!`
        }
      }
    ]
  });
}
```

### 2. CI/CD Pipeline Workflow

**Build & Deploy Notifications:**
```javascript
async function createCICDWorkflow() {
  // Build started
  async function onBuildStart(build) {
    const message = await slack.chat.postMessage({
      channel: '#ci-cd',
      text: `⏳ Build #${build.number} started...`,
      blocks: [
        {
          type: 'section',
          fields: [
            { type: 'mrkdwn', text: `*Branch:*\n${build.branch}` },
            { type: 'mrkdwn', text: `*Commit:*\n${build.commit}` }
          ]
        }
      ]
    });

    return message.ts;  // Save for updates
  }

  // Build finished
  async function onBuildFinish(build, messageTs) {
    const status = build.success ? '✅' : '❌';
    const color = build.success ? 'good' : 'danger';

    await slack.chat.update({
      channel: '#ci-cd',
      ts: messageTs,
      text: `${status} Build #${build.number} ${build.success ? 'passed' : 'failed'}`,
      attachments: [
        {
          color: color,
          fields: [
            { title: 'Duration', value: build.duration, short: true },
            { title: 'Tests', value: `${build.tests_passed}/${build.tests_total}`, short: true }
          ]
        }
      ]
    });
  }

  // Deploy started
  async function onDeployStart(deploy) {
    await slack.chat.postMessage({
      channel: '#deployments',
      text: `🚀 Deploying to ${deploy.environment}...`,
      blocks: [
        {
          type: 'header',
          text: {
            type: 'plain_text',
            text: `🚀 Deploying to ${deploy.environment.toUpperCase()}`
          }
        },
        {
          type: 'section',
          fields: [
            { type: 'mrkdwn', text: `*Version:*\n${deploy.version}` },
            { type: 'mrkdwn', text: `*Deployed by:*\n@${deploy.user}` }
          ]
        }
      ]
    });
  }

  // Deploy finished
  async function onDeployFinish(deploy) {
    const status = deploy.success ? '✅' : '❌';

    await slack.chat.postMessage({
      channel: '#deployments',
      text: `${status} Deployment to ${deploy.environment} ${deploy.success ? 'successful' : 'failed'}!`,
      blocks: [
        {
          type: 'section',
          text: {
            type: 'mrkdwn',
            text: deploy.success
              ? `*Deployment successful!*\n${deploy.version} is now live on ${deploy.environment}`
              : `*Deployment failed!*\nRolling back to previous version...`
          }
        }
      ]
    });
  }
}
```

### 3. Issue Tracking Workflow

**GitHub Issues Integration:**
```javascript
async function createIssueWorkflow() {
  // New issue created
  async function onIssueCreated(issue) {
    await slack.chat.postMessage({
      channel: '#issues',
      blocks: [
        {
          type: 'header',
          text: {
            type: 'plain_text',
            text: `🐛 New Issue #${issue.number}`
          }
        },
        {
          type: 'section',
          text: {
            type: 'mrkdwn',
            text: `*${issue.title}*\n${issue.description}`
          }
        },
        {
          type: 'section',
          fields: [
            { type: 'mrkdwn', text: `*Priority:*\n${issue.priority}` },
            { type: 'mrkdwn', text: `*Reporter:*\n@${issue.reporter}` },
            { type: 'mrkdwn', text: `*Labels:*\n${issue.labels.join(', ')}` }
          ]
        },
        {
          type: 'actions',
          elements: [
            {
              type: 'button',
              text: { type: 'plain_text', text: '🔧 Assign to me' },
              value: `assign_${issue.number}`
            },
            {
              type: 'button',
              text: { type: 'plain_text', text: '👀 View' },
              url: issue.url
            }
          ]
        }
      ]
    });
  }

  // Issue assigned
  async function onIssueAssigned(issue) {
    await slack.chat.postMessage({
      channel: '#issues',
      text: `Issue #${issue.number} assigned to @${issue.assignee}`,
      thread_ts: issue.slack_thread_id
    });

    // DM the assignee
    await slack.chat.postMessage({
      channel: `@${issue.assignee}`,
      text: `You've been assigned to issue #${issue.number}: ${issue.title}`,
      blocks: [
        {
          type: 'section',
          text: {
            type: 'mrkdwn',
            text: `*Issue #${issue.number}*\n${issue.title}`
          }
        },
        {
          type: 'actions',
          elements: [
            {
              type: 'button',
              text: { type: 'plain_text', text: 'View Issue' },
              url: issue.url
            }
          ]
        }
      ]
    });
  }

  // Issue resolved
  async function onIssueResolved(issue) {
    await slack.chat.postMessage({
      channel: '#issues',
      text: `✅ Issue #${issue.number} resolved by @${issue.resolver}`,
      thread_ts: issue.slack_thread_id
    });
  }
}
```

### 4. On-Call & Incident Management

**Incident Response Workflow:**
```javascript
async function createIncidentWorkflow() {
  // Incident detected
  async function onIncidentDetected(incident) {
    await slack.chat.postMessage({
      channel: '#incidents',
      text: `🚨 <!subteam^oncall> Incident detected!`,
      blocks: [
        {
          type: 'header',
          text: {
            type: 'plain_text',
            text: `🚨 ${incident.severity} Incident`
          }
        },
        {
          type: 'section',
          text: {
            type: 'mrkdwn',
            text: `*${incident.title}*\n${incident.description}`
          }
        },
        {
          type: 'section',
          fields: [
            { type: 'mrkdwn', text: `*Severity:*\n${incident.severity}` },
            { type: 'mrkdwn', text: `*Service:*\n${incident.service}` },
            { type: 'mrkdwn', text: `*Status:*\n${incident.status}` },
            { type: 'mrkdwn', text: `*Started:*\n${incident.started_at}` }
          ]
        },
        {
          type: 'actions',
          elements: [
            {
              type: 'button',
              text: { type: 'plain_text', text: '🔥 Acknowledge' },
              style: 'danger',
              value: `ack_${incident.id}`
            },
            {
              type: 'button',
              text: { type: 'plain_text', text: '📊 View Metrics' },
              url: incident.metrics_url
            }
          ]
        }
      ]
    });
  }

  // Incident acknowledged
  async function onIncidentAcknowledged(incident) {
    await slack.chat.postMessage({
      channel: '#incidents',
      text: `Incident #${incident.id} acknowledged by @${incident.responder}`,
      thread_ts: incident.slack_thread_id
    });
  }

  // Incident resolved
  async function onIncidentResolved(incident) {
    await slack.chat.postMessage({
      channel: '#incidents',
      text: `✅ Incident #${incident.id} resolved`,
      blocks: [
        {
          type: 'section',
          text: {
            type: 'mrkdwn',
            text: `*Incident Resolved*\nDuration: ${incident.duration}\nResolved by: @${incident.resolver}`
          }
        }
      ],
      thread_ts: incident.slack_thread_id
    });
  }
}
```

### 5. Daily Standup Workflow

**Automated Standup Collection:**
```javascript
async function createStandupWorkflow() {
  // Send standup prompt at 9 AM
  async function sendStandupPrompt() {
    await slack.chat.postMessage({
      channel: '#team',
      text: '👋 Good morning! Time for standup updates.',
      blocks: [
        {
          type: 'header',
          text: {
            type: 'plain_text',
            text: '👋 Daily Standup'
          }
        },
        {
          type: 'section',
          text: {
            type: 'mrkdwn',
            text: 'Please share your updates:\n• What did you do yesterday?\n• What will you do today?\n• Any blockers?'
          }
        },
        {
          type: 'actions',
          elements: [
            {
              type: 'button',
              text: { type: 'plain_text', text: '✍️ Submit Update' },
              value: 'submit_standup'
            }
          ]
        }
      ]
    });
  }

  // Remind those who haven't submitted
  async function sendReminder(users) {
    for (const user of users) {
      await slack.chat.postMessage({
        channel: `@${user}`,
        text: '⏰ Reminder: Please submit your standup update!'
      });
    }
  }

  // Compile standup summary
  async function compileStandupSummary(updates) {
    const summary = updates.map(update => `
*@${update.user}*
Yesterday: ${update.yesterday}
Today: ${update.today}
Blockers: ${update.blockers || 'None'}
    `).join('\n---\n');

    await slack.chat.postMessage({
      channel: '#team',
      text: '📊 Standup Summary',
      blocks: [
        {
          type: 'header',
          text: {
            type: 'plain_text',
            text: '📊 Daily Standup Summary'
          }
        },
        {
          type: 'section',
          text: {
            type: 'mrkdwn',
            text: summary
          }
        }
      ]
    });
  }
}
```

### 6. Release Workflow

**Versioned Release Notifications:**
```javascript
async function createReleaseWorkflow() {
  // Release created
  async function onReleaseCreated(release) {
    await slack.chat.postMessage({
      channel: '#releases',
      text: `🎉 New release: ${release.version}`,
      blocks: [
        {
          type: 'header',
          text: {
            type: 'plain_text',
            text: `🎉 Release ${release.version}`
          }
        },
        {
          type: 'section',
          text: {
            type: 'mrkdwn',
            text: `*${release.name}*\n\n${release.notes}`
          }
        },
        {
          type: 'section',
          fields: [
            { type: 'mrkdwn', text: `*Type:*\n${release.type}` },
            { type: 'mrkdwn', text: `*Date:*\n${release.date}` }
          ]
        },
        {
          type: 'actions',
          elements: [
            {
              type: 'button',
              text: { type: 'plain_text', text: '📝 View Changelog' },
              url: release.changelog_url
            },
            {
              type: 'button',
              text: { type: 'plain_text', text: '⬇️ Download' },
              url: release.download_url
            }
          ]
        }
      ]
    });
  }
}
```

### 7. Code Review Reminders

**Automatic Review Requests:**
```javascript
async function createReviewReminderWorkflow() {
  // Send reminder for pending reviews
  async function sendReviewReminders() {
    const pendingPRs = await getPendingPRs();

    for (const pr of pendingPRs) {
      if (pr.age_hours > 24) {
        await slack.chat.postMessage({
          channel: `@${pr.requested_reviewer}`,
          text: `⏰ Reminder: PR #${pr.number} needs your review (${pr.age_hours}h old)`,
          blocks: [
            {
              type: 'section',
              text: {
                type: 'mrkdwn',
                text: `*${pr.title}*\nRequested ${pr.age_hours} hours ago by @${pr.author}`
              }
            },
            {
              type: 'actions',
              elements: [
                {
                  type: 'button',
                  text: { type: 'plain_text', text: '👀 Review Now' },
                  url: pr.url
                }
              ]
            }
          ]
        });
      }
    }
  }

  // Run daily at 10 AM
  schedule('0 10 * * *', sendReviewReminders);
}
```

## Example Usage

```bash
# Create PR review workflow
/create-workflow pr-review

# Create deployment notifications
/create-workflow ci-cd-pipeline

# Create incident response
/create-workflow incident-management

# Create daily standup automation
/create-workflow daily-standup

# Create release announcements
/create-workflow releases

# Custom workflow
/create-workflow "Notify #team when tests fail"
```

## Workflow Templates

Templates available:
- `pr-review` - Pull request notifications
- `ci-cd-pipeline` - Build & deploy updates
- `incident-management` - Incident response
- `daily-standup` - Standup collection
- `releases` - Release announcements
- `code-review-reminders` - Review follow-ups
- `issue-tracking` - GitHub issues integration
- `on-call-rotation` - On-call scheduling

**Pattern Demonstrated:** Workflow Automation, Event-Driven Notifications, Team Collaboration
