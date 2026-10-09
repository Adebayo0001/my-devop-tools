# FIGMA TEMPLATES & COMPONENT INGESTION PROTOCOL

> **Purpose:** Instructions for feeding Figma templates, UI kits, and custom designs into the DevOps AI Knowledge Base.
> Enables agents to assemble production code directly from established Figma components without guessing styles or creating duplicate variants.

---

## 1. Supported Figma Assets

You can feed 3 types of Figma resources into this vault:

1. **Figma UI Kits (e.g. Untitled UI, Relume, Craftwork, Apple Design Resources)**
2. **Custom Bespoke Figma Screen Files (Client Projects or Agency Templates)**
3. **Figma Tokens & Variable Exports (Design Tokens JSON / CSS)**

---

## 2. Ingestion Methods

### Method A: Token & Style Export (Zero-Code Setup)
1. In Figma, export your color styles, typography styles, and corner radiuses using **Figma Variables** or the free *Tokens Studio* / *Figma to Code* plugin.
2. Save the output file as:
   - `design-vault/figma-templates/tokens.json` OR `tokens.css`.
3. The AI agents will automatically extract these variables and inject them into `globals.css` and `ui-tokens.md`.

### Method B: Screenshot & Component Frame Deconstruction
1. In Figma, select the master component frame (e.g. Navbar, Hero Section, Feature Grid, Pricing Card).
2. Export as a high-resolution PNG (`2x`).
3. Follow the prompt in [`ingestion-protocol.md`](file:///c:/Users/user/Desktop/My%20DevOp%20Tools/design-vault/ingestion-protocol.md) to generate the component markdown specification.
4. Save the resulting file into `design-vault/figma-templates/components/`.

---

## 3. How the Agent Maps Figma to Production Code

When the agent builds software, it maps Figma concepts directly to the **Silicon Valley Engineering Stack**:

| Figma Concept | Production Code Mapping | Invariant Rule |
|---|---|---|
| **Auto-Layout Horizontal** | `flex flex-row items-center gap-[token]` | No hardcoded margins; use unified gap tokens |
| **Auto-Layout Vertical** | `flex flex-col gap-[token]` | Spacing scales follow the 8px grid |
| **Component Variants** | React props via `class-variance-authority` (cva) | Pre-defined variants only (`variant: default / outline / ghost`) |
| **Nested Component Frames** | Atomic decomposition (`Atoms -> Molecules -> Organisms`) | Bound to headless `@radix-ui/*` primitives |
| **Color Styles** | CSS Variables in `globals.css` (`--primary`, `--card`) | Single-knob global cascade verified |
