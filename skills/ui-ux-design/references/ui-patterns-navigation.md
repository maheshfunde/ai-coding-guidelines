# Interaction Design Patterns & UI Architecture: LLM System Instructions & Guidelines

This document distills comprehensive interaction principles, pattern languages, and structural layout guidelines. It serves as a direct system instruction and prompt reference for Large Language Models (LLMs) to enforce proven UI/UX patterns when designing, generating, or refactoring user interfaces and software workflows.

---

## 1. User Behavior Models & Core Design Directives

When generating or structuring interfaces, assume users exhibit predictable behavioral tendencies. Design to support these behaviors rather than fight them:

1. **Safe Exploration & Instant Gratification**:
   * Users want to try things without fear of breaking the system or losing work. Always provide easy reversibility, clear undo paths, and non-destructive defaults.
   * Lead directly into the primary task. Do not block users with mandatory registrations, lengthy onboarding wizards, or slow splash screens.
2. **Satisficing & Path of Least Resistance**:
   * Users choose the "good enough" path rather than searching for the optimal feature. Keep primary pathways obvious so satisficing leads to correct outcomes.
3. **Changes in Midstream & Deferred Choices**:
   * Users frequently alter their goals mid-task or postpone decision-making. Make forms and dialogs re-entrant; never lock users into strict linear flows unless safety requires it.
4. **Habituation & Spatial Memory**:
   * Users rely on muscle memory and spatial locations of controls. Keep core actions and navigation elements in consistent relative positions across views. Never rearrange UI elements dynamically in ways that break spatial memory.
5. **Streamlined Repetition & Keyboard Power**:
   * For frequent tasks, enable single-click or single-keystroke repetitive execution. Form-heavy applications must support complete keyboard-only traversal (`Tab`, `Shift+Tab`, `Enter` default action, arrow keys).

---

## 2. Information Architecture & Content Organization

Organize features and content according to domain-specific mental models (nouns vs. verbs) before selecting physical UI controls:

### Noun-Centric vs. Verb-Centric Organization
* **List of Objects (Nouns)**: Best for data-rich tools (e.g., inboxes, document libraries, photo galleries). Organize via linear lists, 2D sortable tables, or parent-child hierarchies.
* **List of Actions (Verbs)**: Best for task-driven tools (e.g., "Create Invoice", "File Taxes", "Convert File"). Use plain-language task listings.

### Core Architectural Patterns
* **Two-Panel Selector**:
  * *Rule*: Use side-by-side panels where selecting an item in the left/top panel immediately displays its full details or contents in the right/bottom panel (e.g., email clients, file explorers).
  * *Constraint*: Selection must occur on single-click or arrow key navigation without requiring full page loads.
* **One-Window Drilldown**:
  * *Rule*: Replaces page content within a single window as the user navigates down a hierarchy.
  * *Constraint*: Always provide explicit, prominent back buttons or breadcrumbs so users never feel trapped. Highly suited for mobile and small-screen layouts.
* **Canvas Plus Palette**:
  * *Rule*: For visual editors or builders, place an iconic palette of tools next to a large blank canvas area where created objects are placed and manipulated.
* **Alternative Views**:
  * *Rule*: Allow users to toggle between structurally different views of the same dataset (e.g., List view vs. Grid view vs. Map view) to suit different tasks.
* **Wizard**:
  * *Rule*: Guide users through complex, multi-step, or unfamiliar tasks in a prescribed sequential order.
  * *Constraint*: Keep wizards short (3–5 steps max), display a sequence map ("Step X of Y"), provide "Back" and "Cancel" escape hatches, and preserve entered state.
* **Extras on Demand**:
  * *Rule*: Display the top 20% most critical content up front. Provide a simple gesture or toggle ("Show Advanced Options") to expose remaining low-frequency controls.

---

## 3. Navigation, Signposts & Wayfinding

Minimize the "cost of navigation" (mental context-switching and click distance). Ensure users always know where they are, where they can go, and how to return.

### Signposts & Wayfinding Rules
* **Clear Entry Points**: Present a minimal, task-oriented set of primary entry points on landing screens using plain-language descriptions rather than technical jargon.
* **Global Navigation**: Place a persistent, consistent navigation bar at the top or side of every major page. Highlight the current active section ("You are here").
* **Hub and Spoke**: Route users from a central hub page to specialized, isolated sub-task pages ("spokes"), requiring them to return to the hub upon completion. Ideal for mobile apps and constrained workflows.
* **Pyramid Navigation**: Link adjacent detail items directly (`Previous` / `Next`) so users can scan through items sequentially without returning to the parent list.
* **Modal Panel**: Isolate critical tasks (e.g., file saving, deletion confirmation) by blocking background interaction until resolved. *Use sparingly to prevent workflow disruption.*
* **Breadcrumbs**: Show the full hierarchical parent path (`Home > Category > Subcategory > Item`) as clickable links for deep navigational structures.
* **Annotated Scrollbar**: Enhance standard scrollbars with visual markers (e.g., search term locations, error highlights, page dividers) to turn scrollbars into interactive mini-maps.
* **Escape Hatch**: Include an immediate, obvious exit button/link (`Cancel`, `Return to Dashboard`) on every locked or sequential screen.

---

## 4. Page Layout & Visual Hierarchy

Manipulate visual weight to convey informational structure, guide eye movement, and eliminate visual noise.

### Visual Hierarchy & Flow Mechanics
1. **Primary Focal Points**: The most important UI element must dominate visually (via size, bold contrast, or prominent placement). Secondary controls must cluster around it in smaller panels.
2. **Visual Flow**: Arrange controls along natural scanning paths (top-to-bottom, left-to-right for LTR languages). Place the final completing action button ("Submit", "Save", "Done") at the terminal point of the visual flow.
3. **Gestalt Grouping & Alignment**:
   * *Proximity*: Cluster related controls together; separate distinct groups with whitespace.
   * *Alignment*: Align forms along consistent vertical axes. In two-column forms, right-align labels against left-aligned input controls.

### Structural Layout Patterns
* **Center Stage**: Allocate the largest subsection of the screen to the primary workspace (e.g., document view, main chart, canvas), surrounding it with smaller secondary panels.
* **Titled Sections**: Group dense information into visually distinct chunks using strong, descriptive section headings or subtle border boxes.
* **Card Stack (Tabs)**: Stack content panels directly on top of each other, exposing only one panel at a time via top or side tabs.
* **Closable & Movable Panels**: Allow users to collapse, expand, or reposition secondary tool panels to customize their workspace.
* **Responsive Disclosure**: Start with a minimal UI and reveal additional steps/controls dynamically as the user completes preceding steps on the same page.
* **Responsive Enabling**: Display all potential workflow steps upfront, but keep future controls disabled (`grayed out`) until prerequisite actions are satisfied.
* **Liquid Layout**: Dynamically reflow and scale interface elements as the viewport window resizes to keep the visual space filled gracefully.

---

## 5. Actions, Commands & Transaction Handling

Design command structures around human action verbs, minimizing cognitive friction and preventing irreversible data loss.

### Command Patterns
* **Button Groups**: Cluster related actions into small horizontal or vertical button sets (e.g., `Save`, `Cancel`, `Preview`).
* **Action Panel (Task Pane)**: Use persistent, always-visible sidebars containing categorized lists of task actions instead of hidden pull-down menus.
* **Prominent "Done" Button**: Make the final transaction-closing button visually distinct, large, and placed at the natural end of the task flow.
* **Smart Menu Items**: Dynamically update menu item text to explicitly describe the impending operation (e.g., "Delete 3 selected files" instead of just "Delete").

### Safety & Error Recovery Mechanics
* **Preview**: Show live, immediate visual feedback of changes before the user commits to them (e.g., font size hover preview, image cropping overlay).
* **Multi-Level Undo & Command History**: Maintain a linear stack of user actions allowing unlimited undo/redo capabilities (`Ctrl+Z` / `Ctrl+Y`).
* **Progress Indicator**: For operations taking >1 second, show explicit progress bars or spinners; for long tasks (>5 seconds), allow background execution or cancellation.

---

## 6. Complex Data Presentation: Trees, Tables & Visualizations

Present data visually so users can perceive patterns, spot anomalies, and draw instant conclusions ("show, don't tell").

### Focus Plus Context
Always allow users to inspect fine details while maintaining awareness of the global dataset structure.

### Data Patterns & Visualization Techniques
* **Overview Plus Detail**: Display a small, zoomed-out overview map alongside a larger detail viewport.
* **Dynamic Queries & Filtering**: Provide interactive controls (sliders, checkboxes) that update the visual data rendering in real-time (<100ms response).
* **Data Brushing**: Highlight data items selected in one view simultaneously across all other open views or charts.
* **Datatips**: Show precise data values in lightweight hover tooltips when the cursor pauses over a data point or chart element.
* **Sortable Table**: Allow single and multi-column sorting by clicking table header columns, using visual direction arrows (`▲`/`▼`).
* **Row Striping**: Alternate background shading across table rows to assist horizontal tracking across wide data tables.
* **Cascading Lists**: Express deep hierarchies as a series of side-by-side selectable lists (e.g., macOS Miller Columns).
* **Tree Table**: Combine hierarchical expandable tree nodes in the first column with structured tabular attribute data in adjacent columns.
* **Treemap**: Display nested hierarchical or multi-attribute quantitative data as proportional colored rectangles.

---

## 7. Forms, Controls & Input Design

Minimize input effort, prevent entry errors, and handle invalid states gracefully inline.

### Control Selection Guidelines
* **Binary Choices**: Use single Checkboxes or Toggle Switches.
* **Small Choices (2–5 items)**: Use Radio Button groups (all visible).
* **Medium/Large Choices (>5 items)**: Use Dropdown Lists or Autocompleting Combo Boxes.
* **Bounded Numbers**: Use Sliders for spatial intuition; use Spin Boxes or Text Fields for exact numerical precision.
* **Date & Time Selection**: Use Dropdown Choosers containing interactive calendar popups alongside flexible text input fields.

### Form Usability Patterns
* **Forgiving Format**: Accept arbitrary user input syntaxes (e.g., phone numbers as `(123) 456-7890`, `1234567890`, or `123-456-7890`) and parse them intelligently server/client-side.
* **Structured Format**: Break complex formatted data (e.g., SSN, credit cards) into dedicated segmented fields when strict formatting is mandatory.
* **Fill-in-the-Blanks**: Present input fields embedded naturally within a prose sentence to clarify intent for novice users.
* **Input Hints & Prompts**: Place contextual example text (`e.g., john@example.com`) beside or prefilled inside empty input fields as light placeholder text.
* **Autocompletion**: Offer real-time inline predictions or suggestion dropdowns as the user types into text fields.
* **List Builder**: Use two side-by-side lists ("Source" and "Destination") with `Add ▶` and `◀ Remove` buttons to construct ordered or unordered item selections.
* **Good Defaults**: Prefill form controls with intelligent, high-probability default values to eliminate redundant entry.
* **Same-Page Error Messages**: Highlight invalid fields directly inline with clear red indicators and descriptive error text placed right next to the offending control.

---

## 8. Builders, Editors & Direct Manipulation

For creative tools, graphics editors, and document authoring environments, prioritize fluidity and spatial precision:

* **Edit-in-Place**: Allow users to click directly on displayed text or elements to edit them immediately without opening a separate modal dialog.
* **Smart & Composite Selection**: Support both single-item clicking and multi-item group selection (rubber-band selection boxes, lasso selection, Shift-click additive selection).
* **Spring-Loaded Modes**: Temporarily activate a tool mode only while a modifier key is held down (e.g., holding `Spacebar` to pan), reverting automatically upon release.
* **Alignment Aids (Guides, Magnetism, Constrained Resize)**:
  * Provide active snap-to-grid alignment (**Magnetism**).
  * Display dynamic alignment lines when moving objects (**Guides**).
  * Constrain aspect ratios during resizing when holding modifier keys (**Constrained Resize**).

---

## 9. LLM Code Generation & UI Audit Checklist

When generating frontend code (HTML/CSS, React, Vue, SwiftUI, Flutter, Jetpack Compose), verify that the output satisfies this audit checklist:

- [ ] **Visual Hierarchy**: Does the primary action or workspace dominate the page layout visually?
- [ ] **Navigation Safety**: Is there an obvious, single-click escape hatch or back button on every sub-view or modal?
- [ ] **Form Error Handling**: Are form validation errors displayed inline next to input fields rather than in generic modal alerts?
- [ ] **Keyboard Accessibility**: Can all interactive elements be traversed sequentially via `Tab` and activated via `Enter`/`Spacebar`?
- [ ] **Responsive Reflow**: Does the layout use liquid principles (flexbox/grid) to adapt smoothly to varying container widths?
- [ ] **Feedback & Reversibility**: Do destructive or complex actions provide live previews, clear progress indicators, or multi-level undo support?
