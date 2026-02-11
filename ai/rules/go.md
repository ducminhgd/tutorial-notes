# Go Development Rules

## Code Style and Formatting

- Always run `gofmt` or `goimports` before committing
- Use tabs for indentation (Go standard)
- Follow official [Effective Go](https://go.dev/doc/effective_go) guidelines
- Use MixedCaps or mixedCaps (camelCase) for multi-word names, not underscores
- Export names start with uppercase, unexported with lowercase
- Keep line length reasonable (80-100 characters when practical)
- Use `gofmt -s` for simplified code formatting

## Naming Conventions

- Use short, concise names (prefer `i` over `index` in loops)
- Interface names: single-method interfaces end in `-er` (Reader, Writer, Formatter)
- Package names: short, lowercase, no underscores or mixedCaps
- Avoid stuttering: `user.UserID` → `user.ID`
- Receivers: 1-2 character abbreviations, consistent within type

```go
type Server struct {
    name string
    port int
}

// Good receiver name
func (s *Server) Start() error {
    // Implementation
}
```

## Project Structure

```
project/
├── cmd/
│   └── myapp/
│       └── main.go
├── internal/
│   ├── handler/
│   ├── service/
│   └── repository/
├── pkg/
│   └── utils/
├── api/
│   └── proto/
├── configs/
├── scripts/
├── docs/
├── go.mod
├── go.sum
├── Makefile
└── README.md
```

- `cmd/`: Application entry points
- `internal/`: Private application code
- `pkg/`: Public library code
- `api/`: API definitions (OpenAPI, protobuf)

## Error Handling

- Always check errors, never ignore them
- Return errors as the last return value
- Use `fmt.Errorf` with `%w` to wrap errors (Go 1.13+)
- Create custom error types for specific cases
- Use `errors.Is()` and `errors.As()` for error checking
- Add context to errors as they bubble up

```go
import (
    "errors"
    "fmt"
)

var ErrNotFound = errors.New("resource not found")

func GetUser(id string) (*User, error) {
    user, err := db.FindUser(id)
    if err != nil {
        return nil, fmt.Errorf("failed to get user %s: %w", id, err)
    }
    if user == nil {
        return nil, ErrNotFound
    }
    return user, nil
}

// Usage
user, err := GetUser("123")
if errors.Is(err, ErrNotFound) {
    // Handle not found case
}
```

## Documentation

- Write godoc comments for all exported types, functions, and constants
- Comments should start with the name being documented
- Use complete sentences with proper punctuation
- Add examples in `_test.go` files using `Example` functions
- Package documentation goes in `doc.go` or package comment

```go
// Server represents an HTTP server instance.
// It manages connections and routes requests to handlers.
type Server struct {
    addr string
    mux  *http.ServeMux
}

// Start begins listening for incoming connections on the configured address.
// It returns an error if the server fails to start.
func (s *Server) Start() error {
    return http.ListenAndServe(s.addr, s.mux)
}
```

## Concurrency

- Use goroutines for concurrent operations
- Always handle goroutine lifecycle and cleanup
- Use channels for communication between goroutines
- Use `sync.WaitGroup` to wait for goroutines to complete
- Use `context.Context` for cancellation and timeouts
- Avoid shared memory; prefer channels
- Use mutexes (`sync.Mutex`) when sharing memory is necessary

```go
func processItems(ctx context.Context, items []Item) error {
    var wg sync.WaitGroup
    errCh := make(chan error, len(items))

    for _, item := range items {
        wg.Add(1)
        go func(item Item) {
            defer wg.Done()
            if err := processItem(ctx, item); err != nil {
                errCh <- err
            }
        }(item)
    }

    wg.Wait()
    close(errCh)

    for err := range errCh {
        if err != nil {
            return err
        }
    }
    return nil
}
```

## Testing

- Write tests in `_test.go` files in the same package
- Test function names: `TestFunctionName` or `TestType_Method`
- Use table-driven tests for multiple test cases
- Use `t.Helper()` for test helper functions
- Use subtests with `t.Run()` for better organization
- Aim for meaningful test names describing what's being tested
- Use `testify/assert` or `testify/require` for assertions (optional)

```go
func TestCalculateAverage(t *testing.T) {
    tests := []struct {
        name     string
        input    []float64
        expected float64
        wantErr  bool
    }{
        {
            name:     "valid numbers",
            input:    []float64{1, 2, 3},
            expected: 2.0,
            wantErr:  false,
        },
        {
            name:     "empty slice",
            input:    []float64{},
            expected: 0,
            wantErr:  true,
        },
    }

    for _, tt := range tests {
        t.Run(tt.name, func(t *testing.T) {
            result, err := CalculateAverage(tt.input)
            if (err != nil) != tt.wantErr {
                t.Errorf("CalculateAverage() error = %v, wantErr %v", err, tt.wantErr)
                return
            }
            if result != tt.expected {
                t.Errorf("CalculateAverage() = %v, want %v", result, tt.expected)
            }
        })
    }
}
```

## Interfaces

- Keep interfaces small (1-3 methods)
- Define interfaces at the point of use, not implementation
- Accept interfaces, return concrete types
- Use empty interface `interface{}` or `any` sparingly

```go
// Good: Small, focused interface
type Reader interface {
    Read(p []byte) (n int, err error)
}

// Consumer defines interface at point of use
func ProcessData(r Reader) error {
    // Implementation
}
```

## Context Usage

- Pass `context.Context` as the first parameter
- Use context for cancellation, deadlines, and request-scoped values
- Don't store contexts in structs; pass them explicitly
- Propagate context through call chains

```go
func FetchData(ctx context.Context, url string) (*Data, error) {
    req, err := http.NewRequestWithContext(ctx, "GET", url, nil)
    if err != nil {
        return nil, err
    }

    resp, err := http.DefaultClient.Do(req)
    if err != nil {
        return nil, err
    }
    defer resp.Body.Close()

    // Process response
}
```

## Dependencies and Modules

- Use Go modules (`go.mod`, `go.sum`)
- Run `go mod tidy` regularly to clean up dependencies
- Use semantic versioning for releases
- Vendor dependencies for critical projects (`go mod vendor`)
- Pin dependency versions in production
- Use `go get -u` to update dependencies

## Best Practices

- Initialize variables at declaration when possible
- Use `:=` for short variable declarations
- Prefer `make()` for slices/maps with known size
- Close resources with `defer` immediately after opening
- Check slice/map bounds before accessing
- Use blank identifier `_` for unused values
- Avoid naked returns in long functions
- Return early to reduce nesting

```go
func ProcessFile(filename string) error {
    f, err := os.Open(filename)
    if err != nil {
        return fmt.Errorf("failed to open file: %w", err)
    }
    defer f.Close()

    // Process file
    data := make([]byte, 0, 1024)
    // ...

    return nil
}
```

## Performance

- Use benchmarks to measure performance (`func BenchmarkXxx`)
- Profile with `pprof` before optimizing
- Preallocate slices when size is known: `make([]T, 0, capacity)`
- Use `sync.Pool` for frequently allocated objects
- Avoid unnecessary allocations in hot paths
- Use `strings.Builder` for string concatenation in loops

```go
func BenchmarkStringConcat(b *testing.B) {
    for i := 0; i < b.N; i++ {
        var sb strings.Builder
        for j := 0; j < 100; j++ {
            sb.WriteString("test")
        }
        _ = sb.String()
    }
}
```

## Code Quality Tools

- Use `gofmt` or `goimports` for formatting
- Use `go vet` for static analysis
- Use `golangci-lint` for comprehensive linting
- Use `staticcheck` for additional checks
- Configure CI/CD to run these tools
- Use `go mod tidy` to verify dependencies

## Security

- Validate and sanitize all inputs
- Use parameterized queries for SQL (prevent injection)
- Use `crypto/rand` for cryptographic randomness
- Keep dependencies updated
- Use `gosec` for security scanning
- Never log sensitive information
- Use HTTPS for network communication

## JSON Handling

- Use struct tags for JSON marshaling/unmarshaling
- Use `omitempty` to omit zero values
- Handle errors from `json.Marshal/Unmarshal`
- Consider using `encoding/json` alternatives for performance (jsoniter, easyjson)

```go
type User struct {
    ID        string    `json:"id"`
    Name      string    `json:"name"`
    Email     string    `json:"email,omitempty"`
    CreatedAt time.Time `json:"created_at"`
}
```

## Database Operations

- Use `database/sql` with appropriate driver
- Use prepared statements for repeated queries
- Always close rows: `defer rows.Close()`
- Handle `sql.ErrNoRows` explicitly
- Use transactions for multiple related operations
- Consider using ORM like GORM for complex applications

```go
func GetUser(db *sql.DB, id string) (*User, error) {
    var user User
    err := db.QueryRow("SELECT id, name, email FROM users WHERE id = $1", id).
        Scan(&user.ID, &user.Name, &user.Email)
    if err == sql.ErrNoRows {
        return nil, ErrNotFound
    }
    if err != nil {
        return nil, fmt.Errorf("query failed: %w", err)
    }
    return &user, nil
}
```

## Logging

- Use structured logging (logrus, zap, zerolog)
- Include context in log messages
- Use appropriate log levels (debug, info, warn, error)
- Don't log sensitive information
- Make logs machine-readable (JSON format)

```go
import "go.uber.org/zap"

logger, _ := zap.NewProduction()
defer logger.Sync()

logger.Info("user created",
    zap.String("user_id", user.ID),
    zap.String("email", user.Email),
)
```
