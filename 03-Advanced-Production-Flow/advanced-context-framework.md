<!--  --># Advanced Enterprise Context Framework (Tier 3)

**Scope:** Multi-tenant SaaS, complex full-stack web applications, fintech/healthcare systems, and mission-critical client projects.  
**Objective:** Deliver an unassailable engineering foundation matching the standards of a Silicon Valley Principal Engineer. Completely eliminate spec drift, AI hallucinations, architectural debt, and client anxiety over "AI-generated code."

---

## The Principle: One File at a Time, Instructive and Complete

A context file that arrives bundled with three others provides none of the protection an engineering gate exists for. **Files in this tier are generated and approved strictly one file at a time.**
* The agent writes exactly one file.
* The agent stops, presents it, and highlights architectural trade-offs.
* The developer reviews and approves (*"Approved"* / *"Proceed"*) before the next file is drafted.
* Every file must be complete, instructive, and specific. Broad generalizations, placeholder bullets, and `// TODO` comments are strictly rejected.

---

## The 11-File Advanced Context Suite

```text
context/
├── 1. project-overview.md     <-- PRD, Narrative Core Journey & Data Architecture
├── 2. user-flows.md           <-- Sitemap, Task Flows & 5-State Inventory Per Screen
├── 3. design.md               <-- Visual Identity & Constrained Core Page Prompts
├── 4. architecture.md         <-- System Boundaries, API Specs & Complete SQL Schema
├── 5. library-docs.md         <-- Live-Searched Documentation for Pinned Dependencies
├── 6. code-standards.md       <-- Stack-Agnostic Invariants & Stack-Specific Idioms
├── 7. ui-rules.md             <-- Visual Layout Rules, Component Anatomy & Form Patterns
├── 8. ui-tokens.md            <-- CSS Custom Properties & Token Invariants
├── 9. ui-registry.md          <-- Living Reusable Component Catalog (via /imprint)
├── 10. build-plan.md          <-- Phased Features with 3-Step Verification Runbooks
└── 11. progress-tracker.md    <-- Real-time Milestone Status & Decision Log
```

---

### Detailed Specification for Each File

#### 1. `context/project-overview.md`
The PRD-level north star. Contains:
* **The Problem**: Concrete market failure or operational bottleneck being solved, written with commercial clarity.
* **Target Users & Synthesized User UX Research**:
  - User archetypes, their technical fluency, device environments, and core workflows.
  - **Persona Mental Models**: Cognitive expectations, domain mental models, and emotional triggers.
  - **Jobs-To-Be-Done (JTBD)**: "When [situation], the user wants to [motivation], so they can [expected outcome]."
  - **Task Friction & Cognitive Load Audit**: Concrete mapping of where users stall, form fatigue points, terminology confusion, and error recovery needs.
* **Sitemap & Navigation**: Top-level page hierarchy and information architecture.
* **The Narrative Core Journey**: A dedicated heading detailing each step of the core journey in standalone prose (what happens, why, and what it hands off to) without relying on diagrams.
* **The Narrative Data Architecture**: Explains the data model in plain English: what gets stored, why it is structured that way, how records relate, and where data sovereignty resides.
* **In-Scope vs. Out-of-Scope**: Explicit boundaries. Items out-of-scope prevent mid-build scope creep from being silently absorbed.
* **Measurable Success Criteria**: Checkable business and technical metrics (e.g., "checkout completed in < 45 seconds", "sub-100ms API response time").

#### 2. `context/user-flows.md`
Catches the ambiguity that otherwise becomes build-time defects:
* **Sitemap**: Every route and sub-route.
* **Core Journey Diagrams**: Entry point ➔ decision gates ➔ failure/success branches ➔ terminal states.
* **Task Flows**: Exact click-by-click interaction sequence for primary user actions.
* **5-State Screen Inventory**: For every single screen, defines:
  1. Default (normal loaded state)
  2. Loading (skeleton/spinner feedback)
  3. Empty (purposeful empty state guiding the user to action)
  4. Error (actionable, human-friendly error guidance)
  5. Edge Cases (extreme data volume, character limits, expired sessions)
* **Information Hierarchy**: Primary, secondary, and tertiary visual focal points per screen.

#### 3. `context/design.md` & Core Page Prompts
Establishes an elite, bespoke visual identity:
* **Color Direction**: Role-based palette (canvas, surface, text-primary, text-secondary, accent, destructive, border). Every pairing verified for WCAG 2.1 AA contrast.
* **Typography System**: Distinct Display headline font + highly legible Body font + monospaced Utility font. Complete scale (size, line-height, letter-spacing).
* **Up to 5 Constrained Core Page Prompts (Stitch-Ready)**: Exact, ready-to-paste prompts for foundational screens (e.g., Dashboard, Main Workspace, Settings). Prompts must reference established tokens and layout constraints to strictly prevent image/UI generators from producing generic template slop or badge pills.

#### 4. `context/architecture.md`
The technical blueprint. Contains:
* **System Boundaries**: Client vs. Server responsibilities. What the client is NEVER the source of truth for (pricing, authorization, timestamps, state transitions).
* **System & Integration Topology**: Frontend, API layer, database, cache, auth provider, background workers, external webhooks.
* **Observability & Telemetry Architecture**:
  - **Error Tracking**: **Sentry** SDK (client/server/edge) with release tracking, source map uploads in CI, and React Error Boundaries.
  - **Session Replay**: **LogRocket** instrumentation on authenticated, high-friction user paths.
  - **Performance Monitoring**: **Datadog** APM and RUM tracking Core Web Vitals, microservice spans, database query profiling, and system health.
  - **PII Scrubbing Pipeline**: Zero-trust redaction of client PII, auth headers, and payment data before telemetry egress.
* **The Stack Decision**: Detailed justification for each technology chosen, tied directly to project constraints, team capabilities, and upgrade paths.
* **API Specifications**: Complete route inventory, HTTP methods, authentication requirements, and request/response Zod/TypeScript contracts.
* **Complete SQL / Database Schema**: Full DDL (tables, column types, primary keys, foreign keys, unique constraints, check constraints, indexes, and Row-Level Security policies). Never a rough sketch.

#### 5. `context/library-docs.md`
Live-extracted documentation excerpts for the locked stack:
* **Pulled live via search/documentation tools, never guessed from LLM memory.**
* Captures the exact versions installed in `package.json` (including Radix UI primitives, shadcn/ui, Sentry, LogRocket, and Datadog).
* Includes specific API signatures, configuration files, and known breaking changes or deprecation traps for those libraries.

#### 6. `context/code-standards.md`
* **Stack-Agnostic Layer**: Zero-trust security invariants, server-side validation rules (Zod schemas mandatory), error-handling conventions with React Error Boundaries hooking to Sentry, PII sanitization helpers, and comment discipline (explain *why*, not *what*).
* **Stack-Specific Layer**: Concrete project folder structure, naming conventions, Server Action patterns, route handler templates, and threshold constants file location.
* **Builder Scaffolding**: Clearly annotates why specific patterns are chosen so the developer learns architectural mastery.

#### 7. `context/ui-rules.md`
Design system rules extracted from the approved visual direction:
* **The Atomic Principle**:
  - Rules for constructing **Atoms** (`Button`, `Input`, `Label`, `Badge`, `Avatar`, `Separator`, `Icon`).
  - Rules for composing **Molecules** (`SearchBar`, `FormField`, `UserAvatarBadge`).
  - Rules for assembling **Organisms** (`ProductCard`, `HeaderNav`, `DataTableSection`).
* **The Anti-Pill Invariant**: Explicitly forbids adding generic badge pills (`[✨ SERVICES]`) above section headers.
* Grid rules, navbar structure, card rules, typography rhythm, form input anatomy, button variant matrix, table pagination, and modal behavior.

#### 8. `context/ui-tokens.md`
Implementation-ready CSS custom properties:
* **shadcn/Radix Theme Tokens & Global CSS Variable Layer**:
  - Global CSS token variables in `globals.css` at `:root` and `.dark` (`--background`, `--foreground`, `--primary`, `--secondary`, `--accent`, `--card`, `--border`, `--radius`).
  - **Global CSS Single-Knob Cascading (Figma Webhook Parity)**: Modifying a single variable in `globals.css` cascades instantaneously and re-themes every Atom, Molecule, and Organism app-wide without modifying component code—mirroring a live Figma Tokens API webhook.
  - Token-level invariants: raw hex codes or unmapped utility classes are strictly forbidden in components.

#### 9. `context/ui-registry.md`
The living component catalog:
* Documents every implemented UI component, its atomic tier (`[ATOM]`, `[MOLECULE]`, `[ORGANISM]`), file path, purpose, and consumed tokens.
* Maintained continuously via the `/imprint` workflow after every new component is built.
* **Sprint Design System Immutability**: Any subsequent sprint build or unplanned feature must strictly assemble existing Atoms and Molecules from this registry without prompting. Prevents the AI from reinventing existing components or duplicating UI styles.

#### 10. `context/build-plan.md`
The phased implementation roadmap:
* Phased sequentially from `user-flows.md`. Each phase contains **numbered features**.
* Every feature includes:
  - An **Anchor Prompt** referencing the relevant sections of `architecture.md`, `code-standards.md`, and `ui-tokens.md`.
  - **UI Built with Mock Data First** using Radix/shadcn atomic primitives before database/logic wiring.
  - Implementation of all 5 UI states from `user-flows.md`.
  - **Deterministic 3-Step Verification Runbook**: A 3-step test script with pass/fail criteria (automated Playwright test or manual acceptance steps, including telemetry and cascade verification).
  - Definition of Done (screenshot check, quality-floor check, genericness check, atomic registry compliance, progress tracker update).

#### 11. `context/progress-tracker.md`
The living project status record:
* Phase/status table tied to the Definition of Done in `build-plan.md`.
* **Decisions Made During Build Log**: Timestamped record of mid-build trade-offs, preventing future sessions from reversing deliberate decisions.
* Open follow-ups and notes.

---

## Handover & Audit Trail: `.ai-memory/phase-log.md`

Every feature completed under this tier appends a permanent record to `.ai-memory/phase-log.md`:
* Timestamp & Feature ID
* Summary of architectural choices made
* Verification runbook results (3-step test output)
* Reusable components registered in `ui-registry.md`

This guarantees that clients, employers, and future engineers receive an immutable, enterprise-grade audit trail proving every line of code was built with intention and verified against high standards.
