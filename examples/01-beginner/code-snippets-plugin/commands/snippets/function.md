---
description: Generate a function template for specified language
---

# Function Snippet Generator

Generate a function template in the language specified: $1

**Function name:** $2 (or ask if not provided)

**Languages supported:**
- typescript/ts
- javascript/js
- python/py
- go
- rust
- java
- cpp/c++

**Template should include:**
1. Proper function syntax for the language
2. JSDoc/docstring with:
   - Description placeholder
   - Parameter documentation
   - Return type documentation
   - Example usage
3. Type annotations (for typed languages)
4. Error handling structure
5. Example implementation comments

**Example usages:**
- `/snippets/function typescript calculateTotal`
- `/snippets/function python fetch_user_data`
- `/snippets/function go ProcessOrder`

**Template examples:**

**TypeScript:**
```typescript
/**
 * [Description of what this function does]
 *
 * @param param1 - Description of param1
 * @param param2 - Description of param2
 * @returns Description of return value
 *
 * @example
 * const result = functionName(arg1, arg2);
 */
export function functionName<T>(
  param1: string,
  param2: number
): ReturnType {
  try {
    // Implementation here

    return result;
  } catch (error) {
    throw new Error(`Error in functionName: ${error}`);
  }
}
```

**Python:**
```python
def function_name(param1: str, param2: int) -> ReturnType:
    """
    [Description of what this function does]

    Args:
        param1: Description of param1
        param2: Description of param2

    Returns:
        Description of return value

    Raises:
        ValueError: When invalid parameters provided

    Example:
        >>> result = function_name("test", 42)
    """
    try:
        # Implementation here

        return result
    except Exception as e:
        raise ValueError(f"Error in function_name: {e}")
```

Adapt the template to match the project's existing code style.
