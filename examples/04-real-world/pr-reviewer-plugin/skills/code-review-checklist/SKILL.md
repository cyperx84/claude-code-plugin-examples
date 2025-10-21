---
name: "Code Review Checklist"
description: "Comprehensive checklist and best practices for effective code reviews that catch bugs and improve code quality"
---

# Code Review Checklist

You are an expert code reviewer who helps teams conduct thorough, constructive, and efficient code reviews. You understand how to balance catching bugs, maintaining quality, and supporting team members.

## Code Review Philosophy

### Goals of Code Review

1. **Find Bugs**: Catch logic errors, edge cases, and potential failures
2. **Improve Quality**: Ensure code is readable, maintainable, and well-structured
3. **Share Knowledge**: Help team members learn and spread best practices
4. **Maintain Standards**: Enforce coding standards and architectural patterns
5. **Prevent Technical Debt**: Identify shortcuts that will cause future problems

### Review Mindset

**DO:**
- Ask questions rather than make demands
- Explain the "why" behind suggestions
- Praise good solutions and improvements
- Distinguish between blocking issues and suggestions
- Consider the context and constraints

**DON'T:**
- Bikeshed over trivial style preferences
- Rewrite the code yourself in comments
- Be overly pedantic about minor issues
- Make it personal
- Block on non-critical issues

## Comprehensive Review Checklist

### 1. Functionality and Logic

**Core Questions:**
```
□ Does the code do what it's supposed to do?
□ Are all requirements from the ticket/issue met?
□ Are edge cases handled?
□ Is error handling comprehensive?
□ Are there any obvious bugs or logical errors?
```

**Common Issues:**

**Off-by-One Errors:**
```python
# BAD: Off-by-one error
def get_last_n_items(items, n):
    return items[len(items) - n:]  # What if n == 0?

# Review comment:
# "Consider the edge case where n=0. This will return all items instead
# of an empty list. Suggest: return items[-n:] if n > 0 else []"

# GOOD
def get_last_n_items(items, n):
    if n <= 0:
        return []
    return items[-n:]
```

**Null/None Handling:**
```javascript
// BAD: No null check
function getUserEmail(user) {
    return user.profile.email.toLowerCase();
}

// Review comment:
// "This will throw if user, profile, or email is null/undefined.
// Suggest optional chaining: return user?.profile?.email?.toLowerCase()"

// GOOD
function getUserEmail(user) {
    return user?.profile?.email?.toLowerCase() || null;
}
```

**Boundary Conditions:**
```python
# Review checklist for loops and conditions:
# □ What happens with empty input?
# □ What happens with single item?
# □ What happens with maximum size?
# □ What happens with negative numbers?
# □ What happens with zero?
# □ What happens with None/null?

# Example review comment:
"""
Consider these test cases:
- process_items([])  # Empty list
- process_items([item])  # Single item
- process_items(None)  # None input
What's the expected behavior for each?
"""
```

### 2. Security Review

**Security Checklist:**
```
□ Is user input validated and sanitized?
□ Are SQL queries parameterized (no string concatenation)?
□ Are sensitive data (passwords, tokens) properly handled?
□ Is authentication/authorization properly checked?
□ Are file uploads validated and secured?
□ Are API rate limits implemented?
□ Is HTTPS enforced for sensitive operations?
```

**Input Validation:**
```python
# BAD: No input validation
@app.route('/api/user/<user_id>')
def get_user(user_id):
    user = db.query(f"SELECT * FROM users WHERE id = {user_id}")
    return jsonify(user)

# Review comment:
"""
SECURITY ISSUE - SQL Injection vulnerability:
1. user_id is not validated (could be malicious)
2. String interpolation instead of parameterized query
3. Missing authentication check

Suggest:
- Validate user_id is a valid integer
- Use parameterized queries
- Add @require_auth decorator
- Add authorization check (can user access this user_id?)
"""

# GOOD
@app.route('/api/user/<int:user_id>')
@require_auth
def get_user(user_id):
    # Check authorization
    if current_user.id != user_id and not current_user.is_admin:
        abort(403)

    # Parameterized query
    user = db.query("SELECT * FROM users WHERE id = %s", (user_id,))
    return jsonify(user)
```

**Sensitive Data:**
```javascript
// BAD: Logging sensitive data
console.log('Login attempt:', { username, password });

// Review comment:
// "SECURITY: Don't log passwords. Remove password from log or redact it."

// GOOD
console.log('Login attempt:', {
    username,
    password: '[REDACTED]'
});
```

### 3. Performance Review

**Performance Checklist:**
```
□ Are there any N+1 query problems?
□ Are expensive operations cached?
□ Are large datasets paginated?
□ Are database queries optimized?
□ Are unnecessary computations avoided?
□ Is lazy loading used appropriately?
□ Are there memory leaks?
```

**N+1 Query Detection:**
```python
# BAD: N+1 queries
def get_user_orders(user_ids):
    users = User.objects.filter(id__in=user_ids)
    result = []
    for user in users:
        result.append({
            'user': user.name,
            'orders': user.orders.all()  # N additional queries!
        })
    return result

# Review comment:
"""
PERFORMANCE: N+1 query problem detected.
For 100 users, this executes 101 queries (1 for users + 100 for orders).

Suggest using prefetch_related:
users = User.objects.filter(id__in=user_ids).prefetch_related('orders')

This will execute only 2 queries total.
"""

# GOOD
def get_user_orders(user_ids):
    users = User.objects.filter(
        id__in=user_ids
    ).prefetch_related('orders')

    return [
        {
            'user': user.name,
            'orders': list(user.orders.all())
        }
        for user in users
    ]
```

**Inefficient Algorithms:**
```javascript
// BAD: O(n²) complexity
function findDuplicates(arr) {
    const duplicates = [];
    for (let i = 0; i < arr.length; i++) {
        for (let j = i + 1; j < arr.length; j++) {
            if (arr[i] === arr[j] && !duplicates.includes(arr[i])) {
                duplicates.push(arr[i]);
            }
        }
    }
    return duplicates;
}

// Review comment:
"""
PERFORMANCE: O(n²) algorithm with nested loops.
For large arrays, this will be slow.

Suggest O(n) solution using Set:
const seen = new Set();
const duplicates = new Set();
arr.forEach(item => {
    if (seen.has(item)) duplicates.add(item);
    seen.add(item);
});
return Array.from(duplicates);
"""
```

### 4. Testing Review

**Testing Checklist:**
```
□ Are there tests for new functionality?
□ Do tests cover edge cases?
□ Are error paths tested?
□ Are tests clear and maintainable?
□ Do tests actually test the right thing?
□ Is test coverage adequate (not just high percentage)?
□ Are integration tests needed?
```

**Test Quality:**
```python
# BAD: Test doesn't actually test anything useful
def test_user_creation():
    user = create_user("test@example.com")
    assert user is not None

# Review comment:
"""
This test is too weak. It only checks that create_user returns something,
not that it works correctly.

Suggest testing:
1. User is actually in database
2. Email is stored correctly
3. Password is hashed (not plain text)
4. Duplicate email raises error
5. Invalid email format raises error
"""

# GOOD
def test_user_creation():
    email = "test@example.com"
    password = "secure_password"

    # Create user
    user = create_user(email, password)

    # Verify user exists in database
    db_user = User.query.filter_by(email=email).first()
    assert db_user is not None
    assert db_user.email == email

    # Verify password is hashed, not stored as plaintext
    assert db_user.password != password
    assert verify_password(password, db_user.password)

def test_user_creation_duplicate_email():
    email = "test@example.com"
    create_user(email, "password1")

    # Should raise error on duplicate
    with pytest.raises(DuplicateEmailError):
        create_user(email, "password2")
```

**Missing Test Cases:**
```javascript
// Code under review
function divideNumbers(a, b) {
    return a / b;
}

// Test submitted
test('divides two numbers', () => {
    expect(divideNumbers(10, 2)).toBe(5);
});

// Review comment:
"""
Test coverage is incomplete. Consider these cases:

Missing test cases:
□ Division by zero - divideNumbers(10, 0)
□ Negative numbers - divideNumbers(-10, 2)
□ Decimal results - divideNumbers(10, 3)
□ Invalid inputs - divideNumbers('10', '2')
□ Large numbers - divideNumbers(Number.MAX_VALUE, 2)

At minimum, add test for division by zero since this is
a common error condition.
"""
```

### 5. Code Readability

**Readability Checklist:**
```
□ Is the code self-documenting with clear names?
□ Are functions/methods single-purpose?
□ Is complexity kept low (low cyclomatic complexity)?
□ Are magic numbers replaced with named constants?
□ Is nesting depth reasonable (<3-4 levels)?
□ Are comments used for "why" not "what"?
□ Is the code consistent with existing codebase style?
```

**Naming:**
```python
# BAD: Unclear names
def calc(x, y, z):
    if z == 1:
        return x + y
    else:
        return x * y

# Review comment:
"""
Variable names are unclear. What do x, y, z represent?

Suggest:
def calculate_price(base_price, quantity, is_subscription):
    if is_subscription:
        return base_price + quantity  # Monthly total
    else:
        return base_price * quantity  # One-time purchase
"""

# GOOD
def calculate_price(base_price, quantity, is_subscription):
    """Calculate total price based on subscription status."""
    if is_subscription:
        return base_price + quantity
    else:
        return base_price * quantity
```

**Function Length:**
```javascript
// BAD: Function doing too much
async function processOrder(orderId) {
    // 1. Validate order (15 lines)
    // 2. Check inventory (20 lines)
    // 3. Process payment (25 lines)
    // 4. Update database (15 lines)
    // 5. Send notifications (10 lines)
    // 6. Generate invoice (20 lines)
    // Total: 105 lines in one function!
}

// Review comment:
"""
This function is too long and does too many things.
Violates Single Responsibility Principle.

Suggest extracting into smaller functions:
- validateOrder()
- checkInventory()
- processPayment()
- updateOrderStatus()
- sendNotifications()
- generateInvoice()

Then orchestrate them:
async function processOrder(orderId) {
    const order = await validateOrder(orderId);
    await checkInventory(order);
    const payment = await processPayment(order);
    await updateOrderStatus(order, payment);
    await Promise.all([
        sendNotifications(order),
        generateInvoice(order)
    ]);
}
"""
```

**Magic Numbers:**
```python
# BAD: Magic numbers
def is_valid_password(password):
    return len(password) >= 8 and len(password) <= 128

# Review comment:
"""
Magic numbers should be named constants for:
1. Clarity (why 8 and 128?)
2. Maintainability (change in one place)

Suggest:
MIN_PASSWORD_LENGTH = 8
MAX_PASSWORD_LENGTH = 128

def is_valid_password(password):
    return MIN_PASSWORD_LENGTH <= len(password) <= MAX_PASSWORD_LENGTH
"""
```

### 6. Architecture and Design

**Architecture Checklist:**
```
□ Does this fit the existing architecture?
□ Are abstractions appropriate (not over/under-engineered)?
□ Are dependencies managed correctly?
□ Is separation of concerns maintained?
□ Are interfaces/contracts clear?
□ Is the change backwards compatible?
□ Will this scale with growth?
```

**Separation of Concerns:**
```python
# BAD: Business logic in route handler
@app.route('/api/order', methods=['POST'])
def create_order():
    data = request.json

    # Validation logic
    if not data.get('items'):
        return {'error': 'No items'}, 400

    # Database logic
    order = Order(
        user_id=data['user_id'],
        total=sum(item['price'] for item in data['items'])
    )
    db.session.add(order)

    # Business logic
    for item in data['items']:
        OrderItem(order_id=order.id, **item)

    # Payment logic
    stripe.charge(order.total)

    # Email logic
    send_email(data['email'], 'Order confirmed')

    db.session.commit()
    return {'order_id': order.id}

# Review comment:
"""
This violates separation of concerns. The route handler contains:
- Validation logic
- Database operations
- Business logic
- Payment processing
- Email sending

This makes it:
- Hard to test
- Hard to maintain
- Hard to reuse
- Violates Single Responsibility Principle

Suggest refactoring to service layer:

@app.route('/api/order', methods=['POST'])
def create_order():
    data = request.json
    try:
        order = OrderService.create_order(data)
        return {'order_id': order.id}, 201
    except ValidationError as e:
        return {'error': str(e)}, 400
    except PaymentError as e:
        return {'error': str(e)}, 402

# Service layer handles business logic
class OrderService:
    @staticmethod
    def create_order(data):
        validator = OrderValidator(data)
        validator.validate()

        order = OrderRepository.create(data)
        PaymentService.process(order)
        EmailService.send_confirmation(order)

        return order
"""
```

### 7. Error Handling

**Error Handling Checklist:**
```
□ Are errors caught and handled appropriately?
□ Are error messages helpful and actionable?
□ Is logging sufficient for debugging?
□ Are resources cleaned up (files, connections)?
□ Are errors propagated correctly?
□ Is user-facing error information safe (no sensitive data)?
```

**Error Handling Patterns:**
```javascript
// BAD: Silent failure
async function fetchUserData(userId) {
    try {
        const response = await fetch(`/api/users/${userId}`);
        return response.json();
    } catch (error) {
        return null;  // Silent failure - hard to debug!
    }
}

// Review comment:
"""
Error handling issues:
1. Errors are silently swallowed - no logging
2. Returns null on any error (network, 404, 500, parse error)
3. Caller can't distinguish between "user not found" and "network error"
4. No way to debug issues in production

Suggest:
- Log errors with context
- Throw specific error types
- Let caller decide how to handle
"""

// GOOD
async function fetchUserData(userId) {
    try {
        const response = await fetch(`/api/users/${userId}`);

        if (!response.ok) {
            if (response.status === 404) {
                throw new UserNotFoundError(`User ${userId} not found`);
            }
            throw new APIError(
                `Failed to fetch user ${userId}: ${response.status}`
            );
        }

        return await response.json();

    } catch (error) {
        logger.error('Failed to fetch user data', {
            userId,
            error: error.message,
            stack: error.stack
        });
        throw error;  // Re-throw for caller to handle
    }
}
```

## Review Comments Best Practices

### Comment Categories

**Use Prefixes for Clarity:**
```
CRITICAL:  Must be fixed before merging
BLOCKER:   Prevents merge
SECURITY:  Security vulnerability
PERFORMANCE: Performance concern
SUGGESTION: Nice to have, not required
QUESTION:  Asking for clarification
PRAISE:    Acknowledging good work
NITPICK:   Very minor style preference
```

### Effective Comments

**Bad Comment:**
```
"This is wrong."
```

**Good Comment:**
```
BLOCKER: This will cause a null pointer exception when user.profile is null.

The code assumes user.profile always exists, but it's optional in the database.

Suggest adding a null check:
if (user.profile) {
    return user.profile.email;
}
return null;

Or using optional chaining:
return user.profile?.email;
```

**Bad Comment:**
```
"Why did you do it this way?"
```

**Good Comment:**
```
QUESTION: I'm curious about the choice to use a Set instead of an Array here.

Is this for deduplication? If so, consider adding a comment explaining this,
as it might not be obvious to future readers.

If deduplication isn't needed, an Array might be more straightforward since
we iterate over it multiple times (Set iteration is slower).
```

**Great Comment (Praise):**
```
PRAISE: Excellent error handling here! I especially like how you:
1. Distinguish between different error types
2. Log errors with context
3. Return user-friendly messages
4. Clean up resources in the finally block

This is a great pattern for the rest of the codebase to follow.
```

## Code Review Workflow

### Review Process

**1. Pre-Review:**
```
□ Check CI/CD pipeline status (all green?)
□ Review PR description and linked issues
□ Understand the context and requirements
□ Note the size (large PRs need different approach)
```

**2. First Pass (High Level):**
```
□ Does the approach make sense?
□ Does it fit the architecture?
□ Are there major design issues?
□ Is the scope appropriate?
```

**3. Detailed Pass:**
```
□ Go through each file carefully
□ Check logic, security, performance
□ Verify tests are adequate
□ Look for edge cases
```

**4. Final Pass:**
```
□ Re-read your comments (are they constructive?)
□ Prioritize issues (critical vs. suggestions)
□ Provide overall summary
```

### PR Size Guidelines

**Small PR (< 200 lines):**
- Can review deeply in 15-30 minutes
- Provide detailed feedback
- Expect quick iterations

**Medium PR (200-500 lines):**
- Review in chunks
- Focus on critical paths first
- May need 30-60 minutes

**Large PR (> 500 lines):**
```
Review comment:
"""
This PR is quite large (1500 lines changed across 30 files).
Large PRs are hard to review thoroughly and increase the risk of bugs.

Suggestions:
1. Can this be split into smaller PRs?
   - PR 1: Database schema changes
   - PR 2: API endpoints
   - PR 3: Frontend updates

2. If can't be split, can we schedule a synchronous review session
   to walk through the changes together?

3. Consider adding a high-level summary document explaining:
   - Overall architecture
   - Key components and their interactions
   - Testing strategy
"""
```

## Anti-Patterns to Avoid

### Reviewer Anti-Patterns

**Bikeshedding:**
```
# DON'T spend time on trivial issues
"BLOCKER: This comment has a period but other comments don't."
"CRITICAL: Use single quotes instead of double quotes."
"BLOCKER: Rename this variable from 'userData' to 'userInformation'."
```

**Rewriting:**
```
# DON'T rewrite the entire solution
"Here's how I would write this entire function..."
(proceeds to paste 50 lines of alternative code)

# DO provide guidance
"Consider extracting this logic into a separate function for better testability.
For example, you could create a validateInput() function that handles
the validation logic separately."
```

**Blocking on Non-Issues:**
```
# DON'T block on preferences
"BLOCKER: I prefer using map() instead of forEach() here."

# DO share preferences as suggestions
"SUGGESTION: map() might be more idiomatic here since you're
transforming the array, but forEach() works fine too."
```

### Author Anti-Patterns

**Defensive Responses:**
```
# DON'T
"That's how we've always done it."
"The tests pass, so it's fine."
"I don't have time to fix that now."

# DO
"Good point! I'll fix that."
"Can you explain what issue you see? I want to understand the concern."
"That's a good suggestion. Can we address it in a follow-up PR since this
 is already quite large?"
```

## Related Skills

- **Refactoring**: Improving code structure and design
- **Testing Strategies**: Writing effective tests
- **Security Best Practices**: Identifying security issues
- **Performance Optimization**: Spotting performance problems
- **Communication**: Giving constructive feedback
- **Architecture Patterns**: Understanding design patterns
- **Version Control**: Git and PR workflows
