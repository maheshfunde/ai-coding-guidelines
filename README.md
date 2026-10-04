# 🧠 ai-coding-guidelines

> **Production-grade UI/UX design systems and backend software architecture guidelines for AI coding assistants.**

A universal plugin for AI coding tools (Antigravity, Cursor, Claude Code, Windsurf, Cline) that enforces professional engineering standards — so your AI pair-programmer writes code the way a senior engineer would.

[![npm version](https://img.shields.io/npm/v/@maheshfunde/ai-coding-guidelines)](https://www.npmjs.com/package/@maheshfunde/ai-coding-guidelines)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)

---

## 📦 Installation

### Antigravity IDE (recommended)
```bash
npx @maheshfunde/ai-coding-guidelines
```
Or install directly via the Antigravity plugin system:
```bash
agy plugin install @maheshfunde/ai-coding-guidelines
```

### Cursor / Windsurf / Cline / Claude Code
```bash
cd your-project
npx @maheshfunde/ai-coding-guidelines
```
The installer copies the appropriate rule files (`.cursorrules`, `.windsurfrules`, `.clinerules`, `CLAUDE.md`) into your project root automatically.

---

## 🗂️ What is Inside

```
ai-coding-guidelines/
├── plugin.json                        # Antigravity plugin manifest
├── CLAUDE.md                          # Claude Code rules
├── .cursorrules                       # Cursor AI rules
├── .windsurfrules                     # Windsurf / Cascade rules
├── .clinerules                        # Cline / Roo Code rules
└── skills/
    ├── ui-ux-design/
    │   ├── SKILL.md                   # Master UI/UX design guide
    │   └── references/
    │       ├── visual-hierarchy-layout.md
    │       ├── interaction-foundations.md
    │       ├── goal-directed-interaction.md
    │       ├── ui-patterns-navigation.md
    │       ├── behavioral-ux-cognition.md
    │       ├── typography-grid-systems.md
    │       └── touch-ergonomics-accessibility.md
    └── backend-architecture/
        ├── SKILL.md                   # Master backend architecture guide
        └── references/
            ├── code-craftsmanship.md
            ├── architectural-boundaries.md
            ├── distributed-data-systems.md
            ├── idiomatic-oop-design.md
            ├── outside-in-tdd.md
            └── cloud-native-frameworks.md
```

---

## 🎯 Skills Overview

### 1. 🎨 `ui-ux-design` — UI/UX & Interaction Design

**Activate when:** designing screens, styling components, choosing typography/color, auditing UX flow, or building mobile/web layouts.

#### Core rules enforced

| Category | Rule |
|---|---|
| **Spacing** | Fixed scale only: `4 · 8 · 12 · 16 · 24 · 32 · 48 · 64 px` |
| **Buttons** | Exactly **1 primary filled** button per screen; others outlined or ghost |
| **Touch targets** | Minimum **48×48dp** (Android/Web) / **44×44pt** (iOS) |
| **Line length** | Body text: **45–75 characters** max |
| **Contrast** | WCAG AA: **4.5:1** normal text, **3:1** large/UI elements |
| **Typography** | `Leading 1.1–1.25` for headings, `1.5–1.6` for body |
| **Design order** | Grayscale layout first → color second |

---

#### ❌ Before (no guidelines)

```tsx
// Ad-hoc spacing, oversized button targets, multiple primary CTAs, poor hierarchy
<View style={{ padding: 7, margin: 13 }}>
  <Text style={{ fontSize: 28, fontWeight: 'bold', color: '#333' }}>Book Details</Text>
  <TouchableOpacity style={{ backgroundColor: 'blue', padding: 5, width: 120 }}>
    <Text style={{ color: 'white' }}>Start Reading</Text>
  </TouchableOpacity>
  <TouchableOpacity style={{ backgroundColor: 'green', padding: 5, width: 120 }}>
    <Text style={{ color: 'white' }}>Mark Complete</Text>
  </TouchableOpacity>
  <Text style={{ fontSize: 9, color: '#aaa' }}>Added on 2024-01-01</Text>
</View>
```

**Problems:**
- `padding: 7`, `margin: 13` — off-scale, inconsistent
- Touch targets `width: 120, padding: 5` → well under 48dp minimum
- Two filled blue/green buttons — no visual hierarchy
- 9px caption text fails WCAG AA contrast

---

#### ✅ After (with `ui-ux-design` skill)

```tsx
const SPACING = { xs: 4, sm: 8, md: 16, lg: 24, xl: 32 };

<View style={{ padding: SPACING.md, gap: SPACING.md }}>
  <Text style={{ fontSize: 24, fontWeight: '600', lineHeight: 30, color: '#111827' }}>
    Book Details
  </Text>

  {/* ONE primary action — meets 48dp minimum touch target */}
  <Pressable
    style={{
      backgroundColor: '#4F46E5',
      paddingVertical: SPACING.md,
      paddingHorizontal: SPACING.lg,
      borderRadius: 12,
      alignItems: 'center',
    }}
  >
    <Text style={{ color: '#fff', fontWeight: '600', fontSize: 16 }}>Start Reading</Text>
  </Pressable>

  {/* Secondary action — outlined, not competing with primary */}
  <Pressable
    style={{
      borderWidth: 1,
      borderColor: '#4F46E5',
      paddingVertical: SPACING.md,
      borderRadius: 12,
      alignItems: 'center',
    }}
  >
    <Text style={{ color: '#4F46E5', fontWeight: '500', fontSize: 16 }}>Mark Complete</Text>
  </Pressable>

  {/* Caption: #6B7280 on white = 4.6:1 contrast ratio — WCAG AA pass */}
  <Text style={{ fontSize: 12, color: '#6B7280', lineHeight: 18 }}>Added on 2024-01-01</Text>
</View>
```

**Improvements:**
- ✅ Spacing from fixed scale (16, 24, 32)
- ✅ Single primary button; secondary is outlined
- ✅ Touch targets ≥ 48dp (paddingVertical: 16)
- ✅ Caption at 12px with #6B7280 passes WCAG AA (4.6:1)
- ✅ Typography hierarchy via weight + size, not just size

---

### 2. 🏗️ `backend-architecture` — Backend & Architecture

**Activate when:** designing service layers, REST/gRPC APIs, database schemas, applying Clean Architecture, setting up TDD, or writing Java/Kotlin/Spring Boot code.

#### Core rules enforced

| Principle | Rule |
|---|---|
| **Dependency Rule** | Dependencies flow **strictly inward**: Frameworks → Adapters → Use Cases → Domain |
| **Function size** | Max **20 lines**, single level of abstraction |
| **CQS** | Methods either **change state** or **return data** — never both |
| **Null handling** | Use `Optional<T>`, empty collections, or Result types — **never return null** |
| **TDD** | Walking Skeleton first, then unit tests drive every feature |
| **Naming** | Names reveal **why** and **what** — no abbreviations, no type prefixes |
| **Error handling** | Domain exceptions, not error codes |

---

#### ❌ Before (no guidelines)

```kotlin
// God service: queries DB, transforms, sends email, logs — all in one place
class BookService(val db: BookDatabase, val emailClient: EmailClient) {

    fun completeBook(userId: String, bookId: String): String? {
        val book = db.query("SELECT * FROM books WHERE id = '$bookId'") // SQL injection!
        if (book == null) return null  // caller must null-check
        book.status = "COMPLETED"
        book.completedAt = System.currentTimeMillis()
        db.execute("UPDATE books SET status='COMPLETED', completedAt=${book.completedAt} WHERE id='$bookId'")
        emailClient.send(userId, "You completed ${book.title}!")  // side-effect in query method
        println("Book $bookId completed by $userId")
        return book.title  // returns data AND has side effects — violates CQS
    }
}
```

**Problems:**
- Raw SQL string interpolation → SQL injection vulnerability
- Returns `null` — callers must null-check everywhere
- Single method does: DB read, mutation, DB write, email, logging — violates SRP
- `BookDatabase` (framework) imported directly into business logic — violates Dependency Rule
- Method both mutates state AND returns data — violates CQS

---

#### ✅ After (with `backend-architecture` skill)

```kotlin
// Domain entity — zero framework dependencies
data class Book(
    val id: BookId,
    val title: String,
    val status: BookStatus = BookStatus.IN_PROGRESS,
    val completedAt: Instant? = null,
) {
    fun complete(): Book {
        check(status != BookStatus.COMPLETED) { "Book is already completed." }
        return copy(status = BookStatus.COMPLETED, completedAt = Instant.now())
    }
}

// Output boundary (port) — defined in the domain layer, implemented by adapters
interface BookRepository {
    fun findById(id: BookId): Optional<Book>
    fun save(book: Book)
}

interface NotificationPort {
    fun notifyBookCompleted(userId: UserId, book: Book)
}

// Use Case — depends only on interfaces, not frameworks
class CompleteBookUseCase(
    private val books: BookRepository,
    private val notifications: NotificationPort,
) {
    // Command: changes state, returns Unit (CQS compliant)
    fun execute(userId: UserId, bookId: BookId) {
        val book = books.findById(bookId)
            .orElseThrow { BookNotFoundException(bookId) }  // typed domain exception, not null

        val completedBook = book.complete()   // domain logic stays in entity
        books.save(completedBook)
        notifications.notifyBookCompleted(userId, completedBook)
    }
}

// Infrastructure adapter — framework details live here, NOT in domain
@Repository
class JpaBookRepository(private val jpa: BookJpaRepository) : BookRepository {
    override fun findById(id: BookId): Optional<Book> =
        jpa.findById(id.value).map { it.toDomain() }

    override fun save(book: Book) = jpa.save(book.toEntity())
}
```

**Improvements:**
- ✅ Domain entity has zero framework imports
- ✅ `BookRepository` is an interface (port) — adapter plugs in from outside
- ✅ `execute` is a command — returns `Unit`, no mixed query/command
- ✅ No nulls — uses `Optional<Book>` and throws typed domain exception
- ✅ Use Case is under 20 lines, single responsibility
- ✅ Business logic lives in `Book.complete()` (Tell, Don't Ask)

---

## 🔑 Real-World Patterns (caught in production)

These patterns were identified and fixed during real React Native debugging. They represent exactly the class of bugs these guidelines prevent.

### Pattern 1 — Safe Collection Iteration

#### ❌ Before: Set mutation during `forEach` causes infinite loop

```typescript
// listeners is a Set; listener() re-registers itself → Set grows → forEach never ends
const notifyListeners = () => {
  listeners.forEach(listener => {
    listener(); // ♾️ infinite loop if listener re-registers
  });
};
```

#### ✅ After: Snapshot before iterating

```typescript
const notifyListeners = () => {
  // Freeze the set at call time — mutations during iteration are safe
  const snapshot = Array.from(listeners);
  snapshot.forEach(listener => listener());
};
```

---

### Pattern 2 — Memoize Context Values

#### ❌ Before: New object on every render cascades re-renders

```typescript
// Inline object literal is recreated every render → all consumers re-render
return (
  <SessionContext.Provider value={{ session, startSession, endSession }}>
    {children}
  </SessionContext.Provider>
);
```

#### ✅ After: Stable reference with `useMemo`

```typescript
const contextValue = useMemo(
  () => ({ session, startSession, endSession }),
  [session, startSession, endSession]
);

return (
  <SessionContext.Provider value={contextValue}>
    {children}
  </SessionContext.Provider>
);
```

---

### Pattern 3 — UI-Responsive State Updates

#### ❌ Before: Heavy work blocks the JS thread; loader never paints

```typescript
const handleComplete = () => {
  setShowLoader(true);
  finalizeSession();       // blocks JS thread — loader frame never renders
  setShowCelebration(true);
};
```

#### ✅ After: Yield one frame before heavy work

```typescript
const handleComplete = () => {
  setShowLoader(true);     // UI paints the loader immediately
  setTimeout(() => {       // ~80ms yield lets the frame paint
    finalizeSession();
    setShowCelebration(true);
  }, 80);
};
```

---

### Pattern 4 — Reliable Touch Handling on Android

#### ❌ Before: `onTouchEnd` on `Animated.View` silently ignored on Android

```tsx
<Animated.View onTouchEnd={handleDismiss}>
  <LoaderContent />
</Animated.View>
```

#### ✅ After: Wrap with `Pressable` for guaranteed touch capture

```tsx
<Pressable onPress={handleDismiss}>
  <Animated.View>
    <LoaderContent />
  </Animated.View>
</Pressable>
```

---

## 🤖 Supported AI Tools

| Tool | Config File | Auto-installed |
|---|---|---|
| **Antigravity IDE** | `plugin.json` + skills | ✅ via `agy plugin install` |
| **Cursor** | `.cursorrules` | ✅ via `npx` installer |
| **Claude Code** | `CLAUDE.md` | ✅ via `npx` installer |
| **Windsurf / Cascade** | `.windsurfrules` | ✅ via `npx` installer |
| **Cline / Roo Code / OpenCode** | `.clinerules` | ✅ via `npx` installer |

---

## 🗺️ Reference Guides

### UI/UX Design (`skills/ui-ux-design/references/`)

| Guide | Topics Covered |
|---|---|
| `visual-hierarchy-layout.md` | Layout tactics, color systems, shadows, elevation |
| `interaction-foundations.md` | Affordances, signifiers, conceptual models |
| `goal-directed-interaction.md` | Interaction posture, excise elimination, user flows |
| `ui-patterns-navigation.md` | Reusable UI and navigation patterns |
| `behavioral-ux-cognition.md` | Cognitive psychology, visual perception, behavioral nudges |
| `typography-grid-systems.md` | Modular scale, baseline grid, micro-typography |
| `touch-ergonomics-accessibility.md` | Touch targets, WCAG AA, platform conventions |

### Backend Architecture (`skills/backend-architecture/references/`)

| Guide | Topics Covered |
|---|---|
| `code-craftsmanship.md` | Functions, naming, refactoring smells, error handling |
| `architectural-boundaries.md` | Dependency Rule, use cases, ports & adapters |
| `distributed-data-systems.md` | Replication, partitioning, transactions, consensus |
| `idiomatic-oop-design.md` | Robust Java/Kotlin, design patterns, SOLID |
| `outside-in-tdd.md` | Walking skeleton, mocking guidelines, test pyramid |
| `cloud-native-frameworks.md` | Spring Boot, Jakarta EE, microservice patterns |

---

## 📋 Quick Decision Table

| Situation | Skill to Use |
|---|---|
| New screen / component layout | `ui-ux-design` |
| Color palette or typography | `ui-ux-design` |
| Touch target or accessibility audit | `ui-ux-design` |
| REST API design | `backend-architecture` |
| Database schema or query design | `backend-architecture` |
| Service layer refactoring | `backend-architecture` |
| Writing tests before feature code | `backend-architecture` |
| React context re-render issues | See Real-World Patterns above |

---

## 🤝 Contributing

1. Fork the repo: `https://github.com/maheshfunde/ai-coding-guidelines`
2. Add or improve guidelines in `skills/<name>/SKILL.md` or `references/`
3. Submit a PR with before/after code examples

---

## 📄 License

MIT © [Mahesh Funde](https://github.com/maheshfunde)
