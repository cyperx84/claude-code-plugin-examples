---
description: Generate a class template for specified language
---

# Class Snippet Generator

Generate a class template in the language specified: $1

**Class name:** $2 (or ask if not provided)

**Languages supported:**
- typescript/ts
- javascript/js
- python/py
- java
- cpp/c++

**Template should include:**
1. Proper class syntax for the language
2. Constructor with parameters
3. Private/public properties
4. Getter/setter methods
5. Common methods (toString, equals, etc.)
6. Documentation comments
7. Example usage

**Example usages:**
- `/snippets/class typescript UserAccount`
- `/snippets/class python DataProcessor`
- `/snippets/class java OrderManager`

**Template examples:**

**TypeScript:**
```typescript
/**
 * [Class description]
 *
 * @example
 * const instance = new ClassName(param1, param2);
 * instance.method();
 */
export class ClassName {
  private _property1: string;
  private _property2: number;

  /**
   * Creates a new ClassName instance
   *
   * @param property1 - Description
   * @param property2 - Description
   */
  constructor(property1: string, property2: number) {
    this._property1 = property1;
    this._property2 = property2;
  }

  /**
   * Gets property1
   */
  get property1(): string {
    return this._property1;
  }

  /**
   * Sets property1
   */
  set property1(value: string) {
    this._property1 = value;
  }

  /**
   * [Method description]
   */
  public method(): void {
    // Implementation
  }

  /**
   * String representation
   */
  public toString(): string {
    return `ClassName(${this._property1}, ${this._property2})`;
  }
}
```

**Python:**
```python
class ClassName:
    """
    [Class description]

    Attributes:
        property1: Description
        property2: Description

    Example:
        >>> instance = ClassName("value", 42)
        >>> instance.method()
    """

    def __init__(self, property1: str, property2: int):
        """
        Initialize ClassName

        Args:
            property1: Description
            property2: Description
        """
        self._property1 = property1
        self._property2 = property2

    @property
    def property1(self) -> str:
        """Get property1"""
        return self._property1

    @property1.setter
    def property1(self, value: str):
        """Set property1"""
        self._property1 = value

    def method(self) -> None:
        """[Method description]"""
        # Implementation
        pass

    def __str__(self) -> str:
        """String representation"""
        return f"ClassName({self._property1}, {self._property2})"

    def __repr__(self) -> str:
        """Developer representation"""
        return f"ClassName(property1={self._property1!r}, property2={self._property2!r})"
```

Match the project's existing code style and conventions.
