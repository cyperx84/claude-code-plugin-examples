---
description: Synchronize documentation between code and Notion knowledge base
---

# Sync Documentation

Sync docs: $ARGUMENTS (source and destination)

**Using Notion MCP for doc synchronization**

## Sync Strategies

### 1. Code to Notion (Documentation Generation)
```javascript
// Sync JSDoc comments to Notion
async function syncJSDocToNotion(sourceFiles) {
  for (const file of sourceFiles) {
    const docs = parseJSDoc(file);

    for (const doc of docs) {
      // Check if page exists
      const existing = await findNotionPage(doc.name);

      if (existing) {
        // Update existing
        await notion.pages.update({
          page_id: existing.id,
          properties: {
            'Last Synced': { date: { start: new Date().toISOString() } }
          }
        });

        await updatePageContent(existing.id, doc);
      } else {
        // Create new
        await notion.pages.create({
          parent: { database_id: 'code-docs-db' },
          properties: {
            Name: { title: [{ text: { content: doc.name } }] },
            Type: { select: { name: doc.type } },
            Source: { rich_text: [{ text: { content: file } }] }
          },
          children: generateBlocks(doc)
        });
      }
    }
  }
}
```

### 2. Notion to Code (README Sync)
```javascript
// Sync Notion page to README.md
async function syncNotionToReadme(pageId, readmePath) {
  const page = await notion.pages.retrieve({ page_id: pageId });
  const blocks = await notion.blocks.children.list({ block_id: pageId });

  // Convert Notion blocks to Markdown
  const markdown = notionBlocksToMarkdown(blocks.results);

  // Update README.md
  await fs.writeFile(readmePath, markdown);

  console.log(`✅ Synced ${page.properties.Name.title[0].text.content} to ${readmePath}`);
}
```

### 3. Bidirectional Sync
```javascript
async function bidirectionalSync(sourceDir, notionDbId) {
  // Get last sync timestamp
  const lastSync = await getLastSyncTime();

  // Find files changed since last sync
  const changedFiles = await getChangedFiles(sourceDir, lastSync);

  // Sync changed files to Notion
  for (const file of changedFiles) {
    const content = await readFile(file);
    await syncFileToNotion(file, content, notionDbId);
  }

  // Find Notion pages changed since last sync
  const changedPages = await notion.databases.query({
    database_id: notionDbId,
    filter: {
      property: 'Last Edited',
      date: {
        after: lastSync.toISOString()
      }
    }
  });

  // Sync changed pages to files
  for (const page of changedPages.results) {
    await syncNotionPageToFile(page, sourceDir);
  }

  // Update sync timestamp
  await updateLastSyncTime(new Date());
}
```

### 4. OpenAPI to Notion
```javascript
// Sync OpenAPI spec to Notion API docs
async function syncOpenAPIToNotion(openApiPath, notionDbId) {
  const spec = await readOpenAPISpec(openApiPath);

  for (const [path, methods] of Object.entries(spec.paths)) {
    for (const [method, operation] of Object.entries(methods)) {
      await notion.pages.create({
        parent: { database_id: notionDbId },
        properties: {
          Name: { title: [{ text: { content: `${method.toUpperCase()} ${path}` } }] },
          Method: { select: { name: method.toUpperCase() } },
          Endpoint: { rich_text: [{ text: { content: path } }] }
        },
        children: [
          {
            heading_2: {
              rich_text: [{ text: { content: 'Description' } }]
            }
          },
          {
            paragraph: {
              rich_text: [{ text: { content: operation.summary || operation.description } }]
            }
          },
          operation.parameters && {
            heading_2: {
              rich_text: [{ text: { content: 'Parameters' } }]
            }
          },
          operation.parameters && {
            code: {
              rich_text: [{ text: { content: JSON.stringify(operation.parameters, null, 2) } }],
              language: 'json'
            }
          }
        ].filter(Boolean)
      });
    }
  }
}
```

### 5. TypeScript to Notion
```javascript
// Generate type documentation
async function syncTypeScriptToNotion(tsFiles, notionDbId) {
  for (const file of tsFiles) {
    const types = parseTypeScriptFile(file);

    for (const type of types) {
      await notion.pages.create({
        parent: { database_id: notionDbId },
        properties: {
          Name: { title: [{ text: { content: type.name } }] },
          Kind: { select: { name: type.kind } }, // interface, type, class
          Source: { rich_text: [{ text: { content: file } }] }
        },
        children: [
          {
            heading_2: {
              rich_text: [{ text: { content: 'Type Definition' } }]
            }
          },
          {
            code: {
              rich_text: [{ text: { content: type.definition } }],
              language: 'typescript'
            }
          },
          type.properties.length > 0 && {
            heading_2: {
              rich_text: [{ text: { content: 'Properties' } }]
            }
          },
          ...type.properties.map(prop => ({
            bulleted_list_item: {
              rich_text: [{ text: { content: `${prop.name}: ${prop.type} - ${prop.description}` } }]
            }
          }))
        ].filter(Boolean)
      });
    }
  }
}
```

### 6. Changelog Sync
```javascript
// Sync CHANGELOG.md to Notion
async function syncChangelogToNotion(changelogPath, notionPageId) {
  const changelog = await readFile(changelogPath);
  const releases = parseChangelog(changelog);

  for (const release of releases) {
    await notion.pages.create({
      parent: { page_id: notionPageId },
      properties: {
        title: { title: [{ text: { content: `v${release.version}` } }] }
      },
      children: [
        {
          heading_1: {
            rich_text: [{ text: { content: `Version ${release.version}` } }]
          }
        },
        {
          paragraph: {
            rich_text: [{ text: { content: `Released: ${release.date}` } }]
          }
        },
        ...release.changes.map(change => ({
          bulleted_list_item: {
            rich_text: [{ text: { content: `${change.type}: ${change.description}` } }]
          }
        }))
      ]
    });
  }
}
```

### 7. Watch Mode
```javascript
// Auto-sync on file changes
async function watchAndSync(sourceDir, notionDbId) {
  const watcher = chokidar.watch(sourceDir, {
    ignored: /(^|[\/\\])\../,
    persistent: true
  });

  watcher.on('change', async (path) => {
    console.log(`📝 File changed: ${path}`);

    const content = await readFile(path);
    await syncFileToNotion(path, content, notionDbId);

    console.log(`✅ Synced to Notion`);
  });

  console.log(`👀 Watching ${sourceDir} for changes...`);
}
```

## Example Usage

```bash
# Sync code to Notion
/sync-docs ./src/ --to-notion "API Documentation"

# Sync Notion to README
/sync-docs --from-notion "Getting Started" --to-file README.md

# Bidirectional sync
/sync-docs ./docs/ "Documentation" --bidirectional

# Sync OpenAPI spec
/sync-docs openapi.yaml --to-notion "API Reference"

# Sync TypeScript types
/sync-docs ./src/**/*.ts --to-notion "Type Reference"

# Sync changelog
/sync-docs CHANGELOG.md --to-notion "Release Notes"

# Watch mode
/sync-docs ./docs/ "Documentation" --watch

# One-time full sync
/sync-docs ./project/ "Project Docs" --full-sync --clean
```

## Sync Options

**Direction:**
- `--to-notion` - Code to Notion
- `--to-file` - Notion to file
- `--bidirectional` - Both ways

**Mode:**
- `--watch` - Continuous sync
- `--full-sync` - Sync all files
- `--incremental` - Only changed files

**Conflict Resolution:**
- `--prefer-notion` - Notion version wins
- `--prefer-local` - Local version wins
- `--manual` - Prompt for conflicts

**Cleaning:**
- `--clean` - Remove orphaned pages
- `--archive` - Archive instead of delete

**Pattern Demonstrated:** Documentation Sync, Continuous Integration, Version Control
