# Redis Development Rules

## Key Naming Conventions

### General Format

**Format:** `<namespace>:<entity>:<identifier>[:<field>]`

- Use colons (`:`) as separators (Redis convention)
- Use lowercase with underscores for multi-word components
- Be consistent and descriptive
- Keep keys reasonably short to save memory

```redis
# Good examples
user:1000:profile
user:1000:sessions
product:5432:inventory
cache:api:user:1000
queue:email:pending
counter:page_views:homepage
lock:order:processing:5678
```

### Namespace Prefixes

Use consistent namespace prefixes to organize keys:

```redis
# Application/service namespace
app:user:1000
api:cache:endpoint:/users/list
worker:queue:email

# Environment-specific
prod:user:1000
staging:user:1000
dev:user:1000

# Feature-specific
auth:session:abc123
cart:user:1000
search:index:products
```

### Entity Types

Indicate entity type in key name:

```redis
# Users
user:1000                    # User hash
user:1000:profile           # User profile data
user:1000:settings          # User settings
user:1000:sessions          # User active sessions (set)
user:1000:activity          # User activity log (list)

# Products
product:5432                # Product hash
product:5432:views          # View counter
product:5432:ratings        # Rating sorted set
product:5432:reviews        # Review list

# Caching
cache:user:1000             # Cached user data
cache:api:/users/1000       # Cached API response
cache:query:hash123         # Cached database query

# Sessions
session:abc123def456        # Session data hash
session:user:1000           # User's active sessions

# Queues
queue:email:high            # High priority email queue
queue:email:low             # Low priority email queue
queue:jobs:pending          # Pending job queue

# Locks
lock:user:1000              # User lock
lock:order:5432             # Order processing lock
lock:resource:file123       # Resource lock

# Counters
counter:page_views          # Global page view counter
counter:user:1000:logins    # User login counter
counter:api:rate_limit:ip:1.2.3.4  # Rate limit counter

# Sets
set:users:active            # Set of active user IDs
set:tags:popular            # Set of popular tags
set:followers:user:1000     # User's followers

# Sorted Sets
zset:leaderboard:global     # Global leaderboard
zset:timeline:user:1000     # User timeline with scores
zset:products:trending      # Trending products by score

# Lists
list:notifications:user:1000  # User notifications
list:logs:application         # Application logs
list:queue:tasks              # Task queue

# Bitmaps
bitmap:online:2024-02-11    # Online users on specific date
bitmap:features:user:1000    # User feature flags

# HyperLogLog
hll:unique_visitors:2024-02  # Unique visitors count
hll:unique_ips:today         # Unique IP addresses

# Geospatial
geo:drivers:available        # Available driver locations
geo:stores:all               # Store locations

# Streams
stream:events:user_actions   # Stream of user actions
stream:logs:application      # Application log stream
```

### Temporary Keys

Add expiration indicator for temporary keys:

```redis
temp:otp:user:1000           # Temporary OTP
temp:token:reset:abc123      # Temporary reset token
ttl:cache:user:1000          # Cache with TTL
session:temp:guest:xyz       # Temporary guest session
```

## Data Structure Selection

### String

**Use for:** Simple values, counters, cache, flags

```redis
# Simple value
SET user:1000:email "user@example.com"

# Counter
INCR counter:page_views
INCRBY counter:downloads 5

# Cache with expiration
SETEX cache:api:/users/1000 3600 '{"id":1000,"name":"John"}'

# Atomic flag
SET lock:order:5432 "locked" EX 30 NX

# Bit operations (space-efficient flags)
SETBIT bitmap:online:20240211 1000 1  # User 1000 is online
GETBIT bitmap:online:20240211 1000

# Binary data
SET file:image:123 <binary_data>
```

**Best Practices:**
- Use SETEX/SET with EX for automatic expiration
- Use INCR/DECR for atomic counters
- Use SET with NX for distributed locks
- Consider memory: strings have 40+ bytes overhead

### Hash

**Use for:** Objects with multiple fields, structured data

```redis
# User object
HSET user:1000 name "John Doe" email "john@example.com" age 30
HMSET user:1000 name "John Doe" email "john@example.com" age 30
HGETALL user:1000

# Product details
HSET product:5432 name "Laptop" price 999.99 stock 50 category "electronics"
HINCRBY product:5432 stock -1  # Decrement stock

# Session data
HSET session:abc123 user_id 1000 ip "1.2.3.4" created_at 1707654321
EXPIRE session:abc123 3600

# Configuration
HSET config:app:prod db_host "localhost" db_port 5432 cache_ttl 3600
```

**Best Practices:**
- Use for objects with multiple fields (more memory efficient than multiple strings)
- Field names should be short but descriptive
- Use HINCRBY for atomic field increments
- Consider hash-max-ziplist-entries and hash-max-ziplist-value configs
- Ideal for 100-1000 fields per hash

### List

**Use for:** Queues, logs, timelines, recent items

```redis
# Queue (FIFO)
LPUSH queue:email:pending "email1@example.com"
RPOP queue:email:pending

# Stack (LIFO)
LPUSH stack:undo:user:1000 "action1"
LPOP stack:undo:user:1000

# Timeline/Feed
LPUSH timeline:user:1000 "post:123"
LRANGE timeline:user:1000 0 9  # Get 10 most recent

# Capped list (keep only N recent items)
LPUSH logs:application "log entry"
LTRIM logs:application 0 999  # Keep only 1000 entries

# Blocking queue (for worker patterns)
BRPOP queue:tasks 30  # Block for 30 seconds waiting for task
```

**Best Practices:**
- LPUSH + LTRIM for capped lists (recent items)
- LPUSH + RPOP for queue (FIFO)
- LPUSH + LPOP for stack (LIFO)
- BRPOP/BLPOP for blocking consumer pattern
- Use LRANGE for pagination
- Lists can hold up to 2^32 - 1 elements

### Set

**Use for:** Unique items, tags, membership tests, set operations

```redis
# Tags
SADD tags:product:5432 "electronics" "laptop" "gaming"
SMEMBERS tags:product:5432
SISMEMBER tags:product:5432 "laptop"  # O(1) membership check

# Followers/Following
SADD followers:user:1000 2000 3000 4000
SCARD followers:user:1000  # Count followers
SINTER followers:user:1000 followers:user:2000  # Mutual followers

# Online users
SADD online:users 1000 2000 3000
SISMEMBER online:users 1000

# Unique visitors (for small sets)
SADD visitors:page:home "ip:1.2.3.4"
SCARD visitors:page:home

# Set operations
SUNION set:users:premium set:users:trial  # All premium or trial users
SDIFF set:users:all set:users:active      # Inactive users
SINTER set:users:active set:users:premium # Active premium users
```

**Best Practices:**
- Use for uniqueness enforcement
- Efficient membership testing: O(1)
- Use SINTER, SUNION, SDIFF for complex queries
- Store only necessary data (IDs, not full objects)
- For large sets, consider sorted sets for range queries

### Sorted Set (ZSet)

**Use for:** Leaderboards, ranked lists, priority queues, time series

```redis
# Leaderboard
ZADD leaderboard:global 1500 "user:1000" 2000 "user:2000"
ZREVRANGE leaderboard:global 0 9 WITHSCORES  # Top 10
ZRANK leaderboard:global "user:1000"  # Get rank
ZINCRBY leaderboard:global 100 "user:1000"  # Add points

# Priority queue
ZADD queue:tasks:priority 10 "task:high" 5 "task:medium" 1 "task:low"
ZPOPMIN queue:tasks:priority  # Get highest priority task

# Time-based data (using timestamp as score)
ZADD timeline:user:1000 1707654321 "post:123"
ZRANGEBYSCORE timeline:user:1000 1707654000 1707654999  # Posts in time range
ZREMRANGEBYSCORE timeline:user:1000 0 1707650000  # Remove old posts

# Trending items (score = view count or trending score)
ZADD trending:products 1500 "product:123" 2000 "product:456"
ZREVRANGE trending:products 0 9  # Top 10 trending

# Rate limiting (sliding window)
ZADD rate_limit:user:1000 1707654321 "req:1"
ZCOUNT rate_limit:user:1000 1707654261 1707654321  # Count in last 60s
ZREMRANGEBYSCORE rate_limit:user:1000 0 1707654261  # Remove old entries

# Geospatial (internally uses sorted set)
GEOADD geo:drivers 13.361389 38.115556 "driver:1000"
GEORADIUS geo:drivers 15 37 200 km
```

**Best Practices:**
- Score should be numeric (timestamp, count, priority)
- Use ZREMRANGEBYSCORE to clean up old entries
- ZRANGE/ZREVRANGE for top-N queries
- Combine with TTL for automatic cleanup
- Memory efficient for millions of elements

### Bitmap

**Use for:** Space-efficient boolean flags, user activity tracking

```redis
# Daily active users (bit index = user_id)
SETBIT active:users:2024-02-11 1000 1  # User 1000 active
GETBIT active:users:2024-02-11 1000
BITCOUNT active:users:2024-02-11  # Count active users

# Feature flags per user
SETBIT features:user:1000 0 1  # Enable feature 0
SETBIT features:user:1000 5 1  # Enable feature 5
GETBIT features:user:1000 0    # Check if feature 0 enabled

# Bit operations
BITOP AND result active:2024-02-11 active:2024-02-10  # Users active both days
BITOP OR result active:2024-02-11 active:2024-02-10   # Users active either day
BITCOUNT result
```

**Best Practices:**
- Extremely memory efficient (1 bit per flag)
- Use for large-scale boolean tracking
- User ID should be numeric and not too sparse
- BITCOUNT for analytics
- Max size: 512 MB (2^32 bits)

### HyperLogLog

**Use for:** Cardinality estimation (unique count) with minimal memory

```redis
# Unique visitors
PFADD visitors:page:home "ip:1.2.3.4"
PFADD visitors:page:home "ip:5.6.7.8"
PFCOUNT visitors:page:home  # Approximate unique count (0.81% error)

# Unique users across pages
PFMERGE visitors:all visitors:page:home visitors:page:about
PFCOUNT visitors:all

# Daily unique visitors
PFADD unique:visitors:2024-02-11 "user:1000" "user:2000"
PFCOUNT unique:visitors:2024-02-11
```

**Best Practices:**
- Only 12 KB per key (fixed size)
- 0.81% standard error
- Use when approximate count is acceptable
- Perfect for analytics on large datasets
- Cannot retrieve individual elements

### Stream

**Use for:** Event logs, message queues, time-series data

```redis
# Add events
XADD stream:events:user_actions * user_id 1000 action "login" timestamp 1707654321
XADD stream:logs:app * level "error" message "Connection failed"

# Read events
XRANGE stream:events:user_actions - +  # All events
XREVRANGE stream:events:user_actions + - COUNT 10  # Last 10 events

# Consumer groups (for reliable message processing)
XGROUP CREATE stream:tasks:processing mygroup $ MKSTREAM
XREADGROUP GROUP mygroup consumer1 COUNT 10 STREAMS stream:tasks:processing >

# Trim old events
XTRIM stream:logs:app MAXLEN 10000  # Keep only 10k entries
```

**Best Practices:**
- Use for append-only event logs
- Consumer groups for distributed processing
- Automatic message acknowledgment
- Use MAXLEN to prevent unbounded growth
- Better than lists for message queues with multiple consumers

## Expiration and TTL

### Setting Expiration

```redis
# Set with expiration (seconds)
SETEX cache:user:1000 3600 '{"id":1000}'
SET cache:user:1000 '{"id":1000}' EX 3600

# Set with expiration (milliseconds)
SET cache:user:1000 '{"id":1000}' PX 3600000

# Add expiration to existing key
EXPIRE user:session:abc123 3600
EXPIREAT user:session:abc123 1707654321  # Unix timestamp

# Check TTL
TTL cache:user:1000  # Returns remaining seconds (-1 = no expiry, -2 = not exists)

# Remove expiration
PERSIST cache:user:1000
```

### Expiration Best Practices

```redis
# Always set TTL for cache
SETEX cache:api:/users/1000 300 '{"data":"..."}'

# Session with sliding expiration
MULTI
HGETALL session:abc123
EXPIRE session:abc123 1800  # Reset to 30 minutes
EXEC

# Temporary locks with auto-release
SET lock:order:5432 "locked" EX 30 NX

# Different TTLs for different data types
SETEX cache:hot:user:1000 300 '...'     # 5 minutes for hot data
SETEX cache:cold:user:1000 3600 '...'   # 1 hour for cold data
```

## Caching Patterns

### Cache-Aside (Lazy Loading)

```python
def get_user(user_id):
    # Try cache first
    cache_key = f"cache:user:{user_id}"
    cached = redis.get(cache_key)

    if cached:
        return json.loads(cached)

    # Cache miss: fetch from database
    user = db.query("SELECT * FROM users WHERE id = ?", user_id)

    # Store in cache
    redis.setex(cache_key, 3600, json.dumps(user))

    return user
```

### Write-Through Cache

```python
def update_user(user_id, data):
    # Update database
    db.update("UPDATE users SET ... WHERE id = ?", user_id, data)

    # Update cache immediately
    cache_key = f"cache:user:{user_id}"
    redis.setex(cache_key, 3600, json.dumps(data))
```

### Write-Behind (Write-Back) Cache

```python
def update_user(user_id, data):
    # Update cache immediately
    cache_key = f"cache:user:{user_id}"
    redis.setex(cache_key, 3600, json.dumps(data))

    # Queue for async database write
    redis.lpush("queue:db_writes", json.dumps({
        "user_id": user_id,
        "data": data
    }))
```

### Cache Stampede Prevention

```redis
# Use distributed lock to prevent multiple DB queries
SET lock:cache:user:1000 "locked" EX 10 NX

# Or use early expiration marker
SET cache:user:1000:computing "true" EX 5 NX
```

## Performance Best Practices

### Pipeline Commands

```python
# Bad: Multiple round trips
for i in range(1000):
    redis.set(f"key:{i}", value)

# Good: Single round trip with pipeline
pipe = redis.pipeline()
for i in range(1000):
    pipe.set(f"key:{i}", value)
pipe.execute()
```

### Use Transactions for Atomicity

```redis
# MULTI/EXEC for atomic operations
MULTI
HINCRBY product:5432 stock -1
LPUSH order:queue order:999
EXEC

# Conditional transaction with WATCH
WATCH product:5432
stock = HGET product:5432 stock
if stock > 0:
    MULTI
    HINCRBY product:5432 stock -1
    EXEC
```

### Lua Scripts for Complex Operations

```redis
-- Atomic rate limiting
local key = KEYS[1]
local limit = tonumber(ARGV[1])
local window = tonumber(ARGV[2])
local current = tonumber(redis.call('GET', key) or "0")

if current >= limit then
    return 0
else
    redis.call('INCR', key)
    if current == 0 then
        redis.call('EXPIRE', key, window)
    end
    return 1
end
```

```python
# Execute Lua script
rate_limit_script = redis.register_script(lua_script)
allowed = rate_limit_script(keys=['rate:user:1000'], args=[100, 60])
```

### Memory Optimization

```redis
# Use hashes for objects (more memory efficient)
# Bad: 1000 separate keys
SET user:1000:name "John"
SET user:1000:email "john@example.com"
SET user:1000:age "30"

# Good: Single hash
HSET user:1000 name "John" email "john@example.com" age 30

# Use ziplist encoding for small hashes/lists
CONFIG SET hash-max-ziplist-entries 512
CONFIG SET hash-max-ziplist-value 64

# Compression for large values
# Store compressed data in application layer before setting

# Use short key names in production
# cache:u:1000 instead of cache:user:1000
```

### Avoid Slow Commands

```redis
# Avoid on large datasets (O(N) complexity)
KEYS pattern:*  # Use SCAN instead
SMEMBERS large:set  # Use SSCAN instead
HGETALL large:hash  # Use HSCAN instead

# Use SCAN family for iteration
SCAN 0 MATCH user:* COUNT 100
SSCAN set:users 0 COUNT 100
HSCAN user:1000 0 COUNT 100
```

## Security Best Practices

### Authentication and Authorization

```redis
# Require password
requirepass yourStrongPasswordHere

# Use ACL (Redis 6+)
ACL SETUSER app_user on >password ~cache:* +get +set +del
ACL SETUSER readonly_user on >password ~* +get +info

# Disable dangerous commands
rename-command FLUSHDB ""
rename-command FLUSHALL ""
rename-command CONFIG "CONFIG_abc123"
```

### Network Security

```redis
# Bind to specific interface
bind 127.0.0.1 ::1

# Enable TLS/SSL
tls-port 6379
tls-cert-file /path/to/redis.crt
tls-key-file /path/to/redis.key
tls-ca-cert-file /path/to/ca.crt

# Disable dangerous commands in production
rename-command FLUSHDB ""
rename-command FLUSHALL ""
rename-command KEYS ""
rename-command DEBUG ""
```

### Input Validation

```python
# Always validate input before using in Redis keys
def get_user_cache(user_id):
    # Validate user_id is numeric
    if not isinstance(user_id, int) or user_id < 1:
        raise ValueError("Invalid user_id")

    return redis.get(f"cache:user:{user_id}")

# Avoid key injection
# Bad: f"cache:{untrusted_input}"
# Good: f"cache:user:{sanitized_id}"
```

## Persistence Configuration

### RDB (Snapshotting)

```redis
# Save to disk every 60 seconds if at least 1000 keys changed
save 60 1000
save 300 100
save 900 1

# Disable RDB if you only need cache
save ""
```

### AOF (Append-Only File)

```redis
# Enable AOF
appendonly yes
appendfilename "appendonly.aof"

# Fsync policy
appendfsync everysec  # Good balance (default)
# appendfsync always  # Slower but safer
# appendfsync no      # Faster but less safe

# AOF rewrite
auto-aof-rewrite-percentage 100
auto-aof-rewrite-min-size 64mb
```

### Hybrid Persistence

```redis
# Use RDB + AOF (Redis 4+)
save 900 1
appendonly yes
aof-use-rdb-preamble yes  # Fast load + AOF durability
```

## Monitoring and Debugging

### Key Commands

```redis
# Get information
INFO stats
INFO memory
INFO replication

# Monitor commands in real-time
MONITOR  # Use with caution in production

# Slow log
SLOWLOG GET 10
CONFIG SET slowlog-log-slower-than 10000  # 10ms

# Check memory usage
MEMORY USAGE key:name
MEMORY STATS

# Debug object
DEBUG OBJECT key:name

# Find large keys
redis-cli --bigkeys

# Scan all keys matching pattern
SCAN 0 MATCH cache:* COUNT 1000
```

## Distributed Patterns

### Distributed Lock

```python
import uuid
import time

def acquire_lock(key, timeout=10):
    lock_id = str(uuid.uuid4())
    end = time.time() + timeout

    while time.time() < end:
        if redis.set(key, lock_id, ex=timeout, nx=True):
            return lock_id
        time.sleep(0.001)

    return None

def release_lock(key, lock_id):
    # Lua script for atomic check and delete
    script = """
    if redis.call("GET", KEYS[1]) == ARGV[1] then
        return redis.call("DEL", KEYS[1])
    else
        return 0
    end
    """
    return redis.eval(script, 1, key, lock_id)
```

### Rate Limiting

```python
def rate_limit(user_id, limit=100, window=60):
    key = f"rate:user:{user_id}"
    pipe = redis.pipeline()

    # Increment counter
    pipe.incr(key)
    pipe.expire(key, window)

    result = pipe.execute()
    current = result[0]

    return current <= limit
```

### Pub/Sub

```redis
# Publisher
PUBLISH channel:notifications "New message"

# Subscriber
SUBSCRIBE channel:notifications
PSUBSCRIBE channel:*  # Pattern subscription
```

```python
# Python subscriber
pubsub = redis.pubsub()
pubsub.subscribe('channel:notifications')

for message in pubsub.listen():
    if message['type'] == 'message':
        print(message['data'])
```

## Anti-Patterns to Avoid

### Don't Do This

```redis
# ❌ Using KEYS in production
KEYS user:*  # Blocks entire server
# ✅ Use SCAN instead
SCAN 0 MATCH user:* COUNT 100

# ❌ Large values in single key
SET large:object <10MB of data>
# ✅ Break into smaller chunks or use hash

# ❌ No expiration on cache
SET cache:user:1000 '{"data":"..."}'
# ✅ Always set TTL
SETEX cache:user:1000 3600 '{"data":"..."}'

# ❌ Using Redis as primary database without persistence
# ✅ Enable AOF or RDB for persistence

# ❌ Storing passwords in plain text
HSET user:1000 password "plaintext"
# ✅ Hash passwords before storing

# ❌ Too many small keys
SET user:1000:name "John"
SET user:1000:email "john@example.com"
# ✅ Use hash instead
HSET user:1000 name "John" email "john@example.com"
```
