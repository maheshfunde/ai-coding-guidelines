---
name: backend-architecture
description: Use when designing backend services, REST/gRPC APIs, database schemas, applying Clean Architecture or SOLID principles, setting up TDD with walking skeletons, writing idiomatic Java/Spring Boot code, or architecting distributed systems for reliability, replication, and concurrency.
---

# Backend Engineering & Architecture Master Guide

## Overview
A comprehensive engineering standard synthesizing clean code craftsmanship, layered architectural boundaries, distributed data systems, object-oriented design patterns, test-driven development, and cloud-native application frameworks.

---

## When to Use
- Designing service boundaries, domain models, or clean architectural layers
- Structuring REST, gRPC, or messaging APIs and data schemas
- Applying TDD (Outside-In with Walking Skeleton) before writing feature code
- Writing maintainable, robust Java, Kotlin, or Spring Boot applications
- Evaluating data storage engines, caching layers, replication, or partitioning strategies
- Managing database transaction isolation levels, concurrency locks, and idempotency

**When NOT to use:**
- Pure frontend styling, layout design, or UI color decisions (use `ui-ux-design` instead).

---

## Core Principles & Architectural Frameworks

### 1. Architectural Layers & Boundaries
- **The Dependency Rule**: Source code dependencies must point **strictly inward** toward higher-level policies:
  ```
  [Frameworks & Drivers] → [Interface Adapters] → [Application Use Cases] → [Domain Entities]
  ```
- **Independent of Frameworks**: Business logic and domain entities must never depend on Spring, Hibernate, Express, or Android classes. Frameworks are external plugins.
- **Dependency Inversion Principle (DIP)**: Use Case interactors call output boundaries (interfaces). Presenters, repositories, or external services implement those interfaces.
- **Stable Abstractions**: Modules that are most stable (least likely to change business rules) must be abstract. Volatile details must depend on stable abstractions.

### 2. Code Craftsmanship & Clean Code Guidelines
- **Intention-revealing naming**: Names must explain *why it exists*, *what it does*, and *how it is used*. Avoid abbreviations or type prefixes.
- **Functions do one thing**: Keep functions small (< 20 lines) and at a single level of abstraction.
- **Command-Query Separation (CQS)**: A method either alters state (command) or returns data (query), never both.
- **Don't return or accept null**: Prefer empty collections, `Optional<T>`, or Result wrappers to prevent null pointer exceptions.
- **Exceptions over error codes**: Use unchecked exceptions for unexpected failures; encapsulate recoverable domain errors.
- **Boy Scout Rule**: Always leave code cleaner than you found it.

### 3. Outside-In TDD & Walking Skeleton
- **The Walking Skeleton**: Build the thinnest possible end-to-end slice of functionality connecting real infrastructure (DB, API, transport) before implementing business features.
- **Test Pyramids & Types**:
  - *Acceptance/E2E Tests*: Verify that the feature solves the user's problem from the outside.
  - *Integration Tests*: Verify that adapters correctly speak to external services/databases.
  - *Unit Tests*: Drive internal object collaboration and verify behavior in isolation.
- **Listen to the Tests**: If a unit test is painful to write or requires excessive mocking, the production design is flawed (e.g. tight coupling, hidden dependencies, too many responsibilities).
- **Tell, Don't Ask**: Tell objects what to do with their data; do not query their state to make decisions outside the object.

### 4. Reliable & Scalable Distributed Systems
- **Three Core Pillars**:
  - *Reliability*: Tolerating hardware/software faults and human error without system failure.
  - *Scalability*: Gracefully handling growth in traffic, data volume, and complexity.
  - *Maintainability*: Operability, simplicity, and evolvability of the codebase.
- **Storage Trade-offs**:
  - *LSM-Trees / SSTables*: High write throughput; append-only writes (e.g., RocksDB, Cassandra).
  - *B-Trees*: High read throughput; random access writes in 4KB/8KB pages (e.g., PostgreSQL, MySQL).
- **Replication & Consensus**:
  - Beware of eventual consistency anomalies; evaluate read-after-write consistency, monotonic reads, and consistent prefix reads.
  - Use quorum formulas ($W + R > N$) and consensus protocols (Raft, Paxos) for split-brain prevention.
- **Transaction Isolation Levels**:
  - *Read Committed*: Prevents dirty reads and dirty writes.
  - *Snapshot Isolation (MVCC)*: Prevents read skew; readers never block writers.
  - *Serializable*: Prevents write skew and phantom reads (via SSI or two-phase locking).

### 5. Idiomatic Object-Oriented Design Patterns
- **Static Factory Methods & Builders**: Prefer static factories over public constructors. Use Builders for objects with 4+ parameters.
- **Favor Immutability**: Make classes immutable by default (`final` fields, private constructors, defensive copies of mutable components).
- **Composition over Inheritance**: Inheritance breaks encapsulation across package boundaries. Favor composition and interface forwarding.
- **Generics & Collections**: Eliminate raw types. Favor generic methods and bounded wildcards (`PECS`: Producer Extends, Consumer Super).
- **Modern Concurrency**: Prefer executors, tasks, and high-level concurrency utilities over raw threads and `wait()`/`notify()`.

### 6. Modern Cloud-Native Framework Alignment
- **Modern Baseline**: Adopt Spring Framework 7.x, Java 21/25 LTS, and Jakarta EE 11 namespaces (`jakarta.*`).
- **AOT & Native Readiness**: Use programmatic bean registration (`BeanRegistrar`) and avoid reflection/classpath scanning where Ahead-Of-Time (AOT) efficiency is critical.
- **Explicit Starters**: Use fine-grained starters (`spring-boot-starter-webmvc`, `spring-boot-starter-webflux`, `spring-boot-starter-flyway`) rather than pulling monolithic dependencies.

---

## Quick Decision Matrix

| Scenario | Recommended Architectural Choice |
| :--- | :--- |
| **Domain Logic Coupling** | Extract Domain Entity/Use Case. Move ORM/HTTP dependencies to outer adapters. |
| **High Write Ingestion** | Use append-only logs / LSM-tree stores with asynchronous workers. |
| **Multi-Object State Transition** | Use explicit Domain Events with Outbox Pattern to guarantee atomic database updates and message publishing. |
| **Class has > 4 Arguments** | Refactor to Builder pattern or immutable record/value object. |
| **Slow Database Reads** | Analyze query execution plan (Index Scans vs Seq Scans), optimize indexes, add Read-Through cache (Redis). |
| **Cross-Module Communication** | Depend on abstractions (interfaces/ports). Inject implementations via constructor dependency injection. |

---

## Detailed Topic Guides
For exhaustive deep dives into specific chapters, patterns, and code samples, consult the companion guides in `references/`:

- [Code Craftsmanship & Clean Code](references/code-craftsmanship.md): Functions, naming, refactoring smells, error handling, and unit test guidelines.
- [Layered Architecture & Boundaries](references/architectural-boundaries.md): The dependency rule, use cases, boundaries, and enterprise patterns.
- [Distributed Systems & Data Architecture](references/distributed-data-systems.md): Distributed systems, replication, partitioning, transactions, and consensus.
- [Idiomatic OOP & Robust Design Patterns](references/idiomatic-oop-design.md): Best practices for robust, idiomatic Java/Kotlin development.
- [Outside-In TDD & Walking Skeletons](references/outside-in-tdd.md): Outside-in TDD, walking skeletons, and mocking guidelines.
- [Cloud-Native Framework Architecture](references/cloud-native-frameworks.md): Modern Spring Framework, Jakarta EE, and microservice practices.
