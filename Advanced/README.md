# The 111 Core Systems, Architecture & DevOps Concepts
## What Separates Vibe Coding from Silicon Valley Principal Engineering

This reference guide categorizes the **111 foundational engineering concepts** represented in the architectural visual guides in this directory. In this DevOps toolkit, these safeguards are enforced automatically behind the scenes across database schemas, Row Level Security (RLS) policies, error boundaries, resilient fetchers, and CI/CD pipelines.

---

### 1. Resiliency, Traffic Management & Distributed Systems (1–19)
1. **Rate Limiting**: Throttling abusive traffic and protecting APIs from noisy neighbors.
2. **Caching**: Memory/Redis caching layers to eliminate redundant backend queries.
3. **Load Balancing**: Distributing traffic evenly across multiple server nodes.
4. **Reverse Proxies**: Gateway servers (e.g. Nginx, Cloudflare) handling TLS termination and routing.
5. **API Gateways**: Unified ingress managing auth, rate limiting, and request transformation.
6. **CI/CD**: Automated integration, testing, and continuous deployment pipelines.
7. **Docker**: Deterministic containerization of runtime environments.
8. **Kubernetes**: Container orchestration, auto-healing, and service mesh management.
9. **Service Discovery**: Dynamic registry allowing microservices to locate each other.
10. **Circuit Breakers**: Halting outgoing requests to failing downstream services to prevent cascade failure.
11. **Timeouts**: Enforcing strict upper bounds on network requests to prevent hung threads.
12. **Retries**: Re-attempting failed idempotent operations automatically.
13. **Exponential Backoff**: Increasing delay intervals between retries with jitter to prevent server stampedes.
14. **Idempotency**: Guaranteeing duplicate requests (e.g. multiple payment clicks) produce only one effect.
15. **Message Queues**: Decoupling long-running tasks asynchronously (e.g. SQS, RabbitMQ, BullMQ).
16. **Pub/Sub**: Publish-subscribe asynchronous message broadcasting.
17. **Event-Driven Architecture**: Decoupled state changes reacting to domain events.
18. **Distributed Transactions**: Coordinating transactions that span multiple databases or services.
19. **Saga Pattern**: Sequence of local transactions with compensating rollbacks for distributed failures.

---

### 2. Database Engineering, Concurrency & Data Integrity (20–41)
20. **Dead Letter Queues (DLQ)**: Isolating failed messages that cannot be processed after maximum retries.
21. **Cron Jobs**: Scheduled background processes (database pruning, digest emails).
22. **WebSockets**: Full-duplex bidirectional streaming connections for live UI.
23. **Long Polling**: Emulated real-time fallback using held HTTP requests.
24. **Server-Sent Events (SSE)**: One-way lightweight server-to-client streaming (ideal for AI tokens).
25. **Database Indexing**: B-tree, GIN, and composite indexes eliminating full-table sequential scans.
26. **Query Optimization**: Analyzing `EXPLAIN ANALYZE` execution plans to minimize buffer reads.
27. **N+1 Queries**: Eliminating redundant iterative fetches via batched joins or `IN (...)` queries.
28. **Connection Pooling**: Reusing database connection handles (e.g. PgBouncer) to prevent connection starvation.
29. **Read Replicas**: Offloading read queries to replica nodes to free primary write masters.
30. **Sharding**: Horizontally partitioning database rows across separate database servers.
31. **Partitioning**: Splitting huge single tables by date, range, or hash for query performance.
32. **Replication**: Synchronous or asynchronous copying of database state across regions.
33. **Leader Election**: Consensus algorithms (Raft, Paxos) picking the primary coordinator node.
34. **CAP Theorem**: Fundamental trade-off between Consistency, Availability, and Partition Tolerance.
35. **Eventual Consistency**: Asynchronous replica convergence in distributed data stores.
36. **Optimistic Locking**: Version-column concurrency checks (`WHERE version = 3`) preventing dirty writes.
37. **Pessimistic Locking**: `SELECT ... FOR UPDATE` explicit row locks during high-contention transactions.
38. **Distributed Locks**: Centralized locking coordination across microservices (e.g. Redlock).
39. **Race Conditions**: Two concurrent processes modifying shared state unpredictably.
40. **Deadlocks**: Mutually blocking resource locks causing execution stalls.
41. **Memory Leaks**: Uncollected object references causing progressive memory exhaustion.

---

### 3. Scaling, Deployments & Observability Foundations (42–59)
42. **Garbage Collection (GC)**: Automatic memory cleanup and GC pause time tuning.
43. **Thread Safety**: Concurrent data structures preventing race conditions across CPU threads.
44. **Backpressure**: Upstream rate dampening when downstream consumers are overwhelmed.
45. **Autoscaling**: Automated CPU/memory-triggered scaling of compute pods.
46. **Horizontal Scaling**: Adding more machines to distribute traffic.
47. **Vertical Scaling**: Increasing CPU, RAM, and IOPS on existing machines.
48. **CDN**: Geographically distributed edge networks caching static assets and API responses.
49. **Edge Caching**: Running cache logic and compute at Cloudflare/Fastly points of presence.
50. **Cache Invalidation**: Strategic cache eviction algorithms (stale-while-revalidate, surrogate keys).
51. **Feature Flags**: Decoupling code deployment from feature release to end users.
52. **Blue-Green Deployment**: Zero-downtime routing between two identical production environments.
53. **Canary Releases**: Rolling new software out to 5% of users to test stability before 100% rollout.
54. **Rolling Deployments**: Sequentially replacing server instances one by one.
55. **Rollbacks**: Automated instant reversal to previous stable release upon metric breach.
56. **Health Checks**: Automated endpoints (`/api/health`) verifying system responsiveness.
57. **Liveness & Readiness Probes**: Kubernetes probes confirming container boot and readiness for traffic.
58: **Monitoring**: Real-time aggregation of server CPU, memory, error rates, and throughput.
59. **Logging**: Structured JSON logging (`level`, `timestamp`, `trace_id`, `message`).

---

### 4. Zero-Trust Security, Auth & Cloud Protection (60–82)
60. **Distributed Tracing**: End-to-end trace propagation (W3C TraceContext) across service calls.
61. **Metrics**: Quantifiable telemetry gauges, counters, and histograms.
62. **Alerts**: PagerDuty/Slack notification rules triggered by error rate thresholds.
63. **SLOs (Service Level Objectives)**: Concrete reliability targets (e.g. 99.9% uptime).
64. **SLIs (Service Level Indicators)**: Real-time measurements quantifying whether an SLO is met.
65. **Error Budgets**: Allowed room for downtime/innovation before feature freezes occur.
66. **Observability**: The ability to infer internal system states from external outputs (Traces, Metrics, Logs).
67. **Secrets Management**: Secure vaulting (Vault, Doppler, AWS KMS) of API keys outside git.
68. **IAM (Identity & Access Management)**: Least-privilege role assignment and service accounts.
69. **OAuth**: Delegated authorization standards for third-party access without password sharing.
70. **JWT Rotation**: Short-lived access tokens combined with rotating secure refresh tokens.
71. **TLS / SSL**: Transport Layer Security encrypting data in transit.
72. **Encryption at Rest**: AES-256 database and block storage volume encryption.
73. **Encryption in Transit**: End-to-end HTTPS/mTLS encryption for inter-service communication.
74. **WAF (Web Application Firewall)**: Edge filtering blocking malicious payloads and bot attacks.
75. **DDoS Protection**: Volumetric attack mitigation (Cloudflare Magic Transit, AWS Shield).
76. **CORS**: Cross-Origin Resource Sharing headers restricting unauthorized browser domain access.
77. **CSRF**: Cross-Site Request Forgery tokens protecting authenticated POST/PUT/DELETE requests.
78. **SQL Injection**: Complete parameterization of SQL queries preventing query escape attacks.
79. **XSS (Cross-Site Scripting)**: Input sanitization (DOMPurify) and output encoding preventing malicious JS injection.
80. **SSRF (Server-Side Request Forgery)**: Validating outgoing server requests to prevent intranet network scans.
81. **Database Migrations**: Version-controlled, deterministic SQL schema migrations (Prisma, Drizzle, Flyway).
82. **Schema Versioning**: Backward-compatible database schema evolution.

---

### 5. High Availability, Networking & Protocols (83–101)
83. **Disaster Recovery (DR)**: Documented recovery protocols (RTO / RPO).
84. **Backups**: Automated daily point-in-time recovery (PITR) snapshots stored offsite.
85. **Failover**: Automated redirecting of traffic to backup nodes upon primary node crash.
86. **Multi-Region Deployment**: Serving users from geographically closest regions with multi-master sync.
87. **Chaos Engineering**: Intentionally injecting failure (Chaos Monkey) to test system resilience.
88. **Cost Optimization**: Right-sizing compute, reserved instances, and caching to eliminate cloud waste.
89. **Cold Starts**: Optimizing serverless function initialization times.
90. **Serverless Limits**: Managing execution duration caps, payload sizes, and connection pools.
91. **Latency**: Round-trip time required for a packet to reach its destination.
92. **Throughput**: Number of concurrent requests or gigabytes processed per second.
93. **P99 Latency**: The slowest 1% of user experiences (the true measure of system tail latency).
94. **Tail Latency**: Long-tail latency spikes caused by garbage collection, lock contention, or network hops.
95. **Network Partitions**: Communication loss between distributed nodes (handled by split-brain rules).
96. **Clock Skew**: Slight time divergence between server clocks (resolved with NTP / TrueTime).
97. **DNS**: Domain Name System resolution, TTL tuning, and Anycast routing.
98. **TCP vs UDP**: Reliable ordered delivery (TCP) vs fast connectionless streaming (UDP).
99. **HTTP/2 & HTTP/3**: Multiplexed single-connection HTTP streaming and QUIC UDP transport.
100. **gRPC**: High-performance, binary protocol buffer RPC framework for inter-service calls.
101. **Webhooks**: Event-driven HTTP POST callbacks with HMAC signature verification.

---

### 6. Platform Engineering, Operations & Reliability Culture (102–111)
102. **API Versioning**: Semantic URI/Header versioning (`/v1`, `/v2`) guaranteeing zero breaking client changes.
103. **Semantic Versioning (SemVer)**: `MAJOR.MINOR.PATCH` dependency release contracts.
104. **Infrastructure as Code (IaC)**: Code-defined cloud infrastructure (Terraform, Pulumi, CloudFormation).
105. **Terraform**: Declarative multi-cloud infrastructure provisioning and state locking.
106. **Helm Charts**: Templated package management for Kubernetes manifests.
107. **Build Caching**: Docker layer caching and remote build caches (Turborepo) accelerating CI.
108. **Dependency Hell**: Managing circular, breaking, or vulnerable package dependency trees.
109. **Production Incidents**: High-severity outages requiring immediate cross-functional triage.
110. **On-Call**: Escalation rosters and paging schedules for 24/7 site reliability engineering.
111. **Postmortems**: Blameless post-incident retrospectives producing concrete preventive action items.
