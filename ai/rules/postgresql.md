# PostgreSQL Development Rules

## Naming Conventions

### Tables

- **Prefix:** `tbl_`
- **Format:** `tbl_<entity_name>` in plural form
- **Style:** snake_case, lowercase
- **Examples:**
  - `tbl_users` - user information
  - `tbl_orders` - order records
  - `tbl_products` - product catalog
  - `tbl_order_items` - order line items

```sql
CREATE TABLE tbl_users (
    id BIGSERIAL PRIMARY KEY,
    username VARCHAR(50) NOT NULL,
    email VARCHAR(255) NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);
```

### Views

- **Prefix:** `view_`
- **Format:** `view_<descriptive_name>`
- **Style:** snake_case, lowercase
- **Examples:**
  - `view_active_users` - users with active status
  - `view_order_summary` - aggregated order data
  - `view_user_permissions` - joined user and permission data

```sql
CREATE VIEW view_active_users AS
SELECT id, username, email, created_at
FROM tbl_users
WHERE status = 'active' AND deleted_at IS NULL;
```

### Indexes

- **Format:** `<TYPE>-<table>-<column(s)>`
- **Types:**
  - `PK` - Primary Key
  - `UNQ` - Unique Index
  - `BTREE` - B-Tree Index (default, for ordered data)
  - `HASH` - Hash Index (for equality comparisons)
  - `GIN` - Generalized Inverted Index (for full-text search, JSONB)
  - `GIST` - Generalized Search Tree (for geometric data, full-text)
  - `BRIN` - Block Range Index (for very large tables)
  - `FK` - Foreign Key Index
- **Examples:**
  - `BTREE-tbl_users-email` - B-tree index on user email
  - `UNQ-tbl_users-username` - Unique index on username
  - `BTREE-tbl_orders-created_at` - Index on order creation date
  - `FK-tbl_orders-user_id-tbl_users-id` - Foreign key index
  - `GIN-tbl_products-search_vector` - Full-text search index

```sql
-- B-Tree index for sorting and range queries
CREATE INDEX "BTREE-tbl_users-created_at" ON tbl_users USING BTREE (created_at);

-- Unique index
CREATE UNIQUE INDEX "UNQ-tbl_users-email" ON tbl_users (email);

-- Composite index
CREATE INDEX "BTREE-tbl_orders-user_id-status" ON tbl_orders (user_id, status);

-- Foreign key index
CREATE INDEX "FK-tbl_orders-user_id-tbl_users-id" ON tbl_orders (user_id);

-- Partial index (conditional)
CREATE INDEX "BTREE-tbl_users-active-status" ON tbl_users (status)
WHERE status = 'active';

-- GIN index for JSONB
CREATE INDEX "GIN-tbl_products-metadata" ON tbl_products USING GIN (metadata);

-- Full-text search index
CREATE INDEX "GIN-tbl_articles-search_vector" ON tbl_articles USING GIN (search_vector);
```

### Constraints

- **Primary Key:** `PK-<table>`
- **Foreign Key:** `FK-<table>-<column>-<ref_table>-<ref_column>`
- **Unique:** `UNQ-<table>-<column(s)>`
- **Check:** `CHK-<table>-<condition_description>`
- **Default:** Use inline DEFAULT clause

```sql
CREATE TABLE tbl_users (
    id BIGSERIAL,
    username VARCHAR(50) NOT NULL,
    email VARCHAR(255) NOT NULL,
    age INTEGER,
    status VARCHAR(20) DEFAULT 'active',

    CONSTRAINT "PK-tbl_users" PRIMARY KEY (id),
    CONSTRAINT "UNQ-tbl_users-username" UNIQUE (username),
    CONSTRAINT "UNQ-tbl_users-email" UNIQUE (email),
    CONSTRAINT "CHK-tbl_users-age-positive" CHECK (age > 0 AND age < 150),
    CONSTRAINT "CHK-tbl_users-status-valid" CHECK (status IN ('active', 'inactive', 'suspended'))
);

CREATE TABLE tbl_orders (
    id BIGSERIAL,
    user_id BIGINT NOT NULL,
    total_amount DECIMAL(10,2) NOT NULL,

    CONSTRAINT "PK-tbl_orders" PRIMARY KEY (id),
    CONSTRAINT "FK-tbl_orders-user_id-tbl_users-id"
        FOREIGN KEY (user_id) REFERENCES tbl_users(id) ON DELETE CASCADE,
    CONSTRAINT "CHK-tbl_orders-total_amount-positive" CHECK (total_amount >= 0)
);
```

### Sequences

- **Format:** `seq_<table>_<column>`
- **Examples:**
  - `seq_tbl_users_id`
  - `seq_tbl_orders_number`

```sql
CREATE SEQUENCE seq_tbl_orders_order_number START 1000;

ALTER TABLE tbl_orders
ALTER COLUMN order_number SET DEFAULT nextval('seq_tbl_orders_order_number');
```

### Functions and Stored Procedures

- **Prefix:** `fn_` for functions, `sp_` for procedures
- **Format:** `fn_<verb>_<description>` or `sp_<verb>_<description>`
- **Style:** snake_case, lowercase
- **Examples:**
  - `fn_calculate_order_total`
  - `fn_get_user_permissions`
  - `sp_process_daily_orders`
  - `sp_cleanup_old_logs`

```sql
CREATE OR REPLACE FUNCTION fn_calculate_order_total(order_id BIGINT)
RETURNS DECIMAL(10,2)
LANGUAGE plpgsql
AS $$
DECLARE
    total DECIMAL(10,2);
BEGIN
    SELECT SUM(quantity * unit_price)
    INTO total
    FROM tbl_orders_item
    WHERE order_id = order_id;

    RETURN COALESCE(total, 0);
END;
$$;

CREATE OR REPLACE PROCEDURE sp_archive_old_orders(days_old INTEGER)
LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO tbl_order_archives
    SELECT * FROM tbl_orders
    WHERE created_at < NOW() - (days_old || ' days')::INTERVAL;

    DELETE FROM tbl_orders
    WHERE created_at < NOW() - (days_old || ' days')::INTERVAL;

    COMMIT;
END;
$$;
```

### Triggers

- **Format:** `trg_<table>_<when>_<event>_<action>`
- **When:** `before` or `after`
- **Event:** `insert`, `update`, `delete`
- **Examples:**
  - `trg_tbl_users_before_insert_set_created`
  - `trg_tbl_orders_after_update_log_changes`
  - `trg_tbl_products_before_delete_check_orders`

```sql
CREATE OR REPLACE FUNCTION fn_trg_set_updated_at()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$;

CREATE TRIGGER trg_tbl_users_before_update_set_updated
    BEFORE UPDATE ON tbl_users
    FOR EACH ROW
    EXECUTE FUNCTION fn_trg_set_updated_at();
```

### Column Naming

- **Style:** snake_case, lowercase
- **Avoid:** Reserved keywords (user, order, table, etc.) - wrap in quotes if necessary
- **Boolean:** Use `is_`, `has_`, `can_` prefixes
- **Timestamps:** Use standard names: `created_at`, `updated_at`, `deleted_at`
- **Foreign Keys:** Use `<referenced_table>_id` (without `tbl_` prefix)

```sql
CREATE TABLE tbl_users (
    id BIGSERIAL PRIMARY KEY,
    username VARCHAR(50) NOT NULL,
    email VARCHAR(255) NOT NULL,
    first_name VARCHAR(100),
    last_name VARCHAR(100),
    is_active BOOLEAN DEFAULT TRUE,
    is_verified BOOLEAN DEFAULT FALSE,
    has_newsletter BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE,
    deleted_at TIMESTAMP WITH TIME ZONE  -- for soft deletes
);

CREATE TABLE tbl_orders (
    id BIGSERIAL PRIMARY KEY,
    user_id BIGINT NOT NULL,  -- References tbl_users(id)
    order_number VARCHAR(50) UNIQUE NOT NULL,
    status VARCHAR(20) DEFAULT 'pending',
    total_amount DECIMAL(10,2) NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);
```

## Data Types Best Practices

### Use Appropriate Types

```sql
-- Identity/Primary Keys
id BIGSERIAL PRIMARY KEY  -- Auto-incrementing 64-bit integer

-- Strings
username VARCHAR(50)  -- Variable length with limit
email VARCHAR(255)
description TEXT  -- Unlimited length
status VARCHAR(20)  -- For enum-like values

-- Numbers
quantity INTEGER  -- 32-bit integer
price DECIMAL(10,2)  -- Fixed precision for money
weight NUMERIC(8,3)  -- Variable precision
percentage REAL  -- Floating point (when precision isn't critical)

-- Boolean
is_active BOOLEAN
has_permission BOOLEAN

-- Dates and Times
created_at TIMESTAMP WITH TIME ZONE  -- Preferred: stores timezone
updated_at TIMESTAMP WITH TIME ZONE
birth_date DATE  -- Date only
event_time TIME WITH TIME ZONE  -- Time only

-- JSON
metadata JSONB  -- Binary JSON (preferred over JSON)
settings JSONB

-- Arrays
tags TEXT[]
prices DECIMAL(10,2)[]

-- UUID
uuid UUID DEFAULT gen_random_uuid()

-- Enums (when values are stable)
CREATE TYPE order_status AS ENUM ('pending', 'processing', 'shipped', 'delivered', 'cancelled');
status order_status DEFAULT 'pending'
```

### Avoid These Types

```sql
-- DON'T use CHAR for variable-length data
name CHAR(50)  -- BAD: wastes space if name is shorter

-- DON'T use REAL/DOUBLE PRECISION for money
price REAL  -- BAD: floating point errors

-- DON'T use TIMESTAMP without timezone
created_at TIMESTAMP  -- BAD: loses timezone information

-- DO use these instead
name VARCHAR(50)
price DECIMAL(10,2)
created_at TIMESTAMP WITH TIME ZONE
```

## Schema Design Principles

### Normalization

- Aim for 3rd Normal Form (3NF) for transactional data
- Denormalize strategically for read-heavy operations
- Use materialized views for complex aggregations

```sql
-- Normalized design
CREATE TABLE tbl_users (
    id BIGSERIAL PRIMARY KEY,
    username VARCHAR(50) NOT NULL,
    email VARCHAR(255) NOT NULL
);

CREATE TABLE tbl_addresses (
    id BIGSERIAL PRIMARY KEY,
    user_id BIGINT NOT NULL,
    street VARCHAR(255),
    city VARCHAR(100),
    country VARCHAR(100),
    CONSTRAINT "FK-tbl_addresses-user_id-tbl_users-id"
        FOREIGN KEY (user_id) REFERENCES tbl_users(id)
);

-- Materialized view for performance
CREATE MATERIALIZED VIEW view_user_order_stats AS
SELECT
    u.id,
    u.username,
    COUNT(o.id) as order_count,
    SUM(o.total_amount) as total_spent
FROM tbl_users u
LEFT JOIN tbl_orders o ON o.user_id = u.id
GROUP BY u.id, u.username;

-- Refresh periodically
REFRESH MATERIALIZED VIEW view_user_order_stats;
```

### Soft Deletes

- Use `deleted_at` column for soft deletes
- Create views to filter out deleted records
- Add partial indexes to ignore deleted records

```sql
CREATE TABLE tbl_users (
    id BIGSERIAL PRIMARY KEY,
    username VARCHAR(50) NOT NULL,
    email VARCHAR(255) NOT NULL,
    deleted_at TIMESTAMP WITH TIME ZONE
);

-- View of active records
CREATE VIEW view_active_users AS
SELECT * FROM tbl_users WHERE deleted_at IS NULL;

-- Index that ignores deleted records
CREATE INDEX "BTREE-tbl_users-active-email" ON tbl_users (email)
WHERE deleted_at IS NULL;
```

### Audit Trail

- Add `created_at`, `updated_at`, `created_by`, `updated_by` columns
- Use triggers to automatically populate these fields

```sql
CREATE TABLE tbl_users (
    id BIGSERIAL PRIMARY KEY,
    username VARCHAR(50) NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    created_by BIGINT,
    updated_at TIMESTAMP WITH TIME ZONE,
    updated_by BIGINT
);

CREATE OR REPLACE FUNCTION fn_trg_set_audit_fields()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
BEGIN
    IF TG_OP = 'INSERT' THEN
        NEW.created_at = NOW();
        NEW.created_by = current_setting('app.user_id', TRUE)::BIGINT;
    END IF;

    NEW.updated_at = NOW();
    NEW.updated_by = current_setting('app.user_id', TRUE)::BIGINT;

    RETURN NEW;
END;
$$;

CREATE TRIGGER trg_tbl_users_audit
    BEFORE INSERT OR UPDATE ON tbl_users
    FOR EACH ROW
    EXECUTE FUNCTION fn_trg_set_audit_fields();
```

## Performance Best Practices

### Indexing Strategy

- Index foreign keys
- Index columns used in WHERE, JOIN, ORDER BY clauses
- Use composite indexes for multi-column queries
- Avoid over-indexing (impacts write performance)
- Use partial indexes for filtered queries
- Use expression indexes for computed values

```sql
-- Foreign key index
CREATE INDEX "FK-tbl_orders-user_id-tbl_users-id" ON tbl_orders (user_id);

-- Composite index (order matters!)
CREATE INDEX "BTREE-tbl_orders-user_id-status-created_at"
ON tbl_orders (user_id, status, created_at);

-- Partial index
CREATE INDEX "BTREE-tbl_orders-active" ON tbl_orders (created_at)
WHERE status NOT IN ('cancelled', 'completed');

-- Expression index
CREATE INDEX "BTREE-tbl_users-lower-email" ON tbl_users (LOWER(email));
```

### Query Optimization

- Use EXPLAIN ANALYZE to understand query plans
- Avoid SELECT * - specify needed columns
- Use LIMIT for pagination
- Avoid N+1 queries - use JOINs or batch queries
- Use CTEs (Common Table Expressions) for readability
- Consider window functions for analytics

```sql
-- Good: Specific columns, indexed WHERE clause
SELECT id, username, email
FROM tbl_users
WHERE status = 'active'
ORDER BY created_at DESC
LIMIT 20;

-- Use CTE for complex queries
WITH monthly_orders AS (
    SELECT
        user_id,
        DATE_TRUNC('month', created_at) as month,
        COUNT(*) as order_count,
        SUM(total_amount) as total_spent
    FROM tbl_orders
    WHERE created_at >= NOW() - INTERVAL '1 year'
    GROUP BY user_id, DATE_TRUNC('month', created_at)
)
SELECT
    u.username,
    mo.month,
    mo.order_count,
    mo.total_spent
FROM monthly_orders mo
JOIN tbl_users u ON u.id = mo.user_id
ORDER BY mo.month DESC, mo.total_spent DESC;

-- Window functions
SELECT
    user_id,
    order_number,
    total_amount,
    ROW_NUMBER() OVER (PARTITION BY user_id ORDER BY created_at DESC) as order_rank,
    SUM(total_amount) OVER (PARTITION BY user_id) as user_total_spent
FROM tbl_orders;
```

### Partitioning

- Use table partitioning for very large tables
- Partition by date range (most common)
- Partition by list or hash when appropriate

```sql
-- Partitioned table by date range
CREATE TABLE tbl_orders (
    id BIGSERIAL,
    user_id BIGINT NOT NULL,
    total_amount DECIMAL(10,2),
    created_at TIMESTAMP WITH TIME ZONE NOT NULL,
    CONSTRAINT "PK-tbl_orders" PRIMARY KEY (id, created_at)
) PARTITION BY RANGE (created_at);

-- Create partitions
CREATE TABLE tbl_orders_2024_q1 PARTITION OF tbl_orders
    FOR VALUES FROM ('2024-01-01') TO ('2024-04-01');

CREATE TABLE tbl_orders_2024_q2 PARTITION OF tbl_orders
    FOR VALUES FROM ('2024-04-01') TO ('2024-07-01');
```

## Security Best Practices

### Access Control

- Use separate database users for different applications/roles
- Grant minimum necessary permissions
- Never use superuser for application connections
- Use row-level security for multi-tenant applications

```sql
-- Create application user
CREATE USER app_user WITH PASSWORD 'secure_password';

-- Grant specific permissions
GRANT CONNECT ON DATABASE mydb TO app_user;
GRANT USAGE ON SCHEMA public TO app_user;
GRANT SELECT, INSERT, UPDATE ON tbl_users TO app_user;
GRANT SELECT ON view_active_users TO app_user;

-- Read-only user
CREATE USER readonly_user WITH PASSWORD 'readonly_password';
GRANT CONNECT ON DATABASE mydb TO readonly_user;
GRANT USAGE ON SCHEMA public TO readonly_user;
GRANT SELECT ON ALL TABLES IN SCHEMA public TO readonly_user;

-- Row-level security
ALTER TABLE tbl_orders ENABLE ROW LEVEL SECURITY;

CREATE POLICY order_access_policy ON tbl_orders
    FOR ALL
    TO app_user
    USING (user_id = current_setting('app.user_id')::BIGINT);
```

### SQL Injection Prevention

- Always use parameterized queries
- Never concatenate user input into SQL
- Validate and sanitize inputs at application level

```sql
-- BAD: Vulnerable to SQL injection
SELECT * FROM tbl_users WHERE username = '$username';

-- GOOD: Use parameterized query (in application code)
-- Python example:
-- cursor.execute("SELECT * FROM tbl_users WHERE username = %s", (username,))

-- GOOD: Use prepared statements
PREPARE get_user AS
SELECT * FROM tbl_users WHERE username = $1;

EXECUTE get_user('john');
```

## Migration Best Practices

### Schema Migrations

- Use migration tools (Flyway, Liquibase, Alembic, migrate)
- Version all schema changes
- Make migrations reversible (up/down)
- Test migrations on staging before production
- Use transactions for migration scripts

```sql
-- Migration: V001__create_user_table.sql
BEGIN;

CREATE TABLE tbl_users (
    id BIGSERIAL,
    username VARCHAR(50) NOT NULL,
    email VARCHAR(255) NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),

    CONSTRAINT "PK-tbl_users" PRIMARY KEY (id),
    CONSTRAINT "UNQ-tbl_users-username" UNIQUE (username),
    CONSTRAINT "UNQ-tbl_users-email" UNIQUE (email)
);

CREATE INDEX "BTREE-tbl_users-created_at" ON tbl_users (created_at);

COMMIT;
```

### Safe Column Changes

```sql
-- Adding a nullable column (safe)
ALTER TABLE tbl_users ADD COLUMN phone VARCHAR(20);

-- Adding a NOT NULL column (safe way)
ALTER TABLE tbl_users ADD COLUMN status VARCHAR(20) DEFAULT 'active';
ALTER TABLE tbl_users ALTER COLUMN status SET NOT NULL;

-- Renaming column (requires application update)
ALTER TABLE tbl_users RENAME COLUMN username TO user_name;

-- Dropping column (ensure no application uses it)
ALTER TABLE tbl_users DROP COLUMN old_column;
```

### Zero-Downtime Migrations

```sql
-- Step 1: Add new column
ALTER TABLE tbl_users ADD COLUMN email_new VARCHAR(255);

-- Step 2: Backfill data
UPDATE tbl_users SET email_new = email WHERE email_new IS NULL;

-- Step 3: Add constraint after backfill
ALTER TABLE tbl_users ALTER COLUMN email_new SET NOT NULL;

-- Step 4: Update application to use new column

-- Step 5: Drop old column
ALTER TABLE tbl_users DROP COLUMN email;

-- Step 6: Rename new column
ALTER TABLE tbl_users RENAME COLUMN email_new TO email;
```

## Comments and Documentation

- Add comments to tables, columns, and complex objects
- Document business logic in comments
- Keep comments up to date

```sql
COMMENT ON TABLE tbl_users IS 'Stores user account information';
COMMENT ON COLUMN tbl_users.username IS 'Unique username for login, 3-50 characters';
COMMENT ON COLUMN tbl_users.is_active IS 'False if account is disabled or banned';

COMMENT ON FUNCTION fn_calculate_order_total IS
'Calculates total amount for an order by summing all order items';
```

## Backup and Maintenance

### Regular Maintenance

```sql
-- Analyze tables to update statistics
ANALYZE tbl_users;

-- Vacuum to reclaim space
VACUUM tbl_users;

-- Vacuum analyze (both operations)
VACUUM ANALYZE tbl_users;

-- Reindex to rebuild indexes
REINDEX TABLE tbl_users;
```

### Monitoring

```sql
-- Check table sizes
SELECT
    schemaname,
    tablename,
    pg_size_pretty(pg_total_relation_size(schemaname||'.'||tablename)) AS size
FROM pg_tables
WHERE schemaname = 'public'
ORDER BY pg_total_relation_size(schemaname||'.'||tablename) DESC;

-- Check index usage
SELECT
    schemaname,
    tablename,
    indexname,
    idx_scan,
    pg_size_pretty(pg_relation_size(indexrelid)) AS index_size
FROM pg_stat_user_indexes
ORDER BY idx_scan ASC;
```

## Transaction Management

- Use transactions for multi-statement operations
- Keep transactions short
- Use appropriate isolation levels
- Handle deadlocks in application code

```sql
BEGIN;

INSERT INTO tbl_orders (user_id, total_amount)
VALUES (1, 100.00)
RETURNING id;

INSERT INTO tbl_orders_item (order_id, product_id, quantity)
VALUES (currval('tbl_orders_id_seq'), 123, 2);

COMMIT;

-- Isolation levels
BEGIN ISOLATION LEVEL READ COMMITTED;
-- or
BEGIN ISOLATION LEVEL REPEATABLE READ;
-- or
BEGIN ISOLATION LEVEL SERIALIZABLE;
```
