# Skills Index - Complete Catalog

**Total Skills**: 17 skills across 11 plugins
**Coverage**: Beginner → Advanced → Production-Ready

This index catalogs all skills included in the Claude Code Plugin Examples repository. Skills are modular knowledge modules that enhance Claude's capabilities in specific domains.

---

## 📚 Table of Contents

- [Beginner Skills (6)](#beginner-skills)
- [Intermediate Skills (4)](#intermediate-skills)
- [Advanced Skills (2)](#advanced-skills)
- [Real-World Skills (5)](#real-world-skills)
- [Skills by Category](#skills-by-category)
- [Quick Reference](#quick-reference)

---

## Beginner Skills

### 🎉 Hello Plugin

#### Greeting Generator
**Path**: `examples/01-beginner/hello-plugin/skills/greeting-generator/`
**Description**: Generate personalized, context-aware greetings for developers at different times of day and moods

**Key Features**:
- Time-based greetings (morning, afternoon, evening, night)
- Programming jokes and fun facts
- Developer quotes
- Mood-appropriate messaging

**Use Cases**:
- Starting coding sessions
- Creating welcome messages
- Setting positive tone for collaboration

---

#### Motivation Generator
**Path**: `examples/01-beginner/hello-plugin/skills/motivation-generator/`
**Description**: Provide inspiring coding wisdom, productivity tips, and encouragement to keep developers motivated and focused

**Key Features**:
- Context-aware motivation (frustrated, tired, celebrating)
- Developer quotes from industry leaders
- Productivity techniques (Pomodoro, breaks)
- Problem-solving encouragement

**Use Cases**:
- Overcoming coding challenges
- Maintaining focus during long sessions
- Celebrating achievements
- Learning new technologies

---

### 📦 Code Snippets Plugin

#### Snippet Generator
**Path**: `examples/01-beginner/code-snippets-plugin/skills/snippet-generator/`
**Description**: Generate reusable, customizable code snippets for common programming patterns and boilerplate code across multiple languages

**Key Features**:
- Multi-language support (JS/TS, Python, Go, Rust, Java)
- Design patterns (Factory, Observer, Singleton)
- Framework-specific snippets (React, Express, FastAPI)
- Best practices baked in

**Use Cases**:
- Rapid prototyping
- Consistent code patterns
- Teaching programming concepts
- Reducing boilerplate

**Supported Languages**: JavaScript, TypeScript, Python, Go, Rust, Java

---

#### Code Template Library
**Path**: `examples/01-beginner/code-snippets-plugin/skills/code-template-library/`
**Description**: Maintain and organize a curated library of code templates, boilerplate, and scaffolds for rapid project initialization

**Key Features**:
- Complete project scaffolds (React, Express, FastAPI)
- File templates (components, controllers, models)
- Configuration templates (package.json, tsconfig, .gitignore)
- Architecture patterns

**Use Cases**:
- Starting new projects
- Adding features to existing projects
- Standardizing team conventions
- Learning project structure

**Templates Included**:
- React + TypeScript + Vite
- Express + TypeScript
- Python FastAPI
- Component templates
- Configuration files

---

### 🔀 Git Helper Plugin

#### Commit Message Generator
**Path**: `examples/01-beginner/git-helper-plugin/skills/commit-message-generator/`
**Description**: Generate clear, conventional, and meaningful commit messages following best practices and conventional commit standards

**Key Features**:
- Conventional Commits format
- Type classification (feat, fix, docs, etc.)
- Scope identification
- Body and footer sections
- Breaking change handling

**Use Cases**:
- Writing standardized commit messages
- Generating changelogs
- Semantic versioning
- Team consistency

**Commit Types**: feat, fix, docs, style, refactor, perf, test, build, ci, chore

---

#### Git Workflow Guide
**Path**: `examples/01-beginner/git-helper-plugin/skills/git-workflow-guide/`
**Description**: Provide guidance on git workflows, branching strategies, and best practices for individual and team development

**Key Features**:
- Multiple workflow strategies (GitHub Flow, Git Flow, Trunk-Based)
- Branch naming conventions
- Merge vs rebase guidance
- Conflict resolution
- Team collaboration patterns

**Use Cases**:
- Setting up team workflows
- Choosing branching strategy
- Resolving merge conflicts
- Onboarding new team members

**Workflows Covered**:
- GitHub Flow (recommended for most)
- Git Flow (scheduled releases)
- Trunk-Based Development (high-velocity teams)

---

## Intermediate Skills

### 🧪 Testing Plugin

#### Test Pattern Library
**Path**: `examples/02-intermediate/testing-plugin/skills/test-pattern-library/`
**Description**: Comprehensive library of testing patterns, best practices, and templates for unit, integration, and end-to-end tests across frameworks

**Key Features**:
- AAA pattern (Arrange, Act, Assert)
- Unit, integration, and E2E patterns
- Mocking and stubbing strategies
- Framework-specific examples (Jest, pytest, Go testing)
- React Testing Library patterns

**Use Cases**:
- Writing comprehensive tests
- Improving test quality
- Reducing test maintenance
- Teaching testing best practices

**Frameworks Covered**: Jest, Vitest, pytest, Go testing, React Testing Library

**Test Types**:
- Unit tests (functions, classes)
- Integration tests (APIs, databases)
- Component tests (React)
- Async testing
- Mock patterns

---

#### Assertion Helper
**Path**: `examples/02-intermediate/testing-plugin/skills/assertion-helper/`
**Description**: Guide for writing effective test assertions with clear, meaningful error messages across different testing frameworks

**Key Features**:
- Framework-specific assertion patterns
- Type-appropriate assertions
- Custom matcher creation
- Error message best practices
- Edge case testing

**Use Cases**:
- Writing clear assertions
- Debugging failing tests
- Creating custom matchers
- Improving test readability

**Assertion Categories**:
- Equality (toBe, toEqual)
- Type checks (toBeNull, toBeDefined)
- Numbers (toBeGreaterThan, toBeCloseTo)
- Strings (toContain, toMatch)
- Arrays/Objects (toHaveLength, toHaveProperty)
- Functions (toHaveBeenCalled, toThrow)
- Async (resolves, rejects)

---

### 📊 Productivity Plugin

#### Focus Techniques
**Path**: `examples/02-intermediate/productivity-plugin/skills/focus-techniques/`
**Description**: Science-backed techniques for maintaining deep focus, managing distractions, and maximizing productive coding sessions

**Key Features**:
- Pomodoro Technique (25/5 work/break)
- Time Blocking strategies
- Deep Work sessions (2-4 hour blocks)
- Flow state optimization
- Distraction management

**Use Cases**:
- Complex problem solving
- Learning new technologies
- Long coding sessions
- Maintaining consistent productivity

**Techniques Covered**:
- Pomodoro Technique
- Time Blocking
- Deep Work Sessions
- Two-Minute Rule
- Batch Processing
- Flow State Optimization

---

#### Time Management
**Path**: `examples/02-intermediate/productivity-plugin/skills/time-management/`
**Description**: Strategies for effective time management, prioritization, and sustainable productivity for software developers

**Key Features**:
- Eisenhower Matrix (Urgent/Important)
- MoSCoW prioritization (Must/Should/Could/Won't)
- Value vs Effort matrix
- Realistic estimation techniques
- Calendar optimization

**Use Cases**:
- Sprint planning
- Daily/weekly planning
- Managing multiple projects
- Preventing burnout
- Meeting optimization

**Frameworks**:
- Eisenhower Matrix
- MoSCoW Method
- Value vs Effort Matrix
- Three-Point Estimation
- Time Blocking

---

## Advanced Skills

### 🚀 DevOps Plugin

#### Deployment Strategies
**Path**: `examples/03-advanced/devops-plugin/skills/deployment-strategies/`
**Description**: Comprehensive guide to modern deployment strategies including blue-green, canary, rolling updates, and zero-downtime deployments

**Key Features**:
- Blue-Green deployment
- Canary releases (progressive rollout)
- Rolling updates
- Feature flags / Dark launches
- A/B testing
- Zero-downtime patterns

**Use Cases**:
- Production deployments
- Risk mitigation
- Progressive delivery
- Testing in production
- Quick rollbacks

**Strategies Covered**:
1. Blue-Green Deployment
2. Canary Deployment
3. Rolling Updates
4. Feature Flags
5. A/B Testing

**Infrastructure**: Kubernetes, AWS ELB, Load Balancers

---

#### Incident Response
**Path**: `examples/03-advanced/devops-plugin/skills/incident-response/`
**Description**: Structured approach to handling production incidents, from detection through resolution and post-mortem analysis

**Key Features**:
- Incident severity levels (SEV 1-4)
- Response process (Detection → Resolution)
- Communication templates
- Mitigation strategies
- Post-mortem templates
- Blameless culture

**Use Cases**:
- Production outages
- Performance degradation
- Security incidents
- Post-mortem analysis
- Incident prevention

**Process Phases**:
1. Detection (0-5 min)
2. Response (5-10 min)
3. Investigation (10-30 min)
4. Mitigation (30-60 min)
5. Communication (ongoing)
6. Resolution
7. Post-Mortem

---

## Real-World Skills

### 🌐 Web Scraping Plugin

#### Scraping Best Practices
**Path**: `examples/04-real-world/web-scraping-plugin/skills/scraping-best-practices/`
**Description**: Ethical and effective web scraping techniques, anti-bot evasion, legal compliance, and data extraction strategies

**Key Features**:
- Legal and ethical compliance (robots.txt, ToS)
- Rate limiting and politeness
- Anti-bot detection evasion
- Data extraction strategies (CSS, XPath, regex)
- Pagination handling
- Authentication flows

**Use Cases**:
- Competitive intelligence
- Lead generation
- Content aggregation
- Price monitoring
- Data collection

**Topics Covered**:
- robots.txt compliance
- User-Agent rotation
- Proxy management
- JavaScript rendering
- CAPTCHA handling
- Data validation

---

### 🛡️ Security Audit Plugin

#### Vulnerability Detection
**Path**: `examples/04-real-world/security-audit-plugin/skills/vulnerability-detection/`
**Description**: Systematic approach to identifying security vulnerabilities in code, dependencies, and infrastructure

**Key Features**:
- OWASP Top 10 coverage
- Dependency vulnerability scanning
- Static code analysis
- Security misconfiguration detection
- Vulnerability reporting with CVSS

**Use Cases**:
- Security audits
- Code reviews
- Dependency updates
- Compliance verification
- Penetration testing prep

**Vulnerabilities Covered**:
- SQL Injection
- Cross-Site Scripting (XSS)
- Cross-Site Request Forgery (CSRF)
- Broken Access Control
- Security Misconfiguration
- Vulnerable Dependencies
- Cryptographic Failures
- SSRF, XXE, Deserialization

**Tools**: npm audit, Snyk, semgrep, bandit, gitleaks

---

### 💾 Database Plugin

#### Query Optimization
**Path**: `examples/04-real-world/database-plugin/skills/query-optimization/`
**Description**: Techniques for optimizing database queries, indexing strategies, and performance tuning for SQL databases

**Key Features**:
- Reading EXPLAIN plans
- Index strategies (simple, composite, partial, covering)
- Query rewriting techniques
- N+1 query problem detection
- Caching strategies
- Connection pooling

**Use Cases**:
- Slow query optimization
- Database performance tuning
- Capacity planning
- Schema design
- Production optimization

**Techniques**:
- EXPLAIN/EXPLAIN ANALYZE
- Index creation and optimization
- Query rewriting
- N+1 problem solutions
- Caching (query cache, Redis)
- Batch operations

**Databases**: PostgreSQL, MySQL, SQL Server

---

### 🔍 PR Reviewer Plugin

#### Code Review Checklist
**Path**: `examples/04-real-world/pr-reviewer-plugin/skills/code-review-checklist/`
**Description**: Comprehensive checklist and best practices for effective code reviews that catch bugs and improve code quality

**Key Features**:
- Functionality review checklist
- Security review (input validation, auth, secrets)
- Performance review (N+1, algorithms, memory)
- Testing review (coverage, quality, edge cases)
- Code readability (naming, complexity, documentation)
- Architecture and design patterns

**Use Cases**:
- Pull request reviews
- Code quality improvement
- Team standards enforcement
- Mentoring junior developers
- Catching bugs before production

**Review Categories**:
1. Functionality & Logic
2. Security
3. Performance
4. Testing
5. Readability
6. Architecture & Design
7. Error Handling
8. Documentation

---

### 🧪 API Testing Plugin

#### API Test Design
**Path**: `examples/04-real-world/api-testing-plugin/skills/api-test-design/`
**Description**: Strategies for designing comprehensive API tests including contract testing, integration testing, and performance testing

**Key Features**:
- Testing pyramid for APIs
- Contract testing (Pact)
- Authentication testing
- Error handling tests
- Pagination and filtering
- Performance testing (load, stress)
- Test data management

**Use Cases**:
- API development
- Integration testing
- Contract verification
- Performance testing
- Quality assurance

**Test Types**:
- Unit tests (endpoint logic)
- Integration tests (service interaction)
- Contract tests (API contracts)
- E2E tests (complete workflows)
- Performance tests (load, stress, spike)

**Tools**: Jest, pytest, Supertest, Pact, k6

---

## Skills by Category

### 🎯 Developer Productivity

| Skill | Plugin | Focus |
|-------|--------|-------|
| Greeting Generator | hello-plugin | Engagement |
| Motivation Generator | hello-plugin | Encouragement |
| Focus Techniques | productivity-plugin | Concentration |
| Time Management | productivity-plugin | Planning |

### 💻 Code Quality

| Skill | Plugin | Focus |
|-------|--------|-------|
| Snippet Generator | code-snippets-plugin | Code generation |
| Code Template Library | code-snippets-plugin | Project scaffolding |
| Code Review Checklist | pr-reviewer-plugin | Review quality |

### 🔄 Version Control

| Skill | Plugin | Focus |
|-------|--------|-------|
| Commit Message Generator | git-helper-plugin | Commit quality |
| Git Workflow Guide | git-helper-plugin | Team workflows |

### ✅ Testing

| Skill | Plugin | Focus |
|-------|--------|-------|
| Test Pattern Library | testing-plugin | Test patterns |
| Assertion Helper | testing-plugin | Assertions |
| API Test Design | api-testing-plugin | API testing |

### 🚀 DevOps & Production

| Skill | Plugin | Focus |
|-------|--------|-------|
| Deployment Strategies | devops-plugin | Deployments |
| Incident Response | devops-plugin | Incidents |

### 🛡️ Security

| Skill | Plugin | Focus |
|-------|--------|-------|
| Vulnerability Detection | security-audit-plugin | Security |

### 💾 Data

| Skill | Plugin | Focus |
|-------|--------|-------|
| Query Optimization | database-plugin | Performance |
| Scraping Best Practices | web-scraping-plugin | Data extraction |

---

## Quick Reference

### By Complexity

**Beginner** (6 skills):
- Greeting Generator
- Motivation Generator
- Snippet Generator
- Code Template Library
- Commit Message Generator
- Git Workflow Guide

**Intermediate** (4 skills):
- Test Pattern Library
- Assertion Helper
- Focus Techniques
- Time Management

**Advanced** (2 skills):
- Deployment Strategies
- Incident Response

**Real-World** (5 skills):
- Scraping Best Practices
- Vulnerability Detection
- Query Optimization
- Code Review Checklist
- API Test Design

### By Use Frequency

**Daily Use**:
- Commit Message Generator
- Code Review Checklist
- Test Pattern Library
- Focus Techniques
- Time Management

**Weekly Use**:
- Snippet Generator
- Git Workflow Guide
- Query Optimization
- API Test Design
- Assertion Helper

**Periodic Use**:
- Deployment Strategies
- Incident Response
- Vulnerability Detection
- Code Template Library

**As Needed**:
- Greeting Generator
- Motivation Generator
- Scraping Best Practices

### By Team Size

**Solo Developer**:
- Focus Techniques
- Time Management
- Commit Message Generator
- Snippet Generator

**Small Team (2-5)**:
- Git Workflow Guide
- Code Review Checklist
- Test Pattern Library
- Deployment Strategies

**Medium Team (6-20)**:
- All testing skills
- Incident Response
- Vulnerability Detection
- API Test Design

**Large Team (20+)**:
- All DevOps skills
- All security skills
- Code Template Library (standardization)

---

## Statistics

```
Total Skills:        17
Total Plugins:       11
Average per Plugin:  1.5 skills
Largest Skill:       871 lines (API Test Design)
Smallest Skill:      594 lines (Scraping Best Practices)
Total Lines:         12,000+ lines of expertise
```

---

## Usage in Commands and Agents

Skills are automatically loaded when:
1. **Commands invoke them**: `/commit` loads `commit-message-generator`
2. **Agents reference them**: `test-debugger` uses `test-pattern-library`
3. **Context matches**: Questions about git load `git-workflow-guide`
4. **User requests**: Asking about testing loads testing skills

---

## Contributing New Skills

Want to add a skill? See [SKILLS_GUIDE.md](SKILLS_GUIDE.md) for:
- How to create skills
- Skill file format
- Best practices
- Examples

**Quick Steps**:
1. Create `skills/{skill-name}/` directory
2. Add `SKILL.md` with YAML frontmatter
3. Include examples and best practices
4. Reference related skills
5. Update this index

---

## Related Documentation

- **[SKILLS_GUIDE.md](SKILLS_GUIDE.md)**: Comprehensive guide to creating and using skills
- **[README.md](README.md)**: Main repository documentation
- **[EXAMPLES_SUMMARY.md](EXAMPLES_SUMMARY.md)**: All plugin examples

---

**Last Updated**: 2025-01-21
**Skills Version**: 1.0.0
**Repository**: [claude-code-plugin-examples](https://github.com/YOUR_USERNAME/claude-code-plugin-examples)

---

**🎉 Start using skills today!** Each plugin's README contains specific skill documentation and usage examples.
