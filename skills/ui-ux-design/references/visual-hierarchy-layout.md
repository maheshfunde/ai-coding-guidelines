# Visual Hierarchy & UI Design Engineering: LLM System Instructions & Guidelines

This document synthesizes complete visual design systems, layout heuristics, and UI engineering tactics. It is structured as direct system-level instructions and rules for Large Language Models (LLMs) to strictly enforce when designing UI layouts, styling component systems, or building digital products.

---

## 1. Core Design Philosophy & Workflow Rules

1. **Start with a Feature, Not a Layout**:
   - **Mandate**: When designing an interface or building a new UI component, start with the core functional element (e.g., input fields, primary action button, main data view) before designing the application "shell" (top navigation, sidebars, page wrappers).
   - **LLM Instruction**: Never output complex outer grids or wrapper layouts before defining the inner feature components.

2. **Detail Comes Later (Grayscale First)**:
   - **Mandate**: Establish hierarchy, spacing, sizing, and contrast in **grayscale** before applying colors, shadows, or custom typefaces.
   - **LLM Instruction**: Design layouts using typography scale, font weight, and structural whitespace first. Color must enhance an already clear hierarchy, never create it from scratch.

3. **Systematize Everything in Advance**:
   - **Mandate**: Never pick arbitrary, ad-hoc pixel values or hex codes during component creation. All UI values must come from pre-defined, restrictive design scales.
   - **LLM Instruction**: Restrict all choices for font sizes, font weights, line heights, margins, padding, border radii, box shadows, and color shades to pre-established system scales.

---

## 2. Visual Hierarchy Rules

1. **Size Isn't Everything**:
   - Do not rely solely on font size to establish hierarchy. Oversized primary text and tiny secondary text ruin layout balance.
   - **Enforce**: Combine font weight and color contrast to create distinction.
     - **Primary Content**: Dark/high-contrast color with bold weight (`font-weight: 600` or `700`).
     - **Secondary Content**: Softer/medium-contrast color (e.g., slate/grey) with normal weight (`font-weight: 400` or `500`).
     - **Tertiary Content**: Lighter grey/muted color.

2. **Never Use Plain Grey Text on Colored Backgrounds**:
   - Plain grey text on a colored panel creates ugly, washed-out contrast.
   - **Correct Rule**: Reduce contrast by reducing opacity of white text (`hsla(0, 0%, 100%, 0.7)`), or choose a tinted hue matching the background color with adjusted lightness.

3. **Emphasize by De-emphasizing**:
   - When an active element fails to pop, do not make it louder or brighter. De-emphasize the surrounding competing elements (e.g., soften inactive navigation items, remove sidebar background colors).

4. **Labels as a Last Resort**:
   - Avoid naive `Label: Value` pairs. Combine data into intuitive strings (e.g., "John Doe (john@example.com)" instead of separate labeled rows), or use visual cues (icons, formatting) to make values self-explanatory.
   - When labels are required, make the label smaller/softer and the data value prominent.

5. **Separate Visual Hierarchy from Document Hierarchy**:
   - Semantic HTML tags (`<h1>`, `<h2>`) define document structure, NOT visual size. Do not make page titles massive simply because they use `<h1>`. Size titles according to interface context.

6. **Button Action Pyramid**:
   - **Primary Actions**: High contrast, solid background fill. Exactly one true primary action per screen context.
   - **Secondary Actions**: Low-contrast background or outlined button style.
   - **Tertiary Actions**: Unobtrusive link-style buttons.
   - **Destructive Actions**: Use secondary or tertiary styling initially; reserve bold red solid fill for the final confirmation dialog.

---

## 3. Layout, Spacing, and Sizing Rules

1. **Start with Too Much Whitespace**:
   - Default to generous whitespace around and inside components. It is easier to pull back excess space than to fix a cramped, noisy interface.

2. **Fixed Spacing & Sizing Scale**:
   - Enforce an exponential/tailored spacing scale (e.g., `4px`, `8px`, `12px`, `16px`, `24px`, `32px`, `48px`, `64px`, `96px`, `128px`).
   - Small pixel changes (`12px` to `16px` = +33%) make a huge difference; large pixel changes (`500px` to `520px` = +4%) are imperceptible.

3. **You Don't Have to Fill the Whole Screen**:
   - Constrain maximum content widths. Form inputs and readouts should have fixed max-widths (e.g., `max-w-md`) rather than stretching across full desktop displays.

4. **Grids Are Overrated**:
   - Do not force every element into equal grid columns. Use fixed pixel widths for sidebars and avatars, letting main content fluidly fill remaining space.
   - Do not shrink or break components onto mobile breakpoints until space actually becomes constrained.

5. **Relative Sizing Doesn't Scale**:
   - Do not use `em` units to scale padding or typography globally across components. Tune component padding, font size, and layout properties independently at each breakpoint.

6. **Avoid Ambiguous Spacing**:
   - Ensure the space **around** a logical group of elements is strictly greater than the space **inside** the group (e.g., form label-to-input gap must be smaller than input-to-next-label gap).

---

## 4. Typography & Text Design Rules

1. **Strict Type Scale**:
   - Use a pre-defined scale in `px` or `rem`: `12px`, `14px`, `16px` (base), `18px`, `20px`, `24px`, `30px`, `36px`, `48px`, `60px`, `72px`.

2. **Line Height Rules**:
   - **Body Text**: Generous line height (`1.5` to `1.625`) for maximum readability.
   - **Headings**: Tight line height (`1.1` to `1.25`) to prevent multiline titles from looking disconnected.

3. **Line Length & Tracking**:
   - **Line Length**: Keep body paragraph widths between 45 and 75 characters (`max-width: 65ch`).
   - **Uppercase Text**: Always add letter-spacing (`tracking-wider` or `letter-spacing: 0.05em`) to uppercase text and reduce font size.
   - **Large Headings**: Slightly reduce letter-spacing (`letter-spacing: -0.02em`) on huge titles to feel tight and polished.

---

## 5. Color System & Accessibility Rules

1. **Ditch Hex for HSL**:
   - Represent colors using **HSL** (Hue, Saturation, Lightness) to intuitively tweak shades, tints, and contrast levels.

2. **Build a Complete Color Palette Up Front**:
   - **Greys**: 5–10 shades ranging from dark charcoal (`HSL 220, 15%, 10%`) to soft off-white (`HSL 220, 15%, 98%`).
   - **Primary Brand Color**: 5–10 shades (100–900).
   - **Accents / Semantic States**: 5–10 shades each for Red (danger), Yellow/Amber (warning), Green (success), and Blue/Teal (info).

3. **Tint Your Greys**:
   - Pure black (`#000000`) and pure grey look unnatural. Tint grey scales with a small amount of your primary brand hue (e.g., cool slate blue-grey or warm brown-grey) for a cohesive design.

4. **Don't Let Lightness Kill Saturation**:
   - As lightness moves toward 0% or 100% in HSL, increase saturation so extreme darks and light background tints do not look muddy or washed out.

5. **Flip the Contrast for Accessible Badges**:
   - Dark badge backgrounds with white text look harsh and draw excessive attention.
   - **Flip Rule**: Use a light tinted background (`100–200` shade) paired with dark colored text (`700–800` shade) for elegant, WCAG-compliant status badges.

6. **Don't Rely on Color Alone**:
   - Always pair color cues with text labels, icons, or visual markers to support color-blind users.

---

## 6. Depth, Elevation & Finishing Touches

1. **Emulate a Light Source**:
   - **Raised Elements (Buttons, Cards)**: Add a subtle light top border or inset shadow (`inset 0 1px 0 hsla(..., 0.15)`) and a soft downward drop-shadow (`0 2px 4px ...`).
   - **Inset Elements (Inputs, Well Panels)**: Add a dark top inset shadow and a subtle light bottom border.

2. **Convey Elevation via Shadows**:
   - Define a 5-level box shadow scale (Lowest = Subtle button, Low = Card, Medium = Dropdown, High = Floating panel, Highest = Modal).
   - Deeper elevations require larger blur radii and higher vertical offsets.

3. **Overlap Elements to Create Layers**:
   - Break flat constraints by overlapping cards across section boundaries (e.g., negative top margin `-mt-12`), or adding overlapping avatar stacks with white cutout borders (`border: 2px solid white`).

4. **Text Over Background Images**:
   - Never place raw text directly on unpredictable background images.
   - **Solutions**: Add a dark overlay (`rgba(0,0,0,0.5)`), apply a bottom-to-top gradient mask, or add a subtle un-offset text shadow glow (`0 0 8px rgba(0,0,0,0.8)`).

5. **Supercharge Defaults & Add Accent Borders**:
   - Customize default form controls, focus rings, and scrollbars using brand colors.
   - Add 3–4px accent border lines along the top edge of featured cards, left edge of alerts, or beneath active navigation tabs.

6. **Prioritize Empty States**:
   - Do not leave empty data tables or dashboard panels blank. Provide an engaging illustration, clear explanatory text, and a prominent call-to-action button.

---

## 7. LLM Execution Checklist for UI Code Generation

When generating HTML, CSS, or Tailwind CSS components, verify that the code satisfies:

- [ ] **Grayscale Hierarchy**: Is hierarchy established via font weight, size, and color contrast without depending on bright colors?
- [ ] **System Scale Compliance**: Are all margins, padding, font sizes, and colors strictly pulled from predefined scale values (e.g., Tailwind scale or HSL palette)?
- [ ] **Button Semantics**: Is there exactly one primary filled button, with secondary actions rendered as outlined or subtle styles?
- [ ] **Badges & Pill Tags**: Are badges rendered as light tinted backgrounds with dark text rather than dark solid fills?
- [ ] **Form Inputs & Layout**: Do form fields have constrained maximum widths and tighter internal spacing than external group gaps?
- [ ] **Text Tracking**: Does uppercase text include explicit letter-spacing (`tracking-wider`)?
- [ ] **Depth & Elevation**: Do floating panels, dropdowns, and modals have appropriate box-shadow elevations?
- [ ] **Tinted Greys**: Are grey backgrounds and borders subtly tinted with brand hue rather than neutral `#888888`?
