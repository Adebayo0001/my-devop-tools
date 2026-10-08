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

## Context Folder Protocol

Every project's context files live in a `context/` folder at the project root. **Before generating or executing anything** — writing a component, wiring an endpoint, answering a question about how something should work — read the context folder in this exact order (skip a file only if it genuinely doesn't exist yet at this stage of the project):

1. `context/project-overview.md`
2. `context/architecture.md`
3. `context/ui-tokens.md`
4. `context/ui-rules.md`
5. `context/ui-registry.md`
6. `context/code-standards.md`
7. `context/library-docs.md`
8. `context/build-plan.md`
9. `context/progress-tracker.md`

**This is a different order from the Gate 1 creation sequence below, on purpose.** Creation order exists to catch ambiguity as early as possible (overview and flows before anything visual or technical gets decided). This read order exists to answer "what do I need to know before writing this line of code" — overview and architecture first for the *what*, then the design system (tokens/rules/registry) so nothing gets built outside the established visual language, then code standards and library docs for the *how*, then the plan and tracker for *what's already done and what's next*. `user-flows.md` and `design.md` aren't in this list because by the time build work is happening, their content has already been absorbed into `project-overview.md` and `ui-tokens.md`/`ui-rules.md` — they matter most at kickoff, not on every build action.

If a file this order calls for doesn't exist and the current task needs it (e.g., about to build UI but `ui-tokens.md` is missing), stop and flag it rather than improvising around the gap.

## Rules That Never Change

- **Never use hardcoded hex values or raw Tailwind color classes.** Every color reference goes through `context/ui-tokens.md`. A hex code or an unmapped Tailwind class (`bg-red-500` instead of the project's actual error/destructive token) appearing in a component is always wrong, no exceptions for "it's just a quick fix."
- **Update `context/progress-tracker.md` and `context/ui-registry.md` after every feature** — not at the end of a session, not in a batch later. This is what keeps both files trustworthy as a live source of truth instead of stale documentation nobody updates.
- **Before using any third-party library**: if the build environment has an installed skill for that library, load and apply it first; then read `context/library-docs.md` for this project's specific rules on how it's used here. General library knowledge alone isn't enough — the project-specific constraints in `library-docs.md` take precedence over generic usage patterns.
- **If the same problem persists after one corrective prompt — stop immediately and run `/recover`.** Don't attempt a second, third, fourth fix on instinct. Repeated blind correction attempts are how a small bug turns into a series of increasingly unrelated changes that make the actual problem harder to find.

---

## Gate 1 — Kickoff (before writing any code)

Lock in what's expensive to change later: stack fit (traffic, team size = solo, budget, deploy target), data model shape, auth model (does this even need accounts?), environment strategy (secrets/config per environment), and design system architecture.

**For anything beyond a prototype, produce this file set before scaffolding — generated and approved ONE FILE AT A TIME, never batched.** Generate exactly one file, present it, stop, wait for explicit approval ("approved" / "looks good" / "continue" / specific corrections applied) before starting the next. Never produce a file as a byproduct of another step. A file the user never actually reviewed because it arrived bundled with others provides none of the protection this gate exists for — that's the whole point of gating it. Every file gets the same standard: **write the exact explanation, instructive and complete — not a brief, not a summary.** A bullet that just names a topic without stating the actual rule is not done.

**Sequence:**

1. **project-overview.md** — PRD-level, not a summary. Problem (explained in full), target users with **Synthesized User UX Research** (persona mental models, Jobs-To-Be-Done [JTBD], task friction analysis, cognitive load mapping), clear navigation, onboarding, profile setup, explicit in-scope/out-of-scope features (specific, not categories: "patients can cancel up to 24h in advance," not "booking management"). Plus a **User Flow** section as a heading, with **each step of the core journey as its own sub-heading**, explained in prose (what happens, why, what it hands off to) — readable standalone, without a diagram. Plus a **Data architecture** section explained in prose (the narrative version; literal schema comes later).

2. **user-flows.md** — sitemap; one flow diagram per core journey (entry → every decision point → every branch → end state, not just happy path); a task flow per primary action; a state inventory per screen (default, empty, loading, error, edge cases); information hierarchy per screen; how flows connect.

3. **Visual direction (only if no visual reference exists yet — skip to step 7 extraction if one does):**
   - **design.md** — lock color direction, typography direction, and aesthetic feel through a short back-and-forth with the user first, then write it down: colors with intended usage (not just hex codes), fonts with role (heading/body/accent). Single source of truth for visual identity from here on.
   - **Up to 5 core page prompts** (for Google Stitch or equivalent) — identify the pages every other page rests on (dashboard, main list/browse, primary detail/action view, auth if structurally central, core conversion screen). One exact, ready-to-paste prompt per page, **generated and approved one at a time**. Never restate color in the prompt — reference "the established color system" instead, since design.md already owns it. Describe purpose, content, functionality, information hierarchy (from user-flows.md), and relevant state. First prompt carries full brand/project context; each next prompt builds on the prior approved ones rather than re-explaining from scratch.

4. **architecture.md** — data flow (how data moves end to end, not just its shape), stack + reasoning, folder structure, system boundaries (client vs. server vs. third-party, what the client is never the source of truth for), invariants (rules that must always hold — "a booking can never have two confirmed appointments for the same slot"), full API route list/spec, detailed database schema (tables, columns, types, constraints), and **Observability & Telemetry Architecture** (Sentry exception capture, LogRocket session replay, Datadog APM/RUM, with strict PII scrubbing pipelines).

5. **library-docs.md** — specific, detailed excerpts for exactly the locked-stack libraries (including Radix UI primitives, shadcn/ui, Sentry, LogRocket, and Datadog SDKs), **pulled live, never from training memory**. Setup/config, the specific APIs this project actually calls, version-specific gotchas. Enough to write correct calls without re-searching mid-build — a one-paragraph summary isn't enough.

6. **code-standards.md** — detailed and instructive, not a topic list: engineering mindset, zero-trust security, file/folder naming (with examples), component structure (shown, not named), API route handler pattern, server action pattern (incl. where auth/ownership checks happen), error handling with React Error Boundaries hooking into Sentry, environment variable convention, match/threshold-style constants (where business-rule thresholds live, never hardcoded inline), PII scrubbing helpers, comment discipline (why, not what), dependency standard, import alias convention.

7. **ui-rules.md** — extracted from the approved visual reference. **The Atomic Principle**: rules for constructing **Atoms** (`Button`, `Input`, `Badge`, `Label`), composing them into **Molecules** (`SearchBar`, `FormField`), and assembling **Organisms** (`ProductCard`, `HeaderNav`). Font usage rules, layout/grid rules, navbar structure, card rules, typography hierarchy, button variants and states, form input structure, the standard empty-state pattern, project-specific rules, table conventions, progress bar usage.

8. **ui-tokens.md** — extracted from design.md + approved core pages, expanded to implementation-ready. **The shadcn/Radix Foundation**: Built exclusively on **shadcn/ui** and headless **Radix UI** primitives using established colors. **Global CSS Single-Knob Cascade (Figma Webhook Parity)**: All theme colors are configured as CSS variables in `globals.css` (`--primary`, `--background`, `--card`, `--radius`). Changing a single variable in `globals.css` updates every atom, molecule, and organism app-wide instantaneously. Full token definitions, typography scale, status/indicator tokens, spacing scale, component tokens, button tokens, token-level invariants.

9. **ui-registry.md** — the living inventory of UI patterns actually implemented so far: every component that exists, its atomic tier (`[ATOM]`, `[MOLECULE]`, `[ORGANISM]`), what it's called, where it lives, and which tokens/rules it consumes. Starts near-empty at kickoff and grows via `/imprint` after each new component. **Sprint Design System Immutability**: Any future sprint feature not in the initial overview MUST automatically reuse registered Atoms and Molecules without the builder prompting or guessing.

10. **build-plan.md** — phased directly from user-flows.md. Each phase is a continuation of the previous, not a parallel stream. Each phase has general framing + specific **numbered** features, each feature including both logic and UI. A phase can hold multiple features, each with logic derived from the actual user flow, not invented at plan time. **Every feature includes a detailed, ready-to-use anchor prompt** referencing the relevant sections of architecture/code-standards/ui-rules/ui-tokens and the specific states from user-flows.md it needs. UI-with-mock-data before logic. Every feature's UI section includes ALL its states, not just default. Every feature gets a Definition of Done: screenshot vs. design reference, quality-floor check, component-level genericness check, atomic registry compliance, progress-tracker update.

11. **progress-tracker.md** — phase/status table tied to the Definition of Done; a Decisions Made During Build log (any mid-build call not already in architecture.md/project-overview.md — this is what stops a future session from "fixing" an intentional decision); a Notes section.

If a request is genuinely ambiguous at any step — ask before drafting that file. Don't silently pick an interpretation and let it flow downstream.

All files above live in a `context/` folder at the project root once created (`context/project-overview.md`, etc.) — see **Context Folder Protocol** below for how they get read during actual build work, which follows a different order than this creation sequence.

---

## Gate 2 — Build (while writing each feature)

Five lenses, every feature that touches input/data/rendering. Not every feature needs full strength on every lens, but default to checking, not skipping.

### Design System & Atomic UI
- **Zero Component Guessing**: Every interactive component must use **shadcn/ui** and **Radix UI** primitives. Never create un-accessible custom modal overlays, custom dropdowns, or unstyled form controls.
- **Atomic Composition**: Assemble features by composing established **Atoms** into **Molecules**, and Molecules into **Organisms**.
- **No Hardcoded Hex / Raw Utility Colors**: Never use `#hex` or raw Tailwind color numbers (`bg-blue-600`). Reference only semantic tokens tied to CSS variables (`bg-primary`, `text-foreground`).
- **Sprint Immutability**: New sprint features must strictly consume existing design tokens and atomic primitives.

### Security
- **Secrets**: never in source, ever. `.env` gitignored from commit #1. Client bundles get public/publishable keys only — never a secret key.
- **Input validation**: server-side, always, even if also client-side (client-side is UX, not a boundary). Use a schema library (Zod/Yup) — **show the actual schema**, don't just assert "it's validated."
- **Injection**: parameterized queries / ORM only, never string-concatenated SQL. Rely on framework default escaping; `dangerouslySetInnerHTML`/`v-html` needs explicit sanitization (DOMPurify), never raw user input.
- **Auth = authentication AND authorization.** Server-side checks on every protected route, not just a hidden button. "Logged in" ≠ "allowed to touch this specific record" — check ownership (the Tea app lesson).
- Use established auth providers (Auth.js, Clerk, Supabase Auth, platform-native) — don't hand-roll session/password logic.
- Rate-limit auth endpoints. CORS: never `*` for anything non-public.
- File uploads: validate type/size server-side, don't trust client-reported MIME type.

### Accessibility (WCAG 2.1 AA — the baseline, not a stretch goal)
- Semantic HTML: real `<button>`/`<a>`/`<nav>`/`<main>`/heading hierarchy backed by Radix UI.
- Full keyboard operability on every interactive element. Never remove focus outlines without a clear visible replacement. Modals trap focus, return it on close.
- `alt` text on meaningful images, `alt=""` on decorative ones. Real `<label>`s (not placeholders). Icon-only buttons need `aria-label`. Dynamic content (toasts, errors) needs `aria-live`.
- Contrast ≥4.5:1 normal text / ≥3:1 large text, checked in both light and dark themes if both exist. Never color-alone for meaning.
- Forms: labels, required-field indicators, specific errors tied via `aria-describedby`.

### Performance & Observability
- **Error Tracking**: Wrap layouts with React Error Boundaries reporting to **Sentry** with release tags and sourcemaps. Enable **LogRocket** session capture for critical interactive flows.
- **Performance APM**: Instrument **Datadog** APM and RUM to monitor Core Web Vitals, API latency, and server health.
- **PII Scrubbing**: Telemetry MUST sanitize auth tokens, credit cards, passwords, and client PII before transmitting.
- **Avoid N+1**: about to `.map()` with a fetch inside? Batch it (join / `IN` query / single call) instead.
- Avoid waterfalls: parallelize independent requests (`Promise.all`).
- Paginate/virtualize anything unbounded.
- Targets: **LCP < 2.5s, INP < 200ms, CLS < 0.1.**
- **Low-bandwidth resilience**: ensure fast initial render on 50–400kbps connections.

### Testing
- Prioritize: business logic with branches (pricing, permissions), anything touching money/auth/personal data, anything that's already been fixed once (add the regression test), API endpoints (happy path + invalid input + unauthorized access).
- Don't force tests on pure layout/no-logic components or auto-generated boilerplate.
- Every async operation has three states — confirm all three are handled: loading (something visible, not blank/stale), error (specific user-facing message, not a console error), empty (deliberate empty state, not a broken-looking blank list).
- Reserve heavy E2E (Playwright/Cypress) for genuinely critical journeys (checkout, signup, login) — not every feature.

### Destructive actions — standing rule, not optional
Dropping a table, deleting a production DB/bucket, force-pushing, overwriting production `.env`, running a migration against live data: **stop for an explicit, separate confirmation every time** — even mid-session, even if the broader task was approved, even if the plan seems obviously correct. Approval of a feature is not approval to delete data to build it. This is the one mistake category here that can't be fixed with a follow-up commit.

---

## Gate 3 — Ship (before saying "ready" / deploying)

If `progress-tracker.md` exists, check against it directly — a feature not marked "done" there isn't ready for this checklist regardless of how finished it looks in the browser.

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
- [ ] Keyboard nav works everywhere; meaningful `alt` text; WCAG AA contrast; labeled forms
- [ ] No obvious N+1s or waterfalls; images sized/compressed; no unbounded unpaginated lists
- [ ] Responsive down to 375px
- [ ] No stubbed/mocked code silently presented as finished — disclosed instead
- [ ] No unconfirmed destructive actions in the session history
Report results in plain terms: what was checked, and the one thing left for a real decision — not a wall of checkmarks.

---

## Available Skills

Six workflows exist for build-time situations the three gates above don't fully cover on their own. Each has its own workflow file with full detail — this is the quick-reference index.

| Trigger | Workflow | What it does |
|---|---|---|
| Before any complex feature | `/architect` | Think before building — reads context, reasons through approach and affected invariants, gets a lightweight plan approved before code starts |
| After any new UI component | `/imprint` | Captures the pattern into `context/ui-registry.md` so it's reused, not reinvented, next time |
| Before a demo, or when something feels off | `/review` | Full quality pass — the Gate 3 checklist plus consistency against the registry |
| When something breaks after one failed correction | `/recover` | Stops blind retry attempts, diagnoses systematically, never rolls back destructively without confirmation |
| When user says 'log memory' or feature spans sessions | `/remember save` | Incrementally snapshots where things stand into `memory.md` (never asking to overwrite) |
| When returning to a multi-session feature | `/remember restore` | Reloads that snapshot plus the Context Folder Protocol before resuming |

**If the user doesn't name a specific skill, check the situation against this table and apply the matching one — don't wait to be told.** A request to build something non-trivial without an existing plan is an unstated `/architect` trigger; finishing a UI component is an unstated `/imprint` trigger; "this looks off" or a pre-demo request is an unstated `/review` trigger; a second attempt at the same fix is the unstated signal to stop and run `/recover` instead of trying a third time. When applying one implicitly rather than because the user typed the slash command, say so in one line ("this is a complex enough feature that I'll think it through first — running through `/architect`") so it's never a silent behavior change.

---

## How to work generally

- State assumptions out loud when skipping a check ("no rate limiting — this endpoint has no side effects") rather than silently skipping.
- A `// TODO: add validation` comment is worse than no comment — it looks handled when it isn't. Either fix it or flag it as an open item to the user.
- Fix cheap gaps immediately (an `alt`, a parameterized query). Flag gaps that need a real decision from the user.
- Consistency over cleverness — one state-management approach, one error-handling pattern, one file-structure convention per project. A future session (or future you) extends a consistent codebase correctly; it guesses wrong in a clever, inconsistent one.
- **Memory Logging Rule (`log memory` / `/remember`)**: Whenever the user says "log memory", "log to memory", or calls `/remember save`, update `memory.md` incrementally. **NEVER ask for permission to overwrite**. Preserve existing milestones and decisions, and append new work.
