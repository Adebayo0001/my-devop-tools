# AGENTS.md — Production Standards for AI-Built Projects

## Why these rules exist

There is no human code reviewer in this workflow. Whatever gets written here is what ships. The discipline a senior engineer normally enforces from the outside has to be enforced from the inside, on every pass — not because AI-written code is bad, but because it has a specific failure signature: it runs, it looks fine in the browser, and it's quietly missing the things that don't show up until a real user, a screen reader, a slow connection, or a malicious input hits it.

This isn't theoretical:
- **CSRF/security headers/SSRF**: a 2025 study testing several major AI coding tools across 15 production apps found every single one shipped without CSRF protection or basic security headers, and every tool introduced an SSRF hole.
- **Broken authorization, not missing authentication**: the Tea app breach (2025) — verification photos sat in an open storage bucket, and separately, any logged-in user could pull another user's private messages because the API checked *who's logged in* but never checked *do they own this data*. Authentication was there; authorization wasn't.
- **Exposed databases at scale**: a scan of one popular AI app builder found 170+ apps with databases fully readable/writable by anyone, no login required — a platform default (row-level security) left unconfigured.
- **Destructive agent action**: an AI coding agent deleted a live production database mid-session despite an explicit "don't touch it" instruction and a code freeze. Not a security bug — an agent treating an irreversible action as just another step to complete.
- **N+1 queries at scale**: LLMs generate endpoints in isolation, with no visibility into how they'll interact — the #1 real-world performance killer, invisible on a small test dataset, catastrophic at real volume.
- **Spec drift**: a 2026 study of 807 GitHub repos found AI-assisted sessions built from underspecified prompts produce a real short-term velocity gain paired with steadily compounding complexity. An agent doesn't push back on a vague brief the way a human does — it builds *something*, confidently, and the ambiguity becomes the architecture.
- **Accessibility as legal exposure, not just craft**: ADA web-accessibility lawsuits sit at 3x+ their 2013 baseline; ~95% of tested sites fail basic checks; WordPress/Elementor sites are not exempt.
- **Performance as revenue, measurably**: Google's own controlled A/B case studies — a retailer improved LCP alone and saw +53% revenue per visitor; a telecom improved LCP via SSR and saw +8% sales; a travel platform improved INP and saw +7% sales. Rule of thumb: each added second of load time costs ~7% in conversions.

Apply these gates whenever: scaffolding a new project, adding a feature, fixing a bug (same bar as new code, not a patch around the gap), preparing to deploy, or reviewing existing code.

---

## Calibrating rigor

| Context | Rigor |
|---|---|
| Throwaway prototype / idea exploration | Mention gaps, don't block on them |
| Feature for an existing real product | Full build gate (below) |
| Anything touching payments, auth, or personal data | Full build gate, no exceptions, be explicit about what was checked |
| About to deploy / "this is ready" | Full ship gate (below) |

If unsure which mode applies: ask. "Throwaway or heading toward production?" saves rework.

---

## Gate 1 — Kickoff (before writing any code)

Lock in what's expensive to change later: stack fit (traffic, team size = solo, budget, deploy target), data model shape, auth model (does this even need accounts?), environment strategy (secrets/config per environment), and design system architecture.

### The 4 Conversational Discovery Pillars (No Overwhelm, High Coverage)
Instead of lengthy single-question interrogation loops, discovery is grouped into 4 conversational pillars with helpful examples, capturing vital details without cognitive fatigue:
1. **Pillar 1: Product Mission, Target Users & Real Problem**: What core problem does it solve? Who is the primary user, what is their technical fluency, and what is the end-to-end user journey from first landing to the core "aha!" moment?
2. **Pillar 2: Brand Identity & Visual References (Always Inquire Upfront)**: Do you have existing brand colors, a logo, or visual references (competitor URLs, moodboards, screenshots, Dribbble comps)?
   - *Reference-to-Concept Synthesis*: If references are provided, use them as inspiration while cross-referencing system design vault archetypes (`design-vault/`) to synthesize a **unique, non-generic design concept** tailored to the domain. Ban generic AI defaults (no cream/terracotta buttons, no 3-card grids).
   - *Live In-Chat Color Combo & UI Preview*: Right in the kickoff chat, generate the actual color palette combo (`--background`, `--card`, `--primary`, `--secondary`, `--border`, `--foreground`) and a live rendered UI component preview (buttons, elevated card, input) so the builder visually confirms the aesthetic before locking tokens.
3. **Pillar 3: People, Roles & Access Control (Demystifying Database & RLS)**: Who logs in (Customers, Team Managers, Platform Admins)? What can each user see or edit? (e.g., "Customers only see their own projects; Admins review all projects and can delete accounts"). This defines database tables, ownership boundaries, and Row Level Security (RLS) policies from Day 1.
4. **Pillar 4: Crucial Operations, Privacy & Legal Safeguards (Quietly Enforcing the 111 Production Invariants)**:
   - *Financial & Operational Scope*: Bootstrapped MVP ($0/month recurring SaaS burn using generous free tiers) vs Funded Startup / Enterprise (high-availability infrastructure from Day 1).
   - *Payments & Subscriptions*: Are there paid tiers, one-time checkouts, or trials? What is the statutory refund / cancellation policy ("Click to Cancel" rule)?
   - *Legal Jurisdictions & Regulatory Compliance*: Which regions are targeted? (EU/GDPR, California/CCPA, Nigeria/NDPA 2023, UK/ICO, Canada/PIPEDA). Does the app need a statutory Cookie Consent banner and Impressum (DACH/Germany)?
   - *Data Protection & AI Model Training*: Will user data or prompts be used to train AI models? (Mandatory opt-out toggle required by law). What third-party AI APIs connect, and do they enforce Zero Data Retention (ZDR)?
   - *User Rights & DSAR*: Does the app provide self-serve account deletion ("Right to be Forgotten") and data export (JSON/CSV)?
   - *Transactional Communications & Files*: Automated receipts, password resets, file upload access boundaries.

### The Google Stitch UI Pipeline (Product Designer Mode & 111-System Screen Mapping)
- **Comprehensive 111-System Screen Inventory**: A production application requires complete screen coverage derived from the **111 Core Systems Concepts**:
  - `SCR-01: Landing & Conversion` (Value Prop, Pricing & Comparison, FAQ)
  - `SCR-02: Identity & Auth Security` (Sign-In, Sign-Up, MFA/2FA, Password Reset, Magic Link — *Concepts 68–73*)
  - `SCR-03: Workspace Onboarding` (Team Invite, RLS Role Assignment, Initial Seed Data)
  - `SCR-04: Primary Workspace Dashboard` (Live Telemetry Stream, Core Studio/Canvas, Metric Cards — *Concepts 1–19, 22–24*)
  - `SCR-05: Entity Management & Detail Inspector` (Filterable/Paginated Data Grid, Entity Detail View, Empty States — *Concepts 25–27, 36–37*)
  - `SCR-06: Administrative Governance Console` (User Management, RLS Permission Matrix, Audit Log — *Concepts 68, 81–82*)
  - `SCR-07: Billing & Usage Quotas` (Stripe Customer Portal, Tier Management, Quota Alerts — *Concept 88*)
  - `SCR-08: Platform & Webhook Settings` (API Keys Vault, Webhook Dispatcher, Rate-Limit Analytics — *Concepts 67, 101–103*)
  - `SCR-09: Resilience & Error Boundaries` (500 Error Recovery Boundary, 404, 429 Rate-Limit Throttled Screen with exponential backoff indicator — *Concepts 10–13, 55, 83–85, 109–111*)
  - `SCR-10: Trust, Privacy & Legal Hub` (Privacy Policy, Terms of Service, Cookie Preference Center with granular opt-in & equal-weight Reject All, Data Subject Rights [DSAR] Account Deletion / Data Export page, and Accessibility Statement — *Concepts 68, 71, 74, 111*)
- **Product Designer Stitch Prompts**: The agent writes full-fidelity Google Stitch prompts for each screen, detailing 2D viewport framing (16:9, front-facing, no 3D tilt), spatial layout zones, named components, locked brand palette, and typographic descriptions **without font family names** (preventing Stitch from distorting text).
- **The HTML Screen Vault (`context/screens/`)**: Generated HTML screens (or screenshots) are saved in `context/screens/<screen-name>.html`. In every subsequent development phase, the agent inspects that screen's HTML file and translates it 1:1 into accessible React + Tailwind components.

### Instant Batched Context Compilation (Zero Quality Loss)
For anything beyond a prototype, produce the complete context suite in a **single comprehensive pass**—eliminating multi-turn, file-by-file approval bottlenecks while maintaining complete technical depth:

1. **project-overview.md** — problem, target users with **Synthesized User UX Research** (persona mental models, Jobs-To-Be-Done [JTBD], task friction analysis, cognitive load mapping, **Audience Demographic & Tech Literacy Audit**, and **Jakob's Law Familiar Market Pattern Mapping**), pages/nav, narrative core journey, explicit in-scope/out-of-scope, checkable success criteria.
2. **user-flows.md** — sitemap; one flow diagram per core journey (entry → every decision point → every branch → end state, not just happy path); a task flow per primary action; a **state inventory per screen** (default, empty, loading, error, edge cases); information hierarchy per screen (primary/secondary/tertiary); how flows connect. Must pass the Jakob's Law familiarity test: flows should feel effortless and intuitive based on industry-standard products.
3. **architecture.md** — data model with full SQL DDL, tables, and Row Level Security (RLS) policies; system/integration topology; the Stack Decision writeup (plain-English reasoning and trade-offs); and the **Observability & Telemetry Architecture** (Sentry exception tracking, LogRocket session replay, Datadog APM/RUM, with strict PII scrubbing pipelines).
4. **library-docs.md** — current docs for exactly the locked-stack libraries (including Radix UI primitives, shadcn/ui, Sentry, LogRocket, and Datadog SDKs), **pulled live via search, never from training memory**.
5. **code-standards.md** — two layers. Stack-agnostic (engineering mindset, zero-trust security, React Error Boundaries hooking to Sentry, comment discipline, and a full **Accessibility & Quality Floor**: contrast ratios, keyboard nav, semantic HTML, `prefers-reduced-motion`, responsive down to 375px). Stack-specific, written fresh each time (folder structure, naming, idioms, PII sanitization helpers).
6. **ui-tokens.md / ui-rules.md / ui-registry.md** — 
   - **The shadcn/Radix Foundation**: Built exclusively on **shadcn/ui** and headless **Radix UI** primitives using our established colors. Zero component guessing.
   - **The Atomic Principle**: Classified into **Atoms** (`Button`, `Input`, `Badge`, `Label`), **Molecules** (`SearchBar`, `FormField`), and **Organisms** (`ProductCard`, `HeaderNav`).
   - **Global CSS Single-Knob Cascade (Figma Webhook Parity)**: All theme colors are configured as CSS variables in `globals.css` (`--primary`, `--background`, `--card`, `--radius`). Changing a single variable updates every atom, molecule, and organism app-wide instantaneously.
   - **Typography Cascade & Strict Monospace Quarantine**: Explicit brand font configuration in `tailwind.config.ts` with bulletproof system fallbacks. Monospace (`font-mono`) is strictly quarantined to code blocks and developer terminals—never applied to public UI cards, buttons, badges, or headers.
   - **Sprint Design System Immutability**: Any future sprint feature not in the initial overview MUST automatically reuse registered Atoms and Molecules without the builder prompting.
7. **build-plan.md** — structured into the **Complete 6-Phase Production Lifecycle**:
   - **Phase 1: Discovery & Architecture Specs**
   - **Phase 2: Upfront Foundation (The Shell)** — dependencies, packages, `globals.css` tokens, master App Shell (Header/Navbar, Sidebar, Footer, Root Error Boundary), database tables with RLS policies, and global loading skeletons.
   - **Phase 3: Methodical Layered Sprints (Working Software & Pure User Stories)** — features built as complete **Vertical Slices** along the user journey (UI + real interactive handlers + live seed data). **Zero repetitive plumbing**: once foundation is built, never repeat loading state setups or boilerplates. Inspect `context/screens/*.html` for 1:1 visual fidelity. Includes **In-Phase API Setup Gates** (pauses to request external keys so features work live immediately) and an unbreakable Stop & Verification Gate after each feature.
   - **Phase 4: Production Hardening & Security Audit** — Core Web Vitals (LCP < 2.5s, INP < 150ms), zero-trust sweeps, `.env.production` sanitization.
   - **Phase 5: Brand Launch & Live Cutover** — production build (`npm run build`), custom domain/DNS, SSL, OpenGraph social cards.
   - **Phase 6: Formal Handover, Vault & Post-Launch Ops** — GitHub transfer, 1Password/Bitwarden vault, non-technical Loom admin guide, Sentry live telemetry, 30-day warranty log.
8. **progress-tracker.md** — phase/status table tied to the 6 phases above; a **Decisions Made During Build** log; a Notes section.

### The Zero-Assumption Clarification Protocol (Anti-Guessing Law)
- **The agent must NEVER assume what it is to be doing**. If a request, feature requirement, or data model is ambiguous, unstated, or has multiple valid interpretations, **STOP IMMEDIATELY**.
- Invoke the **Clarification Gate**: present the ambiguity, provide concrete options with trade-offs, and wait for human confirmation. Never silently pick an interpretation.

### The 100% Detail Ingestion & Traceability Matrix (Anti-Information-Loss Standard)
- Before writing code or specs, dissect the user's prompt into an explicit, numbered **Requirement Ingestion Matrix** (`D-1`, `D-2`, etc.).
- High-level summaries must never dilute or drop granular user requirements. Every single explained detail must map 1:1 to an implementation target and a testable acceptance criterion (`AC-1`, `AC-2`).

---

## Gate 2 — Build (while writing each feature)

Eight lenses, every feature that touches input/data/rendering. Default to checking, not skipping.

### 1. Non-Destructive Surgical Modification & Blast-Radius Lock (Anti-Regression Law)
- **Mandatory Blast-Radius Declaration**: Before modifying any existing code, explicitly declare:
  1. **Target Blast Radius**: Exact files, functions, and lines to be edited.
  2. **Protected Working Surface ("DO NOT TOUCH")**: Exact existing features, state hooks, props, and UI sections that are working and must remain 100% untouched.
- **Strict Ban on Wholesale File Rewrites**: When modifying an existing feature, the agent must NEVER re-generate or overwrite entire files from scratch. Use surgical block edits only.
- **Zero Collateral Regressions**: Modifying an existing feature must NEVER break or remove previously working features. Rebuilding previously working code due to agent carelessness is an architectural defect. Preserve all existing props, exports, and styles.

### 2. Agile Working Software & Pure User Stories (Primary Measure of Progress)
- **Foundations Upfront**: Always build dependencies, tokens, database tables with Row Level Security (RLS), and the master App Shell upfront before feature modules.
- **Pure User Journey Sprints (Zero Repetitive Plumbing)**: Once foundation is complete, sprints MUST follow the real **User Journey and User Stories** (e.g. "Story 1: User Onboarding & Sign In", "Story 2: Core Workspace Dashboard"). Never dwell on or re-list abstract boilerplate or loading states from foundation. The very first feature must be a tangible, interactive screen that the user can point to, click, and use immediately.
- **Inspect `context/screens/*.html` for 1:1 Fidelity**: When building any screen or user story, open and inspect the corresponding HTML mockup generated during the Google Stitch phase to mirror the layout, spacing, and micro-copy with high fidelity.
- **In-Phase API & Credential Setup Gate**: Whenever a feature requires an external integration (e.g., Supabase keys, Stripe keys, Resend email tokens, AI model credentials), the agent MUST pause at that exact phase, explain in plain English what key is needed and where to place it in `.env.local`, and verify the connection before marking the feature done.
- **DEV HARNESS QUARANTINE & PRODUCTION SURFACE INTEGRITY (ANTI-HARNESS-LEAK LAW)**:
  - Internal developer test harnesses, token inspectors (`/test-tokens`), component variant showcases (`/shell-preview`), crash simulators, and mock launchers must **NEVER** enter shared production navigation bars (`HeaderNav` `navItems`), the public root landing page (`app/page.tsx` or `/`), or customer product views.
  - All developer verification harnesses must be isolated under dedicated non-production routes (e.g. `app/(dev)/_workbench/...` or `app/(dev)/_tokens/...`) or automated test suites (`/test`), completely detached from public sitemaps and navigation menus.
  - The root home page (`app/page.tsx` or `/`) is the sacred public front door. It must strictly render the customer landing page or authentic product entrypoint defined in `project-overview.md` and `user-flows.md`. Overwriting the root page with buttons like *"Open Shell"* or *"Inspect Design Tokens"* is an architectural defect.
  - Zero framework plumbing in public UI: footers and public copy must never display internal framework specifications (e.g., *"Governed by Tier 3 Advanced SaaS Invariants"* or database architecture specs).
- **Vertical Slices Only**: Every feature must be an end-to-end working slice (UI presentation + interactive state handlers + live seed data + 5 screen states). No disconnected horizontal mock islands.
- **The Stop & Test Gate**: The agent is strictly forbidden from building multiple features in one pass. It must stop after each feature, output the Feature Verification Card, and await test confirmation.

### 3. The Mandatory Pre-Flight Grounding Mandate (Anti-Blind-Coding Law)
- Before calling ANY code-modifying tool (`write_to_file`, `replace_file_content`, `multi_replace_file_content`), the agent **MUST prove it has read the project's rules and active context**.
- The agent must output the **Pre-Flight Grounding Card** before generating code diffs:
  1. **3 Governing Invariants Cited**: Exact 3 rules from `AGENTS.md` governing this build step.
  2. **Target Blast Radius**: Exact files, functions, and lines to modify.
  3. **Protected Working Surface ("DO NOT TOUCH")**: Pre-existing working features and routes to remain 100% untouched.
  4. **Dev Quarantine Verification**: Confirmation that no test harness, token inspector, or developer launcher is leaking into `HeaderNav` or public routes.
- Calling code-writing tools without outputting this Pre-Flight Grounding Card is an **automatic architectural defect**.

### 4. Human Copywriting & Copy Domain Isolation
- **12-Year-Old & Executive Litmus Test**: Client-facing copy must be conversational, crystal-clear, plain English, and benefit-driven.
- **Strict Quarantine on Internal Plumbing**: Developer jargon, architecture mechanisms, and state machine variables (*"dispatch gates"*, *"circuit breakers"*, *"mutation triggers"*, *"BOLA checks"*, *"ingest pipelines"*) must NEVER appear on client UI. Quarantine internal terms strictly to logs, comments, and developer runbooks.
- Zero `Lorem Ipsum`, zero placeholder text, zero hollow AI buzzwords (*"seamless"*, *"transformative"*).

### 3. Human-Centered UX & Jakob's Law ($1M Craft + Effortless Flow)
- **$1M Aesthetic**: Bespoke color harmony, refined elevation, micro-interactions, and premium typography.
- **Effortless Usability (Jakob's Law)**: Users expect your product to behave like top apps they already use. Adopt familiar interaction patterns from market leaders (Stripe, Linear, Notion, Airbnb) seamlessly adapted into the project's design system.
- Zero cognitive friction: maximum 1 primary CTA per viewport, clear visual hierarchy, progressive disclosure for complex actions.

### 4. Design System & Typography Containment
- **Zero Component Guessing**: Every interactive component must use **shadcn/ui** and **Radix UI** primitives. Never create un-accessible custom modal overlays, custom dropdowns, or unstyled form controls.
- **Atomic Composition**: Assemble features by composing established **Atoms** into **Molecules**, and Molecules into **Organisms**.
- **No Hardcoded Hex / Raw Utility Colors**: Reference only semantic tokens tied to CSS variables (`bg-primary`, `text-foreground`).
- **Strict Monospace Quarantine**: `font-mono` is strictly quarantined to code blocks (`<pre><code>`) and developer terminals. Brand sans-serif must govern all public UI.

### 5. Security (Zero-Trust)
- **Secrets**: never in source, ever. `.env` gitignored from commit #1. Client bundles get public/publishable keys only — never a secret key.
- **Input validation**: server-side, always, even if also client-side (client-side is UX, not a boundary). Use a schema library (Zod/Yup) — **show the actual schema**, don't just assert "it's validated."
- **Injection**: parameterized queries / ORM only, never string-concatenated SQL. Rely on framework default escaping; `dangerouslySetInnerHTML`/`v-html` needs explicit sanitization (DOMPurify), never raw user input.
- **Auth = authentication AND authorization.** Server-side checks on every protected route, not just a hidden button. "Logged in" ≠ "allowed to touch this specific record" — check ownership (the Tea app lesson).
- Use established auth providers (Auth.js, Clerk, Supabase Auth, platform-native) — don't hand-roll session/password logic.
- Rate-limit auth endpoints. CORS: never `*` for anything non-public.
- File uploads: validate type/size server-side, don't trust client-reported MIME type.

### 6. Accessibility (WCAG 2.1 AA — the baseline, not a stretch goal)
- Semantic HTML: real `<button>`/`<a>`/`<nav>`/`<main>`/heading hierarchy backed by Radix UI.
- Full keyboard operability on every interactive element. Never remove focus outlines without a clear visible replacement. Modals trap focus, return it on close.
- `alt` text on meaningful images, `alt=""` on decorative ones. Real `<label>`s (not placeholders). Icon-only buttons need `aria-label`. Dynamic content (toasts, errors) needs `aria-live`.
- Contrast ≥4.5:1 normal text / ≥3:1 large text, checked in both light and dark themes. Never color-alone for meaning.
- Forms: labels, required-field indicators, specific errors tied via `aria-describedby`.

### 7. Performance & Observability
- **Error Tracking**: Wrap layouts with React Error Boundaries reporting to **Sentry** with release tags and sourcemaps. Enable **LogRocket** session capture for critical interactive flows.
- **Performance APM**: Instrument **Datadog** APM and RUM to monitor Core Web Vitals, API latency, and server health.
- **PII Scrubbing**: Telemetry MUST sanitize auth tokens, credit cards, passwords, and client PII before transmitting.
- **Avoid N+1**: about to `.map()` with a fetch inside? Batch it (join / `IN` query / single call) instead.
- Avoid waterfalls: parallelize independent requests (`Promise.all`).
- Paginate/virtualize anything unbounded.
- Targets: **LCP < 2.5s, INP < 200ms, CLS < 0.1.**
- **Low-bandwidth resilience**: ensure fast initial render on 50–400kbps connections.

### The Post-Build Testing & Verification Lifecycle (`/test`, `/check`, `/sync`)
- **Automated Test Generation (`/test`)**: Immediately upon implementing code changes, run `/test` to inspect uncommitted git diffs, classify files (component, page, api, logic, cli), and generate unit/integration test suites matching numbered acceptance criteria.
- Prioritize: business logic with branches (pricing, permissions), anything touching money/auth/personal data, anything that's already been fixed once (add the regression test), API endpoints (happy path + invalid input + unauthorized access).
- Don't force tests on pure layout/no-logic components or auto-generated boilerplate.
- Every async operation has three states — confirm all three are handled: loading (something visible, not blank/stale), error (specific user-facing message, not a console error), empty (deliberate empty state, not a broken-looking blank list).
- **Runtime Proof (`/check verify`)**: Drives the live application to verify all numbered acceptance criteria in runtime mode.
- **Pre-Merge Review (`/check review` or `/review`)**: Inspects the git diff, auditing security (BOLA/IDOR), token compliance, typography quarantine, and copywriting.
- **The Post-Build Testing Handoff Invariant**: Immediately upon finishing any feature build and running `/imprint`, the agent MUST output the **Feature Verification & Testing Handoff Card** containing:
  1. **What was built**: Exactly what components, state handlers, and live/seed data were created or wired.
  2. **What is working right now**: Concrete interactive capabilities testable in production mode.
  3. **Captured Details Verification Matrix**: 100% prompt detail ingestion check (`D-1`, `D-2`, etc.) mapped to implementation files and verified status.
  4. **Non-Destructive Blast-Radius Audit**: Declared blast radius, Protected Working Surface ("DO NOT TOUCH") verified untouched, and regression check confirming zero broken pre-existing features.
  5. **What to look out for**: Layout hierarchy, the 5 screen states (Default, Loading, Empty, Error, Edge Cases), plain-English human copy (zero leaked plumbing), typography integrity (zero monospace leaks), and 375px mobile responsiveness.
  6. **Exactly what to test**: A deterministic 3-to-4 step test script (route, action, expected outcome, error/network check).
  7. **The Rule of Thumb Decision Gate**:
     > *"Would you like me to test this for you right now (via browser subagent / terminal automation), or will you test this manually?"*
  8. The feature enters `VERIFYING` state. Only after a verified PASS (agent or human) is it marked `COMPLETED` in `progress-tracker.md` and appended to `memory.md`. If a test fails, trigger `/recover` immediately.
- **Post-Merge Context Sync (`/sync`)**: After merge, run `/sync` to perform single-line reconciliations of `progress-tracker.md`, advance spec statuses to `Accepted`, and surface any unratified `Assumed` specs. Run `/document pr` to draft clean PR bodies.


### Destructive actions — standing rule, not optional
Dropping a table, deleting a production DB/bucket, force-pushing, overwriting production `.env`, running a migration against live data: **stop for an explicit, separate confirmation every time** — even mid-session, even if the broader task was approved, even if the plan seems obviously correct. Approval of a feature is not approval to delete data to build it. This is the one mistake category here that can't be fixed with a follow-up commit.

---

## Gate 3 — Ship, Launch & Client Handover (Full Lifecycle Completion)

If `progress-tracker.md` exists, check against it directly — a project is not ready to deploy until Phases 1–3 are verified complete, and Phases 4–6 are executed systematically.

**Pre-ship checklist:**
- [ ] No secrets in source or git history; `.env` gitignored
- [ ] Every form/endpoint validates + sanitizes server-side
- [ ] Protected routes/data check auth server-side (not just hidden UI)
- [ ] No unhandled rejections/uncaught exceptions; user-facing error states exist
- [ ] Error Tracking configured (Sentry / LogRocket) with verified PII scrubbing
- [ ] Performance Monitoring configured (Datadog APM/RUM) tracking Core Web Vitals
- [ ] UI built with shadcn/ui and Radix UI primitives; Atomic hierarchy respected
- [ ] Single-knob CSS cascade verified: changing `--primary` in `globals.css` propagates app-wide
- [ ] Sprint Design System Immutability verified: no unmapped or guessed component variants
- [ ] Plain English copy verified: zero internal plumbing terms (*"dispatch gates"*, etc.) in public UI
- [ ] Typography quarantine verified: zero monospace font leaks across client cards, buttons, or text
- [ ] Keyboard nav works everywhere; meaningful `alt` text; WCAG AA contrast; labeled forms
- [ ] No obvious N+1s or waterfalls; images sized/compressed; no unbounded unpaginated lists
- [ ] Responsive down to 375px
- [ ] No stubbed/mocked code silently presented as finished — disclosed instead
- [ ] No unconfirmed destructive actions in the session history
- [ ] Production build verified: `npm run build` exits 0 with zero type or lint errors
- [ ] Handover Package prepared: GitHub repo transfer, credentials vault, Loom runbook, 30-day warranty log

Report results in plain terms: what was checked, and the one thing left for a real decision — not a wall of checkmarks.

---

## How to work generally

- State assumptions out loud when skipping a check ("no rate limiting — this endpoint has no side effects") rather than silently skipping.
- A `// TODO: add validation` comment is worse than no comment — it looks handled when it isn't. Either fix it or flag it as an open item to the user.
- Fix cheap gaps immediately (an `alt`, a parameterized query). Flag gaps that need a real decision from the user.
- Consistency over cleverness — one state-management approach, one error-handling pattern, one file-structure convention per project. A future session (or future you) extends a consistent codebase correctly; it guesses wrong in a clever, inconsistent one.

---

## Memory & Session Logging (`log memory` / `/remember`)

- Whenever the user says **"log memory"**, **"log to memory"**, or runs **`/remember`** / **`/remember save`**, immediately perform an **incremental update** to `memory.md` (and `.ai-memory/phase-log.md` if present).
- **NEVER ask for permission to overwrite** (e.g. *"Overwrite with this session's memory? (yes / no)"* is strictly forbidden).
- All memory logging is strictly **incremental**: preserve previous milestones, past decisions, and solved problems while merging newly completed work, updated status, and next steps.

