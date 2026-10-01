# Cognitive Psychology & Behavioral UX: LLM System Instructions & Guidelines

This document synthesizes core cognitive psychology, visual perception, memory, motivation, and decision-making principles. It is formatted as system-level instructions and constraints for Large Language Models (LLMs) to strictly enforce human-centered design, behavioral psychology, and evidence-based UX across software interfaces, digital products, and user workflows.

---

## 1. How People See (Visual Perception & Cues)

When generating UI layouts, graphics, or visual hierarchy, strictly apply these perceptual rules:

1. **Vision Trumps All Senses**: Over half of human brain resources are devoted to visual processing. What people "see" is an active interpretation constructed by the brain, not raw camera input.
2. **Peripheral Vision Informs Scene Gist**: People use peripheral vision to determine the overall context/gist of a screen in 80 milliseconds.
   - *LLM Mandate*: Ensure peripheral areas communicate screen context clearly. Avoid placing annoying animations, blinking banners, or flashing elements in the periphery, as they involuntarily trigger survival attention.
3. **Canonical Perspective**: People imagine and recognize objects fastest when shown from a canonical perspective (slightly tilted and at a slight angle from above).
   - *LLM Mandate*: Render icons, illustrations, and 3D product previews from a canonical 2D/3D angled perspective rather than flat overhead or directly straight-on views.
4. **Pattern & Geon Recognition**: The brain identifies objects by breaking them down into basic 3D geometric shapes (geons). Use simple, clean geometric drawings for icons to maximize instant recognition.
5. **Facial Gaze & Direct Attention**:
   - Faces attract attention faster than any other visual element.
   - *Direct Eye Contact*: Creates maximum emotional engagement and trust.
   - *Directional Gaze*: If a face in an image looks toward a CTA or product, users instinctively follow the line of sight toward that element.
6. **Perceived Affordances**:
   - Objects must explicitly signal how they are used (e.g., buttons must look pressable, input fields must look typable).
   - *LLM Mandate*: Provide clear affordance cues (shading, drop shadows, hover states). Do not rely solely on hover cues for touch devices.
7. **Proximity & Color Rules**:
   - *Law of Proximity*: Items placed close together are assumed to belong to the same functional group.
   - *Color Blindness*: ~9% of men and 0.5% of women are color-blind. Never rely on color alone to convey critical status. Avoid pairing saturated red and blue together (chromostereopsis causes visual fatigue).

---

## 2. How People Read (Typography & Layout)

Enforce these reading mechanics and typographical heuristics for text layout and content generation:

1. **Screen Reading vs. Paper**: Reading on a screen is mentally harder and slower than reading on paper.
   - *LLM Mandate*: Design for scanning. Use short paragraphs, clear section titles, bold lead-ins, bulleted lists, and ample white space.
2. **Line Length Trade-Off**:
   - People read *faster* with longer line lengths (100 characters per line), but *prefer* shorter line lengths (45 to 72 characters per line / 50–60 characters optimal).
   - *LLM Mandate*: Cap body text line length to 50–70 characters for optimal comfort and user satisfaction.
3. **Capitalization & Fonts**:
   - Uppercase text is NOT inherently harder to read, but mixed-case text provides distinctive word-shape contours that speed up scanning.
   - *LLM Mandate*: Use Title Case or Sentence Case for headlines and body copy; restrict ALL CAPS to short badges, labels, or micro-headers.
4. **Font Size & Readability**:
   - Small fonts increase cognitive load and eye strain. Use generous font sizes (minimum 16px for body text on screens) with high x-height fonts for improved legibility.
5. **Reading Patterns & Point of View**:
   - Users scan screens based on past expectations (e.g., top-left to bottom-right in LTR languages).
   - What users comprehend and remember depends heavily on their prior knowledge and the headline/title provided. Always provide meaningful, informative titles.

---

## 3. How People Remember (Memory Constraints)

When designing workflows, forms, or data displays, respect human memory limitations:

1. **The Rule of Four (Working Memory Capacity)**:
   - While George Miller cited "7 ± 2", modern research proves working memory can hold only **4 items or chunks at once**.
   - *LLM Mandate*: Group or chunk information into sets of **3 to 4 items**. Never present unformatted lists of 7+ items without category grouping.
2. **Working Memory Fragility**:
   - Working memory requires active focus and is easily destroyed by noise, interruptions, or task-switching.
   - *LLM Mandate*: Never force users to remember information from one screen/page to enter it on another. Keep context persistent or auto-fill previous inputs.
3. **Recognition over Recall**:
   - Recognizing information is drastically easier than recalling it from memory.
   - *LLM Mandate*: Use drop-downs, visual menus, auto-complete inputs, and option cards instead of blank text fields requiring raw memory recall.
4. **Schemata & Mental Clustering**:
   - Long-term memory is organized into *schemata* (networked clusters of concepts).
   - Connect new information to users' existing schemata to make it intuitive and memorable.
5. **Memory Degradation & Reconstruction**:
   - *The Forgetting Curve*: Unreinforced information drops sharply within hours.
   - *Reconstruction*: People reconstruct memories every time they recall them, making memories malleable and prone to error. Design systems to store ground-truth records rather than relying on user recall.

---

## 4. How People Think (Cognitive Architecture)

Structure information and interaction logic to match human thinking patterns:

1. **Progressive Disclosure**:
   - Present only the vital information required for the current step. Hide advanced settings or secondary details behind "Show More" or expandable panels.
   - *Rule*: If forced to trade off between extra clicks vs. extra mental effort, choose extra clicks with minimal cognitive load ("more easy clicks, less thinking").
2. **Mental Models vs. Conceptual Models**:
   - *Mental Model*: The user's internal belief about how a system works (built from past experience).
   - *Conceptual Model*: The actual design and interface structure provided by the product.
   - *LLM Mandate*: Match the product's conceptual model directly to the user's existing mental model. If introducing a novel conceptual model, provide explicit onboarding/training.
3. **Cognitive Load Hierarchy**:
   - Mental resources are consumed in this order (most expensive to least expensive):
     $$	ext{Cognitive Load (Thinking/Calculating)} > 	ext{Visual Load (Searching/Scanning)} > 	ext{Motor Load (Clicking/Tapping)}$$
   - *LLM Mandate*: Reduce cognitive load even if it slightly increases motor load (e.g., breaking a complex form into a multi-step wizard).
4. **Storytelling & Example-Based Learning**:
   - The human brain is hardwired to process information in story format (Cause $ightarrow$ Effect).
   - People learn best from concrete examples rather than abstract rules or raw data tables.

---

## 5. How People Focus Attention

Design interfaces to manage, direct, and respect limited human attention:

1. **Attention Spans & 10-Minute Limits**:
   - Sustained attention on a single task decays rapidly after **7 to 10 minutes**.
   - *LLM Mandate*: Break long tutorials, videos, or workflows into modular segments of under 7 minutes.
2. **Multitasking is a Myth**:
   - The human brain cannot consciously execute two cognitive tasks simultaneously; it merely switches back and forth rapidly, introducing performance drops and high error rates.
   - *LLM Mandate*: Avoid forcing users to perform dual tasks (e.g., filling a form while listening to complex audio instructions).
3. **Salient Cues & Biological Hooks**:
   - Human attention is involuntarily captured by **food, sex, danger, faces, motion, loud noises, and stories** (governed by the primitive "old brain").
   - *LLM Mandate*: Use salient cues (color contrast, size, motion) sparingly to highlight key actions, avoiding clutter that overwhelms attention.
4. **Selective Attention & Inattentional Blindness**:
   - Users filter out anything they deem irrelevant to their immediate goal (e.g., banner blindness). If critical information must be noticed, make it 10x more visual or pair it with an explicit alert modal/sound.

---

## 6. What Motivates People (Behavioral Drivers)

Incorporate these motivational drivers into product onboarding, habits, and engagement design:

1. **Goal-Gradient Effect**:
   - People are increasingly motivated as they get closer to completing a goal.
   - *LLM Mandate*: Show explicit progress indicators (e.g., "75% Complete"). Give users a "head start" (e.g., pre-filling step 1) to trigger immediate momentum.
2. **Dopamine & Unpredictable Variable Rewards**:
   - The dopamine system drives *seeking* behavior (desire to search) rather than pure satisfaction.
   - Unpredictability (variable-ratio reinforcement) creates compelling habit loops (e.g., notifications, feeds).
3. **Intrinsic vs. Extrinsic Motivation**:
   - *Extrinsic Rewards* (money, points) work well for routine/algorithmic tasks but destroy creativity.
   - *Intrinsic Rewards* (autonomy, mastery, purpose, connection) drive complex, creative (heuristic) work.
4. **Progress & Habit Formation**:
   - Small, incremental commitments lead to long-term habit formation. To change behavior, request a tiny initial action before scaling up.

---

## 7. How People Are Social Animals

Apply social psychology principles to community features, collaboration tools, and persuasive design:

1. **Social Proof & Validation**:
   - When uncertain, people look to others to determine correct behavior (e.g., ratings, reviews, "80% of users choose X").
2. **Dunbar’s Number & Group Dynamics**:
   - Stable social groups cap at approximately **150 individuals**.
   - Online group decisions can be flawed if initial preferences are shared before individual evaluation.
3. **Synchronous Activity & Brain Coupling**:
   - Listening to a speaker creates neural synchronization between speaker and listener.
   - Micro-expressions and authentic smiles build immediate trust; fake smiles are quickly detected in video formats.
4. **Fundamental Attribution Error**:
   - People attribute their own mistakes to situational factors ("the button was hidden"), but attribute others' mistakes to personal character ("they are careless"). Design interfaces that protect users from self-blame.

---

## 8. How People Feel (Emotions & Stress)

Enforce these emotional and affective guidelines:

1. **7 Universal Facial Emotions**:
   - Joy, sadness, anger, fear, surprise, disgust, and contempt are universally recognized across all cultures.
2. **Yerkes-Dodson Law (Stress & Performance)**:
   - Performance follows an inverted U-curve relative to arousal/stress.
   - *High Stress*: Causes vision tunneling and "rigid exploration" (repeating the exact same failing action over and over).
   - *LLM Mandate*: During high-stress or critical error states, eliminate visual clutter, simplify options, and provide clear recovery paths.
3. **Aesthetic-Usability Effect**:
   - Visually pleasing designs are perceived as easier to use and more tolerant of minor usability bugs because they elicit positive emotion.
4. **Anecdotes Beat Data**:
   - Individual human stories and narrative anecdotes evoke stronger empathy and decision-making responses than statistics or charts.

---

## 9. How People Make Mistakes (Error Prevention & Handling)

Design systems defensively around human error classification:

1. **Errors Are Inevitable**:
   - There is no fail-safe product. Systems must be engineered to anticipate and gracefully absorb user mistakes.
2. **Error Classification**:
   - *Performance Errors (Slips & Mistakes)*: Slips occur during automatic execution (e.g., wrong key press); Mistakes occur in planning/rules.
   - *Motor-Control Errors*: Inaccurate touch/pointing actions on touchscreens or small targets.
3. **The Swiss Cheese Model**:
   - System failures occur when multiple latent errors align. Create multi-layered defenses (fencing, confirmation dialogs, auto-save).
4. **Resilience & Poka-Yoke**:
   - *Forgetting*: Provide clear undo functionality for single and bulk actions.
   - *Reversible Actions*: Make all destructive actions reversible via "Undo" rather than aggressive, repetitive modal popups (which become automatic and ignored).

---

## 10. How People Decide (Decision Making)

Apply these decision-making heuristics to conversion flows, pricing tables, and choice architectures:

1. **Unconscious Decision Making**:
   - Decisions are made unconsciously based on gut feel, emotion, and heuristics, then post-rationalized with logic.
   - *LLM Mandate*: Provide both emotional/visual resonance (for the unconscious mind) and rational feature/data specs (for post-decision logic).
2. **The Choice Overload Paradox (Jam Study)**:
   - Offering too many options (e.g., 24 choices) attracts interest but paralyzes action (~3% purchase). Offering fewer choices (e.g., 3–4 choices) yields significantly higher conversion (~30% purchase).
   - *LLM Mandate*: Limit primary options on pricing pages or navigation screens to **3 or 4 choices**. Highlight one "Recommended" option.
3. **Choice Equals Control**:
   - People desire choices because choice confers a feeling of control, even if extra choices increase cognitive load.
4. **Physical Proximity & Tangibility**:
   - People value products more highly when they can physically touch them or see them directly in front of them compared to digital representations. Use realistic visual representations to bridge the gap.

---

## 11. LLM Execution Checklist for UI/UX Code Generation

When generating frontend code, application layouts, or UX specifications, verify that the output satisfies these checks:

- [ ] **Choice Limitation**: Are primary decision choices limited to $\le 4$ distinct options?
- [ ] **Chunking**: Is list and data content grouped into sets of 3–4 items?
- [ ] **Cognitive Load Minimization**: Is cognitive load prioritized over motor load (e.g., progressive disclosure over dense forms)?
- [ ] **Affordances & States**: Do interactive elements have distinct default, hover, active, and focused states with clear perceived affordances?
- [ ] **Error Recovery & Undo**: Does the system provide direct "Undo" capabilities instead of requiring repetitive confirmation popups?
- [ ] **Accessibility & Color**: Is color contrast $\ge 4.5:1$, and is status information conveyed with text/icons alongside color?
- [ ] **Line Length & Typography**: Is body text measure capped at 50–70 characters per line with generous font sizes ($\ge 16	ext{px}$)?
- [ ] **Visual Focus & Gaze**: Are key CTAs placed along natural reading paths or aligned with directional visual cues (e.g., gaze direction)?
