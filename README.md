# AI Coding Guidelines & Architecture Kit 🧠⚡

> Production-grade **UI/UX Design Systems** and **Backend Software Architecture** skills that work out-of-the-box with **Antigravity IDE**, **Claude Code**, **Cursor**, **GitHub Copilot**, **Windsurf**, and any LLM.

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![Antigravity](https://img.shields.io/badge/Antigravity-Compatible-4285F4)](https://github.com)
[![Claude Code](https://img.shields.io/badge/Claude%20Code-Compatible-D97706)](https://anthropic.com)
[![Cursor](https://img.shields.io/badge/Cursor-Compatible-000000)](https://cursor.com)
[![GitHub Copilot](https://img.shields.io/badge/GitHub%20Copilot-Compatible-24292E)](https://github.com)
[![Windsurf](https://img.shields.io/badge/Windsurf-Compatible-00C7B7)](https://codeium.com/windsurf)

---

## 🚀 Quick Install (1 Command)

### Windows (PowerShell)
Clone the repo and run the interactive installer:
```powershell
git clone https://github.com/maheshfunde/ai-coding-guidelines.git
cd ai-coding-guidelines
.\install.ps1
```
*To install for everything silently:*
```powershell
.\install.ps1 -Target all
```

### macOS / Linux (Bash)
```bash
git clone https://github.com/maheshfunde/ai-coding-guidelines.git
cd ai-coding-guidelines
chmod +x install.sh
./install.sh
```

---

## 📦 What's Inside

This kit packages two high-impact, domain-driven skill specifications with zero book/author noise:

### 1. `ui-ux-design`
* **Visual Hierarchy & Layout Systems**: Spacing scales (`4px, 8px, 12px, 16px, 24px...`), grayscale-first design, single primary action per view.
* **Affordances & Mental Models**: Signifiers, immediate user feedback loops (<100ms), and natural mapping.
* **Goal-Directed Interaction**: Sovereign vs. transient interfaces, eliminating excise, flow states.
* **Typography & Grid**: Measure line-lengths (45–75 chars), modular scale, baseline grid alignment.
* **Platform Ergonomics**: 48dp / 44pt minimum touch targets, WCAG AA 4.5:1 contrast compliance.

### 2. `backend-architecture`
* **Layered Boundaries (Clean Architecture)**: The Dependency Rule (dependencies point strictly inward). Decoupled domain entities and use cases.
* **Craftsmanship & Clean Code**: Functions under 20 lines, intention-revealing naming, Command-Query Separation (CQS), no naked nulls.
* **Outside-In TDD**: Walking skeleton methodology, test pyramids, and listening to test pains.
* **Distributed Systems & Data Systems**: LSM-trees vs B-trees, replication lag, partitioning, transaction isolation levels (Snapshot / Serializable), quorum consensus.
* **Idiomatic OOP & Patterns**: Immutability, static factory methods, builders, composition over inheritance.
* **Cloud-Native Frameworks**: Modern Spring Framework & Jakarta EE conventions, AOT readiness, and fine-grained starters.

---

## 🛠 Supported AI Platforms & How They Work

| AI Assistant | Integration Method | Configuration File |
| :--- | :--- | :--- |
| **Antigravity IDE** | Global skill or Workspace skill | `~/.gemini/config/skills/` or `.agents/skills/` |
| **Claude Code** | Global skills or workspace prompt | `~/.claude/skills/` or `CLAUDE.md` |
| **Cursor IDE** | Cursor MDC rules & `.cursorrules` | `.cursor/rules/*.mdc` & `.cursorrules` |
| **GitHub Copilot** | Workspace instructions | `.github/copilot-instructions.md` |
| **Windsurf / Cascade** | Workspace rules | `.windsurfrules` |
| **Cline / Roo Code** | Workspace system prompt | `.clinerules` |
| **ChatGPT / Custom GPTs** | Knowledge files upload | Upload `skills/` folder to GPT Builder Knowledge |

---

## 💡 How to Trigger

### Natural Language (Automatic)
The AI automatically detects when a request relates to UI design or backend architecture:
- *"Design a new user profile settings screen"* → Automatically triggers `ui-ux-design`.
- *"Refactor this repository layer and write tests"* → Automatically triggers `backend-architecture`.

### Explicit Command
```text
Using the backend-architecture skill, audit our service boundary for framework coupling.
```
```text
Apply the ui-ux-design skill to review this form for touch targets and visual hierarchy.
```

---

## 🤝 Contributing & Customization
To add your own skills:
1. Create a new folder under `skills/<your-skill-name>/`
2. Add a `SKILL.md` with YAML frontmatter:
   ```yaml
   ---
   name: your-skill-name
   description: Use when [specific triggering conditions]
   ---
   ```
3. Put deep topic manuals in `skills/<your-skill-name>/references/`.

---

## 📄 License
MIT License. Free to use, adapt, and share across personal and commercial projects.
