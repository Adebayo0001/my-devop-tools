# Context File Generation Framework

**Purpose:** This is not a project template — it's the process you run at the start of *every* new project to produce that project's own `project-overview.md`, `user-flows.md`, `architecture.md`, `code-standards.md`, `design.md` (where applicable), `ui-tokens.md` / `ui-rules.md` / `ui-registry.md`, `build-plan.md`, `progress-tracker.md`, and `library-docs.md`. Every project's files will look different. What stays constant is the order you generate them in, what question each one has to answer, and the discipline of never carrying a previous project's specific choices forward as a default.

Run this before opening the build tool. The output of this process *is* the context file set that then gets fed to Claude Code / Codex / Cursor for actual building.

---

## Step 0 — Discovery Brief

Before anything gets written, these questions must be answered — either by you directly, or by having the AI ask them back to you one at a time:

- What is being built, in one sentence
- Who is the user, and what's their technical comfort level
- What are the 3–6 core user flows / pages
- Scale expectations — side project, funded startup, enterprise. This one decision quietly determines half the stack.
- Hard constraints — compliance, latency, offline support, budget ceiling, existing infrastructure it must integrate with
- Known team/personal stack preferences or existing skills that should bias the choice
- Timeline pressure — affects how much you can justify "boring and proven" vs. "new but faster to ship"
- Does a visual design already exist (Figma, comps, screenshots) — or does design need to be brainstormed as part of this build

This maps directly onto `project-overview.md`. The *shape* of that file (Problem / Users / Pages / In-scope / Out-of-scope / Success criteria) is reusable every time. The content is never copied forward.

---

## Step 1 — Tech Stack Selection Protocol

This is the actual answer to "the build agent needs to use the best tech stack." Give the agent these rules explicitly, every project, before it's allowed to name a single library:

1. **Never default to the last stack used.** Each project re-derives its stack from the Step 0 answers, not from what worked last time.
2. **Selection criteria, in this order:**
   - Fit to actual scale — don't reach for a distributed system for a weekend project, and don't reach for a single monolith when the brief says "needs to handle real concurrent load from day one."
   - Currency and quality of official documentation. A stack the agent can verify against live, current docs beats one it has to guess about from training data — training data version numbers and API shapes go stale fast, and this is exactly why `library-docs.md` exists (see Step 2.4).
   - Ecosystem fit with required integrations — payments, auth, AI/agent tooling, real-time, whatever the brief actually needs.
   - Hosting/infrastructure cost fit to the stated budget.
   - Stated team familiarity — don't silently override a preference the person gave you unless there's a concrete reason.
   - Maturity and stability over hype. Default to boring, well-supported technology unless the brief specifically requires bleeding-edge capability that only a newer tool provides.
3. **Research before locking.** The agent must actually search for current versions and current best-practice guidance for shortlisted options before committing — not recall them from memory. Treat every version number as unverified until checked.
4. **Write the decision down, not just the choice.** Every project's `architecture.md` gets a short "Stack Decision" section: the chosen stack, 2–3 alternatives that were considered, and the concrete reason this one won. This makes the choice auditable later instead of an unexplained assertion.
5. **Pin versions explicitly once decided**, and don't let them drift silently mid-build.

If the brief doesn't give enough signal to pick confidently (e.g., scale is genuinely unknown), the agent should say so and pick the option that's cheapest to migrate away from later, rather than guessing with false confidence.

---

## Step 1.5 — Visual Reference & Google Stitch Protocol

Use this whenever Step 0 confirms no finished/delivered design exists yet — whether or not reference material exists. This step is **sequential and gated, the same discipline as Step 2**: lock the design direction once, then generate one screen at a time, each approved before the next starts. Never generate multiple screens in one pass — that's exactly what produces a set of screens that don't actually share a system.

### 1. The Two-Tier Screen Architecture & Inventory

Do not fall into the trap of thinking a product only has 5 screens. A real product has 15–25 surfaces (sub-views, editors, drawers, setup wizards, modals). Structure design into two tiers:
- **Tier 1: Upfront Macro Anchors (Up to 5 Screens)**: The pillars that define the visual language, typography pairing, and component tokens.
- **Tier 2: Just-In-Time (JIT) Feature Blueprints**: For sub-screens and modals, blueprinted right before their specific feature is built, preventing prompt fatigue and drift.

Pull from `user-flows.md` and identify:
1. The **5 Core Anchor Screens** (e.g. Dashboard/Home, List/Browse view, Detail view, Form/Editor view, Empty/First-run state).
2. The **Complete Screen & Modal Inventory Matrix** in `user-flows.md` mapping every single sub-view and modal to its parent anchor.

### 2. Lock the direction and write `design.md`

If reference material exists, extract qualities, not elements — layout rhythm, type personality, color temperature, density, one word for overall mood. Never name the source product. If no reference exists, derive the direction from the product and audience directly, applying the anti-genericness and signature-element discipline from `high-end-web-design-rules.md` before locking anything.

Once the direction is decided, write it to `design.md` — this file holds **only** the color palette (4–6 named hex values) and type pairing (roles + personality) decided during brainstorming. This is the single source every subsequent Stitch prompt points back to, so colors and fonts are never re-specified or re-negotiated screen to screen.

### 3. Screen 1 prompt — establishes the system

The first Stitch prompt carries the full brand and product context, plus the locked direction from `design.md`:

```
You are designing the first core screen for [product name], a
[one-sentence description] built for [audience]. This is a client-facing
[side project / production] product and needs to read as considered and
professional, specific to this product — not a generic template.

Screen: [screen name] — job: [the one thing this screen accomplishes]

Design system to establish (this will be reused on every subsequent
screen, so define it clearly here):
- Color: [palette from design.md — dominant neutral, supporting
  neutral(s), one accent used sparingly]
- Type: [pairing from design.md — personality and hierarchy across
  headings, body, labels]
- Layout language: [density, structure]
- Button/card/input/badge shapes: [radius scale and treatment — this
  becomes fixed for every screen after this one]
- One signature element that makes this system memorable

Non-negotiable:
- Real information hierarchy — primary action and content clearly
  dominant, secondary/tertiary visibly subordinate
- Text/background contrast readable at a glance
- Original composition — not a reproduction of any existing product's
  interface
```

Generate it, review it against `high-end-web-design-rules.md`, and only move to the next screen once this one is approved.

### 4. Screens 2–5 — one at a time, building on the system

Every subsequent prompt is deliberately shorter — it does **not** restate colors or fonts, since `design.md` already fixed them:

```
Using the established design system from [product name] (see design.md
for color and type — do not deviate from it), design the next core
screen:

Screen: [screen name] — job: [the one thing this screen accomplishes]

[Describe what this screen needs to show and do, in plain terms — content,
key actions, states relevant to this screen. Do not re-specify color or
type.]

Reuse the same button, card, input, and badge shapes established on the
first screen exactly — no new shape or radius introduced here.

Include [its most relevant non-happy-path state — empty / loading / error]
so this screen's edge cases are defined, not left implicit.
```

Generate, review, get approval, then move to the next screen. Repeat until all identified core screens are done.

### 5. After all screens are approved

- Save every approved screen into `context/designs/`, named for what it is (`dashboard.png`, `job-details.png`, etc.).
- `ui-tokens.md` (Step 2.7) is then extracted from `design.md` plus the full set of approved screens — `design.md` seeds the color/type sections, the screens supply everything else (spacing, component tokens, states).

---

## Step 2 — File Generation Order & Shape

**Hard rule: one file, one turn, one approval.** Generate exactly one file per response — never bundle two files together, and never compress a file's content to save space. State which file you're about to generate, produce it in full detail against the shape defined below, then stop and wait for explicit approval before starting the next one. If a file needs changes, revise that same file and wait for approval again — do not move on until it's approved as-is. This single rule is what prevents the vague, everything-summarized-into-one-pass output that happens when multiple files get generated together.

Generate in this order — each file depends on the ones before it being settled.

### 2.1 `project-overview.md`
This file is a PRD, not a summary. Every section below must be written as full explanation — the actual reasoning and detail, not a one-line label. If a section could be understood by someone who has never seen the discovery conversation, it's detailed enough; if it only makes sense to someone who was in the room, it's too thin.

Required sections, in this order:
- **Project explanation** — what this is, written at PRD depth: what it does, how it works end to end, why it's built this way. Several paragraphs, not one sentence.
- **The problem it solves** — the actual pain point, who feels it, and why existing alternatives fall short.
- **Target users** — who specifically, their context, their technical comfort level, what they're trying to accomplish.
- **Navigation** — every top-level nav item, stated clearly, matching what's in `user-flows.md`'s sitemap exactly.
- **Pages / nav bars** — every page, pulled directly from `user-flows.md`, not re-invented here.
- **Core User Flow** — this is its own heading, not a bullet list. Under it, each step in the primary journey gets its own sub-heading, and under each sub-heading, explain — don't just name — what happens, what the user sees, what logic runs, and what leads to the next step. A step like "user searches for jobs" must become: the sub-heading "Searching for Jobs," followed by a paragraph explaining what the user enters, what the system does with it, what determines success or failure, and what the user sees next.
- **Onboarding** (where applicable) — the full first-run sequence, explained the same way as Core User Flow.
- **Profile setup** (where applicable) — same standard.
- **Data architecture** — explained, not just labeled: what the main data entities are, how they relate, which parts of the product read/write which entities, and any data that's derived vs. source-of-truth.
- **Specific features in scope** — a real list, specific enough to build from, not a category name.
- **Specific features out of scope** — equally specific. This is what stops the build agent from silently expanding scope later.
- **Success criteria** — what "this works" looks like, concretely.

Do not brief any of the above. Every section is instructive enough that someone who wasn't in the discovery conversation could build correctly from it alone.

### 2.2 `user-flows.md`
This is the file that's usually missing from AI-assisted builds, and it's the direct fix for "no feature gets built without missing a step." Traditional product teams map this before a single ticket is written — a build agent needs the same thing in writing, not left to infer it feature-by-feature.

Built from `project-overview.md`, before `architecture.md`. Contains:

- **Sitemap** — every page/screen as a flat list, showing how they nest (parent/child relationships).
- **One flow diagram per core journey** — entry point → every decision point → every branch → every end state. A flow diagram that only shows the happy path isn't a flow diagram, it's a wish. If a decision point has a branch that hasn't been thought through — what happens if payment fails mid-checkout? what happens if the session expires mid-form? — that gap belongs here, surfaced before it becomes a half-built code path later. Example shape: `Landing page → [authenticated?] → yes: Dashboard / no: Login → OAuth → callback → Dashboard (first visit: show onboarding banner)`.
- **A task flow for each primary action** — the specific click-by-click sequence for the actions that matter most (sign up, checkout, submit, search). What the user sees, what they do, what changes, what they see next — an actual sequence, not a UI description.
- **A state inventory per screen** — default, empty, loading, error, and edge cases, not just the happy path. A screen with no defined empty state here is a screen that ships with an undefined, probably broken-looking empty state later. This inventory is the direct source `build-plan.md` pulls from when it defines each feature's UI states.
- **Information hierarchy per screen** — primary / secondary / tertiary content, and what sits above vs. below the fold. This is a content and UX decision, not a visual design one — but it directly constrains layout decisions downstream.
- **How flows connect** — where one journey hands off into another (e.g., "complete checkout" ends where "order confirmation / account creation" begins; "Research Company" on a job details page connects back to the dashboard's activity feed). Flows built in isolation are the most common source of dead ends and orphaned features.

`build-plan.md` is written *from* this file — a feature isn't fully planned until its flow, its states, and its hierarchy all exist here first.

### 2.3 `architecture.md`
Depends on the overview and the Stack Decision from Step 1. Every section below is required, written in full detail — not asserted in a line:

- **Stack Decision** — the chosen stack, alternatives considered, and the reasoning (from Step 1).
- **Data flow** — how data actually moves through the system for the core operations: request in, what processes it, what it touches, what comes back out. Trace this for each major operation, not just described in the abstract.
- **Folder structure** — the real, complete directory layout this project will use, down to the level someone could scaffold from it directly.
- **System boundaries** — what's inside this system vs. what's external (third-party APIs, other services) and exactly where the line is drawn — what this system owns vs. what it merely calls.
- **Invariants** — things that must always be true and are never allowed to be violated by any feature added later (e.g., "every record is scoped to a user_id," "no write happens without validation"). These are the rules every future feature gets checked against.
- **API routes** — every route, its method, its purpose, and its request/response shape.
- **Database schema, in specific detail** — every table, every column with its type, every relationship and foreign key, every index that matters. Not "a jobs table with job data" — the actual schema someone could run a migration from.

This is the file every other file's technical content gets derived from.

### 2.4 `library-docs.md`
Populated *after* the stack is locked, sourced from current live documentation for exactly the libraries chosen this project — never carried forward from a previous project's file, even if a library name overlaps, since versions and APIs may have moved.

This must be a specific, detailed reference — the actual method signatures, config shapes, and usage patterns for the libraries in this stack — not a paragraph summarizing what each library generally does. A summary tells the build agent a library exists; a detailed doc tells it exactly how to call it correctly. Pull real excerpts from current documentation, not a description from memory.

### 2.5 `code-standards.md`
Two layers, generated differently:

- **Layer 1 — copy-paste identical every project, stack-agnostic:**
  - Detailed engineering mindset (think before implementing, scope discipline, testability, clean-over-clever, one thing at a time)
  - Error-handling philosophy (never swallow errors silently, human-readable user-facing messages, never let one failure crash everything)
  - Comment discipline (comment the why, not the what)
  - Accessibility & Quality Floor — contrast ratios, keyboard nav, semantic HTML, reduced motion, responsive at real mobile width. None of this depends on framework choice, and it should never be re-derived from scratch or skipped because "this project uses a different stack."

- **Layer 2 — regenerated fresh from `architecture.md`'s Stack Decision, every subsection written specifically for the locked stack, not left generic:**
  - File and folder naming conventions
  - Component structure (the exact order/shape every component follows in this stack)
  - API route handler pattern (with a real example in this stack's syntax)
  - Server actions / mutation pattern (with a real example)
  - Agent code conventions, if this project has agentic/AI-driven logic (error handling, logging, isolation from UI code)
  - Error handling pattern specific to this stack (try/catch shape, error response shape)
  - Environment variables — every variable this project needs, what it's used for, and which are exposed to the client vs. server-only
  - Key domain-specific constants defined once as named exports (e.g. a threshold, a limit, a scoring cutoff — whatever single-source-of-truth values this project actually has) — never hardcoded inline elsewhere
  - Dependencies — the approved list for this project, with the reasoning for each; nothing gets installed outside this list without updating it first
  - Import alias conventions

  This section is deleted and rewritten per project, never adapted line-by-line from the last one — adapting invites the agent to quietly keep the old stack's assumptions.

### 2.6 `ui-rules.md`
Only generated if a visual design exists or was generated in Step 1.5. Translates the approved screens into concrete, applied rules — not raw values (those live in `ui-tokens.md`), but how those values get used. Required sections:

- **Font** — how type is loaded/applied in this stack
- **Layout** — page structure, max-widths, section spacing, header/nav dimensions
- **Navbars** — structure, active/inactive states, behavior
- **Cards** — the container pattern(s) used across the product
- **Typography hierarchy** — every text role (heading, body, label, muted) with its concrete size/weight/color, matching what's actually in the approved screens
- **Badges** — shape, sizing, and every variant that appears in the product
- **Buttons** — every variant (primary/secondary/tertiary/destructive) with its exact treatment
- **Form inputs** — default, focus, error, disabled states
- **Empty states** — the pattern every empty state in the product follows
- **Tables** — row/column treatment, hover state, header styling
- **Progress bars** — treatment and any state-based color logic
- **Specific project rules** — anything particular to this product's domain that doesn't fit the categories above (e.g. a scoring/status visualization specific to what this product does)

### 2.7 `ui-tokens.md`
The raw, named values every rule in `ui-rules.md` points back to. Required sections:

- **How to use** — how tokens are defined and consumed in this stack (e.g. CSS variables via a theme layer)
- **Global CSS / complete token definition** — the actual token file, every value
- **Color usage guide** — which token to use for which purpose, mapped explicitly
- **Page layout** — background/surface/border tokens
- **Typography** — the full type scale as tokens
- **Spacing** — the spacing scale as tokens
- **Component tokens** — cards, buttons, inputs, badges, defined as token references
- **Domain-specific indicator tokens** — whatever categorical or data-driven visual indicators this specific project actually has (e.g. a score/rating color scale, category badges, source badges, status badges, activity markers, trend indicators, chart series colors) — each defined as its own subsection following this same pattern. Not every project has all of these; include exactly the ones this product needs, and name them for what they represent in this product's domain.
- **Logo** — treatment/sizing as a token
- **Invariants** — the "never do this" list for this project's token system (e.g. never hardcode a hex value, never use a raw framework default color class)

If brainstorming from scratch in Step 1.5, apply the anti-genericness and signature-element discipline from `high-end-web-design-rules.md` *before* locking either of these two files — once locked, the coding agent treats them as fixed, not up for aesthetic debate. Shape is reusable; every value inside is unique per brand.

`ui-registry.md` is not generated upfront — it stays a living document that starts empty and gets a new entry appended every time the build agent creates a component, exactly as before.

### 2.8 `build-plan.md`
Built from `project-overview.md` + `user-flows.md` + `architecture.md`. This is the file the build agent will lean on hardest, so nothing in it is allowed to be a category name — every feature is specific enough to build from without guessing.

Required shape:
- **Phased structure** — features grouped into phases, each phase a direct continuation of the one before it (Phase 2 builds on what Phase 1 established, never in parallel or out of order).
- **General information per phase** — a short paragraph at the top of each phase stating what this phase accomplishes as a whole and why it comes at this point in the sequence.
- **Numbered features within each phase** — each feature gets its own number, continuing the count from the previous phase rather than restarting per phase (so numbering reads as one continuous build sequence across the whole project).
- **Both logic and UI defined per feature** — for each feature: what the UI shows (pulling its states directly from `user-flows.md` — default, empty, loading, error, not just the happy path), and what the logic does (the actual behavior, data touched, and outcome). A feature description that only covers one of these two is incomplete.
- **More than one feature per phase where the user flow calls for it** — do not artificially compress a phase into a single feature if the underlying user journey actually has multiple distinct pieces of logic; split them out, each clearly defined.
- **A build-anchor prompt** — the file ends with a short, explicit prompt block the build agent is meant to re-read before starting each phase, anchoring it back to the rules that must never be dropped mid-build:

  ```
  Before starting this phase, confirm: UI is built with mock data first
  and verified visually before logic is wired. Every feature's states
  (empty, loading, error) come from user-flows.md, not invented here.
  Every screen matches its approved design in context/designs/. Code
  follows code-standards.md exactly, including the Accessibility &
  Quality Floor. No feature in this phase is marked done until the
  Definition of Done below passes for it.
  ```

- **UI-first-then-logic ordering** — build the interface with mock data, verify visually, then wire real logic.
- **A Definition of Done gate on every feature**, copy-paste every project: screenshot comparison against the design reference, quality-floor check against `code-standards.md`, a component-level genericness check, and a progress-tracker update. Nothing moves to the next feature until all four pass.

### 2.9 `progress-tracker.md`
Shape is 100% reusable — status/phase table, a Decisions Made During Build log, a Notes section. Content empties and refills per project. Tie its checkboxes explicitly to the Definition of Done in `build-plan.md` so "checked off" always means the same thing.

---

## Step 3 — Human Review Checkpoint

Before handing the finished file set to the build agent for actual coding, check:

- Is the Stack Decision in `architecture.md` actually justified with reasons, or just asserted?
- Does anything still reference a previous project's specific tools, table names, or brand values by accident?
- Is the Accessibility & Quality Floor section present in `code-standards.md` unmodified?
- Does `build-plan.md` contain the Definition of Done gate and the build-anchor prompt for each phase?
- Does every screen in `user-flows.md` have its empty, loading, and error states listed — not just its default state?
- Was every file actually generated one at a time with your approval, or did any get bundled/compressed into a single pass?
- If a design was generated in Step 1.5, does `design.md` exist with a locked palette and type pairing, and do the later screens actually reuse it rather than re-specifying color each time?
- Does `project-overview.md`'s Core User Flow section read as an explained walkthrough (sub-heading + explanation per step), not a bullet list?

If all eight are true, the file set is ready to drive a build session.

---

## Companion File

Pair this process with `high-end-web-design-rules.md` (visual design + accessibility principles). That file is also fully stack-agnostic and reusable as-is — include it alongside `code-standards.md` on every project regardless of what stack gets chosen in Step 1.
