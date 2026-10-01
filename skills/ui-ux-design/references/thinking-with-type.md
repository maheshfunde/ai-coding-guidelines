# Typography & Layout Architecture: LLM System Instructions & Guidelines

This document synthesizes core typographic principles, design heuristics, and technical typesetting rules. It is structured as a system instruction guide for Large Language Models (LLMs) to enforce professional typography, layout hierarchy, CSS/typesetting rules, and grid architecture in design and code generation.

---

## 1. Core Philosophy & Primary Mandates of Typography

1. **Typography as Visual Language**:
   - Typography is "what language looks like." It transforms spoken gestures into manufactured, repeatable visual forms.
   - Good typography bridges the tension between the organic (calligraphic, hand-made) and the geometric (systematic, machine-driven).
2. **The Dual Function of Typography**:
   - Typography must optimize readability for running text while providing structural shortcuts (hierarchies, indents, cues) that help readers scan, navigate, or avoid reading unnecessary content.
3. **Density is the New White Space**:
   - Avoid sparse, empty layouts that isolate information into rigid boxes. Strive for rich, well-organized textures of content where typography creates implied boundaries and visual rhythm.
4. **Content-Driven Systems**:
   - "Make the shoe fit, not the foot." Do not force content into pre-conceived grids or containers. Build flexible systems that expand, contract, and adapt to the material.

---

## 2. Letter & Micro-Typography Guidelines

### Anatomy & Spatial Alignment
- **Baseline**: The primary axis where letters sit. All aligned text across columns or elements must share a common baseline or baseline increment.
- **Cap Height & X-Height**:
  - Point size is measured from the top of the cap height (plus descender buffer) to the bottom of the lowest descender.
  - X-height (height of lowercase 'x') determines the perceived size and visual density of a font. Typefaces with large x-heights appear larger at the same point size.
- **Overhang**: Curved bottoms of letters (O, C, e) must hang slightly below the baseline to prevent them from looking visually smaller or teetering.

### Measurement Systems
- **Points & Picas**:
  - $1\text{ point} = 1/72\text{ inch} = 0.35\text{ mm}$.
  - $12\text{ points} = 1\text{ pica}$.
  - $6\text{ picas} (72\text{ points}) = 1\text{ inch}$.
- **Notation Standard**: Use standard typographic shorthand (e.g., `8p4` for 8 picas 4 points; `8/9 Helvetica` for 8-point Helvetica with 9 points of line spacing).

### Type Classifications & Styles
- **Classification Spectrum**:
  - **Humanist**: Calligraphic roots, organic contrast, angled stress (e.g., Sabon, Garamond).
  - **Transitional**: Upright, uniform contrast, sharp serifs (e.g., Baskerville, Helvetica).
  - **Modern / Didone**: Extreme stroke contrast, vertical stress, hairline serifs (e.g., Bodoni).
  - **Slab Serif / Egyptian**: Heavy, block-like geometric serifs (e.g., Clarendon).
  - **Sans-Serif**: Humanist (Gill Sans), Transitional (Helvetica), Geometric (Futura).
- **True Italics vs. Faux Italics**:
  - *Mandate*: Always use true italic fonts. Never apply mechanical slants or software skews (Pseudo Italics distortion). Italics feature distinct cursive letterforms (especially 'a' and 'e').
- **Small Capitals**:
  - True Small Caps match the x-height and stroke weight of lowercase letters.
  - *Mandate*: Never generate software-scaled "false small caps" (reduced-scale capitals), which look scrawny, thin, and out of stroke weight balance.
- **Numerals**:
  - **Lining Numerals**: Uniform height (matching cap height) and set width. Required for data tables, financial spreadsheets, and column alignment.
  - **Non-Lining / Old Style / Text Numerals**: Variable heights with ascenders and descenders. Required for running body text to prevent numbers from jumping out visually.

---

## 3. Text & Spacing Mechanics (Macro-Typography)

### Kerning & Tracking
- **Kerning** (Letter-Pair Spacing):
  - **Metric Kerning**: Uses the font designer's built-in kerning table. Default for body text.
  - **Optical Kerning**: Evaluates character shapes algorithmically. Use for headlines, large display text, and cheap or novelty fonts lacking kerning tables.
- **Tracking** (Overall Letterspacing):
  - **Positive Tracking**: Mandatory for ALL CAPS, small caps, and small-caption text (6–8 pt) to enhance legibility and impart elegance.
  - **Negative Tracking**: Use sparingly in large display headlines to tighten excess white space.
  - *TYPE CRIME*: Never loosely track lowercase text—especially italics—as it breaks the designed character connections.

### Line Spacing (Leading)
- **Standard Default**: Set auto-leading at ~120% of type size ($10/12\text{ pt}$).
- **Solid & Tight Leading**: Set display headlines solid ($32/32\text{ pt}$) or tight to prevent fragmented visual chunks.
- **Baseline Shift**: Shift baselines manually when mixing different font families or sizes on a single line so their x-heights align.

### Alignment Modes & Rag Management
- **Flush Left / Ragged Right**:
  - Respects natural spoken language flow without word-spacing distortions.
  - *Rag Management*: Actively adjust line breaks, discretionary hyphens, and tracking to create a natural, gently undulating right rag. Avoid "bad rags" (wedges, moons, diving boards, or lines ending with orphan words).
- **Justified**:
  - Creates a clean rectangular block; standard for books and newspapers.
  - *Measure Constraint*: Requires adequate column width ($45{-}75\text{ characters per line}$) and active hyphenation. Avoid short justified columns that create "rivers" of white space.
- **Centered**:
  - Formal and classical. Must be broken *for sense* (phrasing lines by meaning) into alternating long and short lines. Avoid unintentional tombstone shapes.
- **Flush Right / Ragged Left**:
  - Use sparingly for short notes or sidebar callouts. Watch for punctuation weakening the hard right edge.

### Paragraph Separation & Hierarchy
- **Paragraph Marking Rule**:
  - Signal paragraph transitions using **either** a $1\text{ em}$ Indent **OR** Paragraph Spacing (Space After).
  - *TYPE CRIME*: Never combine indents and paragraph spacing simultaneously—this squanders space and creates flabby, redundant text blocks. Do not indent the first paragraph following a heading.
- **Typographic Hierarchy & Cues**:
  - Guide scanning readers using spatial cues (indents, spacing, placement) or graphic cues (size, weight, color, font).
  - *Rule of Economy*: Use no more than **three cues** per hierarchy level or transition to prevent visual noise.
- **Enlarged Capitals & Drop Caps**:
  - Align drop cap top to cap height of line 1 and baseline to the target drop line. Hang sloping characters (e.g., 'A', 'W') slightly into the left margin.

---

## 4. Grid Systems & Layout Architecture

### Spread-Based Layout & Margins
- **The Spread Unit**: Design for two-page facing spreads rather than isolated single pages.
- **Inside vs. Outside Margins**:
  - Symmetrical spreads mirror inside/spine margins. Asymmetrical spreads maintain consistent left/right biases across both pages.
- **Golden Section**: The proportional ratio $1 : 1.618$ ($a : b = b : (a+b)$) provides a classical foundation for page proportions, text blocks, and wireframes.

### Grid Classification & Rules
1. **Single-Column Grid**: Classical text block framed by generous margins.
2. **Multicolumn Grid**: Divides page into flexible vertical zones. Spans content across 1, 2, or more columns to establish hierarchy.
3. **Modular Grid**: Matrix of vertical columns and horizontal rows. Governs spatial placement of text and imagery.
4. **Baseline Grid**:
  - The master vertical rhythm of a document, governed by the leading of the primary body text ($10/12\text{ pt} \rightarrow 12\text{ pt baseline grid}$).
  - All headlines ($24/36\text{ pt}$), subheads ($14/18\text{ pt}$), and captions ($8/12\text{ pt}$) must use leading that multiplies or divides cleanly into the baseline grid unit.
5. **Datum / Hang Line**: A fixed horizontal reference line across columns from which text and image blocks hang down.

### Data Tables
- Let columns of aligned text create implied vertical grid lines.
- *TYPE CRIME*: "Data Prison"—Never trap table entries inside heavy black grid boxes or dense cell borders. Use subtle row shading or clean whitespace alignment instead.

---

## 5. Punctuation, Editorial & Proofreading Precision

### Punctuation Mechanics
- **Smart Quotes vs. Hatch Marks**:
  - Use typographic "curly quotes" (`“ ”`, `‘ ’`) and apostrophes (`’`).
  - Use straight hatch/prime marks (`'`, `"`) **only** for measurements of feet and inches ($5'2''$).
- **Hanging Punctuation**:
  - Push quotation marks, commas, and bullets slightly into the outer margin (`Optical Margin Alignment`) so the text block maintains a crisp visual edge.
- **Dashes & Hyphens**:
  - **Hyphen (`-`)**: Connects compound words and breaks words at line endings.
  - **En Dash (`–`)**: Indicates numerical ranges ($1914–1918$, $10–20\text{ picas}$). Width = $\frac{1}{2}\text{ em}$.
  - **Em Dash (`—`)**: Signals strong grammatical breaks or parenthetical thoughts. Width = $1\text{ em}$. Never surround with space characters.
- **Spaces & Ellipses**:
  - Use **single space** between sentences. Purge all double spaces from manuscripts.
  - Use true ellipsis characters (`…`) or open-tracked periods rather than arbitrary typed dots.

---

## 6. Execution Checklist for Code & Layout Generation

When generating CSS, HTML, typography specs, or UI layouts, verify that output passes this audit:

- [ ] **Are true font variants used?** (No CSS `font-style: italic` on fonts lacking italic files; no artificial `text-transform: uppercase` as false small caps).
- [ ] **Is paragraph spacing clean?** (Uses `margin-bottom` OR `text-indent`, never both).
- [ ] **Are numerals formatted correctly?** (Lining numerals for tables/code, Old Style/Text figures for running prose).
- [ ] **Does the baseline grid align?** (All line heights/leading are whole numbers that share a common divisor).
- [ ] **Is rag management enforced?** (Clean line lengths between 45–75 characters; `hyphens: auto` or manual breaks on justified text).
- [ ] **Are quotation marks and dashes correct?** (Curly smart quotes used; En dashes for ranges; Em dashes for breaks; no double hyphens `--`).
- [ ] **Are table borders minimal?** (No heavy grid cells; aligned columns create implied boundaries).
- [ ] **Is the cue count controlled?** ($\le 3$ visual cues per hierarchy level).
