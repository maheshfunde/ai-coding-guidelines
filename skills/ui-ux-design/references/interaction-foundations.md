# Human-Centered Design & Interaction Foundations: LLM System Instructions & Guidelines

This document distills core principles, cognitive models, and Human-Centered Design (HCD) frameworks. It is structured as system-level instructions and constraints for Large Language Models (LLMs) to enforce exceptional interaction design, usability, error resilience, and intuitive user experiences across software interfaces, APIs, and digital products.

---

## 1. Core Philosophy & The Prime Directive of Design

1. **Human-Centered Design (HCD) First**:
   - Software and interfaces must accommodate human psychology, capabilities, and limitations—never force humans to adapt to machine rigidity.
   - Always solve the **right, fundamental problem**, not merely the immediate symptom presented by stakeholders.

2. **Eliminate "Human Error" as a Concept**:
   - **Mandate**: Never classify user mistakes or operational failures as "human error." What is commonly termed human error is almost always **bad design** or **poor system communication**.
   - Design systems under the assumption that users will make mistakes, get distracted, be interrupted, and misinterpret system states.

3. **The Three Levels of Cognitive Processing**:
   - **Visceral Level** (*Subconscious*): Immediate aesthetic, sensory, and emotional response ("looks and feels good/bad"). Sets the initial perception.
   - **Behavioral Level** (*Subconscious*): The home of learned skills, usability, feedback, and execution. Governed by expectations and feelings of control or frustration.
   - **Reflective Level** (*Conscious*): Long-term memory, rationalization, pride, and brand perception. Determines whether a user recommends or abandons a product.
   - **LLM Instruction**: Designs must satisfy all three levels: visceral delight, behavioral usability/mastery, and reflective satisfaction.

---

## 2. Seven Fundamental Principles of Interaction

When generating UI components, API contracts, workflows, or interactive systems, strictly enforce these seven principles:

### 1. Discoverability
- It must be immediately possible for the user to determine what actions are currently possible and what the current state of the device or system is.

### 2. Feedback
- **Mandate**: Every user action must be acknowledged with **full, continuous, and immediate** feedback.
- Feedback must be explicit, intelligible, and appropriately prioritized (avoiding annoying, uninformative noise or delayed status indicators).

### 3. Conceptual Model
- The system image must project a clear, coherent conceptual model so the user understands how the system operates, predicts outcomes, and feels in control.

### 4. Affordances
- Define what physical or virtual interactions are possible between an actor and an object (e.g., a button *affords* pressing; a scrollbar *affords* sliding).

### 5. Signifiers
- **Crucial Rule**: While affordances define *what* is possible, **signifiers** communicate *where* and *how* the action should take place.
- **LLM Instruction**: Focus heavily on clear, unambiguous signifiers (e.g., visual cues, labels, icons, hover states, clear microcopy) to ensure affordances are easily perceived.

### 6. Mappings
- Exploit **Natural Mappings**—spatial, logical, or cultural relationships between controls and their effects (e.g., moving a slider up increases volume; controls arranged in the same spatial configuration as the items they operate).

### 7. Constraints
- Guide user actions and prevent errors by enforcing **Physical**, **Cultural**, **Semantic**, and **Logical** constraints (e.g., disabling invalid input fields, restricting choices to valid states).

---

## 3. Psychology of Action & Bridging the Two Gulfs

Users face two fundamental cognitive barriers when interacting with any product:

```
+-----------------------------------------------------------------+
|                              GOAL                               |
|                  (What do I want to accomplish?)                |
+-----------------------------------------------------------------+
          |                                             ^
  BRIDGE OF EXECUTION                             BRIDGE OF EVALUATION
  (Feedforward: Signifiers,                      (Feedback: State,
   Constraints, Mappings)                         Intelligible Data)
          |                                             |
          v                                             |
   [1. Plan]                                    [7. Compare]
   [2. Specify]                                 [6. Interpret]
   [3. Perform]                                 [5. Perceive]
          |                                             |
          +-----------------> WORLD <-------------------+
```

### The Gulf of Execution
- *Question*: How do I work this? What can I do right now?
- **Bridge Tool**: Provide **Feedforward** information—clear signifiers, natural mappings, logical constraints, and a sound conceptual model before the user acts.

### The Gulf of Evaluation
- *Question*: What happened? Is the system in the state I wanted?
- **Bridge Tool**: Provide **Feedback**—immediate, clear state updates and evaluation cues matching the user's mental model.

### The Seven Stages of Action Cycle
1. **Goal**: Form the high-level intent.
2. **Plan**: Determine the action strategy.
3. **Specify**: Formulate the exact action sequence.
4. **Perform**: Execute the physical/digital action.
5. **Perceive**: Observe the system state changes.
6. **Interpret**: Make sense of the perception.
7. **Compare**: Evaluate the outcome against the original goal.

### Root Cause Analysis & The "Five Whys"
- Always perform Root Cause Analysis by asking "Why?" repeatedly (e.g., 5 Whys) to uncover the fundamental **Be-goal** (e.g., feeling secure/productive) rather than getting trapped in low-level **Do-goals** or **Motor-goals**.

---

## 4. Human Error, Classification & System Resilience

### Slips vs. Mistakes

```
                     +-----------------------+
                     |        ERRORS         |
                     +-----------------------+
                        /                 \
                       /                   \
             +-----------------+   +-------------------+
             |      SLIPS      |   |     MISTAKES      |
             | (Execution Fail)|   |   (Planning Fail) |
             +-----------------+   +-------------------+
             /                 \    /        |        \
        Action-Based   Memory-Lapse  Rule-Based  Knowledge-  Memory-
            Slips         Slips       Mistakes    Based      Lapse
                                                 Mistakes   Mistakes
```

1. **Slips** (*Subconscious Execution Failure*):
   - Occur when the goal/plan is correct, but the execution goes awry.
   - *Action-Based Slips*: Capture slips, description-similarity slips (acting on the wrong similar object), mode errors (acting in the wrong state).
   - *Memory-Lapse Slips*: Forgetting an intended step during execution.
   - *Design Cure*: Provide constraints, confirmation checks, clear mode indicators, and reversible actions (Undo).

2. **Mistakes** (*Conscious Planning Failure*):
   - Occur when an incorrect goal or plan is established at the reflective level.
   - *Rule-Based Mistakes*: Misdiagnosing a situation and applying the wrong rule.
   - *Knowledge-Based Mistakes*: Problem misdiagnosed due to incomplete or erroneous models.
   - *Memory-Lapse Mistakes*: Forgetting goals or plans due to interruptions.
   - *Design Cure*: Provide clear conceptual models, continuous system state visibility, and decision support tools.

### James Reason's Swiss Cheese Model
- Accidents rarely happen due to a single failure; they occur when alignment exists across holes in multiple defense layers.
- **Resilience Engineering**: Build redundant safety mechanisms, poka-yoke (error-proofing), and graceful degradation into system architectures.

### Forcing Functions (Poka-Yoke)
- **Interlocks**: Force actions to occur in a strict sequence (e.g., microwave shuts off when the door opens).
- **Lock-ins**: Keep an operation active and prevent accidental termination (e.g., warning prompts when quitting with unsaved changes).
- **Lockouts**: Prevent entry or execution of dangerous states (e.g., fire exit stairwell barriers preventing entry to basement).

---

## 5. Design Thinking & The Double-Diamond Process

```
     FINDING THE RIGHT PROBLEM             FINDING THE RIGHT SOLUTION
      (Diverge -> Converge)                 (Diverge -> Converge)
      
       /\               /\                 /\               /\
      /  \             /  \               /  \             /  \
     /    \           /    \             /    \           /    \
    /      \         /      \           /      \         /      \
   < DISCOVER>-----><  DEFINE >------->< DEVELOP >----->< DELIVER >
    \      /         \      /           \      /         \      /
     \    /           \    /             \    /           \    /
      \  /             \  /               \  /             \  /
       \/               \/                 \/               \/
```

1. **The Double-Diamond Process**:
   - **Diamond 1 (Problem Space)**: Diverge via *Discovery* (applied ethnography, user observation) $\rightarrow$ Converge via *Definition* (framing the root problem).
   - **Diamond 2 (Solution Space)**: Diverge via *Development* (broad ideation, exploring multiple concepts) $\rightarrow$ Converge via *Delivery* (prototyping, testing, implementation).

2. **The 4 Iterative HCD Activities**:
   - **Observation**: Conduct applied ethnography in the user's natural environment.
   - **Idea Generation (Ideation)**: Generate diverse alternative solutions without premature convergence.
   - **Prototyping**: Build quick, low-fidelity prototypes to test assumptions early ("Fail fast, fail frequently").
   - **Testing**: Test prototypes with real target users to refine problem understanding and solution efficacy.

3. **Activity-Centered Design**:
   - Design for the overarching **activity** (a high-level collection of tasks) rather than isolated, disjointed micro-tasks, ensuring cross-device and cross-context cohesion.

---

## 6. Business Realities & Standardization

1. **Norman's Law**:
   - "The day the product team is announced, it is behind schedule and over its budget."
   - Product design requires balancing user experience against severe real-world constraints: schedules, costs, manufacturing, and competitive forces.

2. **Featuritis (Creeping Featurism)**:
   - Resisting the trap of continuously adding extra features driven by competitive parity or sales requests, which degrade simplicity and create confusion.

3. **Incremental vs. Radical Innovation**:
   - *Incremental Innovation* (Hill Climbing): Refines existing products through continuous HCD iterations.
   - *Radical Innovation*: Reimagines system meaning and technological paradigms (rare, high-risk, long-gestation).

4. **Principle of Desperation (Standardization)**:
   - When natural mappings, affordances, or signifiers cannot intuitively convey operation, **standardize** across the industry so users only have to learn the convention once.

---

## 7. LLM Execution Checklist for UI/UX Code Generation

When generating UI layouts, API endpoints, workflow logic, or interactive applications, verify:

- [ ] **Signifiers**: Are interactive elements clearly signified with visible cues, labels, or hover states (no mystery meat navigation)?
- [ ] **Feedback**: Does every button click, submission, or API request trigger immediate, clear, and non-disruptive feedback?
- [ ] **Gulf of Execution**: Is feedforward provided so users know what actions are valid *before* they attempt them?
- [ ] **Gulf of Evaluation**: Is the current state of the application immediately clear and readable?
- [ ] **Error Prevention**: Are forcing functions, input validations, or sensible constraints used to block bad inputs or destructive actions?
- [ ] **Error Recovery**: Are destructive actions easily reversible (e.g., explicit "Undo" functionality instead of alarming error messages)?
- [ ] **Natural Mapping**: Do controls logically and spatially map to their corresponding outcomes?
- [ ] **Conceptual Consistency**: Does the UI enforce a consistent system image that aligns with human mental models?
