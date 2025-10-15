---
description: Generate test template for a function or class
---

# Test Snippet Generator

Generate a comprehensive test template for the code/function: $ARGUMENTS

**Process:**
1. If user provides @filename, read that file to understand what to test
2. Detect the testing framework used in the project:
   - JavaScript/TypeScript: Jest, Vitest, Mocha
   - Python: pytest, unittest
   - Go: testing package
   - Java: JUnit

3. Generate tests including:
   - Happy path scenarios
   - Edge cases
   - Error conditions
   - Boundary values
   - Mock/stub examples if needed

**Example usages:**
- `/snippets/test @src/utils/calculateTotal.ts`
- `/snippets/test UserAuthentication class`
- `/snippets/test processPayment function`

**Template example (Jest/TypeScript):**
```typescript
import { describe, it, expect, beforeEach, afterEach } from '@jest/globals';
import { functionName } from './module';

describe('functionName', () => {
  beforeEach(() => {
    // Setup before each test
  });

  afterEach(() => {
    // Cleanup after each test
  });

  describe('Happy Path', () => {
    it('should return expected result with valid input', () => {
      // Arrange
      const input = 'test';
      const expected = 'result';

      // Act
      const result = functionName(input);

      // Assert
      expect(result).toBe(expected);
    });

    it('should handle multiple valid scenarios', () => {
      const testCases = [
        { input: 'case1', expected: 'result1' },
        { input: 'case2', expected: 'result2' },
      ];

      testCases.forEach(({ input, expected }) => {
        expect(functionName(input)).toBe(expected);
      });
    });
  });

  describe('Edge Cases', () => {
    it('should handle empty input', () => {
      expect(functionName('')).toBe('');
    });

    it('should handle null/undefined', () => {
      expect(() => functionName(null)).toThrow();
      expect(() => functionName(undefined)).toThrow();
    });

    it('should handle very large input', () => {
      const largeInput = 'x'.repeat(10000);
      expect(functionName(largeInput)).toBeDefined();
    });
  });

  describe('Error Handling', () => {
    it('should throw error for invalid input', () => {
      expect(() => functionName('invalid')).toThrow('Expected error message');
    });

    it('should handle errors gracefully', () => {
      // Test error recovery
    });
  });

  describe('Boundary Values', () => {
    it('should handle minimum value', () => {
      expect(functionName(0)).toBeDefined();
    });

    it('should handle maximum value', () => {
      expect(functionName(Number.MAX_SAFE_INTEGER)).toBeDefined();
    });
  });
});
```

Adapt to the project's testing framework and style.
