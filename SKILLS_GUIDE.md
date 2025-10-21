# Claude Code Skills in Plugins - Comprehensive Guide

**Version**: 1.0.0
**Last Updated**: 2025-01-21
**Audience**: Plugin Developers, AI Agents, and Claude Code Users

---

## 📋 Table of Contents

1. [What Are Skills?](#what-are-skills)
2. [Why Use Skills in Plugins?](#why-use-skills-in-plugins)
3. [Skills Architecture](#skills-architecture)
4. [Creating Skills](#creating-skills)
5. [Skill File Format](#skill-file-format)
6. [Organizing Skills in Plugins](#organizing-skills-in-plugins)
7. [Best Practices](#best-practices)
8. [Skills by Plugin Type](#skills-by-plugin-type)
9. [Complete Examples](#complete-examples)
10. [For AI Agents](#for-ai-agents)
11. [Troubleshooting](#troubleshooting)

---

## What Are Skills?

**Skills** are modular, self-contained bundles of knowledge and instructions that extend Claude's capabilities in specific domains. Think of them as **"expertise modules"** that Claude can load on-demand.

### Key Characteristics

```
┌─────────────────────────────────────┐
│  SKILL = Knowledge + Instructions   │
├─────────────────────────────────────┤
│  - Domain-specific expertise        │
│  - Step-by-step procedures          │
│  - Examples and templates           │
│  - Best practices                   │
│  - Common patterns                  │
│  - Troubleshooting guides           │
└─────────────────────────────────────┘
```

### Skills vs Commands vs Agents

| Feature | Command | Agent | Skill |
|---------|---------|-------|-------|
| **Purpose** | Execute specific action | Autonomous task completion | Provide knowledge/guidance |
| **Activation** | User types `/command` | User invokes or proactive | Loaded automatically by context |
| **Execution** | Runs immediately | Multi-step process | Referenced during task |
| **Output** | Direct result | Completed task | Enhanced understanding |
| **Example** | `/greet` → greeting | `test-debugger` → fixes tests | `commit-message-generator` → better commits |

**Key Insight**: Skills **augment** commands and agents by providing domain expertise that improves their output quality.

---

## Why Use Skills in Plugins?

### Benefits for Plugin Users

✅ **Better Output Quality**: Skills provide deep domain knowledge
✅ **Consistency**: Standardized approaches across team
✅ **Learning**: Users learn best practices through usage
✅ **Time Savings**: Proven patterns instead of trial and error
✅ **Completeness**: Skills remind Claude of edge cases

### Benefits for Plugin Developers

✅ **Separation of Concerns**: Keep knowledge separate from execution
✅ **Reusability**: Skills can be referenced by multiple commands
✅ **Maintainability**: Update knowledge without changing code
✅ **Extensibility**: Easy to add new expertise areas
✅ **Documentation**: Skills serve as living documentation

### Real-World Impact

```
Without Skill:
User: "Create a commit message"
Claude: "feat: add feature"

With Skill:
User: "Create a commit message"
Claude: "feat(auth): implement JWT token authentication

Adds JWT-based authentication to replace session cookies.
Users now authenticate via Authorization header with Bearer token.

- Add JWT generation and validation
- Update login endpoint to return token
- Add token verification middleware
- Update API documentation

Closes #142"
```

**Difference**: The skill provides:
- Conventional commit format
- Proper scope
- Detailed body explaining WHY
- Bullet points for WHAT changed
- Issue reference

---

## Skills Architecture

### Plugin Structure with Skills

```
my-plugin/
├── .claude-plugin/
│   └── plugin.json              # Plugin metadata
├── commands/
│   ├── commit.md                # Command that uses skills
│   └── review.md                # Another command
├── agents/
│   └── code-reviewer.md         # Agent that uses skills
├── skills/                      # 🆕 Skills directory
│   ├── commit-message-generator/
│   │   ├── SKILL.md            # Main skill definition
│   │   └── templates/          # Optional: Supporting files
│   │       └── examples.md
│   ├── code-review-checklist/
│   │   └── SKILL.md
│   └── git-workflow-guide/
│       └── SKILL.md
└── README.md
```

### Skill Discovery

Claude automatically discovers skills in:
1. **`skills/` directory** in the plugin root
2. **Subdirectories** under `skills/` (one skill per subdirectory)
3. **`SKILL.md` file** in each subdirectory

```
Skills are loaded when:
- Plugin is activated
- Command is invoked that needs the skill
- Agent references the skill
- User asks questions in the skill's domain
```

---

## Creating Skills

### Step 1: Identify the Knowledge Domain

Ask yourself:
- What expertise would make my plugin better?
- What do users repeatedly ask about?
- What best practices should be standardized?
- What common mistakes can be prevented?

**Examples**:
- `commit-message-generator` for git plugins
- `test-pattern-library` for testing plugins
- `vulnerability-detection` for security plugins
- `query-optimization` for database plugins

### Step 2: Create the Skill Directory

```bash
# In your plugin root
mkdir -p skills/my-skill-name
cd skills/my-skill-name
```

**Naming Convention**:
- Use lowercase with hyphens: `skill-name`
- Be specific: `query-optimization` > `database`
- Focus on capability: `vulnerability-detection` > `security`

### Step 3: Create SKILL.md

```bash
touch SKILL.md
```

This is the **required** file that defines your skill.

### Step 4: Add Optional Resources

```bash
mkdir templates examples scripts
```

Optional supporting files:
- `templates/` - Reusable templates
- `examples/` - Extended examples
- `scripts/` - Helper scripts
- `schemas/` - JSON schemas
- `data/` - Reference data

---

## Skill File Format

### Required Structure

```markdown
---
name: Skill Name
description: Brief description of what this skill does and when to use it
---

# Skill Name

[Detailed content here]

## Related Skills
- `other-skill-name`: Brief description
```

### YAML Frontmatter (Required)

```yaml
---
name: "Commit Message Generator"
description: "Generate clear, conventional, and meaningful commit messages following best practices and conventional commit standards"
---
```

**Fields**:
- `name` (required): Human-readable skill name
- `description` (required): One-sentence description
- `version` (optional): Skill version (e.g., "1.0.0")
- `author` (optional): Skill creator
- `tags` (optional): Searchable tags

### Content Sections (Recommended)

```markdown
# Skill Name

## Purpose
What this skill helps with

## When to Use
Situations where this skill is valuable

## Instructions
Step-by-step guidance

## Examples
Concrete examples

## Best Practices
Do's and don'ts

## Templates
Reusable patterns

## Troubleshooting
Common issues and solutions

## Related Skills
Links to complementary skills
```

### Example: Complete Skill

```markdown
---
name: API Test Design
description: Strategies for designing comprehensive API tests including contract testing, integration testing, and performance testing
---

# API Test Design

## Purpose

Design comprehensive API tests that:
- Verify functionality and contracts
- Catch regressions early
- Test edge cases and error conditions
- Validate performance characteristics
- Ensure API reliability

## When to Use

Invoke this skill when:
- Writing tests for REST/GraphQL APIs
- Designing test strategies
- Reviewing test coverage
- Debugging API failures
- Setting up test automation

## Instructions

### Step 1: Understand the API

Gather information about:
1. **Endpoints**: All routes and methods
2. **Request/Response**: Expected formats
3. **Authentication**: Auth mechanisms
4. **Error Handling**: Error responses
5. **Rate Limits**: Throttling rules

### Step 2: Apply Test Pyramid

```
           /\
          /E2E\         Few: Complete workflows
         /------\
        /Integra-\      Some: Multi-service tests
       /tion Tests\
      /------------\
     / Unit Tests   \   Many: Individual endpoints
    /________________\
```

**Distribution**:
- 70% Unit tests (individual endpoints)
- 20% Integration tests (service interactions)
- 10% E2E tests (complete workflows)

### Step 3: Test All HTTP Methods

```typescript
describe('Users API', () => {
  describe('GET /api/users', () => {
    it('should return all users', async () => {
      const response = await request(app).get('/api/users');
      expect(response.status).toBe(200);
      expect(Array.isArray(response.body)).toBe(true);
    });

    it('should support pagination', async () => {
      const response = await request(app)
        .get('/api/users?page=2&limit=10');
      expect(response.body.page).toBe(2);
      expect(response.body.data.length).toBeLessThanOrEqual(10);
    });
  });

  describe('POST /api/users', () => {
    it('should create user with valid data', async () => {
      const userData = {
        email: 'test@example.com',
        name: 'Test User'
      };

      const response = await request(app)
        .post('/api/users')
        .send(userData);

      expect(response.status).toBe(201);
      expect(response.body.email).toBe(userData.email);
    });

    it('should reject invalid email', async () => {
      const response = await request(app)
        .post('/api/users')
        .send({ email: 'invalid', name: 'Test' });

      expect(response.status).toBe(400);
      expect(response.body.errors).toContainEqual(
        expect.objectContaining({ field: 'email' })
      );
    });
  });
});
```

## Best Practices

### DO:
✅ Test both happy and sad paths
✅ Validate response schemas
✅ Test authentication/authorization
✅ Check error messages
✅ Test edge cases (empty, null, invalid)
✅ Verify HTTP status codes
✅ Test rate limiting

### DON'T:
❌ Test only happy paths
❌ Hardcode test data
❌ Skip authentication tests
❌ Ignore error responses
❌ Test in production
❌ Share test data between tests
❌ Forget to cleanup after tests

## Templates

### Contract Test Template

```typescript
import { pactWith } from 'jest-pact';

pactWith({ consumer: 'WebApp', provider: 'UserAPI' }, (provider) => {
  describe('User API Contract', () => {
    beforeEach(() => {
      const interaction = {
        state: 'user exists',
        uponReceiving: 'a request for user by ID',
        withRequest: {
          method: 'GET',
          path: '/api/users/1',
          headers: { Accept: 'application/json' }
        },
        willRespondWith: {
          status: 200,
          headers: { 'Content-Type': 'application/json' },
          body: {
            id: 1,
            email: 'user@example.com',
            name: 'Test User'
          }
        }
      };

      return provider.addInteraction(interaction);
    });

    it('retrieves user successfully', async () => {
      const response = await fetchUser(1);
      expect(response.id).toBe(1);
    });
  });
});
```

## Related Skills

- `test-pattern-library`: For general testing patterns
- `assertion-helper`: For better assertions
- `mock-generator`: For mocking dependencies
- `performance-testing`: For load/stress testing
```

---

## Organizing Skills in Plugins

### Single Skill Plugin

```
simple-plugin/
├── .claude-plugin/
│   └── plugin.json
├── commands/
│   └── format.md
└── skills/
    └── code-formatter/
        └── SKILL.md
```

### Multiple Skills Plugin

```
advanced-plugin/
├── .claude-plugin/
│   └── plugin.json
├── commands/
│   ├── deploy.md
│   └── monitor.md
├── agents/
│   └── sre-agent.md
└── skills/
    ├── deployment-strategies/
    │   └── SKILL.md
    ├── incident-response/
    │   └── SKILL.md
    └── monitoring-setup/
        └── SKILL.md
```

### Skills with Resources

```
data-plugin/
└── skills/
    └── query-optimization/
        ├── SKILL.md
        ├── examples/
        │   ├── complex-queries.sql
        │   └── index-strategies.sql
        ├── templates/
        │   └── explain-plan-template.md
        └── scripts/
            └── analyze-query.sh
```

---

## Best Practices

### Content Guidelines

**1. Be Specific and Actionable**

❌ Bad:
```markdown
## How to Write Tests

Write tests for your code. Make sure they cover edge cases.
```

✅ Good:
```markdown
## Test Writing Strategy

### Step 1: Identify Test Cases

For each function, test:
1. **Happy path**: Normal expected input
2. **Edge cases**: Boundary values (0, max, min)
3. **Error cases**: Invalid input, null, undefined
4. **State changes**: Before/after verification

Example:
```typescript
describe('divide(a, b)', () => {
  it('returns quotient for valid numbers', () => {
    expect(divide(10, 2)).toBe(5);
  });

  it('handles division by zero', () => {
    expect(() => divide(10, 0)).toThrow('Cannot divide by zero');
  });

  it('handles negative numbers', () => {
    expect(divide(-10, 2)).toBe(-5);
  });
});
```
```

**2. Include Real Code Examples**

Always provide working code in relevant languages:

```markdown
## Python Example

```python
def validate_email(email: str) -> bool:
    """Validate email format."""
    import re
    pattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$'
    return bool(re.match(pattern, email))
```

## JavaScript Example

```javascript
function validateEmail(email) {
  const pattern = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
  return pattern.test(email);
}
```
```

**3. Structure with Clear Sections**

Use consistent heading hierarchy:
- `# H1`: Skill title
- `## H2`: Major sections (Purpose, Instructions, Examples)
- `### H3`: Subsections (Step 1, Step 2)
- `#### H4`: Sub-subsections (optional)

**4. Provide Templates**

Include reusable templates:

```markdown
## Commit Message Template

```
<type>(<scope>): <subject>

<body>

<footer>
```

**Types**: feat, fix, docs, style, refactor, test, chore
**Scope**: Component or file affected
**Subject**: Imperative mood, lowercase, no period
**Body**: Explain WHY, not WHAT
**Footer**: BREAKING CHANGE, issues closed
```

**5. Add Troubleshooting Section**

```markdown
## Troubleshooting

### Issue: Tests timeout

**Symptoms**: Jest/pytest hangs indefinitely

**Solutions**:
1. Increase timeout:
   ```javascript
   jest.setTimeout(10000); // 10 seconds
   ```

2. Check for unclosed connections:
   ```javascript
   afterAll(async () => {
     await database.close();
     await server.close();
   });
   ```

3. Look for infinite loops in test code
```

### Organization Guidelines

**1. One Skill = One Domain**

❌ Bad: `helpers` (too broad)
✅ Good: `commit-message-generator` (specific)

**2. Related Skills Should Reference Each Other**

```markdown
## Related Skills

- `git-workflow-guide`: For overall git workflows
- `pr-description-generator`: For pull request descriptions
- `changelog-generator`: For creating changelogs from commits
```

**3. Skill Names Should Be Descriptive**

Pattern: `{verb}-{noun}` or `{domain}-{aspect}`

Examples:
- `test-pattern-library`
- `query-optimization`
- `deployment-strategies`
- `vulnerability-detection`
- `api-test-design`

**4. Keep Skills Focused**

If a skill grows too large (>1000 lines), consider splitting:

❌ `testing` (too broad)
✅ Split into:
- `unit-test-patterns`
- `integration-test-patterns`
- `e2e-test-patterns`
- `test-data-factory`

---

## Skills by Plugin Type

### Beginner Plugins

**Focus**: Learning and simple patterns

```
hello-plugin/skills/
├── greeting-generator/      # How to create engaging greetings
└── motivation-generator/    # Encouraging messages

git-helper-plugin/skills/
├── commit-message-generator/  # Conventional commits
└── git-workflow-guide/        # Branch strategies, workflows

code-snippets-plugin/skills/
├── snippet-generator/         # Code snippet creation
└── code-template-library/     # Project templates
```

### Intermediate Plugins

**Focus**: Best practices and automation

```
testing-plugin/skills/
├── test-pattern-library/      # Testing patterns
└── assertion-helper/          # Better assertions

productivity-plugin/skills/
├── focus-techniques/          # Deep work, pomodoro
└── time-management/           # Planning, prioritization
```

### Advanced Plugins

**Focus**: Complex systems and production patterns

```
devops-plugin/skills/
├── deployment-strategies/     # Blue-green, canary
└── incident-response/         # Production incidents
```

### Real-World Plugins

**Focus**: Production-ready, domain-specific expertise

```
security-audit-plugin/skills/
├── vulnerability-detection/      # OWASP Top 10, scanning
└── security-best-practices/      # Secure coding

database-plugin/skills/
├── query-optimization/           # EXPLAIN, indexes
└── migration-strategies/         # Schema changes

api-testing-plugin/skills/
├── api-test-design/             # Contract, integration tests
└── performance-testing/         # Load, stress testing

web-scraping-plugin/skills/
├── scraping-best-practices/     # Legal, ethical scraping
└── anti-bot-evasion/            # Stealth techniques
```

---

## Complete Examples

### Example 1: Simple Skill

**File**: `skills/greeting-generator/SKILL.md`

```markdown
---
name: Greeting Generator
description: Generate personalized, context-aware greetings for developers
---

# Greeting Generator

## Purpose

Create warm, personalized greetings based on time of day and context.

## When to Use

- User starts a coding session
- Creating welcome messages
- Setting positive tone for collaboration

## Instructions

### Step 1: Determine Time of Day

- Morning (5am-12pm): "Good morning!"
- Afternoon (12pm-5pm): "Good afternoon!"
- Evening (5pm-10pm): "Good evening!"
- Night (10pm-5am): "Burning the midnight oil?"

### Step 2: Add Programming Context

Include one of:
- Programming joke
- Developer quote
- Fun fact
- Productivity tip

### Step 3: Invite Engagement

Ask what they're working on and offer help.

## Examples

### Morning Greeting

```
Good morning! Ready to write some beautiful code today?

Fun fact: The first computer bug was an actual moth found in
Harvard's Mark II computer in 1947.

What are you building today? I'm here to help make it awesome!
```

## Related Skills

- `motivation-generator`: For ongoing encouragement
```

### Example 2: Advanced Skill

**File**: `skills/query-optimization/SKILL.md`

```markdown
---
name: Query Optimization
description: Techniques for optimizing database queries, indexing strategies, and performance tuning
---

# Query Optimization

## Purpose

Optimize database queries through:
- Reading EXPLAIN plans
- Choosing right indexes
- Rewriting inefficient queries
- Solving N+1 problems
- Implementing caching

## When to Use

- Slow queries in production
- Designing new features
- Optimizing existing code
- Database performance review
- Capacity planning

## Instructions

### Step 1: Identify Slow Queries

```sql
-- PostgreSQL: Find slow queries
SELECT
  query,
  mean_exec_time,
  calls
FROM pg_stat_statements
ORDER BY mean_exec_time DESC
LIMIT 10;

-- MySQL: Enable slow query log
SET GLOBAL slow_query_log = 'ON';
SET GLOBAL long_query_time = 1; -- Log queries > 1 second
```

### Step 2: Analyze with EXPLAIN

```sql
EXPLAIN ANALYZE
SELECT u.name, COUNT(o.id) as order_count
FROM users u
LEFT JOIN orders o ON u.id = o.user_id
GROUP BY u.id, u.name;

-- Look for:
-- - Seq Scan (should be Index Scan)
-- - High cost numbers
-- - Large row estimates
-- - Nested loops on large tables
```

### Step 3: Add Appropriate Indexes

```sql
-- Simple index
CREATE INDEX idx_orders_user_id ON orders(user_id);

-- Composite index (column order matters!)
CREATE INDEX idx_orders_user_status ON orders(user_id, status);

-- Partial index (for common filters)
CREATE INDEX idx_active_users ON users(created_at)
WHERE status = 'active';

-- Covering index (includes all needed columns)
CREATE INDEX idx_orders_covering ON orders(user_id, status)
INCLUDE (created_at, total_amount);
```

### Step 4: Rewrite Query

❌ Before:
```sql
SELECT * FROM users
WHERE UPPER(email) = 'USER@EXAMPLE.COM';
```

✅ After:
```sql
-- Add functional index
CREATE INDEX idx_users_email_upper ON users(UPPER(email));

SELECT * FROM users
WHERE UPPER(email) = 'USER@EXAMPLE.COM';
```

## N+1 Query Problem

### Problem

```python
# This creates N+1 queries!
users = User.query.all()  # 1 query
for user in users:
    print(user.orders)  # N queries (one per user)
```

### Solution

```python
# Use eager loading - only 1-2 queries
users = User.query.options(joinedload(User.orders)).all()
for user in users:
    print(user.orders)  # No additional queries
```

## Caching Strategies

```python
from functools import lru_cache
import redis

redis_client = redis.Redis()

@lru_cache(maxsize=100)
def get_user_by_id(user_id: int):
    """In-memory cache for frequently accessed users."""
    return User.query.get(user_id)

def get_product(product_id: int):
    """Redis cache for product data."""
    cache_key = f"product:{product_id}"

    # Try cache first
    cached = redis_client.get(cache_key)
    if cached:
        return json.loads(cached)

    # Cache miss - query database
    product = Product.query.get(product_id)

    # Store in cache (expire after 1 hour)
    redis_client.setex(
        cache_key,
        3600,
        json.dumps(product.to_dict())
    )

    return product
```

## Best Practices

### Index Strategy

✅ **DO**:
- Index foreign keys
- Index WHERE clause columns
- Index ORDER BY columns
- Use composite indexes for multi-column queries
- Monitor index usage

❌ **DON'T**:
- Over-index (slows writes)
- Index low-cardinality columns (status with 2 values)
- Forget to update statistics
- Index everything

### Query Writing

✅ **DO**:
```sql
-- Select only needed columns
SELECT id, name, email FROM users;

-- Filter as early as possible
SELECT u.name
FROM users u
WHERE u.status = 'active'  -- Filter first
  AND u.created_at > '2024-01-01';

-- Use LIMIT for pagination
SELECT * FROM users
ORDER BY created_at DESC
LIMIT 20 OFFSET 40;
```

❌ **DON'T**:
```sql
-- Don't use SELECT *
SELECT * FROM users;

-- Don't use functions on indexed columns
SELECT * FROM users WHERE YEAR(created_at) = 2024;
-- Instead: WHERE created_at >= '2024-01-01' AND created_at < '2025-01-01'

-- Don't fetch everything without LIMIT
SELECT * FROM users;  -- Could return millions
```

## Related Skills

- `database-migrations`: For schema changes
- `connection-pooling`: For connection management
- `monitoring-setup`: For query performance tracking
```

---

## For AI Agents

### How Agents Should Use Skills

When an AI agent (like Claude) encounters a task:

1. **Skill Discovery**: Check if relevant skills are available
2. **Skill Loading**: Load applicable skill(s) into context
3. **Skill Application**: Follow skill instructions
4. **Skill Reference**: Cite skill patterns in output

### Example Agent Workflow

```
User Request: "Create a commit message for my auth changes"

Agent Process:
1. Identify task type: Git commit message
2. Check for skill: `commit-message-generator` ✓ Found
3. Load skill instructions
4. Apply skill patterns:
   - Use conventional commit format
   - Add scope (auth)
   - Write descriptive body
   - Reference issues
5. Generate output following skill template
6. Result: High-quality conventional commit message
```

### When to Invoke Skills

```typescript
interface SkillInvocation {
  trigger: 'command' | 'agent' | 'question' | 'context';
  confidence: number;  // 0-1, how confident skill is relevant
  priority: 'high' | 'medium' | 'low';
}

function shouldInvokeSkill(task: Task): SkillInvocation {
  // Direct command invocation
  if (task.type === 'slash-command' && task.relatedSkills.length > 0) {
    return { trigger: 'command', confidence: 1.0, priority: 'high' };
  }

  // Agent task
  if (task.type === 'agent' && task.domain in skills) {
    return { trigger: 'agent', confidence: 0.9, priority: 'high' };
  }

  // User question
  if (task.type === 'question' && matchesSkillDomain(task.question)) {
    return { trigger: 'question', confidence: 0.7, priority: 'medium' };
  }

  // Background context
  if (isRelevantContext(task)) {
    return { trigger: 'context', confidence: 0.5, priority: 'low' };
  }
}
```

### Skill-Enhanced Responses

**Without Skill**:
```
User: "How do I optimize this query?"
Agent: "You could add an index and use EXPLAIN to check performance."
```

**With Skill** (`query-optimization`):
```
User: "How do I optimize this query?"
Agent: "Let me help you optimize this query using systematic analysis:

1. First, let's analyze with EXPLAIN:
   ```sql
   EXPLAIN ANALYZE
   SELECT u.name, COUNT(o.id)
   FROM users u
   LEFT JOIN orders o ON u.id = o.user_id
   GROUP BY u.id, u.name;
   ```

2. Look for these red flags:
   - Seq Scan instead of Index Scan
   - High cost numbers (> 1000)
   - Large row estimates

3. Add an index on the foreign key:
   ```sql
   CREATE INDEX idx_orders_user_id ON orders(user_id);
   ```

4. Verify improvement:
   - Re-run EXPLAIN ANALYZE
   - Check cost reduction
   - Monitor query time

Would you like me to analyze your specific query?"
```

---

## Troubleshooting

### Skill Not Loading

**Problem**: Skill exists but isn't being used

**Checks**:
```bash
# 1. Verify directory structure
ls -la skills/my-skill/
# Should show: SKILL.md

# 2. Check YAML frontmatter
head -5 skills/my-skill/SKILL.md
# Should show:
# ---
# name: My Skill
# description: ...
# ---

# 3. Verify plugin.json
cat .claude-plugin/plugin.json
# Plugin should be valid JSON
```

**Solutions**:
- Ensure `SKILL.md` filename is correct (case-sensitive)
- Verify YAML frontmatter is valid
- Check for syntax errors in markdown
- Restart Claude Code if needed

### Skill Too Large

**Problem**: Skill file is >2000 lines

**Solution**: Split into multiple skills

```
Before:
skills/
└── testing/  # 3000 lines - too large!
    └── SKILL.md

After:
skills/
├── unit-test-patterns/
│   └── SKILL.md  # 600 lines
├── integration-test-patterns/
│   └── SKILL.md  # 500 lines
├── e2e-test-patterns/
│   └── SKILL.md  # 400 lines
└── test-data-factory/
    └── SKILL.md  # 300 lines
```

### Skill Conflicts

**Problem**: Multiple skills cover similar topics

**Solution**: Use clear naming and cross-references

```markdown
## skills/commit-message-generator/SKILL.md

# Commit Message Generator

Focused on: Writing individual commit messages

See also:
- `git-workflow-guide`: For overall workflow
- `pr-description-generator`: For pull requests
- `changelog-generator`: For release notes
```

---

## Summary

### Quick Checklist for Creating Skills

- [ ] Create `skills/{skill-name}/` directory
- [ ] Add `SKILL.md` with YAML frontmatter
- [ ] Include: Purpose, When to Use, Instructions
- [ ] Add practical code examples
- [ ] Provide templates/patterns
- [ ] Include best practices section
- [ ] Add troubleshooting guide
- [ ] Reference related skills
- [ ] Test with relevant commands
- [ ] Update plugin README

### Key Takeaways

1. **Skills = Knowledge Modules**: They augment commands and agents with domain expertise
2. **One Skill, One Domain**: Keep skills focused and specific
3. **Examples Required**: Always include working code examples
4. **Template Friendly**: Provide reusable patterns
5. **Related Skills**: Cross-reference complementary skills
6. **For Everyone**: Write for both humans and AI agents

---

## Additional Resources

- **Example Plugins**: See `/examples/` directory for 17 plugins with 25+ skills
- **Skills Index**: Complete list of all skills in this repository
- **Contributing**: Guidelines for contributing new skills

---

**Questions or feedback?** Open an issue on GitHub or contribute your own skills!

**Happy skill building!** 🚀
