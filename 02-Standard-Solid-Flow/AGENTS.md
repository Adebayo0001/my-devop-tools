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

**For anything beyond a prototype, produce this file set before scaffolding** — not a free-form brief, a fixed checklist that forces gaps to surface while cheap to fix:

1. **project-overview.md** — problem, target users with **Synthesized User UX Research** (persona mental models, Jobs-To-Be-Done [JTBD], task friction analysis, cognitive load mapping, **Audience Demographic & Tech Literacy Audit**, and **Jakob's Law Familiar Market Pattern Mapping**), pages/nav, core flow, explicit in-scope/out-of-scope, checkable success criteria.
2. **user-flows.md** — sitemap; one flow diagram per core journey (entry → every decision point → every branch → end state, not just happy path); a task flow per primary action; a **state inventory per screen** (default, empty, loading, error, edge cases); information hierarchy per screen (primary/secondary/tertiary); how flows connect. Must pass the Jakob's Law familiarity test: flows should feel effortless and intuitive based on industry-standard products.
3. **architecture.md** — data model, system/integration diagram, the Stack Decision writeup (the *reasoning*, not just the conclusion), and the **Observability & Telemetry Architecture** (Sentry exception tracking, LogRocket session replay, Datadog APM/RUM, with strict PII scrubbing pipelines).
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
   - **Phase 2: Upfront Foundation (The Shell)** — dependencies, packages, `globals.css` tokens, and global App Shell (Header/Navbar, Sidebar, Footer, Root Error Boundary).
   - **Phase 3: Methodical Layered Sprints (Working Software)** — features built as complete **Vertical Slices** (UI + real interactive handlers + 5 states + live/seed data). Unbreakable Stop & Verification Gate after each feature.
   - **Phase 4: Production Hardening & Security Audit** — Core Web Vitals (LCP < 2.5s, INP < 150ms), zero-trust sweeps, `.env.production` sanitization.
   - **Phase 5: Brand Launch & Live Cutover** — production build (`npm run build`), custom domain/DNS, SSL, OpenGraph social cards.
   - **Phase 6: Formal Handover, Vault & Post-Launch Ops** — GitHub transfer, 1Password/Bitwarden vault, non-technical Loom admin guide, Sentry live telemetry, 30-day warranty log.
8. **progress-tracker.md** — phase/status table tied to the 6 phases above; a **Decisions Made During Build** log; a Notes section.

If a request is genuinely ambiguous even after drafting these — ask. Don't silently pick an interpretation.

---

## Gate 2 — Build (while writing each feature)

Seven lenses, every feature that touches input/data/rendering. Default to checking, not skipping.

### 1. Agile Working Software & Methodical Layering (Primary Measure of Progress)
- **Foundations Upfront**: Always build dependencies, tokens, and the master App Shell upfront before feature modules.
- **Vertical Slices Only**: Every feature must be an end-to-end working slice (UI presentation + interactive state handlers + live seed data + 5 screen states). No disconnected horizontal mock islands.
- **The Stop & Test Gate**: The agent is strictly forbidden from building multiple features in one pass. It must stop after each feature, output the Feature Verification Card, and await test confirmation.

### 2. Human Copywriting & Copy Domain Isolation
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

### The Post-Build Testing Handoff Protocol
- Prioritize: business logic with branches (pricing, permissions), anything touching money/auth/personal data, anything that's already been fixed once (add the regression test), API endpoints (happy path + invalid input + unauthorized access).
- Don't force tests on pure layout/no-logic components or auto-generated boilerplate.
- Every async operation has three states — confirm all three are handled: loading (something visible, not blank/stale), error (specific user-facing message, not a console error), empty (deliberate empty state, not a broken-looking blank list).
- **The Post-Build Testing Handoff Invariant**: Immediately upon finishing any feature build and running `/imprint`, the agent MUST output the **Feature Verification & Testing Handoff Card** containing:
  1. **What was built**: Exactly what components, state handlers, and live/seed data were created or wired.
  2. **What is working right now**: Concrete interactive capabilities testable in production mode.
  3. **What to look out for**: Layout hierarchy, the 5 screen states (Default, Loading, Empty, Error, Edge Cases), plain-English human copy (zero leaked plumbing), typography integrity (zero monospace leaks), and 375px mobile responsiveness.
  4. **Exactly what to test**: A deterministic 3-to-4 step test script (route, action, expected outcome, error/network check).
  5. **The Rule of Thumb Decision Gate**:
     > *"Would you like me to test this for you right now (via browser subagent / terminal automation), or will you test this manually?"*
  6. The feature enters `VERIFYING` state. Only after a verified PASS (agent or human) is it marked `COMPLETED` in `progress-tracker.md` and appended to `memory.md`. If a test fails, trigger `/recover` immediately.

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
