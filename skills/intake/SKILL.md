---
name: intake
description: Forensic codebase audit and live website redesign protocol (Tier 4). Audits messy AI-generated codebases (v0, Bolt, Lovable, Cursor), extracts locked context files, enforces Logic Freeze boundaries, migrates styling to shadcn/Radix single-knob CSS variables, and checks Sentry/Datadog observability.
---

# Workflow: intake (Tier 4 Forensic Audit & Live Redesign Engine)

Invoke with `/intake` (or `/devop-intake`) when working with existing code:
- **Scenario 4A (Incoming Codebase)**: Ingesting an unorganized codebase imported from v0, Bolt, Lovable, Replit, or Cursor.
- **Scenario 4B (Live Redesign / Reskin)**: Overhauling a live, fully-functioning application's UI/UX without breaking working business logic.

**Goal**: Transform messy incoming code or dated UI into an elite $1,000,000 engineering standard while eliminating component duplication, hardcoded hex values, and architectural regressions.

---

## The Intake Invariants

1. **THE LOGIC FREEZE (For Live Redesigns)**: Business logic, database queries, API endpoints, authentication guards, and state handlers are 100% frozen. Never modify logic during visual overhaul.
2. **Forensic UX Research Audit**: Audit existing user flows for friction, unhandled error states, cognitive overload, and persona mental models.
3. **Atomic Cataloging & shadcn/Radix Base**: Catalog legacy components into Atoms, Molecules, and Organisms in `context/ui-registry.md`. Standardize interactive elements on **shadcn/ui** and **Radix UI**.
4. **Single-Knob Global CSS Cascade**: Audit `globals.css` and `tailwind.config.ts`. Flag unmapped hex values and migrate them to HSL CSS variables so changing `--primary` cascades globally (Figma Tokens API / webhook updater parity).
5. **Observability Verification**: Audit presence of **Sentry** / **LogRocket** Error Boundaries and **Datadog** APM/RUM with client/server PII scrubbing.

---

## Step-by-Step Protocol

### Scenario 4A: Incoming Codebase Intake & Audit (v0 / Bolt / Lovable)

Reference: `references/codebase-intake-and-audit-protocol.md`

1. **Phase 1: Forensic Discovery & UX Audit**:
   - Inspect dependencies (`package.json`) for Radix, Lucide, Tailwind, shadcn, and state libraries.
   - Audit Observability: check for Sentry/LogRocket Error Boundaries and Datadog APM/RUM.
   - Inventory routes and screens (complete vs. half-built vs. stubs).
   - Conduct UX friction audit on existing flows.
2. **Phase 2: Context Extraction & Logic Mapping**:
   - Reverse-engineer `context/project-overview.md` (mission, personas, JTBD).
   - Reverse-engineer `context/architecture.md` (system topology, data schemas, observability map).
   - Extract `context/code-standards.md` (naming, zero-trust rules, PII filters).
3. **Phase 3: Component Cataloging & Atomic UI Registry**:
   - Audit `globals.css` for single-knob CSS variable mappings; migrate hardcoded hex codes.
   - Catalog all UI components in `context/ui-registry.md` under `[ATOM]`, `[MOLECULE]`, and `[ORGANISM]`. Replace ad-hoc custom buttons/inputs with shadcn/Radix primitives.
   - Enforce Sprint Design System Immutability.
4. **Phase 4: Build Plan & Technical Debt Roadmap**:
   - Generate `context/build-plan.md` (Phase 0: Debt/Security/Observability remediation; Phase 1..N: Features).
   - Initialize `context/progress-tracker.md`.

---

### Scenario 4B: Live Website Redesign & Reskin

Reference: `references/live-website-redesign-protocol.md`

1. **Stage 1: Logic Freeze Boundary & Observability Map**:
   - Declare business logic files (`lib/db.ts`, `server/api/`, etc.) as **READ-ONLY**.
   - Map data contracts in `context/architecture.md`.
   - Verify existing Sentry/Datadog instrumentation remains untouched.
2. **Stage 2: Design Thinking & $1,000,000 Token System**:
   - Explore Tree-of-Thoughts layout concepts.
   - Establish shadcn/ui and Radix UI base.
   - Set up single-knob HSL CSS variables in `globals.css` and `context/ui-tokens.md`.
   - Strictly enforce Anti-Pill/Anti-Badge Law in `context/ui-rules.md`.
3. **Stage 3: Atomic Component-by-Component Reskinning**:
   - Reskin Atoms first (`Button`, `Input`, `Dialog`).
   - Compose into Molecules (`SearchBar`, `FormField`).
   - Assemble into Organisms (`ProductCard`, `DataGrid`).
   - Run `/imprint` after each atomic component.
4. **Stage 4: Regression Audit & Verification**:
   - Verify every form submits to unchanged backend.
   - Verify Sentry catches zero unhandled exceptions with PII scrubbing.
   - Verify Datadog RUM shows zero Core Web Vitals degradation.
   - Verify single-knob cascade: changing `--primary` in `globals.css` flips colors app-wide.
