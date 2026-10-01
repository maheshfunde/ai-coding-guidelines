# Software Architecture & Layered Boundaries: LLM System Instructions & Guidelines

This document distills core architectural principles, dependency rules, and structural constraints for enterprise software systems. It is designed as a direct system instruction and prompt reference for Large Language Models (LLMs) to enforce clean architectural boundaries when designing software, writing code, or refactoring existing applications.

---

## 1. Core Architectural Values & Mandates

1. **Structure over Behavior**:
   - Every software system provides two values: **Behavior** (what it does today) and **Structure** (how easily it can change tomorrow).
   - Structure is the greater value because it preserves the "softness" of software. LLM code generation must prioritize maintainability, extensibility, and decoupling over quick, tightly coupled implementations.
2. **Minimize Lifetime Human Cost**:
   - The primary goal of architecture is to minimize the human resources required to build, maintain, and evolve the system over its entire lifecycle.
3. **Defer Technical Decisions**:
   - A good architecture renders decisions about frameworks, databases, web servers, dependency injection containers, and third-party tools ancillary and deferrable. Core business logic must never depend on implementation details.

---

## 2. SOLID Design Principles (Mid-Level Code Guidelines)

When writing, refactoring, or generating classes, modules, and functions, strictly enforce SOLID:

### Single Responsibility Principle (SRP)
- **Rule**: A module or class should have one, and only one, reason to change (it must respond to only one actor or stakeholder group).
- **LLM Instruction**: Never mix code that serves different actors (e.g., UI presentation, financial calculations, and database persistence) within the same class or module.

### Open-Closed Principle (OCP)
- **Rule**: Software artifacts must be open for extension but closed for modification.
- **LLM Instruction**: Extend system behavior by adding new classes that implement existing abstractions, rather than editing existing, tested core code.

### Liskov Substitution Principle (LSP)
- **Rule**: Subtypes must be completely substitutable for their base types without altering system correctness.
- **LLM Instruction**: Derived implementations must strictly adhere to the contract and behavior invariants of their interfaces. Never throw `UnsupportedOperationException` for required interface methods.

### Interface Segregation Principle (ISP)
- **Rule**: Do not force clients to depend on methods or interfaces they do not use.
- **LLM Instruction**: Keep interfaces fine-grained, focused, and client-specific. Avoid bloated or "fat" interfaces.

### Dependency Inversion Principle (DIP)
- **Rule**: High-level policies must not depend on low-level details. Both must depend on abstractions.
- **LLM Instruction**: Depend only on abstract interfaces or stable abstractions, never on concrete, volatile classes or low-level modules.

---

## 3. Component Design Principles

### Component Cohesion Principles
- **Reuse/Release Equivalence Principle (REP)**: The granule of reuse is the granule of release. Group classes that share a common theme and release cycle.
- **Common Closure Principle (CCP)**: Gather into a component those classes that change for the same reasons and at the same times (SRP applied at the component level).
- **Common Reuse Principle (CRP)**: Do not force component users to depend on classes they do not need (ISP applied at the component level).

### Component Coupling Principles
- **Acyclic Dependencies Principle (ADP)**: Allow no cycles in the component dependency graph. Eliminate cycles using DIP (interfaces) or intermediate components.
- **Stable Dependencies Principle (SDP)**: Depend in the direction of stability. Volatile components must never be depended upon by hard-to-change components.
- **Stable Abstractions Principle (SAP)**: A component should be as abstract as it is stable. Highly stable components must consist of abstract classes/interfaces to allow extension.

---

## 4. Concentric Architecture & The Dependency Rule

Software must be organized into concentric circles governed strictly by the **Dependency Rule**:

```
+-------------------------------------------------------------+
| Frameworks & Drivers (Web, DB, Devices, UI, External APIs)  |
|  +-------------------------------------------------------+  |
|  | Interface Adapters (Controllers, Presenters, Gateways)|  |
|  |  +-------------------------------------------------+  |  |
|  |  | Application Business Rules (Use Cases)          |  |  |
|  |  |  +-------------------------------------------+  |  |  |
|  |  |  | Enterprise Business Rules (Entities)     |  |  |  |
|  |  |  +-------------------------------------------+  |  |  |
|  |  +-------------------------------------------------+  |  |
|  +-------------------------------------------------------+  |
+-------------------------------------------------------------+
```

### The Dependency Rule
- **Mandate**: Source code dependencies must **point inward ONLY**, toward higher-level policies.
- Nothing in an inner circle can know anything about outer circles. Function names, class imports, database schemas, or framework constructs declared in an outer circle must **never** be mentioned in an inner circle.

### Ring Definitions & Implementation Rules
1. **Entities (Enterprise Business Rules - Innermost Circle)**:
   - Encapsulate Critical Business Rules and Critical Business Data.
   - Must be pure domain objects (POJOs/dataclasses). **Zero dependencies** on frameworks, ORMs (e.g., `@Entity`, `@Table`), database drivers, or web frameworks.
2. **Use Cases (Application Business Rules)**:
   - Orchestrate the flow of data to and from Entities.
   - Define application-specific business logic.
   - Interact with outer layers strictly via abstract **Input Ports** (use case interfaces) and **Output Ports / Gateways** (data access or external interfaces).
   - Data crossing use case boundaries must be simple **Data Transfer Objects (DTOs)**, primitive types, or Value Objects—never Entity objects or DB row structs.
3. **Interface Adapters**:
   - Convert data between the format convenient for Use Cases/Entities and the format convenient for external agencies (Web, DB).
   - Contains Controllers, Presenters, View Models, and Repository Gateways.
   - Implements the **Humble Object Pattern**: separates easy-to-test presentation logic (Presenters) from hard-to-test UI views, and separates business query logic from raw SQL/ORM execution.
4. **Frameworks & Drivers (Outermost Circle)**:
   - Contains web frameworks (Express, Spring, React, FastAPI), database engines, ORMs, and `Main` entrypoints.
   - Kept on the outside where they can do minimal harm and can be swapped easily.

---

## 5. Architectural Rules & Anti-Patterns for LLMs

### The Database is a Detail
- Business rules must communicate with databases strictly through Gateway Interfaces owned by the Use Case layer.
- Never let SQL statements, ORM annotations, or database schema types leak into Entities or Use Cases.

### Web and UI are Details
- The UI is an I/O device and a plugin to the business rules.
- Business rules must remain 100% agnostic to whether the UI is REST, GraphQL, gRPC, CLI, or Web HTML.

### Do Not Marry Frameworks
- Keep frameworks at arm's length. Never inherit domain entities or use cases from framework base classes.
- Avoid sprinkling framework-specific annotations (e.g., `@Autowired`, `@Component`, `@Inject`) inside core Entities or Use Cases. Reserve DI frameworks for the `Main` entrypoint.

### Screaming Architecture & Package Organization
- Top-level directory structures must reflect the **business domain** (e.g., `orders/`, `payments/`, `inventory/`), NOT technical mechanisms (`controllers/`, `models/`, `services/`).
- Favor **Package by Component** or **Package by Feature** over horizontal **Package by Layer**.

### Testability & Testing API
- Every Entity and Use Case must be unit-testable in isolation, in-memory, without a running web server, database, or framework context.
- Create a dedicated **Testing API** that interacts through Interactor boundaries to decouple test suites from application implementation details.

---

## 6. Execution Checklist for Code Generation

When generating software solutions, verify that the output passes these checks:
- [ ] Are Entity objects free of framework/database imports and annotations?
- [ ] Do all source code imports point inward toward higher-level policies?
- [ ] Are data access operations accessed via interface gateways defined in the Use Case / Application layer?
- [ ] Are simple DTOs used to pass data across boundaries (no Entity leak to UI/DB)?
- [ ] Is UI presentation logic isolated via Presenters / View Models (Humble Object Pattern)?
- [ ] Can core business rules be executed and tested purely in-memory?
