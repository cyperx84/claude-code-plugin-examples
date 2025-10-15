# Real-World Plugin Examples

🌍 Production-ready plugins demonstrating diverse patterns, integrations, and real-world use cases

## Overview

This directory contains **10 comprehensive real-world examples** that showcase different plugin patterns, MCP integrations, and automation workflows used in production environments.

## Complete Plugin List

### 1. Plugin Creator (Meta-Plugin) 🎩
**The Ultimate Meta-Plugin** - Creates other plugins!

- **Complexity:** ⭐⭐⭐⭐⭐ Advanced/Meta
- **Components:** 4 commands, 1 agent
- **Pattern:** Self-referential system, code generation
- **Commands:**
  - `/create [name]` - Generate complete plugin
  - `/add-command` - Add command to plugin
  - `/add-agent` - Add specialized agent
  - `/add-hook` - Add automation hook
- **Agent:** Plugin Architect - Expert design consultant

**Teaches:**
- Meta-programming concepts
- AI-assisted code generation
- Template-based scaffolding
- Best practice automation

---

### 2. PR Reviewer Plugin 🔍
**Automated Pull Request Reviews**

- **Complexity:** ⭐⭐⭐⭐ Advanced
- **Components:** 3 commands, 1 agent, GitHub MCP
- **Pattern:** GitHub integration, collaborative workflows
- **Commands:**
  - `/review-pr [number]` - Comprehensive PR review
  - `/create-pr [title]` - Auto-generate PR
  - `/pr-status [filter]` - Status dashboard
- **Agent:** Code Quality Reviewer (proactive)
- **MCP:** GitHub (pull requests, issues, status)

**Teaches:**
- GitHub MCP integration
- Real-time data fetching
- Automated code review
- Quality metrics analysis
- Collaborative workflows

---

### 3. Database Manager Plugin 💾
**Database Operations & Migrations**

- **Complexity:** ⭐⭐⭐⭐ Advanced
- **Components:** 2 commands, 1 agent, PostgreSQL MCP
- **Pattern:** Database management, migrations, optimization
- **Commands:**
  - `/query [sql]` - Smart SQL execution
  - `/migrate [action]` - Database migrations
- **Agent:** Query Optimizer (proactive)
- **MCP:** PostgreSQL (live database queries)

**Teaches:**
- PostgreSQL MCP integration
- Natural language to SQL
- Query optimization
- Migration management
- Zero-downtime deployments
- Database safety patterns

---

### 4. Security Audit Plugin 🛡️
**Proactive Security Scanning**

- **Complexity:** ⭐⭐⭐⭐ Advanced
- **Components:** 1 command, 1 agent, 2 hooks, 1 script
- **Pattern:** Proactive security, automated scanning
- **Commands:**
  - `/scan [target]` - Security vulnerability scan
- **Agent:** Security Scanner (proactive)
- **Hooks:** Pre-commit security checks

**Teaches:**
- Proactive agent patterns
- Security vulnerability detection
- Pattern-based scanning
- Pre-commit automation
- Compliance checking

---

### 5. API Testing Plugin 🧪
**API Testing & Validation**

- **Complexity:** ⭐⭐⭐ Intermediate
- **Components:** 1 command, 1 agent
- **Pattern:** API testing, contract validation
- **Commands:**
  - `/test-api [url]` - Comprehensive API testing
- **Agent:** API Test Generator

**Teaches:**
- API testing automation
- Contract testing
- Test generation
- Performance testing
- OpenAPI/Swagger integration

---

### 6. Documentation Generator Plugin 📚
**Automated Documentation**

- **Complexity:** ⭐⭐⭐ Intermediate
- **Components:** 1 command, 1 agent
- **Pattern:** AI-powered documentation
- **Commands:**
  - `/generate-docs [type]` - Auto-generate docs
- **Agent:** Technical Writer

**Teaches:**
- Documentation automation
- AI as writing assistant
- Multi-format docs
- Code-to-docs generation
- README automation

---

### 7. Web Scraping Plugin 🌐
**Browser Automation & Data Extraction**

- **Complexity:** ⭐⭐⭐⭐ Advanced
- **Components:** 4 commands, 1 agent, Puppeteer MCP
- **Pattern:** Web scraping, automation, data extraction
- **Commands:**
  - `/scrape [url]` - Scrape website data
  - `/automate-task [description]` - Automate browser tasks
  - `/extract-data [url]` - Structured data extraction
  - `/screenshot [url]` - Capture screenshots/PDFs
- **Agent:** Scraping Expert
- **MCP:** Puppeteer (browser automation)

**Teaches:**
- Browser automation with Puppeteer
- Web scraping techniques
- Data extraction strategies
- Screenshot and PDF generation
- Anti-bot techniques
- Legal and ethical scraping

---

### 8. Slack Integration Plugin 💬
**Team Communication & Notifications**

- **Complexity:** ⭐⭐⭐ Intermediate/Advanced
- **Components:** 3 commands, 1 agent, Slack MCP
- **Pattern:** Team communication, workflow automation
- **Commands:**
  - `/send-message [channel] [message]` - Send messages
  - `/create-workflow [type]` - Automate notifications
  - `/team-status [target]` - Team activity monitoring
- **Agent:** Communication Coordinator (proactive)
- **MCP:** Slack (messaging, presence, workflows)

**Teaches:**
- Slack MCP integration
- Notification design
- Workflow automation (CI/CD, PRs, incidents)
- Team status monitoring
- Rich message formatting
- Scheduled messages

---

### 9. Cloud Storage Plugin ☁️
**File Operations & Backup Automation**

- **Complexity:** ⭐⭐⭐ Intermediate/Advanced
- **Components:** 3 commands, 1 agent, AWS S3 MCP
- **Pattern:** Cloud storage, backup, synchronization
- **Commands:**
  - `/upload [source] [destination]` - Upload files/directories
  - `/sync [source] [destination]` - Synchronize storage
  - `/manage [operation]` - Manage buckets and files
- **Agent:** Storage Optimizer (proactive)
- **MCP:** AWS S3 (cloud storage)

**Teaches:**
- AWS S3 MCP integration
- File upload and sync strategies
- Storage cost optimization
- Lifecycle policies
- Backup automation
- Security and encryption

---

### 10. Knowledge Base Plugin 📚
**Documentation & Knowledge Management**

- **Complexity:** ⭐⭐⭐ Intermediate/Advanced
- **Components:** 3 commands, 1 agent, Notion MCP
- **Pattern:** Knowledge management, doc synchronization
- **Commands:**
  - `/create-doc [title]` - Create documentation
  - `/search-kb [query]` - Search knowledge base
  - `/sync-docs [source] [destination]` - Sync documentation
- **Agent:** Knowledge Curator (proactive)
- **MCP:** Notion (knowledge management)

**Teaches:**
- Notion MCP integration
- Documentation generation from code
- Knowledge base organization
- Doc synchronization (code ↔ Notion)
- Quality monitoring
- Search optimization

---

## Pattern Summary

| Plugin | MCP | Agents | Hooks | Scripts | Key Pattern |
|--------|-----|--------|-------|---------|-------------|
| Plugin Creator | ❌ | 1 | ❌ | ❌ | Meta-programming |
| PR Reviewer | GitHub | 1 | ❌ | ❌ | GitHub Integration |
| Database Manager | PostgreSQL | 1 | ❌ | ❌ | Database Ops |
| Security Audit | ❌ | 1 | 2 | 1 | Proactive Scanning |
| API Testing | ❌ | 1 | ❌ | ❌ | Test Automation |
| Docs Generator | ❌ | 1 | ❌ | ❌ | AI Documentation |
| Web Scraping | Puppeteer | 1 | ❌ | ❌ | Browser Automation |
| Slack Integration | Slack | 1 | ❌ | ❌ | Team Communication |
| Cloud Storage | AWS S3 | 1 | ❌ | ❌ | File Operations |
| Knowledge Base | Notion | 1 | ❌ | ❌ | Knowledge Management |

## Installation

### From Marketplace

```bash
# Add real-world examples marketplace
/plugin marketplace add ./examples/marketplaces/real-world-marketplace

# Browse plugins
/plugin

# Install specific plugin
/plugin install plugin-creator@real-world-examples
/plugin install pr-reviewer@real-world-examples
```

### MCP Setup (Where Applicable)

**For PR Reviewer (GitHub):**
```bash
export GITHUB_TOKEN="ghp_your_token_here"
```

**For Database Manager (PostgreSQL):**
```bash
export DATABASE_URL="postgresql://user:pass@localhost:5432/db"
```

**For Web Scraping (Puppeteer):**
```bash
# No authentication needed - Puppeteer runs locally
```

**For Slack Integration (Slack):**
```bash
export SLACK_BOT_TOKEN="xoxb-your-bot-token"
export SLACK_TEAM_ID="T123456789"
```

**For Cloud Storage (AWS S3):**
```bash
export AWS_ACCESS_KEY_ID="AKIA..."
export AWS_SECRET_ACCESS_KEY="..."
export AWS_REGION="us-east-1"
```

**For Knowledge Base (Notion):**
```bash
export NOTION_API_KEY="secret_..."
```

## Quick Start Guide

### 1. Meta-Plugin (Create Plugins!)

```bash
/plugin install plugin-creator@real-world-examples

# Create your own plugin automatically
/create my-awesome-plugin

# Get expert design advice
/agent plugin-architect
```

### 2. PR Reviewer (GitHub Integration)

```bash
/plugin install pr-reviewer@real-world-examples

# Review a pull request
/review-pr 123

# Create PR with auto-description
/create-pr

# Check PR status
/pr-status mine
```

### 3. Database Manager

```bash
/plugin install database-manager@real-world-examples

# Natural language query
/query "show me users who signed up today"

# Run migrations
/migrate up

# Optimize query
# (Agent activates automatically on slow queries)
```

### 4. Security Audit

```bash
/plugin install security-audit@real-world-examples

# Scan codebase
/scan

# Auto-scans on file changes (proactive agent)
# Pre-commit hook checks for secrets
```

### 5. API Testing

```bash
/plugin install api-testing@real-world-examples

# Test an API
/test-api https://api.example.com/users

# Generate full test suite
/test-api https://api.example.com/openapi.json --generate-tests
```

### 6. Documentation Generator

```bash
/plugin install docs-generator@real-world-examples

# Generate all docs
/generate-docs

# Generate README
/generate-docs readme

# Generate API docs
/generate-docs api
```

## Learning Path

### For Different Use Cases

**Web Developers:**
1. Start with: PR Reviewer (code reviews)
2. Then: API Testing (backend testing)
3. Then: Security Audit (safety)

**Database Engineers:**
1. Start with: Database Manager (SQL operations)
2. Then: Documentation Generator (schema docs)
3. Then: Security Audit (SQL injection)

**DevOps Engineers:**
1. Start with: PR Reviewer (GitHub integration)
2. Then: Security Audit (compliance)
3. Then: Database Manager (migrations)

**Plugin Developers:**
1. Start with: Plugin Creator (meta-plugin!)
2. Study all examples for patterns
3. Build your own custom plugin

## Real-World Use Cases

### Startup Team (5 developers)

```bash
# Install collaboration tools
/plugin install pr-reviewer
/plugin install security-audit

# Automated workflow:
# 1. Developer creates PR → Auto-reviewed
# 2. Security scan runs → Flags issues
# 3. Team reviews → Merges
# 4. Quality improves, velocity maintained
```

### Enterprise (50+ developers)

```bash
# Install full suite
/plugin install pr-reviewer
/plugin install database-manager
/plugin install security-audit
/plugin install api-testing
/plugin install docs-generator

# Enterprise workflow:
# - PR reviews: Automated with quality gates
# - Database: Managed migrations, optimized queries
# - Security: Continuous scanning, compliance
# - APIs: Contract testing, documentation
# - Docs: Always current, auto-generated
```

### Solo Developer

```bash
# Install productivity boosters
/plugin install plugin-creator
/plugin install docs-generator

# Solo workflow:
# - Create plugins quickly (meta-plugin)
# - Document automatically
# - Ship faster, maintain quality
```

## Comparison with Basic Examples

| Feature | Beginner | Intermediate | **Real-World** |
|---------|----------|--------------|----------------|
| **Complexity** | Simple | Moderate | **Production-ready** |
| **Components** | 1-2 | 2-4 | **3-6** |
| **MCP** | ❌ | Sometimes | **6 plugins** |
| **Agents** | ❌ | 1-2 | **All have agents** |
| **Hooks** | ❌ | Yes | **Where appropriate** |
| **Use Cases** | Learning | Practice | **Production** |
| **Documentation** | Basic | Good | **Comprehensive** |

## Key Innovations

### 1. Meta-Programming
**Plugin Creator** - First plugin-creating-plugin
- Self-referential system
- AI-assisted generation
- Template automation

### 2. Live Data Integration
**PR Reviewer & Database Manager** - MCP usage
- Real-time GitHub data
- Live database queries
- OAuth authentication

### 3. Proactive Intelligence
**Security Audit** - Automated scanning
- Activates on file changes
- Pre-commit hooks
- Continuous monitoring

### 4. AI Augmentation
**All plugins** - AI as assistant
- Code review
- Query optimization
- Test generation
- Documentation writing

## Best Practices Demonstrated

### Security
- ✅ Environment variables for secrets
- ✅ OAuth via MCP
- ✅ Pre-commit scanning
- ✅ Input validation

### Performance
- ✅ Query optimization
- ✅ Efficient MCP usage
- ✅ Proactive detection
- ✅ Smart caching

### Reliability
- ✅ Error handling
- ✅ Safety confirmations
- ✅ Dry-run modes
- ✅ Rollback support

### Usability
- ✅ Clear feedback
- ✅ Interactive workflows
- ✅ Helpful defaults
- ✅ Comprehensive docs

## File Structure

```
04-real-world/
├── plugin-creator-meta-plugin/     # Meta: Creates plugins
├── pr-reviewer-plugin/             # GitHub MCP integration
├── database-plugin/                # PostgreSQL MCP integration
├── security-audit-plugin/          # Proactive security
├── api-testing-plugin/             # API testing automation
├── docs-generator-plugin/          # AI documentation
├── web-scraping-plugin/            # Puppeteer MCP integration
├── slack-integration-plugin/       # Slack MCP integration
├── cloud-storage-plugin/           # AWS S3 MCP integration
└── knowledge-base-plugin/          # Notion MCP integration

Each plugin contains:
├── .claude-plugin/plugin.json      # Metadata
├── commands/                        # Commands
├── agents/                          # Specialized agents
├── hooks/ (if applicable)           # Automation hooks
├── scripts/ (if applicable)         # Helper scripts
├── .mcp.json (if applicable)        # MCP configuration
└── README.md                        # Comprehensive docs
```

## Troubleshooting

### MCP Connection Issues

**GitHub:**
```bash
# Check token
echo $GITHUB_TOKEN

# Verify scopes
# Needs: repo, write:discussion

# Test manually
npx -y @modelcontextprotocol/server-github
```

**PostgreSQL:**
```bash
# Check connection string
echo $DATABASE_URL

# Test connection
psql $DATABASE_URL -c "SELECT 1"
```

### Proactive Agents Not Activating

```bash
# Check proactive flag
grep "proactive: true" examples/04-real-world/*/agents/*.md

# Verify conditions are met
# - File modifications trigger agents
# - Error conditions trigger agents
# - Manual invocation always works: /agent agent-name
```

## Next Steps

1. **Install** - Try each plugin
2. **Study** - Read the code
3. **Modify** - Customize for your needs
4. **Build** - Create your own using meta-plugin
5. **Share** - Contribute back to community

## Related Resources

- **Beginner Examples** - `examples/01-beginner/`
- **Intermediate Examples** - `examples/02-intermediate/`
- **Advanced Examples** - `examples/03-advanced/`
- **Learning Guide** - Root `LEARNING_GUIDE.md`

---

**Real-World Plugins:** Production-ready examples for professional development workflows

🎉 **Start building production-grade plugins today!**
