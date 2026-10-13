---
name: architect
description: Think through complex features like a Silicon Valley Principal Engineer before writing any code. Verifies context folder protocols, locks down TypeScript contracts and state taxonomy, checks zero-trust security invariants, enforces Atomic Design decomposition (shadcn/Radix), architects Sentry/Datadog observability, manages persistent specs in docs/specs/, ratifies Assumed specs, and produces an approved blueprint.
---

# Workflow: architect (Evergreen Silicon Valley Edition)

Invoke with `/architect` before starting any complex feature — or applied automatically per `AGENTS.md`'s Available Skills table when a request is non-trivial and no plan exists yet. 

"Complex" means: touches more than one entity in the data model, introduces a new permission/ownership boundary, involves an async/background process, touches financial/auth logic, introduces multi-step UI flows, or the implementation approach is genuinely not obvious. A simple CRUD form on an already-established pattern does not need this.

**Goal**: Think before building. A blueprint gets reviewed in two minutes; a flawed architecture gets discovered three features later, deeply entangled with everything built on top of it.

---

## The Evergreen Architecture Invariants

1. **Local Truth Over Model Memory**: Never assume framework APIs from model training cutoffs. Inspect the project's actual `package.json`, installed `@types`, and existing codebase patterns first.
2. **Anchor the Blueprint & Persistent Specs**: Write persistent build specs to `docs/specs/NNNN-<feature>/` (`index.md` for the contract + `rationale.md` for the decision record). An unwritten plan drifts when context window compaction occurs. Reflect the milestone in `context/progress-tracker.md` before coding starts.
3. **Numbered Acceptance Criteria**: Every spec must define numbered, testable acceptance criteria (`AC-1`, `AC-2`, etc.) that downstream skills (`/develop`, `/test`, `/check verify`) verify deterministically.
4. **The "Assumed Spec" Valve & Ratification**:
   - If fast prototyping is required before an architectural deliberation, the builder may record an `Assumed` spec stub (`Status: Assumed`).
   - Only `/architect` can ratify and clear an `Assumed` spec by conducting proper discovery and updating it to `Status: Proposed` or `Status: Accepted`.
5. **Cross-Model Spec Check**: For mission-critical, billing, or security specs, offer to cross-check the drafted spec on an independent secondary model to detect blind spots, unassigned data sources, or architectural gaps before code is generated.
6. **Atomic Composition & Sprint Immutability**: New feature UI must strictly compose existing **Atoms** and **Molecules** from `context/ui-registry.md` into **Organisms**. Never invent redundant, un-imprinted card or button variants.
7. **Single-Knob Global CSS Cascading**: All styling must bind to HSL/OKLCH CSS variables in `globals.css` (e.g. `--primary`) mapped through `tailwind.config.ts`. Modifying a single variable in `globals.css` must cascade app-wide automatically (Figma Tokens API / webhook updater parity).
8. **Latest Stable Versions & Live RAG Verification**: Verify current library signatures against official live documentation via RAG and MCP tools (e.g. `context7`) before locking contracts.
9. **Tool Consolidation & Anti-Tool Sprawl**: Strictly forbid adding redundant external dependencies or SaaS vendors when existing foundational platforms in the architecture (e.g., Supabase or full-stack framework APIs) already handle the capability.
10. **The 100% Detail Ingestion Invariant (Anti-Information-Loss)**: Systematically decompose the user's prompt into an explicit, numbered **Requirement Ingestion Matrix** (`D-1`, `D-2`, etc.). Every single nuance, business constraint, and UX detail explained by the user must map 1:1 to an implementation target and an acceptance criterion (`AC-1`, `AC-2`). High-level lossy summarization is strictly banned.
11. **The Zero-Assumption Clarification Invariant (Anti-Guessing Law)**: Never guess user intent, data models, or unstated business rules. If a request is ambiguous or underspecified, the architect MUST STOP and invoke the **Clarification Gate** with concrete options.
12. **The Non-Destructive Blast-Radius Invariant (Anti-Regression Law)**: When modifying existing features, lock the **Target Blast Radius** and explicitly inventory the **Protected Working Surface ("DO NOT TOUCH")**. Wholesale file rewrites are strictly forbidden; only surgical block diffs are permitted. Zero collateral regressions on working features.

---

## Step-by-Step Protocol

### 1. Ingest Prompt Details & Read Context in Protocol Order
- **100% Prompt Decomposition (Anti-Lossy Ingestion)**: Before reading context or designing, parse every single sentence, constraint, and nuance from the user prompt into the **Requirement Ingestion Matrix** (`D-1`, `D-2`, etc.). Never summarize away granular user instructions.
- **The Zero-Assumption Clarification Gate**: If any requirement or edge case is ambiguous, unstated, or has multiple valid interpretations, **HALT IMMEDIATELY**. Present the ambiguity and ask the builder with concrete options before proceeding.
- Read the project context files in the strict sequence defined in `AGENTS.md`:
1. `context/project-overview.md` (Product vision, personas, JTBD & UX research findings)
2. `context/architecture.md` (System invariants, schemas & observability topology)
3. `context/ui-tokens.md` & `ui-rules.md` (Design constraints & CSS variable mappings)
4. `context/ui-registry.md` (Existing Atoms, Molecules, Organisms)
5. `context/code-standards.md` & `context/library-docs.md` (Engineering rules)
6. `context/build-plan.md` (The exact feature milestone & acceptance criteria)

---

### 2. User UX Research, Jakob's Law & Human-Centered Usability Pre-Check
Before proposing technical architecture, verify user alignment against `context/project-overview.md`:
- **Audience Demographic & Literacy Audit**: Who is the target user, what is their age bracket, and what is their technical literacy level (e.g. non-technical operator vs developer)? How do we eliminate cognitive friction?
- **Jakob's Law Familiar Pattern Mapping**: What proven, industry-standard product (e.g. Stripe, Linear, Notion, Airbnb) has already perfected this interaction pattern? How do we adapt that familiar pattern into our design system rather than forcing the user to learn an unfamiliar mechanism?
- **3-Level Jobs-To-Be-Done (JTBD)**: Which exact Functional, Emotional, or Social job does this feature satisfy?
- **Copy Domain Isolation & Plain English**: Derive conversational, benefit-driven headlines, helper text, and CTA buttons that pass the **12-Year-Old & Executive Litmus Test**. Strictly quarantine internal plumbing terms (*"dispatch gates"*, *"circuit breakers"*, *"mutation triggers"*, *"BOLA checks"*) to logs/code—NEVER allow them into public UI.

---

### 3. Define Technical Contract, Interfaces & Non-Destructive Blast Radius
Before writing any implementation code, define the **Contract & Blast Radius Boundaries**:
- **Non-Destructive Blast Radius Specification**:
  - **Target Blast Radius**: Exact files, functions, and lines to be modified.
  - **Protected Working Surface ("DO NOT TOUCH" Inventory)**: Explicit list of pre-existing working features, state handlers, component props, and routes that must remain 100% untouched.
  - **Surgical Edit Mandate**: Wholesale file rewrites are strictly prohibited. Edits must be localized block replacements.
- **Data Model & Schema**: What exact TypeScript types/schemas are touched or introduced?
- **State Taxonomy**: Where does this state live? (Server cache via TanStack Query/SWR, Global client store, Local component state, or URL params). *Manual `useState` + `useEffect` for remote fetching is strictly banned.*
- **Dependencies & Flow**: What calls this feature, and what does this feature call?
- **Numbered Acceptance Criteria**:
  - `AC-1`: [User action + system response + state mutation — tied to D-1]
  - `AC-2`: [Error condition + user feedback — tied to D-2]
  - `AC-3`: [Authorization boundary: only resource owner can access]

---

### 4. Check System Invariants, Zero-Trust & Observability Boundaries
Cross-reference the proposed approach against `context/architecture.md` and `ai-dev-standards`:
- **Ownership & Authorization Boundary**: Does this feature check *resource ownership* (preventing BOLA/IDOR), not merely login status?
- **Data Integrity Invariants**: Does it respect database constraints, unique keys, and row-level security (RLS)?
- **Error Tracking Architecture (Sentry / LogRocket)**:
  - Which Error Boundary wraps this feature's organisms?
  - What PII scrubbing rules (`beforeSend`) sanitize user input before telemetry is dispatched?
- **Performance APM Architecture (Datadog)**:
  - What are the query latency budgets (<100ms)?
  - How are distributed trace headers passed across API calls?
  - What Core Web Vitals thresholds (INP < 200ms, LCP < 2.5s) apply to this screen?

---

### 5. Wireframe Specification, Atomic UI & Typography Containment
Consult `context/ui-rules.md` and `context/ui-registry.md` to specify the UI before coding:
- **User Journey Stage**:
  - `| Stage | Action | Thought | Emotion | What screen must provide |`
- **Section Wireframe Hierarchy**:
  - Layout structure (grid, split-column, centered stack).
  - Visual weight (dominant focal point vs supporting elements; max 1 primary CTA per viewport).
  - Elements listed in strict descending order of visual prominence.
  - Interaction behaviors (hover, focus, transitions, loading skeletons).
  - Mobile behavior (how columns collapse at 375px; touch targets ≥44px).
  - Transition signal to the next section/screen.
- **Micro-Copy Contract**:
  - Exact CTA button text (action-oriented, e.g. "Generate Migration Report" not "Submit").
  - Form field labels (always visible above fields; no placeholder-only labels).
  - Explicit error messages (plain language explaining root cause and resolution).
  - Success confirmations and toasts.
- **Typography Containment**:
  - Confirm all UI headings, body, cards, and buttons strictly consume `--font-sans` (brand typeface).
  - Strict Monospace Quarantine: `font-mono` is strictly forbidden except inside code blocks or developer consoles.
- **Atomic Primitives (shadcn/Radix)**:
  - Atoms reused (`Button`, `Input`, `Label`, `Dialog`, `DropdownMenu`).
  - Molecules composed (`SearchBar`, `FormField`, `FilterGroup`).
  - Organism layout (`DataGrid`, `SettingsModal`, `MetricCardGroup`).
- **Single-Knob Global CSS Cascade Check**: Confirm all component styling binds to HSL/OKLCH CSS variables in `globals.css`.

---

### 6. Ratify an Assumed Decision (When Applicable)
If invoked to ratify an existing `Status: Assumed` spec recorded during rapid prototyping:
1. Read the code actually built and inspect the assumption.
2. Evaluate trade-offs, security invariants, and state boundaries properly.
3. If the assumption was sound: flesh out the full rationale, write `rationale.md`, and promote status to `Status: Accepted`.
4. If flawed: write a corrected spec, mark the old one `Superseded`, and schedule surgical refactoring.

---

### 7. Optional Cross-Model Spec Review (Mission-Critical Features)
For complex features involving financial transactions, auth boundaries, or database migrations, offer the developer:
> *"Would you like me to run a cross-model critique of this spec to identify any unassigned data sources or edge case blind spots before building?"*

---

### 8. Present the Blueprint & Persist Spec File
Persist the spec to `docs/specs/NNNN-<feature-slug>/index.md` and present the blueprint:

```markdown
### 📐 Architecture Blueprint: [Feature Name]
- **Summary**: [What will be built in 1–2 sentences]
- **Spec File**: `docs/specs/NNNN-[feature-slug]/index.md` (Status: Proposed)

#### 📋 100% Requirement Ingestion Matrix (Anti-Lossy Traceability):
| Detail # | User-Explained Detail / Constraint | Implementation Target | Acceptance Criterion |
|---|---|---|---|
| **D-1** | [Verbatim requirement from prompt] | [File / Function / Component] | AC-1 |
| **D-2** | [Specific business rule or edge case] | [File / Function / Component] | AC-2 |

#### 🛡️ Non-Destructive Blast-Radius Contract (Anti-Regression Lock):
- **Target Blast Radius**: [Exact files, functions, and lines to modify]
- **Protected Working Surface ("DO NOT TOUCH")**: [List of existing working components, routes, state hooks to remain 100% untouched]
- **Surgical Edit Guarantee**: [Confirmed zero wholesale file replacements; surgical block diffs only]

- **UX Research, Jakob's Law & Demographic Alignment**: [Target persona, tech literacy, familiar market pattern adapted]
- **Plain English Copy & Micro-Copy**: [Exact headline, CTA text, labels passing 12-year-old test; zero leaked plumbing]
- **Contracts & Schemas**: [Key types/interfaces touched]
- **Numbered Acceptance Criteria**:
  - AC-1: [Specific testable condition — tied to D-1]
  - AC-2: [Specific testable condition — tied to D-2]
  - AC-3: [Zero-trust ownership condition]
- **State & Data Flow (Vertical Slice)**: [Where state lives, live/seed data binding, and interactive flow]
- **Invariants Verified**: [Ownership, RLS, zero-trust boundaries checked]
- **Observability Architecture**: [Sentry Error Boundary placement, PII scrubbing, Datadog trace budget]
- **Wireframe & Atomic Hierarchy**:
  - Wireframe Layout: [Structure, visual weight, 375px mobile collapse]
  - Typography: [Verified brand font; zero monospace leaks]
  - Atoms: [shadcn/Radix primitives reused]
  - Molecules: [Combinations used]
  - Organisms: [Composed layout structure]
  - Single-Knob CSS Cascade: [Verified globals.css CSS variable consumption]
- **Verification Plan & Testing Pre-Check**:
  - What to look out for: [Visual presentation, 5 states: Default, Loading, Empty, Error, Edge Cases, 375px mobile responsiveness]
  - Exact Step-by-Step Test Script: [1. Navigate, 2. Trigger, 3. Expected outcome, 4. Telemetry/DB check]
```

Wait for human confirmation (*"Proceed" / "Approved"*).

---

### 9. Hand Off to Build Gate, `/test`, `/check`, and Testing Handoff
Once approved:
1. Proceed to **Gate 2 (Build)** per `AGENTS.md` and build the complete vertical slice.
2. Run `/imprint` to record newly built components in `context/ui-registry.md`.
3. Run `/test` to generate test suites tied directly to `AC-1`, `AC-2`, etc.
4. Run `/check verify` (runtime proof) and emit the **Feature Verification & Testing Handoff Card**.
5. After merge, run `/sync` to advance spec status to `Accepted` and close the loop.
