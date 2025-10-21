---
name: Git Workflow Guide
description: Provide guidance on git workflows, branching strategies, and best practices for individual and team development
---

# Git Workflow Guide

## Purpose

Provide comprehensive guidance on:
- Git branching strategies
- Collaboration workflows
- Merge vs rebase decisions
- Conflict resolution
- Git best practices

## When to Use

Invoke this skill when:
- Setting up a new project's git workflow
- User asks about branching strategy
- Resolving merge conflicts
- Deciding between merge, rebase, or squash
- Onboarding team members to git practices
- Troubleshooting git issues

## Instructions

### Step 1: Understand the Context

Determine:
1. **Team size**: Solo, small team (2-5), medium (6-20), large (20+)
2. **Release cadence**: Continuous, weekly, monthly, versioned
3. **Collaboration style**: Individual, pair programming, code review
4. **Project maturity**: New, active development, maintenance mode

### Step 2: Recommend Workflow

Choose appropriate workflow based on context:

#### For Solo Developers
- **Simple trunk-based**: Main branch + feature branches
- Minimal overhead
- Quick iterations

#### For Small Teams (2-5)
- **GitHub Flow**: Main + feature branches
- Pull requests for review
- Deploy from main

#### For Medium Teams (6-20)
- **Git Flow**: Main, develop, feature, release, hotfix branches
- Structured release process
- Clear separation of concerns

#### For Large Teams/Complex Projects
- **Trunk-Based Development**: Short-lived feature branches
- Feature flags for incomplete features
- Continuous integration focus

### Step 3: Provide Specific Guidance

Based on the user's question, provide detailed guidance on:
- Branch naming conventions
- Commit strategies
- Merge/rebase best practices
- Code review process
- Release management

## Branching Strategies

### GitHub Flow (Recommended for Most)

**Branches:**
- `main`: Always deployable, production code
- `feature/*`: Short-lived feature branches

**Workflow:**
```bash
# 1. Create feature branch from main
git checkout main
git pull origin main
git checkout -b feature/user-authentication

# 2. Make changes and commit
git add .
git commit -m "feat(auth): add login functionality"

# 3. Push and create pull request
git push -u origin feature/user-authentication

# 4. After review, merge to main
# (Usually done via PR interface)

# 5. Delete feature branch
git branch -d feature/user-authentication
```

**Best for:**
- Continuous deployment
- Small to medium teams
- Web applications
- Projects with simple release cycles

---

### Git Flow (Detailed Release Process)

**Branches:**
- `main`: Production-ready code
- `develop`: Integration branch for features
- `feature/*`: New features
- `release/*`: Release preparation
- `hotfix/*`: Emergency fixes

**Workflow:**
```bash
# Feature development
git checkout develop
git checkout -b feature/shopping-cart
# ... make changes ...
git checkout develop
git merge --no-ff feature/shopping-cart

# Release preparation
git checkout -b release/1.2.0 develop
# ... version bumps, final testing ...
git checkout main
git merge --no-ff release/1.2.0
git tag -a v1.2.0
git checkout develop
git merge --no-ff release/1.2.0

# Hotfix
git checkout -b hotfix/1.2.1 main
# ... fix critical bug ...
git checkout main
git merge --no-ff hotfix/1.2.1
git tag -a v1.2.1
git checkout develop
git merge --no-ff hotfix/1.2.1
```

**Best for:**
- Scheduled releases
- Multiple versions in production
- Complex projects with strict release processes
- Enterprise applications

---

### Trunk-Based Development (High-Velocity Teams)

**Branches:**
- `main`: The trunk, always deployable
- `feature/*`: Very short-lived (< 2 days)

**Workflow:**
```bash
# Create short-lived branch
git checkout -b feature/quick-fix

# Small, frequent commits
git commit -m "feat: add validation"
git commit -m "test: add validation tests"

# Merge quickly (same day or next)
git checkout main
git pull --rebase origin main
git merge feature/quick-fix
git push origin main
```

**Key practices:**
- Feature flags for incomplete features
- Frequent integration (multiple times per day)
- Strong CI/CD pipeline
- Comprehensive automated testing

**Best for:**
- High-performing teams
- Continuous deployment
- Large projects with many contributors
- Microservices architectures

## Branch Naming Conventions

### Feature Branches
```
feature/user-authentication
feature/add-shopping-cart
feature/implement-search
feat/user-profile-page
```

### Bug Fixes
```
fix/login-timeout
fix/memory-leak-in-parser
bugfix/null-pointer-exception
```

### Hotfixes
```
hotfix/security-patch
hotfix/critical-data-loss
```

### Release Branches
```
release/1.2.0
release/2024-03-15
release/sprint-42
```

### Chore/Maintenance
```
chore/upgrade-dependencies
chore/update-documentation
refactor/extract-validation-logic
```

## Merge vs Rebase Decision Guide

### Use Merge When:
✅ Merging feature branch into main/develop
✅ Preserving complete history is important
✅ Working on public/shared branches
✅ Multiple people worked on the branch

```bash
git checkout main
git merge --no-ff feature/user-auth
```

**Pros**: Preserves history, safe, easy to understand
**Cons**: Creates merge commits, more complex history

---

### Use Rebase When:
✅ Updating feature branch with latest main
✅ Cleaning up local commits before PR
✅ Want linear history
✅ Working on personal branch

```bash
git checkout feature/user-auth
git rebase main
```

**Pros**: Clean linear history, no merge commits
**Cons**: Rewrites history, can be dangerous on shared branches

---

### Use Squash Merge When:
✅ Merging PR with many small commits
✅ Want one commit per feature
✅ Cleanup experimental commits

```bash
git merge --squash feature/user-auth
git commit -m "feat(auth): add complete user authentication"
```

**Pros**: Clean main history, one commit per feature
**Cons**: Loses granular history

## Golden Rules

### DO:
✅ Commit early and often (on feature branches)
✅ Write meaningful commit messages
✅ Pull before you push
✅ Keep commits atomic (one logical change)
✅ Test before committing
✅ Use branches for all changes
✅ Delete merged branches

### DON'T:
❌ Commit directly to main/develop
❌ Force push to shared branches
❌ Commit large binary files
❌ Mix multiple concerns in one commit
❌ Commit broken code
❌ Rewrite public history
❌ Ignore merge conflicts

## Common Workflows

### Daily Development Workflow

```bash
# Morning: Start fresh
git checkout main
git pull origin main
git checkout -b feature/new-feature

# During day: Commit frequently
git add src/component.ts
git commit -m "feat: add user component"
git add tests/component.test.ts
git commit -m "test: add component tests"

# End of day: Push work
git push -u origin feature/new-feature

# Next day: Update with latest main
git checkout main
git pull origin main
git checkout feature/new-feature
git rebase main  # or merge main

# When done: Create PR
# (via GitHub/GitLab interface)

# After merge: Cleanup
git checkout main
git pull origin main
git branch -d feature/new-feature
```

### Conflict Resolution Workflow

```bash
# When merge conflict occurs
git merge feature/other-feature
# CONFLICT (content): Merge conflict in src/app.ts

# Option 1: Use merge tool
git mergetool

# Option 2: Edit manually
# Edit src/app.ts, resolve conflicts
git add src/app.ts
git commit -m "merge: resolve conflicts from feature/other-feature"

# Option 3: Abort and try differently
git merge --abort
git rebase feature/other-feature  # Try rebase instead
```

### Hotfix Workflow

```bash
# Emergency fix needed in production
git checkout main
git checkout -b hotfix/critical-security-fix

# Make minimal fix
git add security/auth.ts
git commit -m "fix(security): patch XSS vulnerability"

# Test thoroughly
npm test

# Merge to main
git checkout main
git merge --no-ff hotfix/critical-security-fix
git tag -a v1.2.1 -m "Security hotfix"
git push origin main --tags

# Also merge to develop
git checkout develop
git merge --no-ff hotfix/critical-security-fix
git push origin develop

# Deploy immediately
git branch -d hotfix/critical-security-fix
```

## Best Practices by Team Size

### Solo Developer
- Keep it simple: main + feature branches
- Commit often, push less frequently
- Use tags for releases
- Consider squash merging for cleaner history

### Small Team (2-5)
- GitHub Flow
- Required pull request reviews (at least 1)
- CI checks must pass
- Delete branches after merge
- Regular sync meetings

### Medium Team (6-20)
- Git Flow or GitHub Flow
- Code owners for critical paths
- Automated testing required
- Branch protection rules
- Release branches for scheduled releases

### Large Team (20+)
- Trunk-based development
- Feature flags
- Strong CI/CD
- Automated code review (linters, etc.)
- Clear contribution guidelines

## Troubleshooting Guide

### "I committed to the wrong branch"
```bash
# Move last commit to new branch
git branch feature/correct-branch
git reset HEAD~ --hard
git checkout feature/correct-branch
```

### "I need to undo my last commit"
```bash
# Keep changes, undo commit
git reset HEAD~

# Discard changes too
git reset HEAD~ --hard
```

### "I need to change my last commit message"
```bash
git commit --amend -m "New commit message"
```

### "I want to add more changes to last commit"
```bash
git add forgotten-file.ts
git commit --amend --no-edit
```

### "My branch is behind main"
```bash
git checkout feature/my-branch
git merge main
# or
git rebase main
```

### "I have merge conflicts"
```bash
# See conflicted files
git status

# Edit conflicts in files
# Look for <<<<<<, ======, >>>>>>

# Mark as resolved
git add resolved-file.ts
git commit
```

## Output Format for Recommendations

When providing workflow guidance:

```
## Recommended Workflow: [Name]

**Best for your situation because:**
- [Reason 1]
- [Reason 2]

**Branch structure:**
- [Branch type]: [Purpose]

**Step-by-step:**
1. [Step]
2. [Step]

**Key commands:**
```bash
[Command examples]
```

**Tips:**
- [Tip 1]
- [Tip 2]
```

## Related Skills

- `commit-message-generator`: For writing better commits
- `pr-description-generator`: For pull requests
- `conflict-resolver`: For handling merge conflicts
- `git-history-cleaner`: For cleaning up history before PR
