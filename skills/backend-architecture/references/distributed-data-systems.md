# Distributed Systems & Data Architecture: LLM System Instructions & Guidelines

This document synthesizes core principles, trade-offs, algorithms, and architectural patterns for distributed data systems. It is structured as system-level instructions and design heuristics for Large Language Models (LLMs) to strictly enforce robust distributed data system design, data modeling, storage selection, and consistency reasoning during software architecture and code generation.

---

## 1. Core Architectural Pillars

When designing data-intensive architectures, LLMs must evaluate and balance three fundamental pillars:

### Reliability
- **Definition**: The system must continue to work correctly (performing the desired function at the desired level of performance) even in the face of adversity (hardware/software faults, human error).
- **LLM Rule**: Distinguish between **faults** (a component deviating from spec) and **failures** (the system as a whole stopping work). Design fault-tolerant mechanisms that prevent faults from triggering failures.
- **Human Error Mitigation**: Combine well-designed abstractions, sandbox/staging environments, automated testing, quick rollback capabilities, and detailed telemetry/monitoring.

### Scalability
- **Definition**: The system's ability to cope with increased load without degrading performance.
- **Load Parameters**: Quantify load explicitly (e.g., requests/sec, read:write ratio, active users, hit rate).
- **Performance Metrics**: Use **percentiles** ($p50$, $p95$, $p99$, $p99.9$) rather than averages. High-percentile latency ($p99.9$ / "tail latency") governs customer experience and SLA/SLO compliance.
- **Architecture**: Distinguish between scaling up (vertical) and scaling out (horizontal/shared-nothing). Prefer shared-nothing architectures for massive scale, but avoid premature distribution.

### Maintainability
- **Operability**: Make it easy for operations teams to keep the system running smoothly (visibility, runtime metrics, good defaults).
- **Simplicity (Managing Complexity)**: Use abstraction to eliminate accidental complexity.
- **Evolvability (Extensibility)**: Design for change so future requirements can be added easily.

---

## 2. Data Models & Query Languages

### Model Selection Criteria
- **Relational Model (SQL)**: Best for deep cross-table relationships, many-to-many structures, ACID guarantees, and unknown future query patterns.
- **Document Model (NoSQL)**: Best for self-contained, tree-structured document data with one-to-many relationships and high write throughput. Avoid when deep many-to-many relationships exist (leads to manual join emulation in application code).
- **Graph Model**: Best for highly interconnected data where relationships between entities are as important as entities themselves (e.g., social networks, fraud detection, routing).

### Schema Flexibility & Evolution
- **Schema-on-Write**: Traditional relational databases enforcing explicit constraints at insert time. Preferred for strict data integrity.
- **Schema-on-Read**: Document databases reading raw bytes and interpreting structure dynamically. Equivalent to dynamic typing in code; requires application-level handling of legacy formats.

---

## 3. Storage Engines & Data Access Patterns

LLMs must select and reason about storage engines based on access workloads:

### OLTP vs. OLAP
- **OLTP (Online Transaction Processing)**: High volume of small, key-based reads/writes. Requires low latency, indexing, and row-level access.
- **OLAP (Online Analytics Processing)**: Analytical queries aggregating millions of rows across few columns. Requires column-oriented storage, compression, and vectorized execution.

### Storage Engine Internal Mechanics

#### 1. Log-Structured Merge-Trees (LSM-Trees) / Append-Only
- **Mechanism**: Writes buffer in an in-memory **MemTable** (AVL tree/Splay tree) and WAL, then flush to immutable **SSTables** (Sorted String Tables) on disk. Background compaction merges SSTables.
- **Key Characteristics**: High write throughput (sequential disk writes). Uses **Bloom Filters** to speed up non-existent key lookups.
- **Trade-off**: Higher write amplification during heavy compaction, but faster writes than B-Trees.

#### 2. B-Trees (In-Place Update)
- **Mechanism**: Breaks database into fixed-size pages (typically 4KB) organized in a balanced tree. Updates overwrite existing pages in place; uses Write-Ahead Log (WAL) for crash safety.
- **Key Characteristics**: Fast, predictable key lookups ($O(\log N)$).
- **Trade-off**: High write amplification due to page overwrites and WAL writes.

#### 3. Column-Oriented Storage (Data Warehousing)
- **Mechanism**: Stores values of each column together on disk rather than row-by-row.
- **Optimizations**: Bitmap encoding, run-length encoding, vectorization. Massive compression gains and fast scan times for analytical aggregations.

---

## 4. Encoding & Schema Evolution

### Serialization Formats
- **Textual (JSON, XML, CSV)**: Human-readable, but verbose, ambiguous numbers, and no native binary schema enforcement.
- **Binary Formats (Protocol Buffers, Apache Thrift, Apache Avro)**:
  - Compact, fast parsing, typed.
  - Require explicit field tags/ids or schema definitions.

### Compatibility Mandates
- **Backward Compatibility**: Newer code can read data written by older code.
- **Forward Compatibility**: Older code can read data written by newer code (ignoring new unknown fields).
- **Schema Evolution Rules**:
  - Never change field tag IDs.
  - Only add optional fields or fields with defaults.
  - Remove optional fields; never reuse removed field tag IDs.

---

## 5. Distributed Data: Replication

Replication distributes data across multiple node instances to improve availability, latency, and read throughput.

### Replication Topologies

#### 1. Single-Leader Replication
- Writes go exclusively to the Leader; reads can go to Leader or Followers.
- **Failover**: Requires leader election when leader fails. Beware of split-brain scenarios.

#### 2. Multi-Leader Replication
- Multiple leaders accept writes across data centers.
- **Conflict Resolution**: Writes can conflict concurrently. Must resolve via Last-Write-Wins (LWW - prone to data loss), Conflict-free Replicated Data Types (CRDTs), or Operational Transformation.

#### 3. Leaderless Replication (Dynamo-Style)
- Clients send reads/writes to multiple replicas ($N$).
- **Quorum Rules**: $W + R > N$ (Write quorum $W$, Read quorum $R$, Replicas $N$).
- **Read Repair / Anti-Entropy**: Background processes repair stale replicas using version vectors.

### Replication Lag Guarantees
- **Read-After-Write Consistency**: Users must always see their own updates (e.g., read user's own profile from leader).
- **Monotonic Reads**: Users will never see time go backward (ensure consecutive reads go to the same replica or leader).
- **Consistent Prefix Reads**: Preserves causal ordering of dependent writes.

---

## 6. Distributed Data: Partitioning (Sharding)

Partitioning breaks massive datasets into smaller subsets assigned to specific nodes.

### Partitioning Strategies
- **Key Range Partitioning**: Sorts keys sequentially. Enables fast range queries, but prone to hot spots if access is skewed (e.g., timestamp keys).
- **Hash Partitioning**: Hashes keys to distribute writes uniformly across partitions. Eliminates hot spots, but destroys range query performance.

### Secondary Index Partitioning
- **Document-Partitioned (Local Index)**: Each partition indexes only its own documents. Writes are fast; reads require **Scatter-Gather** across all partitions.
- **Term-Partitioned (Global Index)**: Index is partitioned globally across nodes by term. Reads are fast (single partition target); writes require multi-partition updates.

---

## 7. Transactions & Isolation Levels

Transactions group multiple operations into a single logical execution unit to prevent concurrency anomalies.

### ACID Definition
- **Atomicity**: All-or-nothing execution.
- **Consistency**: Maintaining application-specific invariants (e.g., balance $\ge 0$).
- **Isolation**: Concurrent transactions execute as if running serially.
- **Durability**: Committed data will not be lost.

### Concurrency Race Conditions & Isolation Hierarchy

| Race Condition | Description | Minimum Isolation Level Required |
| :--- | :--- | :--- |
| **Dirty Read** | Transaction reads uncommitted writes from another transaction. | Read Committed |
| **Dirty Write** | Transaction overwrites uncommitted writes from another transaction. | Read Committed |
| **Read Skew (Non-repeatable Read)** | Client sees different state at different points in same transaction. | Snapshot Isolation / Repeatable Read |
| **Lost Update** | Two concurrent read-modify-write cycles overwrite each other's changes. | Atomic Operations / Compare-and-Swap / Explicit Locks / Repeatable Read |
| **Write Skew** | Concurrent transactions read same state, make conflicting decisions, and write disjoint rows. | Serializable Isolation |
| **Phantom Read** | A write in one transaction changes the search condition result of another transaction. | Serializable Isolation (Predicate Locks) |

### Serializability Implementation Mechanics
1. **Actual Serial Execution**: Single-threaded execution loop (e.g., Redis, VoltDB). Requires short transactions held entirely in-memory.
2. **Two-Phase Locking (2PL)**: Shared locks for reads, exclusive locks for writes. High overhead; prone to deadlocks.
3. **Serializable Snapshot Isolation (SSI)**: Optimistic concurrency control. Tracks dependencies; aborts transactions on conflict at commit time.

---

## 8. Distributed Systems Realities & Consensus

Distributed systems operate in asynchronous networks subject to node crashes, message loss, network partitions, and clock drift.

### The Trouble with Distributed Systems
- **Unreliable Networks**: Packets can be delayed, duplicated, reordered, or dropped. Unbounded network latency means timeouts cannot distinguish between a dead node and a slow node.
- **Unreliable Clocks**: Wall-clock time (NTP) drifts and can jump backward. **Never use wall-clock timestamps for causality or total ordering** (e.g., LWW leads to silent data loss). Use monotonic clocks for duration measurement and logical clocks (Lamport/Vector clocks) for causality tracking.
- **Process Pauses**: Garbage collection (GC) pauses, VM suspension, or page faults can stall execution for seconds, invalidating leases and locks. Use **Fencing Tokens** (monotonically increasing IDs) to validate lock ownership at storage endpoints.

### Linearizability vs. Serializability
- **Serializability**: A multi-operation transaction property ensuring concurrent transactions execute as if strictly sequential.
- **Linearizability**: A single-operation, real-time freshness guarantee on single objects (reads return the latest written value immediately).
- **CAP Theorem**: In the presence of a Network Partition ($P$), a system must choose between Availability ($A$) or Linearizable Consistency ($C$).

### Consensus Algorithms
- **Goal**: Getting multiple nodes to agree on a single value or sequence of decisions (Total Order Broadcast).
- **Algorithms**: Paxos, Raft, Zab, Viewstamped Replication.
- **Consensus Primitives**: Used for leader election, distributed locking, service discovery, and atomic state machine replication.
- **Two-Phase Commit (2PC)**: Distributed transaction protocol across heterogeneous systems. Uses a Coordinator; blocks indefinitely if coordinator crashes during commit phase.

---

## 9. Derived Data: Batch & Stream Processing

### Batch Processing (UNIX Philosophy for Big Data)
- **MapReduce / Hadoop / Spark**: Process bounded, immutable datasets offline.
- **Determinism & Immutability**: Input data is read-only. Failed tasks can be re-executed safely without side effects.
- **Joins**: Sort-Merge Joins, Broadcast Hash Joins, Map-Side Joins.

### Stream Processing
- **Unbounded Streams**: Processing continuous streams of events in near-real-time.
- **Messaging Engines**:
  - **AMQP / JMS (RabbitMQ)**: Message broker delivering messages individually; deletes upon ACK.
  - **Log-based Message Brokers (Kafka, Apache Pulsar)**: Append-only disk log. Allows independent consumer offset tracking, replayability, and linear scalability.
- **Change Data Capture (CDC)**: Extracting database write logs as a continuous event stream to update search indexes, caches, and analytics stores asynchronously.
- **Event Sourcing**: Storing all application changes as an append-only sequence of domain events rather than mutating state directly.

### Time & Processing Guarantees
- **Event Time vs. Processing Time**: Always frame windowed operations (tumbling, sliding, session) around **Event Time** (when the event occurred) rather than Processing Time (when the server saw it). Handle late-arriving data using **Watermarks**.
- **Exactly-Once Semantics**: Achieved through **idempotent operations** combined with atomic state updates (e.g., transactional offsets in Kafka/Flink).

---

## 10. Architectural Checklist for LLM System Generation

When evaluating or generating data system designs, verify:

- [ ] Is the storage engine choice matched to the workload (LSM-Tree for write-heavy OLTP, B-Tree for read-heavy OLTP, Column-Store for OLAP)?
- [ ] Does the schema design support backward and forward evolution without breaking active clients?
- [ ] Are replication conflict strategies explicitly defined (LWW vs CRDT vs application handling)?
- [ ] Are read/write quorums ($W + R > N$) verified for leaderless replication topologies?
- [ ] Is the isolation level specified, and are race conditions (write skew, phantom reads) guarded against?
- [ ] Are distributed locks secured using monotonically increasing **Fencing Tokens**?
- [ ] Are wall-clock timestamps excluded from critical causality/ordering logic?
- [ ] Are stream processing pipelines designed around **Event Time** with explicit watermark strategies for late data?
- [ ] Are external side-effect operations idempotent to guarantee effectively-once execution?
