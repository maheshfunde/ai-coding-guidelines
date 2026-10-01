---
name: ui-ux-design
description: Use when designing user interfaces, creating layouts, styling components, choosing color palettes or typography, auditing UX flow, eliminating cognitive friction, or reviewing frontend implementations for visual hierarchy and usability.
---

# UI/UX & Interaction Design Master Guide

## Overview
A unified engineering and design standard synthesizing modern visual design systems, human-centered interaction principles, cognitive psychology, typography, and platform ergonomics.

---

## When to Use
- Designing a new web, mobile, or desktop screen from scratch
- Choosing typography, modular scale, line lengths, or baseline grids
- Structuring layout hierarchy, whitespace, borders, elevation, and shadows
- Building color palettes (functional neutrals, primary accent, semantic status)
- Eliminating cognitive friction, confusing feedback, or unusable interaction flows in software
- Auditing UI for interaction posture, touch target sizing, or accessibility

**When NOT to use:**
- Writing pure database queries or backend infrastructure logic (use `backend-architecture` instead).
- Writing project-specific build configurations without UI implications.

---

## Core Principles & Mental Models

### 1. Visual Hierarchy & Spacing Systems
- **Feature-first, not layout-first**: Design the core workflow widget before drawing the outer chrome/header/sidebar.
- **Grayscale first**: Establish spacing, typography weights, and contrasts in pure grayscale before introducing color.
- **Systematize all values**: Never pick ad-hoc pixels. Constrain choices to fixed geometric scales:
  - Spacing scale: `4px, 8px, 12px, 16px, 24px, 32px, 48px, 64px`.
  - Type scale: `12px (caption), 14px (body-sm), 16px (body), 18px (lead), 20px (h4), 24px (h3), 30px (h2), 36px+ (h1)`.
- **De-emphasize secondary content**: Instead of making key elements bigger/bolder, make secondary text smaller, softer (`slate-500`), or lower-contrast.
- **One primary action per screen**: Exactly one prominent visual button. All other actions must be secondary (outlined) or tertiary (ghost/text).

### 2. Affordances, Signifiers & Mental Models
- **Signifiers over assumptions**: Interactive elements must clearly indicate *where* and *how* to interact (clickable states, hover affordance, touch padding).
- **Immediate feedback**: Every user action (tap, click, swipe, submit) must provide instant visible feedback (<100ms) and ongoing progress for operations >300ms.
- **Natural mapping**: Spatial controls must mirror their real-world effects (e.g. scroll direction, slider orientation, ordering).
- **Error prevention over recovery**: Constrain invalid inputs, confirm destructive actions, provide safe undo channels.

### 3. Interaction Posture & User Flow
- **Match interface posture**:
  - *Sovereign* (full-screen workspace/editor): Restrained chrome, dark or neutral backgrounds, dense high-efficiency tooling.
  - *Transient* (dialogs, utilities, calculators): Self-explanatory, single-task focus, dismissible.
- **Eliminate excise**: Remove unnecessary steps, duplicate confirmations, technical jargon, or file management hassles from the user's primary mental goal.

### 4. Human Cognition & Memory Limits
- **Working memory limits**: Users can hold only 3–4 chunks of novel information simultaneously. Chunk forms and lists into cohesive clusters.
- **Progressive disclosure**: Show only the essential choices upfront; reveal advanced settings on demand.
- **Recognition over recall**: Give visible cues, recent items, and previews rather than forcing users to remember IDs, names, or syntax.
- **Fitts' Law**: Make primary target zones large and place them close to thumb zones on mobile or screen edges on desktop.

### 5. Micro-Typography & Grid Alignment
- **Measure (Line Length)**: Optimal body line length is **45 to 75 characters** (approx. 2 to 3 alphabets). Never let body text span unbounded 100% widths.
- **Leading / Line-Height**: Tighten line-height for headings (`1.1 - 1.25`); loosen line-height for body copy (`1.5 - 1.6`).
- **Hierarchy through contrast**: Combine font weight (Medium/SemiBold) and color tint instead of inflating font size excessively.

### 6. Platform Ergonomics & Touch Guidelines
- **Minimum interactive touch targets**: Minimum **44×44pt** (iOS) or **48×48dp** (Android/Web).
- **Dynamic type & contrast**: Meet WCAG AA minimum contrast ratio: **4.5:1** for regular text, **3:1** for large text and UI components.

---

## Quick Reference Checklist

| Category | Rule of Thumb |
| :--- | :--- |
| **Buttons** | 1 Primary filled, remaining actions Outlined or Ghost. |
| **Card Borders** | Prefer subtle `1px` border with light neutral color over harsh, dark drop shadows. |
| **Spacing** | Double the space between distinct sections compared to space within a section. |
| **Forms** | Single-column forms outperform multi-column. Always align labels directly above inputs. |
| **Destructive Actions** | Tint red/error color, separate from primary confirm button, require explicit confirmation. |
| **Empty States** | Explain *what this is*, *why it is empty*, and provide a single direct action to add content. |

---

## Detailed Topic Guides
For deep dives into specific interaction patterns, heuristics, and tactical examples, consult the dedicated guides in the `references/` directory:

- [Visual Design & Layout Guide](references/visual-hierarchy-layout.md): Layout tactics, color systems, shadows, and spacing rules.
- [Affordances & Mental Models Guide](references/interaction-foundations.md): Affordances, signifiers, interaction mappings, and conceptual models.
- [Goal-Directed Interaction Design](references/goal-directed-interaction.md): Interaction postures, user flow, and excise elimination.
- [Interaction Design Patterns Guide](references/ui-patterns-navigation.md): Reusable UI interaction and navigation patterns.
- [Cognitive Psychology & Behavioral UX](references/behavioral-ux-cognition.md): Cognitive psychology, visual perception, and behavioral nudges.
- [Typography & Grid Systems Guide](references/typography-grid-systems.md): Typesetting, modular scales, baseline grids, and micro-typography.
- [Touch Ergonomics & Accessibility Standards](references/touch-ergonomics-accessibility.md): Touch ergonomics, system typography, accessibility, and platform conventions.
