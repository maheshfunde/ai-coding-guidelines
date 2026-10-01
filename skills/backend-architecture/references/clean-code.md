# Clean Code & Software Craftsmanship: LLM System Instructions & Guidelines

This document synthesizes core craftsmanship principles, naming practices, function design, and refactoring heuristics. It serves as a direct system instruction and prompt constraint guide for Large Language Models (LLMs) to write, refactor, and review clean, maintainable, and readable code.

---

## 1. Core Philosophy & First Principles

1. **Readability Over Writing Convenience**:
   - Code is read vastly more often than it is written (ratio > 10:1). Always optimize for the reader, not the writer.
2. **The Boy Scout Rule**:
   - *Leave the campground cleaner than you found it.* Always check in code slightly cleaner than when you checked it out (rename a variable, extract a small function, eliminate dead code).
3. **Make It Work, Then Make It Right**:
   - First draft code is naturally clumsy. Never stop when code merely works—always perform the refactoring step to make it readable, structured, and clean.
4. **WTFs/Minute as Quality Metric**:
   - Code quality is measured by how easily a peer can understand intent without confusion. Strive for polite code that yields no surprises ("Ward Cunningham's rule").

---

## 2. Meaningful Naming Rules

### General Naming Heuristics
- **Use Intention-Revealing Names**: Names must answer why an entity exists, what it does, and how it is used. If a name requires a comment, the name has failed.
- **Avoid Disinformation & Noise Words**: Never use vague suffixes or noise words like `Data`, `Info`, `Object`, `Manager`, `a1`, `a2`. Do not use terms with technical misdirection (e.g., calling a set `accountList`).
- **Pick One Word per Concept**: Maintain a consistent ubiquitous lexicon across the codebase (e.g., pick *one* of `get`, `fetch`, `retrieve` and stick with it).

### Scope-Based Naming Rules
- **Variable Length $\propto$ Scope Size**:
  - Small, local variables inside short loops or tiny functions should be short (e.g., `i`, `n`, `e`).
  - Variables with wider or global scopes must have long, highly descriptive, search-friendly names (`WORK_DAYS_PER_WEEK`).
- **Function/Class Length $\propto$ $1 / \text{Scope Size}$**:
  - Global/public abstractions should have concise, high-level names (`open()`, `Customer`).
  - Private, detailed helper functions inside small scopes should have long, highly descriptive names (`checkForIllegalPrefixCombinations()`).

### Parts of Speech
- **Classes & Objects**: Use noun or noun-phrase names (`Customer`, `AddressParser`, `WikiPage`). Avoid generic suffixes like `Controller` or `Manager` when a domain noun exists.
- **Functions & Methods**: Use verb or verb-phrase names (`pay()`, `calculateTax()`, `isFlagged()`).
- **Factory Methods over Overloaded Constructors**: Use named static factory methods (`Complex.fromRealNumber(23.0)`) instead of ambiguous overloaded constructors (`new Complex(23.0)`).

---

## 3. Clean Functions & Methods

### Size & Single Responsibility
- **Small!**: Functions should ideally be 5–15 lines long. Deeply nested blocks (`if`, `while`, `for`) should be extracted into well-named single-line function calls.
- **Do One Thing**: A function should do one thing, do it well, and do it only. If a function contains sections that can be extracted into another function with a meaningful name, it is doing more than one thing.
- **One Level of Abstraction (Stepdown Rule)**:
  - All statements within a function must operate at the exact same level of abstraction.
  - Structure functions so the file reads like a top-down narrative, descending one level of abstraction per step.

### Function Arguments
- **Ideal Argument Count**: 0 (Niladic) is best, followed by 1 (Monadic) and 2 (Dyadic). Avoid 3 (Triadic); require a compelling reason for 4+ (Polyadic).
- **Wrap Parameter Groups**: If a function requires 3+ arguments, group related primitives into Value Objects or DTOs (e.g., `Point center` instead of `double x, double y`).
- **Eliminate Flag Arguments**: Passing boolean flags (`render(boolean isSuite)`) proves the function does more than one thing. Split into two explicit functions (`renderSuite()`, `renderSingleTest()`).

### Command-Query Separation (CQS) & Error Handling
- **Command-Query Separation**: Functions should either *do something* (modify state) or *answer something* (return state), never both.
- **Prefer Exceptions to Returning Error Codes**: Returning error codes forces deeply nested `if` checks and pollutes control flow.
- **Extract Try/Catch Blocks**: Error handling is "one thing". A function that contains `try/catch` should begin with `try` and contain nothing after `catch/finally`. Extract the bodies of `try` and `catch` into dedicated private helper methods.
- **Don't Repeat Yourself (DRY)**: Duplication is the root of all software evil. Extract duplicate algorithms, logic, or structures into unified functions or abstractions.

---

## 4. Comments Policy

> *"Don't comment bad code—rewrite it."* — Brian Kernighan & P.J. Plaugher

### The Rule of Comments
Comments represent a failure to express intent in code. Prioritize making code clear and expressive over writing explanatory comments. Inaccurate comments are worse than no comments.

### Good / Acceptable Comments
- **Legal & Copyright Headers**: Mandatory corporate or license notices.
- **Informative Comments**: Explaining the format of an obscure return value or regular expression (`// format matched kk:mm:ss`).
- **Explanation of Intent**: Documenting *why* a non-obvious algorithmic decision or business choice was made.
- **Warning of Consequences**: Warning developers about slow execution or side effects (`// Don't run unless you have 10+ minutes`).
- **TODO Comments**: Tracking temporary pending work (must be regularly audited and cleaned).

### Bad / Forbidden Comments
- **Redundant / Noise Comments**: Restating what the code explicitly says (`/** The name */ private String name;`).
- **Misleading / Outdated Comments**: Comments that drifted out of sync with updated code.
- **Journal / Log Comments**: Historical change logs inside source files (let Git/source control handle this).
- **Commented-Out Code**: Never check in commented-out code. Delete it immediately—version control retains history.
- **Bylines & Attributions**: `// Added by John`. Use source control blame instead.
- **Position Markers / Banners**: Slashing banners (`// Actions ///////`) that add visual clutter.

---

## 5. Formatting & Structure

### Vertical Formatting (The Newspaper Metaphor)
- **Top-Down Organization**: High-level concepts and public APIs appear at the top of the file; implementation details unfold below.
- **Vertical Openness**: Separate distinct concepts, imports, and methods with blank lines.
- **Vertical Density**: Keep tightly related lines of code visually dense without unnecessary blank lines.
- **Dependent Functions**: Callers should be placed vertically *above* callees to maintain a natural downward reading flow.

### Horizontal Formatting
- **Line Length**: Keep lines short (aim for under 100–120 characters). Avoid horizontal scrolling.
- **Horizontal White Space**: Use spaces to associate strongly bound operators and separate arguments or assignments (`a = b * c + d`).
- **Indentation**: Never collapse short `if`/`while` statements or getters into a single unindented line. Respect visual indentation hierarchy.

---

## 6. Objects vs. Data Structures & The Law of Demeter

### Data/Object Antisymmetry
- **Objects**: Hide internal data behind abstractions and expose public functions operating on that data.
  - *Strength*: Easy to add new classes/types without changing existing functions.
  - *Weakness*: Hard to add new functions because all classes must change.
- **Data Structures (DTOs / Value Objects)**: Expose raw data fields with no meaningful behavior.
  - *Strength*: Easy to add new functions operating on data structures.
  - *Weakness*: Hard to add new data structures because all functions must change.
- **Rule**: Do not create hybrid structures (half object, half data structure). Choose intentionally based on whether the system needs type-flexibility (OO) or operation-flexibility (Procedural).

### Law of Demeter ("Talk to Friends, Not Strangers")
- A method `f` of class `C` should only call methods on:
  1. Class `C` itself.
  2. Objects created inside `f`.
  3. Objects passed as arguments to `f`.
  4. Objects held in instance variables of `C`.
- **Avoid Trainwrecks**: Never chain accessor calls across object boundaries (`ctxt.getOptions().getScratchDir().getAbsolutePath()`).
- **Fix via "Tell, Don't Ask"**: Instead of navigating an object's internal graph to extract data, tell the target object to perform the work (`ctxt.createScratchFileStream(name)`).

---

## 7. Clean Classes & Simple Design

### Class Design & Cohesion
- **Small Classes**: Measure class size by *responsibilities* (reasons to change), not line count.
- **Single Responsibility Principle (SRP)**: A class or module should have one, and only one, reason to change (it should respond to only one actor/stakeholder).
- **High Cohesion**: Classes should have a small number of instance variables that are actively manipulated by most class methods.

### Kent Beck's 4 Rules of Simple Design
Organized strictly by priority:
1. **Runs All Tests**: Code must be verifiable and decoupled to be testable.
2. **Contains No Duplication (DRY)**: Eliminate duplicate logic, structure, and execution paths.
3. **Expresses Intent**: Clear naming, small methods, standard patterns, and readable structures.
4. **Minimizes Number of Classes & Functions**: Avoid over-decomposition that creates useless abstraction layers.

---

## 8. Clean Unit Tests (F.I.R.S.T.)

### Testing Disciplines & Dual Standards
- **Test Code is First-Class**: Test code must be kept as clean, readable, and well-structured as production code. Dirty tests lead to test rot, which destroys code flexibility.
- **Domain-Specific Testing API**: Build helper functions and Test Data Builders to create expressive, readable tests.
- **Single Concept per Test**: Minimize assertions per test; each test method should verify a single, isolated concept.

### F.I.R.S.T. Principles of Clean Tests
- **Fast**: Tests must execute rapidly so developers run them continuously.
- **Independent / Isolated**: Tests must not depend on each other or run in a specific order.
- **Repeatable**: Tests must pass consistently in any environment (local, CI/CD, offline).
- **Self-Verifying**: Tests must output a boolean pass/fail result, requiring no manual log evaluation.
- **Timely**: Unit tests should be written concurrently or immediately alongside production code (TDD / Small Bundles).

---

## 9. Concurrency & Clean Boundaries

### Concurrency Defense
- **Separate Concurrency Code**: Concurrency is a decoupling strategy. Keep thread-management code strictly isolated from core business logic (SRP).
- **Limit Shared Data**: Severely restrict access to shared mutable state. Prefer immutable Value Objects, local copies, or pure functional transformations.
- **Test Threaded Code Separately**: Ensure non-threaded code works 100% outside of multi-threaded execution before testing concurrency.

### Clean Boundaries
- **Isolate Foreign Code**: Wrap third-party libraries, vendor frameworks, and external APIs behind Adapter interfaces (Ports & Adapters / Hexagonal Architecture).
- **Depend on What You Control**: Code inside domain boundaries must depend on abstract interfaces owned by the application, not concrete vendor classes.

---

## 10. Execution Checklist for Code Generation

When generating software solutions, LLMs must verify:
- [ ] Are variable and function names clear, intention-revealing, and free of noise words (`Data`, `Info`)?
- [ ] Are functions short (5–15 lines) and strictly operating at a single level of abstraction?
- [ ] Are function parameters minimized ($\le 2$), with boolean flag arguments eliminated?
- [ ] Is error handling separated from main happy-path business logic?
- [ ] Is all commented-out code and redundant noise comment clutter removed?
- [ ] Are object call chains free of Demeter "trainwreck" violations?
- [ ] Are classes small, cohesive, and adhering to the Single Responsibility Principle?
- [ ] Do unit tests follow F.I.R.S.T. principles and test isolated behavioral concepts?
