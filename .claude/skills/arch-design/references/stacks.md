# Tech Stack Reference — Opinionated Defaults by Domain

## Backend Services

### Go (Primary — high-concurrency services, APIs, gateways)
| Layer | Choice | Notes |
|-------|--------|-------|
| HTTP Framework | `chi` or `gin` | chi for minimalism, gin for batteries-included |
| gRPC | `google.golang.org/grpc` | for internal service communication |
| ORM / DB | `sqlx` + raw SQL or `ent` | avoid heavy ORMs for performance-sensitive paths |
| Migrations | `golang-migrate` | simple, file-based |
| Config | `viper` | env + file based config |
| Validation | `go-playground/validator` | struct tag validation |
| Logging | `zap` (structured) | fast, zero-allocation |
| Testing | `testify` + `mockery` | mocking via interfaces |
| DI | manual / `wire` | prefer manual for clarity |

### Python (AI/ML/Data — FastAPI services, pipelines)
| Layer | Choice | Notes |
|-------|--------|-------|
| Framework | `FastAPI` | async, OpenAPI out of the box |
| ORM | `Tortoise ORM` + `Aerich` | async-first; or SQLAlchemy 2.0 + Alembic for complex cases |
| Validation | `Pydantic v2` | built into FastAPI |
| Config | `pydantic-settings` | env-based config with type safety |
| Logging | `structlog` | structured logging |
| Testing | `pytest` + `httpx` | async-friendly test client |
| Package mgmt | `uv` | fast, modern Python package manager |
| AI/LLM | `LangChain` / `LangGraph` | for RAG, agents, pipelines |
| Vector DB client | `qdrant-client` / `pgvector` | Qdrant for standalone, pgvector for Postgres-native |

---

## Databases

| Use Case | Choice | Notes |
|----------|--------|-------|
| Primary relational | PostgreSQL 16+ | default for all transactional data |
| Cache / session | Valkey (Redis-compatible) | prefer over Redis for open-source compliance |
| Vector search | Qdrant | purpose-built, fast, good Python client |
| Vector (embedded) | pgvector extension | if already on Postgres, reduces infra complexity |
| Time-series | TimescaleDB or InfluxDB | for metrics/events if Prometheus isn't enough |
| Columnar / analytics | Trino + Apache Iceberg | for data lake queries at scale |
| Message queue | RabbitMQ (simple) / Kafka (high-throughput) | RabbitMQ for ERP workflows, Kafka for event streaming |

---

## Data Platform (Medallion Architecture)

| Layer | Choice | Notes |
|-------|--------|-------|
| Storage | AWS S3 / MinIO (self-hosted) | prefix-based multi-tenant isolation |
| Table format | Apache Iceberg | ACID, time-travel, schema evolution |
| Query engine | Trino | federated SQL across Iceberg + Postgres |
| Orchestration | Apache Airflow | DAG-based pipelines; or Prefect for lighter footprint |
| Streaming ingestion | Kafka + Kafka Connect | CDC from Postgres via Debezium |
| Transformation | dbt | SQL-based, tested transformations for silver/gold layers |

---

## AI / ML Stack

| Component | Choice | Notes |
|-----------|--------|-------|
| LLM provider | Anthropic Claude / OpenAI GPT-4o | Claude for reasoning/code, GPT-4o for general |
| Orchestration | LangGraph | stateful agent workflows, better than LangChain for complex flows |
| Embeddings | `sentence-transformers` / OpenAI `text-embedding-3` | local model for privacy, OpenAI for quality |
| Vector store | Qdrant | best balance of performance + features |
| Hybrid search | BM25 (rank-bm25) + vector | combine for better RAG retrieval |
| Reranking | `cross-encoder/ms-marco` | rerank top-k results before LLM |
| Text-to-SQL | LangChain SQL agent or custom prompt chain | always validate output SQL before execution |

---

## Frontend

| Layer | Choice | Notes |
|-------|--------|-------|
| Framework | Next.js (App Router) | SSR + SSG + API routes |
| Language | TypeScript | always, no plain JS |
| State mgmt | Zustand (simple) / React Query (server state) | avoid Redux for new projects |
| UI components | shadcn/ui + Tailwind CSS | composable, unstyled base |
| Forms | React Hook Form + Zod | type-safe validation |
| Module Federation | Webpack 5 / Vite plugin | for micro-frontend / plugin architecture |
| Build | Vite (apps) / Turbopack (Next.js) | |

---

## Infrastructure & DevOps

| Component | Choice | Notes |
|-----------|--------|-------|
| Container runtime | Docker | standard |
| Orchestration | Kubernetes (K8s) | production; Docker Compose for local dev |
| CI/CD | GitHub Actions (cloud) / Jenkins (on-prem) | |
| Code quality | SonarQube + SARIF | static analysis, security findings |
| Security scanning | Trivy | container + IaC scanning, SARIF output |
| Secrets | HashiCorp Vault / K8s Secrets | Vault for production |
| Observability | Prometheus + Grafana + Loki | metrics, dashboards, logs |
| Tracing | OpenTelemetry + Jaeger/Tempo | distributed tracing |
| API Gateway | Kong / Nginx / Traefik | depends on K8s ingress needs |
| Service mesh | Linkerd (lightweight) / Istio (full-featured) | only if cross-service security/observability needed |

---

## Architecture Patterns — When to Use What

| Pattern | Use When | Avoid When |
|---------|----------|------------|
| **Modular Monolith** | Team < 10, complex domain, early stage | High independent scaling needs per module |
| **Microservices** | Independent deployment needed, team > 20 | Small team, tight coupling between domains |
| **Event-Driven** | Async workflows, audit trails, decoupling needed | Simple CRUD apps |
| **CQRS** | Read/write load significantly different | Low-traffic apps |
| **Hexagonal / Clean Architecture** | Long-lived codebase, multiple adapters needed | Simple scripts, small tools |
| **Saga Pattern** | Distributed transactions across services | Single-DB transactions (use DB transactions instead) |
| **Plugin / Extension System** | Multi-tenant customization, modular ERP | Tight single-customer products |