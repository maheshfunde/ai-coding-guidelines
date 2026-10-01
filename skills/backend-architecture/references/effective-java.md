# Idiomatic Java & Object-Oriented Design: LLM System Instructions & Guidelines

This document distills 90 proven engineering items into strict system instructions and guidelines for Large Language Models (LLMs). It serves as an authoritative prompt reference for AI models to generate, refactor, and audit idiomatic, robust, maintainable, and efficient Java code.

---

## 1. Object Creation & Lifecycle (Items 1–9)

### Static Factory Methods & Builders
- **Item 1: Static Factory Methods over Constructors**: Provide named static factory methods (e.g., `valueOf`, `of`, `getInstance`, `newInstance`) instead of overloaded constructors to clarify intent, control instantiation, return subtypes, or reuse immutable instances.
- **Item 2: Builder Pattern for Multi-Parameter Objects**: Use the Builder pattern when faced with 4+ constructor parameters or many optional parameters. Enforce invariant checks inside the `build()` method after parameter copying.
- **Item 3: Single-Element Enums for Singletons**: Enforce the singleton property using a single-element `enum` (`public enum Singleton { INSTANCE; }`). It naturally handles serialization, reflection attacks, and multi-instance prevention.
- **Item 4: Noninstantiability via Private Constructors**: Utility classes (containing only static members) must have an explicit `private` constructor that throws `AssertionError` to prevent instantiation and subclassing.

### Dependency Management & Cleanup
- **Item 5: Dependency Injection over Hardwiring**: Never hardwire resources using static utility classes or singletons when behavior depends on underlying resources. Pass resources (or supplier factories) into the constructor via Dependency Injection (DI).
- **Item 6: Avoid Unnecessary Objects**: Reuse immutable objects (`String s = "text"`, static `Pattern` instances, primitive values) rather than re-creating functionally identical objects in loops or frequently invoked methods.
- **Item 7: Eliminate Obsolete References**: Explicitly null out object references in custom memory pools, stacks, or caches when elements become obsolete to prevent memory leaks.
- **Item 8: Avoid Finalizers and Cleaners**: Never rely on `finalizer` or `cleaner` methods for resource cleanup; they are unpredictable, slow, and dangerous.
- **Item 9: Prefer `try-with-resources` to `try-finally`**: Always use `try-with-resources` for objects implementing `AutoCloseable` to guarantee proper, exception-safe resource release and preserve clean stack traces.

---

## 2. Fundamental Methods Common to All Objects (Items 10–14)

### Equals & HashCode Contracts
- **Item 10: Obey the `equals` Contract**: Override `equals` only for value classes requiring logical equivalence. Strictly preserve symmetry, transitivity, reflexivity, consistency, and non-nullity. Always check type with `instanceof` (which safely handles `null`) before casting.
- **Item 11: Override `hashCode` Whenever Overriding `equals`**: Equal objects **must** have equal hash codes. Generate hash codes using prime multipliers (`31 * result + field.hashCode()`) or `Objects.hash(...)`. Cache hash codes for immutable value objects if computation is expensive.

### Common Object Utilities
- **Item 12: Always Override `toString`**: Return a concise, useful, human-readable representation for all instantiable classes to improve logging and debugging. Document whether the format is guaranteed/specified.
- **Item 13: Override `clone` Judiciously**: Prefer copy constructors or static copy factories (`public ClassName(ClassName other)`) over implementing `Cloneable` and overriding `clone()`.
- **Item 14: Implement `Comparable` for Value Classes**: Implement `Comparable<T>` for value classes with a natural ordering. Use static compare methods (`Integer.compare`, `Double.compare`) or comparator construction methods (`Comparator.comparingInt`). Never use subtraction (`a.val - b.val`) due to integer overflow risks.

---

## 3. Classes and Interfaces (Items 15–25)

### Access Control & Immutability
- **Item 15: Minimize Accessibility**: Declare classes and members with the narrowest possible access level (`private` or `package-private`). Public classes must never expose mutable `public static final` arrays or fields.
- **Item 16: Use Accessor Methods in Public Classes**: Never expose public mutable fields in public classes; use getter and setter methods.
- **Item 17: Minimize Mutability**: Make classes immutable by making fields `private final`, preventing subclassing (`final` class or private constructors), providing no mutators, and making defensive copies of mutable components.

### Hierarchy & Interface Design
- **Item 18: Favor Composition over Inheritance**: Avoid extending concrete classes across package boundaries; inheritance breaks encapsulation. Use the Decorator pattern (wrapper classes holding an interface reference).
- **Item 19: Design and Document for Inheritance or Prohibit It**: Document self-use of overridable methods using `@implSpec`. Constructors must never invoke overridable methods. If not designed for inheritance, declare the class `final`.
- **Item 20: Prefer Interfaces to Abstract Classes**: Use interfaces for type definitions and mixins. Provide skeletal abstract implementations (Abstract Interface pattern) to ease implementation burden.
- **Item 21: Design Interfaces for Posterity**: Exercise caution with default interface methods; ensure they maintain all invariants of all existing implementations.
- **Item 22: Use Interfaces Only to Define Types**: Never use "constant interfaces" to export constants; use utility classes or `enum` types instead.
- **Item 23: Prefer Class Hierarchies to Tagged Classes**: Replace classes with `enum` tag fields with abstract classes/interfaces and polymorphic subclasses.
- **Item 24: Favor Static Member Classes over Nonstatic**: Declare nested classes `static` unless they strictly require a reference to their enclosing instance, preventing hidden outer object memory leaks.
- **Item 25: Limit Source Files to a Single Top-Level Class**: Never place multiple top-level classes in a single `.java` file.

---

## 4. Generics & Type Safety (Items 26–33)

### Type Safety Rules
- **Item 26: Don't Use Raw Types**: Always use parameterized types (`List<String>`) rather than raw types (`List`). Use unbounded wildcards (`Set<?>`) if the element type is unknown.
- **Item 27: Eliminate Unchecked Warnings**: Fix or eliminate all compiler warnings. If a warning cannot be eliminated but is proven safe, suppress it using `@SuppressWarnings("unchecked")` in the narrowest possible scope and add a comment explaining why.
- **Item 28: Prefer Lists to Arrays**: Arrays are covariant and reified; generics are invariant and erased. Prefer `List<T>` to `T[]` to catch type errors at compile time rather than runtime `ClassCastException`.

### Generic API Design
- **Item 29: Favor Generic Types**: Parameterize custom data structures to provide type safety without explicit client-side casts.
- **Item 30: Favor Generic Methods**: Declare static helper methods with generic type parameters (`public static <E> Set<E> union(Set<E> s1, Set<E> s2)`).
- **Item 31: Use Bounded Wildcards for API Flexibility**: Follow the **PECS** rule (**P**roducer-**E**xtends, **C**onsumer-**S**uper). Use `? extends T` for input parameters producing data, and `? super T` for input parameters consuming data.
- **Item 32: Combine Generics and Varargs Judiciously**: Generic varargs methods create heap pollution risks. Annotate method with `@SafeVarargs` ONLY if the varargs array is never modified or exposed to untrusted code.
- **Item 33: Consider Typesafe Heterogeneous Containers**: Map types to instances using parameterized keys (`Map<Class<?>, Object>`) with dynamic `Class.cast()` for dynamic type lookup.

---

## 5. Enums, Annotations & Functional Programming (Items 34–48)

### Enums and Annotations
- **Item 34: Use Enums Instead of Int Constants**: Enums provide compile-time type safety, rich behavior, and distinct namespaces. Use constant-specific method implementations for distinct constant behaviors.
- **Item 35: Use Instance Fields Instead of Ordinals**: Never derive values from `ordinal()`; store values in private instance fields instead.
- **Item 36: Use `EnumSet` Instead of Bit Fields**: Replace bitwise bit fields (`1 << 0`) with `EnumSet.of(...)` for type safety and performance.
- **Item 37: Use `EnumMap` Instead of Ordinal Indexing**: Use `java.util.EnumMap` rather than indexing directly into arrays with `.ordinal()`.
- **Item 38: Emulate Extensible Enums with Interfaces**: When extensible enumerated types are needed, define an interface and implement it in standard `enum` types.
- **Item 39: Prefer Annotations to Naming Patterns**: Use structured annotations (e.g., `@Test`) instead of naming conventions (`testFoo`).
- **Item 40: Consistently Use the `@Override` Annotation**: Annotate every method intended to override a superclass or interface method to prevent silent overloading bugs.
- **Item 41: Use Marker Interfaces to Define Types**: Use empty marker interfaces (like `Serializable`) when defining a type parameter constraint; use marker annotations when targets extend beyond types.

### Lambdas and Streams
- **Item 42: Prefer Lambdas to Anonymous Classes**: Use short lambdas (1–3 lines) for single-method function objects. Avoid complex multi-line logic in lambdas.
- **Item 43: Prefer Method References to Lambdas**: Use method references (`String::toLowerCase`, `Integer::parseInt`) whenever they are shorter and clearer than explicit lambdas.
- **Item 44: Favor Standard Functional Interfaces**: Use standard functional interfaces from `java.util.function` (`Function`, `Predicate`, `Consumer`, `Supplier`, `UnaryOperator`, `BinaryOperator`) instead of declaring duplicate custom interfaces.
- **Item 45: Use Streams Judiciously**: Avoid overusing streams to the point of unreadability. Prefer iterative loops when side-effects, control flow (`break`/`continue`), or multi-variable mutation are required.
- **Item 46: Prefer Side-Effect-Free Functions in Streams**: Stream operations must be pure functions. The `.forEach()` terminal operation should **only** be used to report results, never to compute or mutate state. Use collectors (`Collectors.toList()`, `Collectors.groupingBy()`).
- **Item 47: Prefer Collection to Stream as Return Type**: Return `Collection`, `List`, or `Set` (or `Iterable`) rather than `Stream` from public methods so callers can iterate or stream seamlessly.
- **Item 48: Use Caution When Making Streams Parallel**: Parallelizing streams without testing can severely degrade performance or cause correctness bugs. Parallelize only over easily splittable structures (`ArrayList`, arrays, `IntStream.range`) with side-effect-free operations.

---

## 6. Methods & General Programming (Items 49–68)

### Defensive Method Design
- **Item 49: Check Parameters for Validity**: Validate parameter preconditions at the top of method bodies using `Objects.requireNonNull()` or throwing `IllegalArgumentException`/`IndexOutOfBoundsException`. Document restrictions with `@throws`.
- **Item 50: Make Defensive Copies When Needed**: Make defensive copies of mutable input parameters in constructors before invariant checks. Return defensive copies (or unmodifiable views) of mutable internal fields.
- **Item 51: Design Method Signatures Carefully**:
  - Keep method names clear and consistent.
  - Limit parameter lists to 4 or fewer parameters.
  - Favor interface types over concrete implementation classes for parameters.
  - Use 2-element enums instead of boolean parameters.
- **Item 52: Use Overloading Judiciously**: Avoid overloading methods with the same number of parameters, especially when parameter types can be converted via autoboxing, generics, or lambdas. Overloading choice is static at compile time.
- **Item 53: Use Varargs Judiciously**: Precede varargs parameters (`T...`) with mandatory parameters (`int min(int first, int... rest)`). Be mindful of implicit array creation overhead.
- **Item 54: Return Empty Collections or Arrays, Not Nulls**: Never return `null` for an empty array or collection; return `Collections.emptyList()`, `Collections.emptySet()`, or a zero-length array.
- **Item 55: Return Optionals Judiciously**: Return `Optional<T>` when a method might not return a result and callers must handle the missing value. Never wrap collections, maps, arrays, or optionals in an `Optional`. Never use `Optional` in fields or parameters.
- **Item 56: Write Doc Comments for Exposed API Elements**: Document all exported classes, interfaces, methods, and fields using Javadoc with `@param`, `@return`, `@throws`, and `@implSpec`.

### General Programming Rules
- **Item 57: Minimize the Scope of Local Variables**: Declare variables where first used. Initialize local variables upon declaration. Prefer `for-each` loops over traditional `while` loops.
- **Item 58: Prefer `for-each` Loops**: Use `for-each` loops over traditional `for` loops unless performing destructive filtering (`Iterator.remove()`), element transformation, or parallel iteration.
- **Item 59: Know and Use the Libraries**: Use standard JDK libraries (`java.util.concurrent`, `ThreadLocalRandom`, `java.nio.file`) instead of reinventing wheels.
- **Item 60: Avoid `float` and `double` for Exact Answers**: Never use `float` or `double` for monetary or exact calculations; use `BigDecimal`, `int`, or `long`.
- **Item 61: Prefer Primitive Types to Boxed Primitives**: Primitives are faster and cannot throw `NullPointerException`. Using boxed primitives in arithmetic causes silent auto-unboxing performance bottlenecks and potential `NPE`s.
- **Item 62: Avoid Strings Where Other Types Are Appropriate**: Do not use strings as substitutes for value types, enums, capability keys, or aggregate data types.
- **Item 63: Beware String Concatenation Performance**: Do not use `+` to concatenate many strings in loops; use `StringBuilder`.
- **Item 64: Refer to Objects by Their Interfaces**: Declare variables, parameters, and return types using interfaces (`Map<String, String> map = new HashMap<>()`).
- **Item 65: Prefer Interfaces to Reflection**: Avoid reflection for routine code execution. Use reflection only to instantiate classes reflectively and access them via known interfaces.
- **Item 66: Use Native Methods Judiciously**: Avoid JNI / native methods unless necessary for platform integration or legacy C/C++ libraries.
- **Item 67: Optimize Judiciously**: Strive for clean, modular, well-architected code first; speed will follow. Profile before optimizing.
- **Item 68: Adhere to Generally Accepted Naming Conventions**: Follow standard Java typographical (CamelCase, UPPER_CASE) and grammatical naming conventions.

---

## 7. Exceptions & Concurrency (Items 69–84)

### Exception Handling Rules
- **Item 69: Use Exceptions Only for Exceptional Conditions**: Never use exceptions for standard control flow (e.g., catching `ArrayIndexOutOfBoundsException` to terminate a loop).
- **Item 70: Checked Exceptions for Recoverable Conditions, RuntimeExceptions for Programming Errors**: Use checked exceptions if the caller can recover. Use unchecked `RuntimeException` for logic bugs or unrecoverable conditions.
- **Item 71: Avoid Unnecessary Use of Checked Exceptions**: Do not force API callers to handle checked exceptions if recovery is impossible; return `Optional<T>` or throw unchecked exceptions.
- **Item 72: Favor Standard Exceptions**: Reuse standard exceptions (`IllegalArgumentException`, `IllegalStateException`, `NullPointerException`, `IndexOutOfBoundsException`, `UnsupportedOperationException`).
- **Item 73: Throw Exceptions Appropriate to the Abstraction**: High-level layers must catch low-level exceptions and rethrow higher-level domain exceptions (Exception Translation), chaining the root cause via `getCause()`.
- **Item 74: Document All Exceptions Thrown by Each Method**: Declare checked exceptions individually in the method signature and document both checked and unchecked exceptions with `@throws` Javadoc tags.
- **Item 75: Include Failure-Capture Information in Detail Messages**: Include all parameters and field values relevant to the failure in the exception's string detail message.
- **Item 76: Strive for Failure Atomicity**: Ensure failed method calls leave the object in the state it was in prior to the invocation.
- **Item 77: Don't Ignore Exceptions**: Never leave `catch` blocks empty. If intentionally ignoring an exception, document the reason and name the exception variable `ignored`.

### Concurrency Rules
- **Item 78: Synchronize Access to Shared Mutable Data**: Synchronization guarantees both mutual exclusion and thread visibility. Use `volatile` only for state flags without compound operations, or use atomic variables (`AtomicInteger`).
- **Item 79: Avoid Excessive Synchronization**: Never invoke "alien" (overridable or client-provided) methods inside synchronized regions to prevent deadlocks and data corruption. Keep synchronized blocks minimal.
- **Item 80: Prefer Executors, Tasks, and Streams to Threads**: Use `ExecutorService` and high-level concurrency tasks (`Callable`, `CompletableFuture`) rather than raw `Thread` creation.
- **Item 81: Prefer Concurrency Utilities to `wait` and `notify`**: Use `ConcurrentHashMap`, `CountDownLatch`, `Semaphore`, and `BlockingQueue` instead of low-level `wait()` and `notify()`.
- **Item 82: Document Thread Safety**: Explicitly document a class's thread-safety level: Immutable, Unconditionally Thread-Safe, Conditionally Thread-Safe, Not Thread-Safe, or Thread-Hostile.
- **Item 83: Use Lazy Initialization Judiciously**: Use normal initialization by default. Use the Double-Check Idiom for lazy instance fields, and the Lazy Initialization Holder Class Idiom for static fields.
- **Item 84: Don't Depend on the Thread Scheduler**: Never rely on `Thread.yield()` or thread priorities for program correctness or performance.

---

## 8. Serialization (Items 85–90)

- **Item 85: Prefer Alternatives to Java Serialization**: Avoid Java Serialization due to severe security vulnerabilities (remote code execution gadgets). Use cross-platform structured formats like JSON or Protocol Buffers.
- **Item 86: Implement `Serializable` with Great Caution**: Implementing `Serializable` creates long-term API liability and breaks encapsulation.
- **Item 87: Consider Using a Custom Serialized Form**: If serialization is required, design a custom serialized form that captures logical content rather than internal physical representation.
- **Item 88: Write `readObject` Methods Defensively**: Treat `readObject` as a public constructor; validate all invariants and defensively copy mutable components.
- **Item 89: Prefer Enum Types for Instance Control**: Use single-element `enum` types rather than `readResolve()` to enforce singletons across serialization.
- **Item 90: Consider Serialization Proxies**: Use the Serialization Proxy Pattern (`writeReplace()` and `readResolve()`) to safely deserialize complex objects with nontrivial invariants.

---

## 9. LLM Code Generation Audit Checklist

When generating or auditing Java solutions, verify that the code complies with these rules:

- [ ] Are parameter validity checks (`Objects.requireNonNull()`, precondition checks) enforced at method entry points?
- [ ] Are mutable input parameters and return fields defensively copied where appropriate?
- [ ] Are collections returned as empty immutable collections (`Collections.emptyList()`) instead of `null`?
- [ ] Are exceptions used exclusively for exceptional conditions and documented with `@throws`?
- [ ] Are interfaces (`Map`, `List`, `Set`) used for variable declarations, return types, and parameter types instead of concrete classes?
- [ ] Are lambdas kept concise (1–3 lines) and free of mutating side-effects inside streams?
- [ ] Are all methods intended to override a superclass/interface explicitly annotated with `@Override`?
- [ ] Are resources managed via `try-with-resources` blocks?
