# Platform Ergonomics & Human Interface Design: LLM System Instructions & Guidelines

This document synthesizes core design principles, foundations, interaction patterns, touch ergonomics, and accessibility guidelines. It is structured as system-level instructions for AI models (LLMs) to strictly enforce modern ergonomics, visual clarity, and platform interaction paradigms when generating UI code, designing app interfaces, or reviewing user experiences.

---

## 1. Core Design Principles & Philosophy

When designing or generating UI code for Apple platforms, strictly adhere to these fundamental design tenets:

1. **Clarity**:
   - Text must be legible at every size, icons must be precise and lucid, and adornments should be subtle and purposeful.
   - Design should drive focus to content; interactive elements should highlight functionality without overpowering the core experience.
2. **Deference**:
   - The user interface should help people understand and interact with content, never compete with it.
   - Use translucent materials, subtle visual depth, and purposeful whitespace so content remains the hero.
3. **Depth**:
   - Use distinct visual layers, materials, and realistic motion to convey hierarchy, impart vitality, and facilitate understanding.
   - Utilize physical metaphors (depth, z-axis layering, shadows, and translucency) to help users navigate spatial mental models.
4. **Direct Manipulation**:
   - Enable people to interact directly with on-screen content through fluid gestures, touch, direct dragging, and real-time visual feedback.
5. **Feedback & Responsiveness**:
   - Acknowledge every user action immediately with visual feedback, haptics, or sound to build confidence and trust.
6. **Consistency & Familiarity**:
   - Utilize system-defined controls, standard gestures, typography, and familiar layout paradigms so users instantly feel at home.

---

## 2. Design Foundations

### Accessibility
- **LLM Instruction**: Design for inclusion from day one.
- **Dynamic Type**: Always support Dynamic Type so users can customize text size. Use relative typography scales and auto-wrapping layouts.
- **Color Contrast**: Maintain a minimum contrast ratio of 4.5:1 for standard text (3:1 for large text) against its background.
- **Screen Readers (VoiceOver)**: Provide concise, descriptive accessibility labels (`accessibilityLabel`), values, and traits for all interactive components.
- **Hit Targets**: Maintain a minimum touch/click target size of 44×44 pt (iOS/iPadOS) or 60×60 pt (visionOS) to accommodate finger taps and spatial input.

### Color & Dark Mode
- **System Colors**: Prefer semantic system colors (`systemBackground`, `label`, `accentColor`) over hardcoded hex values to automatically adapt to Light and Dark Mode.
- **Vibrancy & Contrast**: Ensure sufficient contrast in both Light and Dark appearances. Use semi-transparent overlay colors sparingly to maintain legibility across dynamic backgrounds.

### Typography
- **System Fonts**: Use SF Pro (iOS/macOS/visionOS), SF Compact (watchOS), SF Mono, or New York for serif contexts.
- **Hierarchical Text**: Use standard text styles (`Large Title`, `Title`, `Headline`, `Body`, `Caption`) to establish a clear visual hierarchy and support Dynamic Type scaling natively.

### Materials & Spatial Depth
- **Vibrancy & Translucency**: Use system materials (such as blurs, frosted glass, and thin materials) to establish physical hierarchy and draw focus to foreground content.
- **Spatial Computing (visionOS)**: Use glass materials that adjust dynamically to surrounding lighting conditions. Maintain spatial balance and place content within the user's comfortable field of view.

---

## 3. UI Patterns & Interaction Standards

### Navigation Paradigms
- **Hierarchical Navigation**: Use Navigation Stacks for step-by-step traversal from high-level categories to detailed content.
- **Flat / Tabbed Navigation**: Use Tab Bars for switching between primary, distinct app sections. Limit main tabs to 3–5 items on iOS.
- **Sidebar Navigation**: Use split view sidebars on iPadOS and macOS for organizing rich multi-level data hierarchies.

### Modality & Feedback
- **Modality Usage**: Reserve modal views (sheets, full-screen covers, alerts) for self-contained, critical tasks that require deliberate user action or confirmation.
- **Non-Intrusive Feedback**: Prefer unobtrusive, inline feedback or toast notifications over intrusive modal alerts for routine updates.

### Gestures & Input Methods
- **Multi-Input Support**: Support touch, mouse/trackpad, keyboard shortcuts, Apple Pencil, spatial hand gestures, and eye tracking depending on the target device.
- **Standard Gestures**: Use standard gesture behaviors (swipe to delete, pinch to zoom, pull to refresh) consistently across all screens.

---

## 4. System Components & Layout Guidelines

### Layout & Safe Areas
- **Safe Area Insets**: Always respect safe area margins (avoiding the Dynamic Island, notch, rounded corners, and home indicator).
- **Adaptive Layouts**: Use SwiftUI flexible layouts (`HStack`, `VStack`, `Grid`, `NavigationSplitView`) or Auto Layout constraints to adapt seamlessly across screen sizes and orientations.

### Key UI Components
- **Buttons**: Use standard button styles (Prominent, Filled, Tinted, Plain) matching action hierarchy.
- **Lists & Tables**: Structure complex lists with clear section headers, concise rows, and disclosure indicators.
- **Toolbars & Bars**: Keep top navigation bars clean; place primary action buttons on bottom toolbars or trailing header spots.

---

## 5. Platform-Specific Principles

1. **iOS & iPadOS**:
   - Focus on touch ergonomics, fluid gestures, single-task focus (iOS), and rich multi-window multitasking with Stage Manager (iPadOS).
2. **macOS**:
   - Optimize for precision pointer control, keyboard shortcuts, multi-window workflows, menu bar commands, and dense data layouts.
3. **watchOS**:
   - Design for glanceable, quick-interaction sessions (under 5 seconds). Prioritize large text, bold controls, and Digital Crown navigation.
4. **visionOS (Spatial Computing)**:
   - Design windows and spatial volumes anchored in 3D physical space. Use gaze + pinch interaction paradigms and comfortable spatial ergonomics.
5. **tvOS**:
   - Design for distant viewing (10-foot experience). Use focus-engine navigation with highlight effects and Siri Remote trackpad gestures.

---

## 6. Execution Checklist for Code Generation

When generating SwiftUI or UIKit solutions, verify:
- [ ] Are all UI elements wrapped within Safe Area boundaries?
- [ ] Are system semantic colors used instead of hardcoded hex values to support Light/Dark Mode?
- [ ] Is typography defined using dynamic text styles (`.font(.body)`, `.font(.title)`) rather than fixed point sizes?
- [ ] Are touch targets at least 44×44 pt?
- [ ] Are VoiceOver accessibility labels and traits attached to interactive controls?
- [ ] Are standard navigation patterns (NavigationStack, TabView, NavigationSplitView) applied appropriately?
