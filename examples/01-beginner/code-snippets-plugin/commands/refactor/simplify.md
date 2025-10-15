---
description: Simplify complex code while preserving functionality
---

# Simplify Code Refactoring

Simplify complex code referenced by: $ARGUMENTS

**Process:**

1. **Analyze complexity:**
   - Identify nested conditions
   - Find complex expressions
   - Spot code smells
   - Measure cyclomatic complexity

2. **Suggest simplifications:**
   - Early returns to reduce nesting
   - Guard clauses
   - Extract complex conditions
   - Use built-in language features
   - Apply design patterns

3. **Show before/after:**
   - Original code
   - Simplified version
   - Explanation of changes
   - Benefits of each change

4. **Preserve behavior:**
   - Ensure tests still pass
   - Maintain edge case handling
   - Keep performance characteristics

**Example simplifications:**

**1. Reduce nesting with early returns:**

Before:
```typescript
function processUser(user: User): string {
  if (user) {
    if (user.isActive) {
      if (user.email) {
        return `Active user: ${user.email}`;
      } else {
        return 'No email';
      }
    } else {
      return 'Inactive user';
    }
  } else {
    return 'No user';
  }
}
```

After:
```typescript
function processUser(user: User): string {
  if (!user) return 'No user';
  if (!user.isActive) return 'Inactive user';
  if (!user.email) return 'No email';

  return `Active user: ${user.email}`;
}
```

**2. Extract complex conditions:**

Before:
```typescript
if (user.age >= 18 && user.age <= 65 && user.hasLicense && !user.isSuspended) {
  allowDriving();
}
```

After:
```typescript
const isEligibleDriver = (user: User): boolean => {
  const isAdult = user.age >= 18 && user.age <= 65;
  const hasValidLicense = user.hasLicense && !user.isSuspended;
  return isAdult && hasValidLicense;
};

if (isEligibleDriver(user)) {
  allowDriving();
}
```

**3. Use language features:**

Before:
```typescript
let result = [];
for (let i = 0; i < items.length; i++) {
  if (items[i].active) {
    result.push(items[i].name);
  }
}
```

After:
```typescript
const result = items
  .filter(item => item.active)
  .map(item => item.name);
```

Show complexity metrics before/after when helpful.
