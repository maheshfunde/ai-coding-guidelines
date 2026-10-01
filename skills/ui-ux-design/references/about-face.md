# Goal-Directed Interaction Design: LLM System Instructions & Guidelines

This document synthesizes core interaction design principles, frameworks, and interface rules. It serves as a direct system instruction and prompt reference for Large Language Models (LLMs) to enforce Goal-Directed Design (GDD), persona-centric architectures, flow-state orchestration, excise elimination, and idiomatic interface patterns.

---

## 1. The Triad of Product Success & Core Mandates

1. **The Product Success Triad**:
   - Every successful digital product stands on three equal pillars: **Capability** (Engineering/Technology), **Viability** (Business), and **Desirability** (Design).
   - Design provides the missing human connection. Technical functionality without goal-directed behavior design results in complex, frustrating, and alienating products.
2. **Behavior First**:
   - Interaction design is primarily the design of **behavior over time**, not merely static form or content.
   - Software must adapt to human mental models rather than forcing humans to adapt to computer implementation models.
3. **The Prime Directive of Interaction Design**:
   - **Don't make the user feel stupid.**
   - Eliminate software behaviors that cause users to make big mistakes, require excessive effort, bore them, or make them feel incompetent.

---

## 2. Models of Interaction

### Three Models Framework
- **Implementation Model**: How the software is actually built, coded, and structured (database schemas, API calls, internal algorithms).
- **Mental Model**: How the user perceives their job, task, and how the system works (simple, cause-and-effect, goal-oriented, non-technical).
- **Represented Model (Designer's Model)**: How the designer chooses to present the software's functioning to the user.

**LLM Instruction**: The represented model must match the user's mental model as closely as possible. Never leak the implementation model into the UI (e.g., raw SQL errors, exposed database IDs, or forcing users through multi-step transactional database state machines).

### Goal-Directed vs. Activity/Task-Centered Design
- **Activities** are composed of **tasks**, which are composed of **actions**, which are composed of **operations** (Norman's hierarchy).
- **Tasks are merely a means to an end; Goals are the end itself.**
- Designing solely for existing tasks traps software in obsolete models. Understanding **why** a user performs an activity (their goals) allows software to streamline or eliminate unnecessary tasks entirely.

---

## 3. User Modeling: Personas & User Goals

### Personas as Composite Archetypes
- Personas are **composite user archetypes** synthesized directly from qualitative ethnographic research (in-context user interviews and observation).
- Personas are **not** real people, but they are grounded in real behavioral patterns. They are **never made up** or based on superficial stereotypes/demographic profiles.
- **The Elastic User**: Precise personas prevent "elastic user" creep, where product teams stretch user definitions to justify arbitrary technical features.

### The 8-Step Persona Creation Process
1. **Group interview subjects by role**.
2. **Identify behavioral variables** (Activities, Attitudes, Aptitudes, Motivations, Skills).
3. **Map interview subjects to behavioral variables** (identifying clusters across ranges).
4. **Identify significant behavior patterns** (correlated groups of variables).
5. **Synthesize characteristics and define goals** (3–5 end goals per persona).
6. **Check for completeness and redundancy**.
7. **Designate persona types** (Primary, Secondary, Supplemental, Customer, Served, Negative/Anti-persona).
8. **Expand description of attributes and behaviors** (third-person narrative, believable non-stereotypical photo).

### Persona Priority Rules
- **Rule of One Primary**: Each distinct interface must focus on a **single primary persona**. A primary persona's needs cannot be satisfied by an interface designed for any other persona.
- **Secondary Personas**: Satisfied by the primary interface with minor, non-disruptive additions.
- **Negative Personas (Anti-Personas)**: Explicitly identified non-targets (e.g., hackers, power-user early adopters for consumer apps) to keep product scope focused.

### The Three Levels of User Goals
Aligning with the multi-level cognitive processing model:
1. **Experience Goals (Visceral Level — How the user wants to feel)**:
   - Universal, personal, and affective (e.g., "Feel smart and in control", "Don't feel stupid", "Feel secure").
   - Directs visual design, motion, responsiveness, tactile feel, and microinteractions.
2. **End Goals (Behavioral Level — What the user wants to do)**:
   - Practical outcomes for using a specific product (e.g., "Clear my inbox by 5:00 PM", "Get the best deal on a flight").
   - Directs interaction architecture, workflow efficiency, and functional capabilities.
3. **Life Goals (Reflective Level — Who the user wants to be)**:
   - Long-term personal aspirations and self-image (e.g., "Be a respected leader", "Live a healthy lifestyle").
   - Directs overall product vision, brand promise, and high-level strategy.

*Non-User Goals*: Business and technical goals are valid constraints but must **never** be satisfied at the user's expense.

---

## 4. Setting the Vision: Scenarios & Requirements

### Scenarios vs. Use Cases
- **Persona-Based Scenarios**: Narrative descriptions of one or more personas using a product to achieve specific goals. They focus on human activities, mental models, and ideal flow before technical details are specified.
- **Use Cases**: System-centric, transactional catalogs of functional steps and edge cases. Use cases treat all interactions as equally important; they belong in later validation phases, not initial interaction design.

### Three Types of Persona-Based Scenarios
1. **Context Scenarios**: Broad, high-level narratives written before drawing UI sketches. Focus on the big picture, environmental context, and goal achievement ("Pretend the interface is magic").
2. **Key Path Scenarios**: Task-oriented walkthroughs detailing major interaction pathways, screen states, and primary UI elements.
3. **Validation Scenarios**: Low-level walkthroughs testing edge cases, alternative paths, boundary conditions, and technical feasibility.

### Requirements Definition Process
Extract requirements from context scenarios categorized into:
- **Data Requirements**: Objects, information, and attributes needed by the persona (e.g., messages, contacts, status).
- **Functional Requirements**: Actions and operations needed on data objects (e.g., filter, send, arrange).
- **Contextual Requirements**: Environmental constraints, device posture, location, and co-located information needs.

---

## 5. Interaction Design Framework & Orchestration (Flow)

### The Interaction Framework Process
1. **Define form factor, posture, and input methods**.
2. **Define functional and data elements** (concrete UI manifestations of requirements).
3. **Determine functional groups and hierarchy** (views, panes, and containers based on mental models).
4. **Sketch the interaction framework** (low-fidelity layout options).
5. **Construct key path scenarios** (storyboarding sequential screen states).
6. **Check designs with validation scenarios**.

### Orchestration & Flow State
- **Flow**: A state of deep, uninterrupted concentration where users are highly productive and satisfied.
- **Invisible Interface**: Interacting with software is a pragmatic exercise. "No matter how cool your interface is, less of it would be better." Interaction mechanics should disappear, leaving users face-to-face with their goals.

### Harmonious Interaction Strategies
- **Follow users' mental models**: Match visual organization to how users think about data.
- **Let users direct rather than discuss**: Prefer direct manipulation tools over dialog questions.
- **Provide choices rather than ask questions**: Offer sensible defaults with inline overrides.
- **Keep necessary tools close at hand**: Inflect the interface so primary tools are 0-1 clicks away.
- **Provide modeless feedback**: Use subtle visual/audible cues instead of modal popups.
- **Design for the probable, anticipate the possible**: Optimize the interface for 99% daily use-cases rather than 1% edge-case dialogs.
- **Avoid blank slates**: Pre-populate initial views with reasonable defaults, templates, or recent items.

---

## 6. Eliminating Interaction Excise

### Excise Defined
**Excise** is extra work forced on the user by the tool or system that does not contribute directly to reaching their goal.

### Taxonomies of Excise to Eliminate
1. **Navigational Excise**:
   - Excessive window/screen hopping, deep menu hierarchies, and multiple adjacent panes.
   - Keep views to a minimum; use unified, multi-pane layouts for sovereign applications.
2. **Modal Excise**:
   - Interrupting user flow with confirmation dialogs ("Are you sure?"), alert dialogs, or asking permission before performing safe actions.
   - Replace confirmations with a robust, multi-level **Undo facility**.
3. **Stylistic & Visual Excise**:
   - Overly stylized graphics, heavy 3D borders, excessive visual noise, or crowded layouts that force visual decoding work.
4. **Administrative & Storage Excise**:
   - Forcing users to manage file paths, manual file saves ("Save As..."), or file format conversions.

### The Considerate & Smart Product
- **Task Coherence**: Remember user choices, window positions, recent inputs, and settings across sessions.
- **Advance Knowledge**: Predict likely next actions based on past behavior without asking.
- **Ask Forgiveness, Not Permission**: Execute reasonable actions automatically; provide clear Undo if the user wants to revert.

---

## 7. Platform Postures & Idiomatic Design

### Interface Paradigms
1. **Implementation-Centric**: Exposes internal code mechanics (deprecated).
2. **Metaphoric**: Relies on real-world physical analogies (e.g., desktop, file cabinet). Limited because digital software shouldn't be bound by real-world physics.
3. **Idiomatic**: Based on learning simple, non-metaphorical visual and behavioral idioms (e.g., buttons, toggles, sliders, swiping). Idioms must be learned once, but once learned, provide boundless power.

### Product Postures

#### Desktop Postures
- **Sovereign Posture**:
  - Full-screen, complex applications used continuously for long periods (e.g., IDEs, Photoshop, CAD, spreadsheets).
  - *Rules*: Rich, dense controls; conservative/neutral visual style; extensive keyboard shortcuts; multi-pane layouts; optimized for perpetual intermediates.
- **Transient Posture**:
  - Single-function applications that appear briefly and disappear (e.g., calculators, widgets, pop-up dialogs).
  - *Rules*: Bold, high-contrast controls; simple and obvious UI; zero learning curve; no deep navigation.
- **Daemonic Posture**:
  - Background processes with no persistent main window (e.g., network monitors, printer queues).

#### Mobile & Touch Postures
- **Transient by Nature**: Brief, highly contextual, task-focused interactions.
- **Idioms**: Stack layouts, Screen Carousels, Drawers (Left/Right), Cards, Bottom/Top Navigation Bars.
- **Touch Targets**: Minimum 44×44 pt (iOS) / 48×48 dp (Android) touch targets to accommodate fingertips.

---

## 8. Data Management, Errors, and Undo

### Modern Storage Model
- Eliminate explicit "Save" and "Save As..." modal workflows.
- Automatically save documents and state changes continuously.
- Provide automatic versioning and revision history so users never fear losing work.

### Error Prevention & Rich Modeless Feedback (RVMF)
- **Errors are system failures, not human failures.** Software must absolve the user of blame.
- **Never use dialogs to report normalcy or minor warnings.**
- Use **Rich Visual Modeless Feedback (RVMF)**: Dynamically update status text, progress meters, and inline icons in the primary window without halting user flow.

### Robust Undo Design
- **Blind Undo vs. Explanatory Undo**: Provide clear text describing what action will be undone (e.g., "Undo Delete 'Document.pdf'").
- **Multi-Level Linear Undo**: Allow users to step backward through action history.
- **Reversible Actions**: Every destructive action must be reversible via Undo rather than guarded by an "Are you sure?" confirmation prompt.

---

## 9. LLM Execution Checklist for Interaction Design

When generating UI specifications, wireframes, user flows, or frontend code, verify:

- [ ] **Persona Grounding**: Is the design explicitly targeted at a single, well-defined primary persona and their end goals?
- [ ] **Mental Model Alignment**: Does the UI vocabulary and structure match the user's mental model rather than database/API implementation details?
- [ ] **Excise Audit**: Are unnecessary confirmation dialogs ("Are you sure?"), modal popups, and manual save steps eliminated?
- [ ] **Posture Compliance**: Does the visual density and control richness match the application's posture (Sovereign vs. Transient vs. Mobile)?
- [ ] **Direct Manipulation & Pliancy**: Do interactive elements provide clear static affordances and dynamic pliant feedback (hover/active states)?
- [ ] **Flow & Modeless Feedback**: Is status information conveyed inline (RVMF) without halting user concentration?
- [ ] **Commensurate Effort**: Are complex or advanced features hidden behind progressive disclosure while primary tools remain immediately accessible?
- [ ] **Error Immunity & Reversibility**: Are destructive actions guarded by multi-level Undo rather than disruptive modal prompts?
