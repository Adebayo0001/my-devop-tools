# Context File Generation Framework

**Purpose:** This is not a project template — it's the process you run at the start of *every* new project to produce that project's own `project-overview.md`, `user-flows.md`, `architecture.md`, `code-standards.md`, `ui-tokens.md` (etc.), `build-plan.md`, `progress-tracker.md`, and `library-docs.md`. Every project's files will look different. What stays constant is the order you generate them in, what question each one has to answer, and the discipline of never carrying a previous project's specific choices forward as a default.

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

Use this whenever Step 0 turns up reference material — competitor sites, Dribbble/Pinterest saves, screenshots — but no delivered design of your own exists yet. The goal is to use references for *direction*, never for replication.

1. **Extract qualities, not elements.** For each reference, write down the abstract qualities it's contributing — not "the hero from X app," but things like: layout rhythm (dense/sparse), type personality (geometric/humanist/serif-editorial), color temperature, density, one word for the overall feeling it gives off. Throw away anything that's a specific, copyable UI element (a particular icon set, a specific illustration style, a distinctive named component).
2. **Never name the source product in the generation prompt.** A Stitch prompt that says "make it look like [App]'s dashboard" is asking for replication, not direction — and produces something too close to protectable UI design. Describe the extracted qualities and the actual subject matter instead.
3. **Stitch prompt template** — fill this in per project and paste into Google Stitch:

   ```
   Product: [one sentence — what this is and who it's for]
   Page: [which screen — e.g. dashboard, onboarding, landing]
   Page's single job: [the one thing this screen needs to accomplish]

   Layout direction: [density — sparse/dense; structure — grid/asymmetric/bento; derived from reference qualities, not copied elements]
   Type personality: [e.g. "confident geometric sans for headings, warm humanist body text"]
   Color direction: [temperature and mood, not exact hex values yet — e.g. "cool, low-saturation, one warm accent"]
   Signature element: [the one memorable thing this screen should be built around]

   This should be an original composition inspired by the direction above — not a reproduction of any specific existing product's interface.
   ```

4. **Save Stitch output into `context/designs/`** the same way a delivered Figma comp would be saved — one image per key screen.
5. **Extract tokens from the Stitch output**, not from the original references, when writing `ui-tokens.md`. The references did their job in step 1; from here forward the Stitch screens are the single source of truth.

---

## Step 2 — File Generation Order & Shape

Generate in this order — each file depends on the ones before it being settled.

### 2.1 `project-overview.md`
From Step 0 directly. Shape is reusable: problem statement, pages/navigation, core user flow, in-scope features, explicitly out-of-scope features, success criteria. Being explicit about out-of-scope is what keeps the build agent from silently expanding scope later — keep this section even when it feels obvious.

### 2.2 `user-flows.md`
This is the file that's usually missing from AI-assisted builds, and it's the direct fix for "no feature gets built without missing a step." Traditional product teams map this before a single ticket is written — a build agent needs the same thing in writing, not left to infer it feature-by-feature.

Built from `project-overview.md`, before `architecture.md`. Contains:

- **Sitemap** — every page/screen as a flat list, with its parent/child relationship to other pages.
- **One user flow diagram per core journey** — described as a path, not just a page list: entry point → each decision point → each possible branch → end state. Example shape: `Landing page → [authenticated?] → yes: Dashboard / no: Login → OAuth → callback → Dashboard (first visit: show onboarding banner)`. Write every branch, including the ones that aren't the happy path.
- **Task flow per primary action** — for each significant feature (not just each page), the exact step-by-step a user takes: what they see, what they do, what changes, what they see next. This is where "search for a job" becomes an actual sequence instead of a UI description.
- **State inventory per screen** — for every screen, explicitly list: default/happy state, empty state (nothing to show yet), loading state, error state(s) (validation, network, permission), and edge states (zero results, max limit reached, partial/incomplete data). A screen with only its happy-path state described is not fully specified.
- **Information hierarchy per screen** — what's primary (the thing the page exists for), secondary, and tertiary content, and what's above vs. below the fold. This is what keeps the build agent from giving equal visual weight to everything.
- **Cross-flow connections** — where each flow hands off to another (e.g., "Research Company" on the job details page connects back to the Dashboard's recent activity feed). Flows built in isolation are the most common source of dead ends and orphaned features.

`build-plan.md` is written *from* this file — a feature isn't fully planned until its flow, its states, and its hierarchy all exist here first.

### 2.3 `architecture.md`
Depends on the overview and the Stack Decision from Step 1. Contains: data model, system/integration diagram, and the Stack Decision writeup itself (choice + alternatives + reasoning). This is the file every other file's technical content gets derived from.

### 2.4 `library-docs.md`
Populated *after* the stack is locked, sourced from current live documentation for exactly the libraries chosen this project — never carried forward from a previous project's file, even if a library name overlaps, since versions and APIs may have moved.

### 2.5 `code-standards.md`
Two layers, generated differently:

- **Layer 1 — copy-paste identical every project, stack-agnostic:**
  - Engineering mindset (think before implementing, scope discipline, testability)
  - Error-handling philosophy (never swallow errors silently, human-readable user-facing messages)
  - Comment discipline (comment the why, not the what)
  - Accessibility & Quality Floor — contrast ratios, keyboard nav, semantic HTML, reduced motion, responsive at real mobile width. None of this depends on framework choice, and it should never be re-derived from scratch or skipped because "this project uses a different stack."

- **Layer 2 — regenerated fresh from `architecture.md`'s Stack Decision:**
  - Framework-specific conventions (file/folder structure, naming, the exact code patterns for routes/actions/components in whatever framework was actually chosen)
  - This section is deleted and rewritten per project, never adapted line-by-line from the last one — adapting invites the agent to quietly keep the old stack's assumptions.

### 2.6 `ui-tokens.md` / `ui-rules.md` / `ui-registry.md`
Only generated if Step 0 confirms a visual design already exists (delivered comps) or is being deliberately brainstormed as part of this session. If brainstorming from scratch, apply the anti-genericness and signature-element discipline (see the companion design rules file) *before* locking these — once locked here, the coding agent should treat them as fixed, not up for aesthetic debate. Shape (how a design translates into tokens/rules/a component registry) is reusable; every value inside is unique per brand.

### 2.7 `build-plan.md`
Built from `project-overview.md` + `user-flows.md` + `architecture.md`. Shape is fully reusable regardless of stack:
- UI-first-then-logic ordering (build the interface with mock data, verify visually, then wire real logic)
- Every feature's UI section must include its states from `user-flows.md` — not just the happy path. If a feature is written up with only its default state described, that's a signal `user-flows.md` wasn't consulted; go back and fill it in rather than letting the build agent invent states on the fly.
- A **Definition of Done** gate on every feature, copy-paste every project: screenshot comparison against the design reference, quality-floor check against `code-standards.md`, a component-level genericness check, and a progress-tracker update. Nothing moves to the next feature until all four pass.

### 2.8 `progress-tracker.md`
Shape is 100% reusable — status/phase table, a Decisions Made During Build log, a Notes section. Content empties and refills per project. Tie its checkboxes explicitly to the Definition of Done in `build-plan.md` so "checked off" always means the same thing.

---

## Step 3 — Human Review Checkpoint

Before handing the finished file set to the build agent for actual coding, check:

- Is the Stack Decision in `architecture.md` actually justified with reasons, or just asserted?
- Does anything still reference a previous project's specific tools, table names, or brand values by accident?
- Is the Accessibility & Quality Floor section present in `code-standards.md` unmodified?
- Does `build-plan.md` contain the Definition of Done gate?
- Does every screen in `user-flows.md` have its empty, loading, and error states listed — not just its default state?

If all five are true, the file set is ready to drive a build session.

---

## Companion File

Pair this process with `high-end-web-design-rules.md` (visual design + accessibility principles). That file is also fully stack-agnostic and reusable as-is — include it alongside `code-standards.md` on every project regardless of what stack gets chosen in Step 1.
