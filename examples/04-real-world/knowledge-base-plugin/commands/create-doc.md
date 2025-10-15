---
description: Create documentation pages in Notion knowledge base
---

# Create Documentation

Create doc: $ARGUMENTS (title and content)

**Using Notion MCP for knowledge management**

## Document Creation

### 1. Basic Page Creation
```javascript
// Create simple page
await notion.pages.create({
  parent: { database_id: 'docs-database-id' },
  properties: {
    Name: { title: [{ text: { content: 'Getting Started Guide' } }] }
  },
  children: [
    {
      object: 'block',
      type: 'paragraph',
      paragraph: {
        rich_text: [{ type: 'text', text: { content: 'Welcome to our documentation!' } }]
      }
    }
  ]
});
```

### 2. Rich Content Pages
```javascript
// Create page with multiple content types
await notion.pages.create({
  parent: { database_id: 'wiki-id' },
  properties: {
    Name: { title: [{ text: { content: 'API Documentation' } }] },
    Status: { select: { name: 'Published' } },
    Tags: { multi_select: [{ name: 'API' }, { name: 'Backend' }] }
  },
  children: [
    // Heading
    {
      heading_1: {
        rich_text: [{ text: { content: 'API Overview' } }]
      }
    },
    // Paragraph
    {
      paragraph: {
        rich_text: [{ text: { content: 'Our REST API provides...' } }]
      }
    },
    // Code block
    {
      code: {
        rich_text: [{ text: { content: 'GET /api/users' } }],
        language: 'javascript'
      }
    },
    // Bulleted list
    {
      bulleted_list_item: {
        rich_text: [{ text: { content: 'Authentication required' } }]
      }
    },
    // Callout (info box)
    {
      callout: {
        rich_text: [{ text: { content: '💡 Pro tip: Use API keys for authentication' } }],
        icon: { emoji: '💡' }
      }
    },
    // Toggle (collapsible)
    {
      toggle: {
        rich_text: [{ text: { content: 'View example response' } }],
        children: [
          {
            code: {
              rich_text: [{ text: { content: '{ "users": [...] }' } }],
              language: 'json'
            }
          }
        ]
      }
    }
  ]
});
```

### 3. Documentation from Code
```javascript
// Generate docs from source code
async function generateAPIDocsFromCode(sourceFile) {
  const code = await readFile(sourceFile);
  const functions = parseAPIFunctions(code);

  for (const func of functions) {
    await notion.pages.create({
      parent: { database_id: 'api-docs-db' },
      properties: {
        Name: { title: [{ text: { content: func.name } }] },
        Method: { select: { name: func.method } },
        Endpoint: { rich_text: [{ text: { content: func.endpoint } }] }
      },
      children: [
        {
          heading_2: {
            rich_text: [{ text: { content: 'Description' } }]
          }
        },
        {
          paragraph: {
            rich_text: [{ text: { content: func.description } }]
          }
        },
        {
          heading_2: {
            rich_text: [{ text: { content: 'Parameters' } }]
          }
        },
        {
          code: {
            rich_text: [{ text: { content: JSON.stringify(func.params, null, 2) } }],
            language: 'json'
          }
        },
        {
          heading_2: {
            rich_text: [{ text: { content: 'Example' } }]
          }
        },
        {
          code: {
            rich_text: [{ text: { content: func.example } }],
            language: 'javascript'
          }
        }
      ]
    });
  }
}
```

### 4. Meeting Notes Template
```javascript
async function createMeetingNotes(date, attendees, agenda) {
  await notion.pages.create({
    parent: { database_id: 'meetings-db' },
    properties: {
      Name: { title: [{ text: { content: `Team Meeting - ${date}` } }] },
      Date: { date: { start: date } },
      Attendees: { multi_select: attendees.map(a => ({ name: a })) }
    },
    children: [
      {
        heading_1: {
          rich_text: [{ text: { content: '📋 Agenda' } }]
        }
      },
      ...agenda.map(item => ({
        bulleted_list_item: {
          rich_text: [{ text: { content: item } }]
        }
      })),
      {
        heading_1: {
          rich_text: [{ text: { content: '📝 Discussion' } }]
        }
      },
      {
        paragraph: {
          rich_text: [{ text: { content: '(To be filled during meeting)' } }]
        }
      },
      {
        heading_1: {
          rich_text: [{ text: { content: '✅ Action Items' } }]
        }
      },
      {
        to_do: {
          rich_text: [{ text: { content: 'Add action items here' } }],
          checked: false
        }
      }
    ]
  });
}
```

### 5. Project Documentation
```javascript
async function createProjectDocs(project) {
  // Main project page
  const projectPage = await notion.pages.create({
    parent: { database_id: 'projects-db' },
    properties: {
      Name: { title: [{ text: { content: project.name } }] },
      Status: { select: { name: project.status } },
      Owner: { people: [{ id: project.ownerId }] }
    },
    children: [
      {
        heading_1: {
          rich_text: [{ text: { content: '🎯 Overview' } }]
        }
      },
      {
        paragraph: {
          rich_text: [{ text: { content: project.description } }]
        }
      }
    ]
  });

  // Sub-pages
  const sections = [
    { title: 'Requirements', icon: '📋' },
    { title: 'Architecture', icon: '🏗️' },
    { title: 'Implementation Plan', icon: '🗺️' },
    { title: 'API Documentation', icon: '📚' },
    { title: 'Testing Strategy', icon: '🧪' },
    { title: 'Deployment Guide', icon: '🚀' }
  ];

  for (const section of sections) {
    await notion.pages.create({
      parent: { page_id: projectPage.id },
      properties: {
        title: { title: [{ text: { content: `${section.icon} ${section.title}` } }] }
      }
    });
  }
}
```

### 6. Knowledge Base from External Sources
```javascript
// Import from Markdown
async function importMarkdownDocs(markdownFiles) {
  for (const file of markdownFiles) {
    const markdown = await readFile(file);
    const blocks = markdownToNotionBlocks(markdown);

    await notion.pages.create({
      parent: { database_id: 'docs-db' },
      properties: {
        Name: { title: [{ text: { content: extractTitle(markdown) } }] },
        Source: { rich_text: [{ text: { content: file } }] }
      },
      children: blocks
    });
  }
}

// Import from Confluence
async function importFromConfluence(confluencePages) {
  for (const page of confluencePages) {
    const content = await fetchConfluencePage(page.id);
    const blocks = htmlToNotionBlocks(content);

    await notion.pages.create({
      parent: { database_id: 'migrated-docs-db' },
      properties: {
        Name: { title: [{ text: { content: page.title } }] },
        'Original URL': { url: page.url },
        'Migrated Date': { date: { start: new Date().toISOString() } }
      },
      children: blocks
    });
  }
}
```

## Example Usage

```bash
# Create simple doc
/create-doc "Getting Started" "Welcome to our platform..."

# Create API documentation
/create-doc --template api --title "User API" --endpoint "/api/users"

# Create meeting notes
/create-doc --template meeting --date 2025-10-15 --attendees "Alice,Bob,Carol"

# Create project docs
/create-doc --template project --name "Mobile App v2.0"

# Generate from code
/create-doc --from-code ./src/api/users.js --output-to "API Docs"

# Import markdown
/create-doc --import ./docs/**/*.md --database "Documentation"

# Create release notes
/create-doc --template release --version "v2.0.0" --changes changelog.md
```

## Templates Available

- `api` - API endpoint documentation
- `meeting` - Meeting notes with agenda and action items
- `project` - Full project documentation structure
- `runbook` - Operational runbook
- `onboarding` - Team member onboarding guide
- `rfc` - Request for Comments (design proposal)
- `postmortem` - Incident postmortem
- `changelog` - Release notes

**Pattern Demonstrated:** Documentation Automation, Knowledge Management, Content Generation
