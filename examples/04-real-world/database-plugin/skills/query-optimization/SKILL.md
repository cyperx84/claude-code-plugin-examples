---
name: "Query Optimization"
description: "Techniques for optimizing database queries, indexing strategies, and performance tuning for SQL databases"
---

# Query Optimization

You are a database performance expert specializing in query optimization, indexing strategies, and database performance tuning. You help identify and resolve performance bottlenecks in database queries and operations.

## Understanding Query Execution

### 1. Reading EXPLAIN Plans

**PostgreSQL EXPLAIN:**
```sql
-- Basic EXPLAIN
EXPLAIN SELECT * FROM orders WHERE customer_id = 123;

-- Detailed analysis with ANALYZE
EXPLAIN ANALYZE SELECT * FROM orders WHERE customer_id = 123;

-- Visual format
EXPLAIN (FORMAT JSON) SELECT * FROM orders WHERE customer_id = 123;
```

**Key Metrics to Watch:**
```sql
EXPLAIN (ANALYZE, BUFFERS, VERBOSE)
SELECT o.*, c.name
FROM orders o
JOIN customers c ON o.customer_id = c.id
WHERE o.created_at > '2024-01-01'
  AND o.status = 'completed';

/*
Key indicators:
- Seq Scan: Table scan (usually slow for large tables)
- Index Scan: Using an index (good)
- Index Only Scan: Best - data from index only
- Nested Loop: Join strategy (good for small datasets)
- Hash Join: Join strategy (good for large datasets)
- Sort: Expensive operation, consider indexes
- Buffers: Memory usage
- Actual time: Real execution time
*/
```

**Interpreting Costs:**
```
Cost Structure: cost=0.42..8.44 rows=1 width=136
- First number (0.42): Startup cost
- Second number (8.44): Total cost
- rows: Estimated rows returned
- width: Average row size in bytes

LOWER COST = BETTER PERFORMANCE
```

### 2. Query Execution Order

**SQL Execution Flow:**
```sql
-- Written order (logical)
SELECT customer_name, SUM(total) as revenue
FROM orders
WHERE status = 'completed'
GROUP BY customer_name
HAVING SUM(total) > 1000
ORDER BY revenue DESC
LIMIT 10;

-- Actual execution order:
-- 1. FROM orders
-- 2. WHERE status = 'completed'
-- 3. GROUP BY customer_name
-- 4. HAVING SUM(total) > 1000
-- 5. SELECT customer_name, SUM(total)
-- 6. ORDER BY revenue DESC
-- 7. LIMIT 10
```

## Indexing Strategies

### 1. When to Create Indexes

**Good Index Candidates:**
```sql
-- Foreign keys (for JOINs)
CREATE INDEX idx_orders_customer_id ON orders(customer_id);

-- Frequently filtered columns (WHERE clauses)
CREATE INDEX idx_orders_status ON orders(status);

-- Frequently sorted columns (ORDER BY)
CREATE INDEX idx_orders_created_at ON orders(created_at);

-- Columns used in GROUP BY
CREATE INDEX idx_sales_product_id ON sales(product_id);

-- Columns in JOIN conditions
CREATE INDEX idx_order_items_order_id ON order_items(order_id);
```

**Bad Index Candidates:**
```sql
-- High cardinality UUID primary keys (already indexed)
-- CREATE INDEX idx_users_id ON users(id); -- DON'T DO THIS

-- Low cardinality columns (few distinct values)
-- CREATE INDEX idx_users_gender ON users(gender); -- Usually not helpful

-- Frequently updated columns in write-heavy tables
-- CREATE INDEX idx_counters_value ON counters(value); -- Slow writes

-- Very large text columns
-- CREATE INDEX idx_posts_content ON posts(content); -- Too large
```

### 2. Composite Indexes

**Column Order Matters:**
```sql
-- For queries filtering by status AND customer_id
CREATE INDEX idx_orders_status_customer ON orders(status, customer_id);

-- This index helps these queries:
SELECT * FROM orders WHERE status = 'pending';  -- ✓ Uses index
SELECT * FROM orders WHERE status = 'pending' AND customer_id = 123;  -- ✓ Uses index
SELECT * FROM orders WHERE customer_id = 123;  -- ✗ Doesn't use index

-- Rule: Most selective column first, or match query patterns
```

**Optimal Composite Index Strategy:**
```sql
-- Common query pattern
SELECT * FROM orders
WHERE status = 'pending'
  AND created_at > '2024-01-01'
ORDER BY created_at DESC;

-- Optimal index
CREATE INDEX idx_orders_status_created_at ON orders(status, created_at DESC);

-- This supports:
-- 1. WHERE status = 'pending'
-- 2. WHERE status = 'pending' AND created_at > ...
-- 3. ORDER BY created_at DESC (when combined with WHERE status)
```

### 3. Partial Indexes

**Index Only What You Need:**
```sql
-- Only index active orders
CREATE INDEX idx_active_orders ON orders(created_at)
WHERE status IN ('pending', 'processing');

-- Only index recent data
CREATE INDEX idx_recent_orders ON orders(customer_id)
WHERE created_at > '2024-01-01';

-- Benefits:
-- - Smaller index size
-- - Faster index updates
-- - Better cache utilization
```

### 4. Covering Indexes

**Include All Required Columns:**
```sql
-- Query that needs optimization
SELECT order_id, customer_id, total
FROM orders
WHERE status = 'completed'
  AND created_at > '2024-01-01';

-- Covering index (PostgreSQL)
CREATE INDEX idx_orders_covering ON orders(status, created_at)
INCLUDE (order_id, customer_id, total);

-- Now the database can satisfy the query entirely from the index
-- (Index Only Scan - fastest possible)
```

## Query Optimization Techniques

### 1. Avoid SELECT *

**Problem:**
```sql
-- BAD: Fetches all columns (slow, wasteful)
SELECT * FROM orders WHERE customer_id = 123;
```

**Solution:**
```sql
-- GOOD: Only select needed columns
SELECT order_id, total, created_at FROM orders WHERE customer_id = 123;

-- Benefits:
-- - Less data transfer
-- - Better index usage (covering indexes)
-- - Reduced memory usage
-- - Faster network transfer
```

### 2. Filter Early, Filter Often

**Suboptimal:**
```sql
-- Joins first, filters later
SELECT o.order_id, c.name
FROM orders o
JOIN customers c ON o.customer_id = c.id
WHERE o.created_at > '2024-01-01';
```

**Optimized:**
```sql
-- Filter in subquery first
SELECT o.order_id, c.name
FROM (
    SELECT order_id, customer_id
    FROM orders
    WHERE created_at > '2024-01-01'
) o
JOIN customers c ON o.customer_id = c.id;

-- Or use CTE for readability
WITH recent_orders AS (
    SELECT order_id, customer_id
    FROM orders
    WHERE created_at > '2024-01-01'
)
SELECT o.order_id, c.name
FROM recent_orders o
JOIN customers c ON o.customer_id = c.id;
```

### 3. Optimize JOINs

**JOIN Order Matters:**
```sql
-- Start with smallest result set
EXPLAIN ANALYZE
SELECT o.*, p.name, c.name
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
JOIN products p ON oi.product_id = p.product_id
JOIN customers c ON o.customer_id = c.id
WHERE o.created_at > '2024-01-01'  -- Filters orders first
  AND p.category = 'electronics';  -- Then filters products
```

**Avoid Implicit Cross Joins:**
```sql
-- BAD: Implicit cross join
SELECT *
FROM orders o, customers c
WHERE o.customer_id = c.id;

-- GOOD: Explicit JOIN
SELECT *
FROM orders o
JOIN customers c ON o.customer_id = c.id;
```

### 4. Use EXISTS Instead of IN for Large Datasets

**Suboptimal:**
```sql
-- IN creates a full list in memory
SELECT *
FROM customers
WHERE customer_id IN (
    SELECT customer_id FROM orders WHERE total > 1000
);
```

**Optimized:**
```sql
-- EXISTS stops at first match (short-circuit evaluation)
SELECT *
FROM customers c
WHERE EXISTS (
    SELECT 1 FROM orders o
    WHERE o.customer_id = c.customer_id
      AND o.total > 1000
);
```

### 5. Avoid Functions on Indexed Columns

**Prevents Index Usage:**
```sql
-- BAD: Function on indexed column
SELECT * FROM orders WHERE YEAR(created_at) = 2024;
SELECT * FROM users WHERE LOWER(email) = 'user@example.com';
```

**Index-Friendly:**
```sql
-- GOOD: Use range queries
SELECT * FROM orders
WHERE created_at >= '2024-01-01'
  AND created_at < '2025-01-01';

-- GOOD: Store lowercase, or use functional index
CREATE INDEX idx_users_email_lower ON users(LOWER(email));
SELECT * FROM users WHERE LOWER(email) = 'user@example.com';
```

## The N+1 Query Problem

### 1. Identifying N+1 Queries

**Problem Pattern:**
```python
# BAD: N+1 query problem
orders = Order.objects.all()  # 1 query
for order in orders:
    print(order.customer.name)  # N additional queries!
    # This executes: SELECT * FROM customers WHERE id = ?
    # Once for EACH order!
```

**Detection:**
```python
from django.db import connection
from django.test.utils import override_settings

@override_settings(DEBUG=True)
def detect_n_plus_one():
    queries_before = len(connection.queries)

    orders = Order.objects.all()
    for order in orders:
        _ = order.customer.name

    queries_after = len(connection.queries)
    query_count = queries_after - queries_before

    if query_count > 10:
        print(f"WARNING: Possible N+1 problem! {query_count} queries executed")
```

### 2. Solutions

**Eager Loading (Prefetch):**
```python
# GOOD: Use select_related for ForeignKey/OneToOne
orders = Order.objects.select_related('customer').all()  # 1 query with JOIN
for order in orders:
    print(order.customer.name)  # No additional queries!

# GOOD: Use prefetch_related for ManyToMany/reverse ForeignKey
orders = Order.objects.prefetch_related('items').all()
for order in orders:
    print([item.name for item in order.items.all()])  # Efficient!
```

**SQL Equivalent:**
```sql
-- Instead of:
-- SELECT * FROM orders; (1 query)
-- SELECT * FROM customers WHERE id = 1; (N queries)
-- SELECT * FROM customers WHERE id = 2;
-- ...

-- Do this:
SELECT o.*, c.*
FROM orders o
LEFT JOIN customers c ON o.customer_id = c.id;  -- 1 query!
```

## Caching Strategies

### 1. Query Result Caching

```python
import redis
import json
from functools import wraps

redis_client = redis.Redis(host='localhost', port=6379, db=0)

def cache_query(timeout=300):
    """Cache query results in Redis"""
    def decorator(func):
        @wraps(func)
        def wrapper(*args, **kwargs):
            # Create cache key from function name and arguments
            cache_key = f"query:{func.__name__}:{hash(str(args) + str(kwargs))}"

            # Try to get from cache
            cached = redis_client.get(cache_key)
            if cached:
                return json.loads(cached)

            # Execute query
            result = func(*args, **kwargs)

            # Store in cache
            redis_client.setex(
                cache_key,
                timeout,
                json.dumps(result)
            )

            return result
        return wrapper
    return decorator

# Usage
@cache_query(timeout=600)
def get_popular_products():
    return Product.objects.filter(
        sales_count__gt=1000
    ).values_list('id', 'name', 'price')
```

### 2. Database Query Cache

```sql
-- MySQL Query Cache (deprecated in MySQL 8.0)
-- Use application-level caching instead

-- PostgreSQL: Use materialized views for complex aggregations
CREATE MATERIALIZED VIEW sales_summary AS
SELECT
    product_id,
    DATE_TRUNC('day', created_at) as day,
    COUNT(*) as order_count,
    SUM(total) as revenue
FROM orders
GROUP BY product_id, DATE_TRUNC('day', created_at);

-- Refresh periodically
REFRESH MATERIALIZED VIEW sales_summary;

-- Query the materialized view (very fast)
SELECT * FROM sales_summary WHERE day = '2024-01-01';
```

## Connection Pooling

### 1. Why Connection Pooling Matters

```python
# WITHOUT Connection Pooling:
# Each request creates new connection (slow!)
import psycopg2

def bad_approach():
    conn = psycopg2.connect(
        dbname="mydb",
        user="user",
        password="password",
        host="localhost"
    )
    cursor = conn.cursor()
    cursor.execute("SELECT * FROM users")
    result = cursor.fetchall()
    conn.close()  # Connection destroyed
    return result

# WITH Connection Pooling:
# Reuse connections across requests (fast!)
from psycopg2 import pool

connection_pool = pool.SimpleConnectionPool(
    minconn=1,
    maxconn=10,
    dbname="mydb",
    user="user",
    password="password",
    host="localhost"
)

def good_approach():
    conn = connection_pool.getconn()
    cursor = conn.cursor()
    cursor.execute("SELECT * FROM users")
    result = cursor.fetchall()
    connection_pool.putconn(conn)  # Return to pool
    return result
```

### 2. Optimal Pool Settings

```python
# Django settings
DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.postgresql',
        'NAME': 'mydb',
        'CONN_MAX_AGE': 600,  # Keep connections open for 10 minutes
        'OPTIONS': {
            'connect_timeout': 10,
            'options': '-c statement_timeout=30000'  # 30 second query timeout
        },
    }
}

# SQLAlchemy pool configuration
from sqlalchemy import create_engine
from sqlalchemy.pool import QueuePool

engine = create_engine(
    'postgresql://user:password@localhost/mydb',
    poolclass=QueuePool,
    pool_size=10,           # Normal pool size
    max_overflow=20,        # Extra connections when needed
    pool_timeout=30,        # Wait 30s for connection
    pool_recycle=3600,      # Recycle connections after 1 hour
    pool_pre_ping=True,     # Verify connection before using
)
```

## Batch Operations

### 1. Batch Inserts

**Slow:**
```python
# DON'T: Insert one at a time
for item in items:
    cursor.execute(
        "INSERT INTO products (name, price) VALUES (%s, %s)",
        (item.name, item.price)
    )
    # 1000 items = 1000 queries!
```

**Fast:**
```python
# DO: Batch insert
values = [(item.name, item.price) for item in items]

# PostgreSQL
from psycopg2.extras import execute_values
execute_values(
    cursor,
    "INSERT INTO products (name, price) VALUES %s",
    values
)  # 1000 items = 1 query!

# Django ORM
Product.objects.bulk_create([
    Product(name=item.name, price=item.price)
    for item in items
], batch_size=1000)
```

### 2. Batch Updates

```python
# Efficient batch update
from django.db import transaction

with transaction.atomic():
    for product in products_to_update:
        product.price *= 1.1  # 10% increase

    Product.objects.bulk_update(products_to_update, ['price'], batch_size=500)
```

## Advanced Optimization Techniques

### 1. Partitioning

**Range Partitioning (PostgreSQL 10+):**
```sql
-- Partition large tables by date
CREATE TABLE orders (
    order_id BIGSERIAL,
    customer_id INTEGER,
    created_at DATE NOT NULL,
    total DECIMAL(10,2)
) PARTITION BY RANGE (created_at);

-- Create partitions
CREATE TABLE orders_2024_q1 PARTITION OF orders
    FOR VALUES FROM ('2024-01-01') TO ('2024-04-01');

CREATE TABLE orders_2024_q2 PARTITION OF orders
    FOR VALUES FROM ('2024-04-01') TO ('2024-07-01');

-- Queries automatically use correct partition
SELECT * FROM orders WHERE created_at = '2024-02-15';
-- Only scans orders_2024_q1!
```

### 2. Denormalization

**When Reads >> Writes:**
```sql
-- Instead of joining every time
SELECT o.order_id, c.name, c.email
FROM orders o
JOIN customers c ON o.customer_id = c.id;

-- Denormalize for read performance
ALTER TABLE orders
ADD COLUMN customer_name VARCHAR(255),
ADD COLUMN customer_email VARCHAR(255);

-- Update on insert/update
CREATE OR REPLACE FUNCTION update_customer_info()
RETURNS TRIGGER AS $$
BEGIN
    SELECT name, email INTO NEW.customer_name, NEW.customer_email
    FROM customers WHERE customer_id = NEW.customer_id;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER update_order_customer
BEFORE INSERT OR UPDATE ON orders
FOR EACH ROW
EXECUTE FUNCTION update_customer_info();

-- Now just query orders table (no JOIN needed)
SELECT order_id, customer_name, customer_email FROM orders;
```

### 3. Database-Specific Optimizations

**PostgreSQL:**
```sql
-- Use JSONB for semi-structured data
CREATE TABLE events (
    event_id SERIAL PRIMARY KEY,
    event_data JSONB
);

-- Index JSONB columns
CREATE INDEX idx_events_data ON events USING GIN (event_data);

-- Efficient JSONB queries
SELECT * FROM events WHERE event_data @> '{"user_id": 123}';
```

**MySQL:**
```sql
-- Use covering indexes
ALTER TABLE orders
ADD INDEX idx_covering (customer_id, status, created_at, total);

-- Force index if optimizer makes wrong choice
SELECT * FROM orders
FORCE INDEX (idx_customer_status)
WHERE customer_id = 123 AND status = 'pending';
```

## Performance Monitoring

### 1. Slow Query Log

**PostgreSQL Configuration:**
```sql
-- Enable slow query logging
ALTER SYSTEM SET log_min_duration_statement = 1000;  -- Log queries > 1 second
ALTER SYSTEM SET log_line_prefix = '%t [%p]: [%l-1] user=%u,db=%d,app=%a,client=%h ';
SELECT pg_reload_conf();

-- View slow queries
SELECT
    query,
    calls,
    total_time,
    mean_time,
    max_time
FROM pg_stat_statements
ORDER BY mean_time DESC
LIMIT 10;
```

### 2. Query Performance Metrics

```python
import time
from contextlib import contextmanager

@contextmanager
def query_timer(query_name):
    """Measure query execution time"""
    start = time.time()
    try:
        yield
    finally:
        duration = time.time() - start
        if duration > 1.0:  # Log slow queries
            print(f"SLOW QUERY [{query_name}]: {duration:.2f}s")

# Usage
with query_timer("fetch_user_orders"):
    orders = Order.objects.filter(customer_id=123).all()
```

## Optimization Checklist

**Before Deploying:**
- [ ] All foreign keys have indexes
- [ ] WHERE clause columns are indexed
- [ ] No SELECT * in production code
- [ ] N+1 queries eliminated
- [ ] EXPLAIN ANALYZE on critical queries
- [ ] Connection pooling configured
- [ ] Query timeouts set
- [ ] Slow query logging enabled
- [ ] Batch operations for bulk data
- [ ] Caching strategy implemented

**Red Flags:**
- ⚠️ Queries taking > 1 second
- ⚠️ Full table scans on large tables
- ⚠️ Missing indexes on foreign keys
- ⚠️ DISTINCT or GROUP BY without indexes
- ⚠️ Subqueries in SELECT clause
- ⚠️ Cartesian products (cross joins)
- ⚠️ OR clauses (consider UNION instead)
- ⚠️ Functions on indexed columns

## Related Skills

- **Database Design**: Schema design and normalization
- **Index Management**: Advanced indexing techniques
- **SQL Fundamentals**: Core SQL knowledge
- **ORM Usage**: Efficient ORM query patterns
- **Caching**: Application-level caching strategies
- **Monitoring**: Database performance monitoring
- **Scaling**: Database scaling and sharding
