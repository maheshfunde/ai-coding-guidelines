# Test-Driven Development & Object-Oriented Software: LLM System Instructions & Guidelines

This document distills core principles, practices, and design patterns for Outside-In Test-Driven Development (TDD). It is formatted as system-level instructions for Large Language Models (LLMs) to strictly enforce TDD, walking skeletons, mock object best practices, and clean object-oriented design during code generation and software architecture.

---

## 1. Core TDD Philosophy & Golden Rules

1. **The Golden Rule of TDD**:
   - **Never write new functionality without a failing test.**
2. **Software as Growth**:
   - Software is grown incrementally in small, safe, feedback-driven steps. Always keep the system in a working state.
3. **Feedback Loops & Test Hierarchy**:
   - **Acceptance / End-to-End Tests**: Verify *external quality* (does the system perform the required business features end-to-end?). Run through external entry points (UI, API, messaging).
   - **Integration Tests**: Verify interaction with code you do not control (databases, third-party libraries, frameworks).
   - **Unit Tests**: Verify *internal quality* (do individual objects behave correctly, and are they loosely coupled and highly cohesive?).
4. **Listen to the Tests**:
   - Difficulty in writing or setting up a unit test is a design smell indicating poor object design (e.g., tight coupling, implicit dependencies, too many responsibilities). Fix the production design, do not complicate the test.

---

## 2. Process & TDD Workflow Guidelines

### Kick-Starting: The Walking Skeleton
- Before writing features, build a **Walking Skeleton**: the thinnest possible slice of end-to-end functionality that automatically builds, deploys, and tests through real technical infrastructure (e.g., UI, DB, messaging).
- Use the walking skeleton to flush out architectural uncertainty and deployment pipeline risks early.

### Outside-In Development
- Start every feature with a failing **Acceptance Test** expressed purely in domain terminology.
- Work inward from external triggers (UI events, API calls) through adapters to domain objects, unit-testing objects as you discover them.
- An acceptance test passing indicates the feature is complete—stop writing code ("no gold plating").

### Canonical Unit Test Structure
Every unit test must follow a clear structure:
1. **Setup**: Prepare the target object and its mock collaborators.
2. **Execute**: Trigger the single action/behavior under test.
3. **Assert/Verify**: Check side effects, return values, or expected mock interactions.
4. **Teardown**: Clean up state if necessary.

---

## 3. Object-Oriented Style & Architectural Guidelines

### A Web of Communicating Objects
- OO design is about **messaging and communication protocols between objects**, not static classification or data structures. Behavior changes by reconfiguring how objects are composed.

### Tell, Don't Ask (Law of Demeter)
- **Command objects**: Tell an object what to do; do not ask for its internal state via getters to make decisions on its behalf.
- **Eliminate "Train Wrecks"**: Never chain getters (e.g., `a.getB().getC().getD().doSomething()`). Wrap behavior behind a single, meaningful method on the target object.

### Values vs. Objects
- **Values**: Immutable, functionally processed, no identity (e.g., `Money`, `Quantity`, `EmailAddress`). Never mock values!
- **Objects**: Mutable state over time, distinct identity, model computational processes and collaborations.

### Object Peer Stereotypes
Dependencies and collaborators passed to an object must fall into clear roles:
1. **Dependencies**: Mandatory services required for the object to function. **Must be passed explicitly in the constructor**. Never create partially initialized objects.
2. **Notifications**: Fire-and-forget event listeners (`listeners`).
3. **Adjustments**: Policy/Strategy objects that adjust internal behavior.

### Composite Simpler Than the Sum of Its Parts
- Composing objects into a higher-level composite must result in an API that is simpler than the sum of its internal components. Hide moving parts.

### Context Independence
- An object must have zero knowledge about the wider environment outside its immediate collaborators. Pass all external references in explicitly.

---

## 4. Mock Objects & Interaction Testing Rules

### 1. Only Mock Types That You Own
- **NEVER mock third-party APIs, database libraries, or vendor frameworks.**
- Write an **Adapter Layer** (Ports & Adapters / Hexagonal Architecture) that wraps the third-party API in a domain-specific interface.
- Test adapters with focused **Integration Tests**. Mock the domain interface in unit tests.

### 2. Interface Discovery ("On-Demand" Design)
- Use unit tests and mock objects to "pull" required collaborator interfaces into existence from the perspective of the client object.

### 3. Allowances vs. Expectations
- **Allow Queries (`allowing()`)**: Queries return data and have no side effects. Allow them zero or more times without asserting exact call counts.
- **Expect Commands (`oneOf()`, `atLeast(1)`)**: Commands produce side effects outside the object. Explicitly assert their exact execution count and arguments.

### 4. Do Not Mock Concrete Classes or Values
- Mocking concrete classes obscures object relationships and forces coupling to volatile implementation details. Extract an interface defining the role first.
- Instantiated immutable value objects directly in tests rather than mocking them.

---

## 5. Test Quality, Readability, & Test Data Construction

### Test Names Describe Features
- Test names must read like descriptive domain sentences explaining behavior (e.g., `notifiesListenersWhenAuctionCloses()`), NOT method names (`testProcessMessage()`).

### Test Data Builders
- Use the **Test Data Builder Pattern** to create complex test objects with sensible defaults.
- Example: `anOrder().withLine("Hat", 1).withDiscount(0.10).build()`
- Keeps tests readable, focused only on relevant parameters, and resilient to constructor signature changes.

### Precise Assertions & Matchers
- Assert only the specific fields/effects relevant to the test scenario using expressive matchers (e.g., Hamcrest). Avoid over-specifying or comparing entire complex objects when only one attribute matters.

---

## 6. Execution Checklist for LLM Code Generation

When generating software solutions or test suites, verify:
- [ ] Does every new feature start with an end-to-end / acceptance test?
- [ ] Are all mandatory dependencies passed via the constructor (no hidden singletons or missing parameters)?
- [ ] Are classes adhering to "Tell, Don't Ask" with zero getter-chaining train wrecks?
- [ ] Are mock objects used strictly for interfaces owned by the project (no mocking third-party libraries or concrete classes)?
- [ ] Are queries stubbed with `allowing()` and commands asserted with explicit expectations?
- [ ] Are value objects immutable and instantiated directly without mocks?
- [ ] Are complex test data structures constructed using Test Data Builders?
- [ ] Are unit test names structured as self-describing domain sentences?
