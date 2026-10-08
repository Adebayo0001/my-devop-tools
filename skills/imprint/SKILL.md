---
name: imprint
description: Capture newly built UI components into context/ui-registry.md immediately after building. Audits design token compliance, extracts keyboard and accessible contracts, enforces Atomic Design classification (Atoms/Molecules/Organisms), and prevents UI styling fragmentation.
---

# Workflow: imprint (Evergreen Silicon Valley Edition)

Invoke with `/imprint` immediately after any new UI component is built or significantly modified — or applied automatically per `AGENTS.md` right after a component ships.

**Goal**: Capture the component's visual, accessible, and atomic patterns into `context/ui-registry.md` so it is reused consistently across future sessions, permanently eliminating component duplication, styling drift, and broken design systems.

---

## The Evergreen Design System Invariants

1. **Atomic Design Classification**: Every imprinted component must be tagged with its strict atomic hierarchy:
   - **`[ATOM]`**: Basic primitives (`Button`, `Input`, `Label`, `Checkbox`, `Avatar`, `Badge`, `Icon`). Must be built on **shadcn/ui** and headless **Radix UI** primitives from established color variables. No custom, unaccessible reimplementations.
   - **`[MOLECULE]`**: Combinations of atoms (`SearchBar` = `Input` + `SearchIcon` + `Button`, `FormField` = `Label` + `Input` + `ErrorMessage`, `UserDropdownMenu`, pagination controls).
   - **`[ORGANISM]`**: Complex layouts & domain sections (`ProductCard` = `Image` + `Badge` + `Heading` + `PriceText` + `Button`, `DataGrid`, `Navbar`, `Sidebar`, `PricingTable`).
2. **Single-Knob Global CSS Cascade Compliance**: Before imprinting, inspect the component. All colors consumed MUST be mapped to HSL/OKLCH CSS variables in `globals.css` (e.g., `hsl(var(--primary))`) through Tailwind tokens. Hardcoded hex values (`#...`) or unmapped Tailwind utility colors (`bg-blue-600`) violate `AGENTS.md`. Modifying a single CSS variable in `globals.css` must cascade across this component automatically (Figma Tokens API / webhook updater parity).
3. **Design System Sprint Immutability**: Features added during upcoming sprints must compose existing **Atoms** and **Molecules** into **Organisms** without inventing ad-hoc variants or disconnected visual styles.
4. **Accessible Contract Extraction**: UI consistency includes keyboard and assistive states. Capture focus rings, keyboard triggers (`Enter`, `Space`, `Escape`), and ARIA bindings (`aria-expanded`, `aria-label`).
5. **Living Registry Discipline (Append/Merge Only)**: Never regenerate or overwrite `context/ui-registry.md` from scratch. Append new components or add named variants to existing entries.

---

## Step-by-Step Protocol

### 1. Identify Component Scope & Novelty
- Target the specific file just created or modified (e.g., `src/components/common/MetricCard.tsx`).
- Check `context/ui-registry.md`:
  - Is this genuinely a **new component**? &rarr; Classify its atomic tier (`[ATOM]`, `[MOLECULE]`, or `[ORGANISM]`) and add a new entry.
  - Is this a **variant** of an existing component (e.g., `MetricCard` with compact mode)? &rarr; Update the existing entry with the new variant props. Do not create duplicate cards.

### 2. Token & Single-Knob Cascade Audit (Pre-Imprint Verification)
Inspect the component code:
- [ ] Are all colors mapped to CSS variables via `context/ui-tokens.md` and `globals.css`?
- [ ] Would changing `--primary` in `globals.css` cascade automatically to this component without code modifications?
- [ ] If an Atom, does it build directly on **shadcn/ui** and headless **Radix UI** primitives?
- [ ] Are spacing, borders, shadows, and typography aligned with `context/ui-rules.md`?
- [ ] Are all interactive states (`hover`, `focus-visible`, `active`, `disabled`) styled with tokenized focus indicators?
- *If any ad-hoc style or raw hex value exists, fix it in code before registering the pattern.*

### 3. Extract and Write Structured Registry Entry
Append a structured entry to `context/ui-registry.md` adhering strictly to this schema:

```markdown
### [ATOM | MOLECULE | ORGANISM]: [ComponentName]
- **Filepath**: `[relative/path/to/component]`
- **Atomic Tier**: `Atom` | `Molecule` | `Organism`
- **Underlying Primitives**: [e.g., Radix UI Slot, shadcn/ui Button, or Composed Atoms: Input + Button]
- **Purpose**: [1-sentence explanation of when to use vs. adjacent components]
- **Tokens Consumed (Single-Knob CSS Variables)**:
  - Background: `hsl(var(--background))` / `hsl(var(--card))`
  - Primary / Text: `hsl(var(--primary))` / `hsl(var(--foreground))`
  - Border & Radius: `hsl(var(--border))` / `var(--radius)`
  - Focus Ring: `hsl(var(--ring))`
- **Supported States**:
  - `default`: [Visual behavior]
  - `loading`: [Skeleton / spinner pattern used]
  - `empty`: [Empty state illustration / message]
  - `disabled`: [Opacity / pointer-events handling]
  - `error`: [Validation / error styling]
- **Accessibility Contracts**:
  - Native element / Radix primitive: `<button>` / `<dialog>` / `<nav>` / `Radix.Dialog`
  - ARIA attributes: `aria-expanded`, `aria-label`, etc.
  - Keyboard triggers: `Enter`, `Space`, `Escape`
- **Canonical Usage**:
  ```tsx
  <ComponentName variant="primary" label="Action" onClick={handleClick} />
  ```
```

### 4. Audit Mode (`/imprint audit`)
When invoked with `/imprint audit` (e.g., starting a new milestone or reviewing an existing codebase):
1. Scan the components directory for all UI files.
2. Compare them against `context/ui-registry.md`.
3. Report:
   - Components missing from the registry.
   - Duplicate or near-duplicate components that should be merged.
   - Any raw styling, unmapped hex codes, or non-atomic violations found in existing components.

### 5. Log Registration in Progress Tracker
Append a one-line entry to `context/progress-tracker.md` under the current feature milestone:
`- Imprinted [ATOM/MOLECULE/ORGANISM]: [ComponentName] into ui-registry.md (token-verified, shadcn/Radix-compliant, a11y-compliant).`
