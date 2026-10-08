---
name: architect
description: Think through complex features like a Silicon Valley Principal Engineer before writing any code. Verifies context folder protocols, locks down TypeScript contracts and state taxonomy, checks zero-trust security invariants, enforces Atomic Design decomposition (shadcn/Radix), architects Sentry/Datadog observability, and produces an approved blueprint.
---

# Workflow: architect (Evergreen Silicon Valley Edition)

Invoke with `/architect` before starting any complex feature — or applied automatically per `AGENTS.md`'s Available Skills table when a request is non-trivial and no plan exists yet. 

"Complex" means: touches more than one entity in the data model, introduces a new permission/ownership boundary, involves an async/background process, touches financial/auth logic, introduces multi-step UI flows, or the implementation approach is genuinely not obvious. A simple CRUD form on an already-established pattern does not need this.

**Goal**: Think before building. A blueprint gets reviewed in two minutes; a flawed architecture gets discovered three features later, deeply entangled with everything built on top of it.

---

## The Evergreen Architecture Invariants

To ensure this workflow remains effective across all AI model generations (GPT-4, Claude 3.5/3.7, Gemini 2.0 Pro, OpenAI o1/o3) and framework upgrades:
1. **Local Truth Over Model Memory**: Never assume framework APIs from model training cutoffs. Inspect the project's actual `package.json`, installed `@types`, and existing codebase patterns first.
2. **Anchor the Blueprint**: An unwritten plan drifts when context window compaction occurs. The blueprint must be anchored in the chat and reflected in `context/progress-tracker.md` before coding starts.
3. **Atomic Composition & Sprint Immutability**: New feature UI must strictly compose existing **Atoms** and **Molecules** from `context/ui-registry.md` into **Organisms**. Never invent redundant, un-imprinted card or button variants.
4. **Single-Knob Global CSS Cascading**: All styling must bind to HSL/OKLCH CSS variables in `globals.css` (e.g. `--primary`) mapped through `tailwind.config.ts`. Modifying a single variable in `globals.css` must cascade app-wide automatically (Figma Tokens API / webhook updater parity).
5. **Latest Stable Versions & Live RAG Verification**: Never guess package APIs from model training cutoffs. Verify current library signatures against official live documentation via RAG and MCP tools (e.g. `context7`) before locking contracts.
6. **Tool Consolidation & Anti-Tool Sprawl**: Strictly forbid adding redundant external dependencies or SaaS vendors when existing foundational platforms in the architecture (e.g., Supabase or full-stack framework APIs) already handle the capability.

---

## Step-by-Step Protocol

### 1. Read Context in Protocol Order
Read the project context files in the strict sequence defined in `AGENTS.md`:
1. `context/project-overview.md` (Product vision, personas, JTBD & UX research findings)
2. `context/architecture.md` (System invariants, schemas & observability topology)
3. `context/ui-tokens.md` & `ui-rules.md` (Design constraints & CSS variable mappings)
4. `context/ui-registry.md` (Existing Atoms, Molecules, Organisms)
5. `context/code-standards.md` & `context/library-docs.md` (Engineering rules)
6. `context/build-plan.md` (The exact feature milestone & acceptance criteria)

### 2. User UX Research & Behavioral Mental Model Pre-Check
Before proposing technical architecture, verify user alignment against `context/project-overview.md`:
- **Target Persona & Mental Model**: Which user persona is this for, what is their existing cognitive mental model, and what emotional state do they bring to this screen?
- **3-Level Jobs-To-Be-Done (JTBD)**: Which exact Functional, Emotional, or Social job (from the project's JTBD Matrix) does this feature satisfy?
- **Friction & Objection Audit**: What pain points or objections from the UX Research Pain Points Hierarchy are being eliminated? How do we eliminate redundant inputs, prevent validation surprises, and provide immediate optimistic feedback?
- **Language Intelligence & Copy Contract**: Pull exact user phrasing from the Language Intelligence repository in `context/project-overview.md` for headlines, helper text, and CTA buttons. Strictly ban generic placeholder copy and hollow AI buzzwords.

### 3. Define Technical Contract & Interfaces (Spec-First)
Before writing any implementation code, define the **Contract Boundaries**:
- **Data Model & Schema**: What exact TypeScript types/schemas are touched or introduced?
- **State Taxonomy**: Where does this state live? (Server cache via TanStack Query/SWR, Global client store, Local component state, or URL params). *Manual `useState` + `useEffect` for remote fetching is strictly banned.*
- **Dependencies & Flow**: What calls this feature, and what does this feature call?

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

### 5. Wireframe Specification & Atomic UI Decomposition
Consult `context/ui-rules.md` and `context/ui-registry.md` to specify the UI before coding:
- **User Journey Stage**:
  - `| Stage | Action | Thought | Emotion | What screen must provide |`
- **Section Wireframe Hierarchy**:
  - Layout structure (grid, split-column, centered stack).
  - Visual weight (dominant focal point vs supporting elements).
  - Elements listed in strict descending order of visual prominence.
  - Interaction behaviors (hover, focus, transitions, loading skeletons).
  - Mobile behavior (how columns collapse at 375px; touch targets ≥44px).
  - Transition signal to the next section/screen.
- **Micro-Copy Contract**:
  - Exact CTA button text (action-oriented, e.g. "Generate Migration Report" not "Submit").
  - Form field labels (always visible above fields; no placeholder-only labels).
  - Explicit error messages (plain language explaining root cause and resolution).
  - Success confirmations and toasts.
- **Atomic Primitives (shadcn/Radix)**:
  - Atoms reused (`Button`, `Input`, `Label`, `Dialog`, `DropdownMenu`).
  - Molecules composed (`SearchBar`, `FormField`, `FilterGroup`).
  - Organism layout (`DataGrid`, `SettingsModal`, `MetricCardGroup`).
- **Single-Knob Global CSS Cascade Check**: Confirm all component styling binds to HSL/OKLCH CSS variables in `globals.css`.

### 6. Surface Genuine Ambiguities (No Silent Guessing)
If any requirement, API contract, or edge case is ambiguous:
- **Do not guess or assume.** LLMs tend to build confidently on underspecified prompts, creating hidden technical debt.
- Formulate a crisp, 1–2 sentence clarifying question with a recommended option for the developer.

### 7. Present the Lightweight Blueprint & Obtain Approval
Present the concise blueprint to the developer:

```markdown
### 📐 Architecture Blueprint: [Feature Name]
- **Summary**: [What will be built in 1–2 sentences]
- **UX Research & JTBD**: [Target persona, mental model, and friction reduction strategy]
- **Verbatim Copy & Micro-Copy**: [Exact headline, CTA text, and key form labels derived from Language Intelligence]
- **Contracts & Schemas**: [Key types/interfaces touched]
- **State & Data Flow**: [Where state lives & how data flows]
- **Invariants Verified**: [Ownership, RLS, zero-trust boundaries checked]
- **Observability Architecture**: [Sentry Error Boundary placement, PII scrubbing, Datadog trace budget]
- **Wireframe & Atomic Hierarchy**:
  - Wireframe Layout: [Structure, visual weight, 375px mobile collapse]
  - Atoms: [shadcn/Radix primitives reused]
  - Molecules: [Combinations used]
  - Organisms: [Composed layout structure]
  - Single-Knob CSS Cascade: [Verified globals.css CSS variable consumption]
- **Verification Plan**: [Commands to verify: tsc, tests, Datadog/Sentry checks, manual checks]
```

Wait for human confirmation (*"Proceed" / "Approved"*).

### 8. Hand Off to Build Gate
Once approved, proceed to **Gate 2 (Build)** per `AGENTS.md` and enforce the quality gates of `ai-dev-standards`.
