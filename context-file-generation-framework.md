# Context File Generation Framework

**Purpose:** This is not a project template — it's the process you run at the start of *every* new project to produce that project's own `project-overview.md`, `user-flows.md`, `architecture.md`, `code-standards.md`, `ui-tokens.md` (etc.), `build-plan.md`, `progress-tracker.md`, and `library-docs.md`. Every project's files will look different. What stays constant is the order you generate them in, what question each one has to answer, and the discipline of never carrying a previous project's specific choices forward as a default.

Run this before opening the build tool. The output of this process *is* the context file set that then gets fed to Claude Code / Codex / Cursor for actual building.

---

## Step 0 — The 4 Conversational Discovery Pillars (No Overwhelm, High Coverage)

Instead of lengthy single-question interrogation loops or overwhelming technical walls, discovery is grouped into 4 conversational pillars with helpful examples:
1. **Pillar 1: Product Mission, Target Users & Real Problem**: What core problem does it solve? Who is the primary user, what is their technical fluency, and what is the end-to-end user journey from first landing to the core "aha!" moment?
2. **Pillar 2: Brand Identity & Visual Personality**: Do you have existing brand colors, a logo, or typography guidelines? (Always ask upfront). If starting fresh: What atmosphere fits best (clean light, deep dark, or modern clean tech)?
3. **Pillar 3: People, Roles & Access Control (Plain-English Database & RLS)**: Who logs in (Customers, Team Managers, Platform Admins)? What can each user see or edit? (e.g., "Customers only see their own projects; Admins review all projects, manage billing, and delete users"). This defines database tables, ownership boundaries, and Row Level Security (RLS) policies from Day 1.
4. **Pillar 4: Crucial Operations & Hidden Needs (Quietly Enforcing the 111 Production Safeguards)**: Will users make payments or subscriptions? Do they need automated transactional emails/receipts? Will they upload sensitive files? What third-party APIs/webhooks are needed? Is this a lean MVP ($0/month free-tier target) or a funded scale architecture?

---

## Step 1 — Tech Stack Selection Protocol (Plain English Rationale)

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

## Step 1.5 — The Google Stitch UI Pipeline (Product Designer Mode)

Map every screen required across the user journey based on user stories, generate full-fidelity prompts for ALL screens, and maintain the HTML screen repository:

1. **Screen Inventory Mapping**: Catalog every core screen (e.g. `SCR-01 Landing`, `SCR-02 Auth`, `SCR-03 Dashboard`, `SCR-04 Detail Workspace`, `SCR-05 Settings`).
2. **Deterministic Google Stitch Prompts for ALL Screens**:
   - 2D viewport framing (16:9 widescreen, front-facing, no 3D tilt).
   - Spatial layout zones (navigation rail, main stage, contextual inspector).
   - Named components, buttons, and form labels down to the smallest detail.
   - Locked brand palette.
   - **NO font family names** in the prompt (preventing diffusion distortion).
3. **The HTML Screen Vault (`context/screens/`)**:
   - Save generated HTML files (or screenshots) directly into `context/screens/<screen-name>.html`.
   - During subsequent sprint builds, the agent inspects that screen's HTML file and translates it 1:1 into accessible React + Tailwind components.

---

## Step 2 — Instant Batched Context Suite Generation (Zero Quality Loss)

All context files are generated in a **single comprehensive pass**, completely eliminating slow multi-turn approval bottlenecks while embedding full technical depth:

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
Built from `project-overview.md` + `user-flows.md` + `architecture.md`. Structured into pure **User Stories** and the 6-phase lifecycle:
- **Phase 2 Foundation**: Dependencies, tokens, database tables with Row Level Security (RLS) policies, master App Shell, and global loading skeletons.
- **Phase 3 Pure User Story Sprints**: Sprints strictly follow the real **User Journey and User Stories** (e.g. Onboarding ➔ Dashboard ➔ Core Workspace). **Zero repetitive plumbing**: never re-list or re-explain foundation loading states. The very first feature must be a tangible, working, clickable screen that the user can immediately use.
- **Inspect `context/screens/*.html` for 1:1 Fidelity**: Every feature references its corresponding HTML mockup generated during the Google Stitch phase to mirror layout, spacing, and micro-copy.
- **In-Phase API Setup Gate**: Whenever a feature requires an external integration (Supabase, Stripe, Resend, AI models), pause at that phase, explain in plain English what key is needed, and let the user add it to `.env.local` before moving to test the live feature.
- A **Definition of Done** gate on every feature: verification runbook pass, quality-floor check against `code-standards.md`, component genericness check, atomic registry `/imprint`, and a progress-tracker update.

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
