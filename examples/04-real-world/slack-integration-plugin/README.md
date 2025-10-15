# Slack Integration Plugin 💬

**Version:** 1.5.0
**Complexity:** ⭐⭐⭐ Intermediate/Advanced
**MCP Integration:** Slack

Team communication and automation plugin using Slack MCP for notifications, messaging, and collaboration workflows.

---

## 📋 Overview

This plugin provides comprehensive Slack integration for team communication, automated notifications, workflow coordination, and team status monitoring.

### Components

- **3 Commands:** send-message, create-workflow, team-status
- **1 Agent:** Communication Coordinator (proactive notification management)
- **1 MCP Server:** Slack (team communication)

### Key Features

✅ **Rich Messaging** - Send formatted messages with blocks, buttons, and attachments
✅ **Workflow Automation** - Automate PR reviews, CI/CD notifications, incident response
✅ **Team Status** - Monitor presence, activity, and on-call status
✅ **Smart Notifications** - Respect timezones, DND, and user preferences
✅ **Interactive Elements** - Buttons, dropdowns, and form inputs
✅ **Scheduled Messages** - Send reminders and scheduled notifications
✅ **Thread Management** - Organize conversations with threads
✅ **File Sharing** - Upload files and code snippets

---

## 🚀 Installation

### 1. Install Plugin

```bash
# From real-world marketplace
/plugin marketplace add ./examples/marketplaces/real-world-marketplace
/plugin install slack-integration@real-world-examples
```

### 2. Slack App Setup

**Create Slack App:**
1. Go to https://api.slack.com/apps
2. Click "Create New App" → "From scratch"
3. Name it "Claude Code Integration"
4. Select your workspace

**Configure Bot Permissions:**
Add these OAuth scopes:
- `chat:write` - Send messages
- `chat:write.public` - Send to public channels
- `channels:read` - View channel info
- `channels:history` - Read channel messages
- `groups:read` - View private channels
- `users:read` - View user info
- `users:read.email` - View user emails
- `files:write` - Upload files
- `reactions:read` - View reactions

**Install to Workspace:**
1. Install app to your workspace
2. Copy the "Bot User OAuth Token" (starts with `xoxb-`)

### 3. MCP Configuration

Set environment variables:

```bash
export SLACK_BOT_TOKEN="xoxb-your-token-here"
export SLACK_TEAM_ID="T123456789"  # Your workspace ID
```

Add to shell profile (~/.bashrc, ~/.zshrc):
```bash
echo 'export SLACK_BOT_TOKEN="xoxb-your-token"' >> ~/.zshrc
echo 'export SLACK_TEAM_ID="T123456789"' >> ~/.zshrc
```

### 4. Verify Installation

```bash
# Check plugin is installed
/plugin
# Should show "slack-integration"

# Test message
/send-message #test-channel "Hello from Claude Code! 👋"
```

---

## 📚 Commands

### 1. `/send-message [channel] [message]` - Send Messages

Send messages and notifications to Slack channels or users.

**Basic Usage:**
```bash
# Simple text message
/send-message #general "Hello team!"

# Message with formatting
/send-message #dev "*Important:* Please review PR #123"

# Direct message
/send-message @john.doe "Hey, quick question about the deployment"

# Thread reply
/send-message #support "Additional info" --thread 1234567890.123456
```

**Rich Messages:**
```bash
# Deployment notification
/send-message #deployments "🚀 Deployed v2.0.0 to production"

# Error alert
/send-message #alerts "🚨 Database connection timeout - Action needed"

# Success notification
/send-message #ci-cd "✅ Build #123 passed - All tests green"
```

**Scheduled Messages:**
```bash
# Schedule for specific time
/send-message #team "Meeting in 10 minutes" --schedule "2025-10-15 14:50"

# Daily reminder
/send-message #standup "Time for daily standup!" --schedule daily --time "09:00"
```

---

### 2. `/create-workflow [type]` - Workflow Automation

Create automated notification workflows for common events.

**Available Workflows:**

**PR Review Workflow:**
```bash
/create-workflow pr-review

# Automatically notifies on:
# - New PR created → #code-review
# - PR approved → Thread update
# - PR merged → #deployments
```

**CI/CD Pipeline:**
```bash
/create-workflow ci-cd-pipeline

# Notifies on:
# - Build started → #ci-cd
# - Build finished → Update with results
# - Tests failed → Alert author
# - Deploy started → #deployments
# - Deploy complete → Confirmation
```

**Incident Management:**
```bash
/create-workflow incident-management

# Notifies on:
# - Incident detected → #incidents + ping @on-call
# - Incident acknowledged → Thread update
# - Incident resolved → Summary
```

**Daily Standup:**
```bash
/create-workflow daily-standup

# Automatically:
# - Send standup prompt at 9 AM
# - Collect team updates
# - Compile summary
# - Remind those who haven't submitted
```

**Release Announcements:**
```bash
/create-workflow releases

# Notifies on:
# - New release created → #releases
# - Release notes with download links
# - Changelog summary
```

---

### 3. `/team-status [target]` - Team Status

Get team presence, activity, and status information.

**Usage:**
```bash
# Check specific user
/team-status @john.doe

# Check channel activity
/team-status #engineering

# Get all active users
/team-status --active

# Check who's on-call
/team-status --on-call

# Get OOO users
/team-status --ooo

# Generate team dashboard
/team-status --dashboard

# Activity report
/team-status #dev --activity --days 7
```

**Output Examples:**
```
Team Status:
✅ John Doe: active - "Working on PR #123"
🌴 Jane Smith: away - "On vacation until 10/20"
💻 Bob Johnson: active - "In a meeting"
🚨 Alice Chen: active - "On-call this week"

Active: 8/15 users (53%)
```

---

## 🤖 Agent

### Communication Coordinator

Proactive agent that manages team communication and notifications.

**Capabilities:**
- Automatically send notifications on key events
- Design effective messages with proper context
- Respect user preferences and DND
- Batch similar notifications
- Choose appropriate channels
- Coordinate multi-step workflows

**Activation Conditions:**
- Deployment events (started, completed, failed)
- Error detection (production errors, CI failures)
- PR events (created, approved, merged)
- Build results (passed, failed)
- Long-running tasks complete

**Manual Activation:**
```bash
/agent communication-coordinator

# Then ask:
# "How should I notify the team about this deployment?"
# "What's the best way to alert on-call about this incident?"
# "Should this notification go to #general or #dev?"
```

---

## 🎯 Use Cases

### 1. CI/CD Integration

**Automated Build Notifications:**

```bash
# Set up CI/CD workflow
/create-workflow ci-cd-pipeline

# Now automatically notifies on:
# ✅ Build passed
# ❌ Build failed
# 🚀 Deployment started
# ✅ Deployment complete
```

**Benefits:**
- Team stays informed without checking CI dashboard
- Failures are immediately visible
- Deployment coordination is automatic

---

### 2. PR Review Process

**Streamlined Code Review:**

```bash
# Set up PR workflow
/create-workflow pr-review

# Automatically:
# 1. New PR → Notify #code-review
# 2. Reviewers get DM
# 3. Approval → Update thread
# 4. Merge → Notify #deployments
```

**Benefits:**
- Faster review cycles
- No PRs slip through cracks
- Clear audit trail in Slack

---

### 3. Incident Response

**Rapid Incident Coordination:**

```bash
# Set up incident workflow
/create-workflow incident-management

# On production error:
# 1. Alert #incidents
# 2. Ping @on-call team
# 3. Track acknowledgment
# 4. Update status in thread
# 5. Post-incident summary
```

**Benefits:**
- Faster response times
- Clear communication during incidents
- Automatic documentation

---

### 4. Team Coordination

**Daily Standup Automation:**

```bash
# Set up standup workflow
/create-workflow daily-standup

# Every morning at 9 AM:
# 1. Send standup prompt
# 2. Collect updates
# 3. Remind stragglers
# 4. Compile summary at 9:30 AM
```

**Benefits:**
- Async standup flexibility
- Automated summaries
- No meetings needed

---

### 5. Release Communication

**Release Announcements:**

```bash
# Set up release workflow
/create-workflow releases

# On new release:
# 1. Post to #releases
# 2. Include changelog
# 3. Add download links
# 4. Notify stakeholders
```

**Benefits:**
- Stakeholders stay informed
- Clear release documentation
- Automatic announcements

---

## 🛡️ Best Practices

### Message Design

✅ **Be Specific:**
```
❌ "Something went wrong"
✅ "🚨 Database timeout in user-auth service (prod)"
```

✅ **Provide Context:**
```
❌ "Build failed"
✅ "❌ Build #123 failed
   Branch: feature/login
   3 tests failing
   [View Logs]"
```

✅ **Make Actionable:**
```
❌ "Error detected"
✅ "🚨 Error detected
   [Restart Service] [Rollback] [View Logs]"
```

### Channel Strategy

```
#incidents → Critical production issues only
#alerts → Automated alerts (errors, monitoring)
#deployments → Deployment notifications
#ci-cd → Build and test results
#code-review → PR notifications
#releases → Release announcements
@user → Direct notifications only when needed
```

### Notification Timing

✅ **Respect Timezones:**
- Check user timezone before non-urgent messages
- Schedule for working hours when possible

✅ **Respect DND:**
- Only critical alerts during DND
- Batch non-urgent notifications

✅ **Rate Limit:**
- Don't spam channels
- Batch similar notifications
- Use threads for follow-ups

### Thread Usage

✅ **Use Threads For:**
- Follow-up updates to original event
- Detailed logs/traces
- Status progress
- Related discussions

❌ **Don't Thread:**
- New separate events
- Different topics
- Critical alerts (might be missed)

---

## 🔧 Configuration

### Environment Variables

```bash
# Required
export SLACK_BOT_TOKEN="xoxb-your-bot-token"
export SLACK_TEAM_ID="T123456789"

# Optional
export SLACK_DEFAULT_CHANNEL="#general"
export SLACK_ALERT_CHANNEL="#alerts"
export SLACK_ONCALL_GROUP="S123456"  # User group ID
```

### User Preferences

Users can set preferences via DM:
```
@claude-bot preferences
- Notifications: On/Off for each type
- DND Hours: 22:00 - 08:00
- Timezone: America/Los_Angeles
```

---

## 🐛 Troubleshooting

### Issue: Bot Can't Send Messages

**Symptoms:** "channel_not_found" error

**Solution:**
1. Invite bot to channel: `/invite @claude-code`
2. Check bot has `chat:write` permission
3. For private channels, bot needs explicit invite

---

### Issue: Token Invalid

**Symptoms:** "invalid_auth" error

**Solution:**
```bash
# Check token is set
echo $SLACK_BOT_TOKEN

# Verify it starts with 'xoxb-'
# Regenerate if needed at api.slack.com/apps
```

---

### Issue: Messages Not Formatting

**Symptoms:** Raw markdown visible

**Solution:**
- Ensure `mrkdwn: true` is set
- Use proper markdown syntax: `*bold*`, `_italic_`
- Check blocks syntax in Block Kit Builder

---

### Issue: Can't Read Channel History

**Symptoms:** "missing_scope" error

**Solution:**
Add required scopes in app settings:
- `channels:history`
- `groups:history`
- `im:history`

Then reinstall app to workspace.

---

## 📊 Examples

### Example 1: Deployment Notification

```bash
/send-message #deployments --blocks '{
  "blocks": [
    {
      "type": "header",
      "text": {"type": "plain_text", "text": "🚀 Deployment Started"}
    },
    {
      "type": "section",
      "fields": [
        {"type": "mrkdwn", "text": "*Environment:*\nProduction"},
        {"type": "mrkdwn", "text": "*Version:*\nv2.0.0"}
      ]
    }
  ]
}'
```

### Example 2: Team Activity Report

```bash
# Generate weekly activity report
/team-status #engineering --activity --days 7 --output report.json

# Send to channel
/send-message #team "📊 Weekly Activity Report" --file report.json
```

### Example 3: Custom Workflow

Create custom workflow for specific needs:
```bash
# Monitor competitor website
/create-workflow "When competitor price changes, notify #competitive-intel"

# Database backup alerts
/create-workflow "Daily database backup status to #ops at 6 AM"

# Customer signup notifications
/create-workflow "New customer signup → #sales with details"
```

---

## 🚀 Advanced Usage

### Interactive Buttons

Messages with actionable buttons:
```javascript
// Approval flow
/send-message #approvals --interactive '{
  "text": "PR #123 needs approval",
  "actions": [
    {"type": "button", "text": "✅ Approve", "value": "approve_123"},
    {"type": "button", "text": "❌ Reject", "value": "reject_123"}
  ]
}'
```

### Scheduled Workflows

Schedule recurring notifications:
```bash
# Daily standup reminder
/create-workflow daily-standup --schedule "weekdays at 9:00 AM"

# Weekly summary
/create-workflow team-summary --schedule "Friday at 5:00 PM"

# Monthly metrics
/create-workflow metrics-report --schedule "1st of month at 9:00 AM"
```

### Integration with Other Plugins

```bash
# Database Manager + Slack
# When slow query detected:
- Database plugin optimizes
- Slack plugin notifies team

# Security Audit + Slack
# When vulnerability found:
- Security plugin scans
- Slack plugin alerts @security-team

# PR Reviewer + Slack
# When PR created:
- PR Reviewer analyzes
- Slack plugin notifies reviewers with summary
```

---

## 📈 Metrics & Monitoring

Track communication effectiveness:
- Average response time to notifications
- Notification open rate
- Action button click rate
- Channel engagement
- Off-hours notification count

View metrics:
```bash
/team-status --metrics --days 30
```

---

## 🎓 Learning Resources

### Slack API Documentation
- [Block Kit Builder](https://app.slack.com/block-kit-builder)
- [API Methods](https://api.slack.com/methods)
- [Event Types](https://api.slack.com/events)

### Related Plugins
- **PR Reviewer** - Integrates with PR workflow
- **DevOps Plugin** - Deployment notifications
- **Database Manager** - Query alert notifications

---

## 📝 License

MIT

---

## 🤝 Contributing

Improve this plugin:
1. Add new workflow types
2. Enhance message templates
3. Add more interactive elements
4. Share communication strategies

---

**Pattern Demonstrated:** Team Communication, Workflow Automation, Notification Management, MCP Integration

💬 **Start collaborating smarter today!**
