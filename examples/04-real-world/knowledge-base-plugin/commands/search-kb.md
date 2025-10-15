---
description: Search and query the knowledge base in Notion
---

# Search Knowledge Base

Search: $ARGUMENTS (query terms and filters)

**Using Notion MCP for knowledge retrieval**

## Search Operations

### 1. Basic Search
```javascript
// Search across all pages
const results = await notion.search({
  query: 'authentication',
  sort: {
    direction: 'descending',
    timestamp: 'last_edited_time'
  }
});

console.log(`Found ${results.results.length} pages`);
results.results.forEach(page => {
  console.log(`- ${page.properties.Name.title[0].text.content}`);
});
```

### 2. Filtered Search
```javascript
// Search within specific database
const results = await notion.search({
  query: 'API',
  filter: {
    property: 'object',
    value: 'page'
  },
  sort: {
    direction: 'ascending',
    timestamp: 'last_edited_time'
  }
});
```

### 3. Database Queries
```javascript
// Query with filters
const apiDocs = await notion.databases.query({
  database_id: 'api-docs-db',
  filter: {
    and: [
      {
        property: 'Status',
        select: {
          equals: 'Published'
        }
      },
      {
        property: 'Tags',
        multi_select: {
          contains: 'Backend'
        }
      }
    ]
  },
  sorts: [
    {
      property: 'Last Updated',
      direction: 'descending'
    }
  ]
});
```

### 4. Full-Text Search
```javascript
async function fullTextSearch(searchTerm) {
  // Search in titles
  const titleResults = await notion.search({
    query: searchTerm,
    filter: { property: 'object', value: 'page' }
  });

  // Search in page content
  const contentResults = [];

  for (const page of titleResults.results) {
    const blocks = await notion.blocks.children.list({
      block_id: page.id
    });

    for (const block of blocks.results) {
      if (block.type === 'paragraph') {
        const text = block.paragraph.rich_text.map(t => t.text.content).join('');
        if (text.toLowerCase().includes(searchTerm.toLowerCase())) {
          contentResults.push({
            page: page.properties.Name.title[0]?.text.content,
            pageId: page.id,
            content: text,
            url: page.url
          });
        }
      }
    }
  }

  return contentResults;
}
```

### 5. Advanced Queries
```javascript
// Find outdated documentation (not edited in 90 days)
const outdatedDocs = await notion.databases.query({
  database_id: 'docs-db',
  filter: {
    property: 'Last Edited',
    date: {
      before: new Date(Date.now() - 90 * 24 * 60 * 60 * 1000).toISOString()
    }
  }
});

// Find docs by author
const authorDocs = await notion.databases.query({
  database_id: 'docs-db',
  filter: {
    property: 'Author',
    people: {
      contains: 'user-id'
    }
  }
});

// Find high-priority incomplete tasks
const urgentTasks = await notion.databases.query({
  database_id: 'tasks-db',
  filter: {
    and: [
      {
        property: 'Priority',
        select: {
          equals: 'High'
        }
      },
      {
        property: 'Status',
        select: {
          does_not_equal: 'Done'
        }
      }
    ]
  }
});
```

### 6. Semantic Search
```javascript
// Search related documentation
async function findRelatedDocs(currentPage) {
  const currentContent = await getPageContent(currentPage);
  const keywords = extractKeywords(currentContent);

  const related = [];
  for (const keyword of keywords.slice(0, 5)) {
    const results = await notion.search({ query: keyword });
    related.push(...results.results.filter(r => r.id !== currentPage));
  }

  // Deduplicate and rank by relevance
  return deduplicateAndRank(related);
}
```

### 7. Search Analytics
```javascript
async function searchAnalytics(query) {
  const results = await notion.search({ query });

  return {
    query,
    totalResults: results.results.length,
    pageTypes: countByType(results.results),
    lastUpdated: getMostRecent(results.results),
    topAuthors: countByAuthor(results.results),
    tags: extractTags(results.results)
  };
}
```

## Example Usage

```bash
# Basic search
/search-kb "authentication"

# Search in specific database
/search-kb "API" --database "API Documentation"

# Search with filters
/search-kb "deployment" --status Published --tag DevOps

# Find outdated docs
/search-kb --outdated --days 90

# Find by author
/search-kb --author @john.doe

# Content search
/search-kb "error handling" --in-content

# Related docs
/search-kb --related "Getting Started Guide"

# Search and export
/search-kb "API" --export results.json
```

## Search Filters

**By Status:**
- `--status Draft` - Draft documents
- `--status Published` - Published documents
- `--status Archived` - Archived documents

**By Tags:**
- `--tag Backend` - Documents with Backend tag
- `--tags "API,REST"` - Multiple tags

**By Date:**
- `--updated-after 2025-01-01` - Recently updated
- `--updated-before 2024-12-31` - Older documents
- `--outdated --days 90` - Not updated in 90 days

**By Author:**
- `--author @john.doe` - Created by specific user
- `--edited-by @alice` - Last edited by user

**By Type:**
- `--type page` - Only pages
- `--type database` - Only databases

## Output Formats

**Console:**
```
Search Results for "authentication":

1. Authentication Guide (Updated: 2025-10-10)
   https://notion.so/auth-guide
   Tags: Security, Backend

2. API Authentication (Updated: 2025-09-15)
   https://notion.so/api-auth
   Tags: API, Security

Found 2 results
```

**JSON:**
```json
{
  "query": "authentication",
  "results": [
    {
      "title": "Authentication Guide",
      "url": "https://notion.so/auth-guide",
      "lastEdited": "2025-10-10T10:30:00Z",
      "author": "John Doe",
      "tags": ["Security", "Backend"]
    }
  ]
}
```

**Pattern Demonstrated:** Knowledge Retrieval, Advanced Queries, Search Optimization
