---
description: Extract code into a reusable function or component
---

# Extract Code Refactoring

Help the user extract code into a reusable function or component.

**What to extract:** $ARGUMENTS (or ask user to select code)

**Process:**

1. **Analyze the code:**
   - Identify code duplication or complex logic
   - Determine what should be extracted
   - Find parameters needed
   - Identify return values

2. **Suggest extraction:**
   - Propose a meaningful name
   - List parameters with types
   - Show return type
   - Explain the benefits

3. **Create the extracted function:**
   - Proper documentation
   - Type safety
   - Error handling
   - Tests

4. **Update call sites:**
   - Replace original code with function calls
   - Ensure behavior is preserved
   - Update tests if needed

**Example:**

**Before:**
```typescript
// In multiple places:
const total = items.reduce((sum, item) => {
  return sum + (item.price * item.quantity);
}, 0);
const tax = total * 0.08;
const finalTotal = total + tax;
```

**After extraction:**
```typescript
/**
 * Calculate total price including tax
 * @param items - Array of items with price and quantity
 * @returns Total price with tax applied
 */
function calculateTotalWithTax(items: Item[]): number {
  const subtotal = items.reduce((sum, item) => {
    return sum + (item.price * item.quantity);
  }, 0);

  const tax = subtotal * 0.08;
  return subtotal + tax;
}

// Usage:
const finalTotal = calculateTotalWithTax(items);
```

**Benefits to explain:**
- ✅ DRY (Don't Repeat Yourself)
- ✅ Testable in isolation
- ✅ Reusable across codebase
- ✅ Easier to maintain
- ✅ Single Responsibility Principle
