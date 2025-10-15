# Knowledge Base Plugin 📚

**Version:** 1.0.0
**Complexity:** ⭐⭐⭐ Intermediate/Advanced
**MCP Integration:** Notion

Knowledge management plugin using Notion MCP for documentation, team wikis, notes, and knowledge organization.

---

## 📋 Overview

Comprehensive knowledge base management with Notion integration for creating, searching, syncing, and maintaining documentation.

### Components

- **3 Commands:** create-doc, search-kb, sync-docs
- **1 Agent:** Knowledge Curator (proactive quality & organization)
- **1 MCP Server:** Notion (knowledge management)

### Key Features

✅ **Documentation Creation** - Generate docs from code, templates
✅ **Intelligent Search** - Full-text search with advanced filters
✅ **Auto-Sync** - Keep code and docs in sync
✅ **Quality Monitoring** - Identify outdated/broken docs
✅ **Templates** - Standardized doc templates
✅ **Organization** - Logical structure and tagging

---

## 🚀 Installation

### 1. Install Plugin
```bash
/plugin install knowledge-base@real-world-examples
```

### 2. Notion Setup

**Create Integration:**
1. Go to https://www.notion.so/my-integrations
2. Click "New integration"
3. Name it "Claude Code Integration"
4. Select capabilities: Read, Update, Insert
5. Copy the "Internal Integration Token"

**Share Pages:**
1. Open Notion page/database
2. Click "..." → "Connections"
3. Add your integration

### 3. Configure
```bash
export NOTION_API_KEY="secret_..."
```

### 4. Verify
```bash
/search-kb --test-connection
```

---

## 📚 Commands

### 1. `/create-doc [title] [content]` - Create Documentation

```bash
# Simple doc
/create-doc "Getting Started" "Welcome to our platform..."

# From template
/create-doc --template api --title "User API"

# From code
/create-doc --from-code ./src/api/ --output "API Docs"

# Meeting notes
/create-doc --template meeting --date 2025-10-15

# Project docs
/create-doc --template project --name "Mobile App v2.0"
```

**Templates:** api, meeting, project, runbook, onboarding, rfc, postmortem, changelog

---

### 2. `/search-kb [query]` - Search Knowledge Base

```bash
# Basic search
/search-kb "authentication"

# Filtered search
/search-kb "API" --status Published --tag Backend

# Find outdated
/search-kb --outdated --days 90

# By author
/search-kb --author @john.doe

# Related docs
/search-kb --related "Getting Started"
```

---

### 3. `/sync-docs [source] [destination]` - Sync Documentation

```bash
# Code to Notion
/sync-docs ./src/ --to-notion "API Documentation"

# Notion to README
/sync-docs --from-notion "Getting Started" --to-file README.md

# Bidirectional
/sync-docs ./docs/ "Documentation" --bidirectional

# Watch mode
/sync-docs ./docs/ "Documentation" --watch

# Sync OpenAPI
/sync-docs openapi.yaml --to-notion "API Reference"
```

---

## 🤖 Agent: Knowledge Curator

Proactive agent that maintains documentation quality.

**Auto-maintenance:**
- Reviews new documentation
- Flags outdated content
- Detects duplicates
- Finds broken links
- Suggests improvements

```bash
/agent knowledge-curator
# "How can I improve our documentation quality?"
# "What docs need updating?"
```

---

## 🎯 Use Cases

### 1. API Documentation
```bash
# Generate from OpenAPI
/sync-docs openapi.yaml --to-notion "API Reference"

# Auto-update on changes
/sync-docs ./openapi/ "API Reference" --watch
```

### 2. Team Wiki
```bash
# Create knowledge base structure
/create-doc --template wiki

# Sync team docs
/sync-docs ./team-docs/ "Team Wiki" --bidirectional
```

### 3. Onboarding
```bash
# Create onboarding docs
/create-doc --template onboarding --role "Software Engineer"

# Keep updated
/sync-docs --from-notion "Onboarding" --to-file ONBOARDING.md
```

### 4. Meeting Notes
```bash
# Daily standup
/create-doc --template meeting --daily

# Project meeting
/create-doc --template meeting --attendees "Alice,Bob" --agenda "..."
```

---

## 🛡️ Best Practices

### Documentation Structure
```
📚 Knowledge Base
├── 🚀 Getting Started
├── 📖 Guides
├── 📚 API Reference
├── 🛠 Tutorials
├── 💡 Best Practices
├── ❓ FAQ
└── 🐛 Troubleshooting
```

### Naming Conventions
- Clear, descriptive titles
- Consistent formatting
- Logical prefixes/emojis

### Quality Standards
- Clear purpose
- Code examples
- Last updated date
- Owner assigned
- Proper tagging
- No broken links

### Maintenance
- Review quarterly
- Archive outdated content
- Consolidate duplicates
- Update examples

---

## 🐛 Troubleshooting

### Issue: Can't Access Notion
**Solution:** Share pages with integration in Notion

### Issue: Sync Conflicts
**Solution:** Use `--prefer-notion` or `--prefer-local` flags

### Issue: Outdated Docs
**Solution:** Run `/search-kb --outdated` to find

---

## 📊 Documentation Metrics

Track documentation health:
```bash
# Get metrics
/search-kb --metrics

# Quality report
/agent knowledge-curator "Generate quality report"
```

**Metrics:**
- Total documents
- Quality scores
- Outdated count
- Broken links
- Most/least viewed

---

**Pattern Demonstrated:** Knowledge Management, Documentation Automation, Quality Assurance, MCP Integration

📚 **Start building your knowledge base today!**
