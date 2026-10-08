# **Context Files**

This is the concrete output of the Kickoff gate for any non-trivial project: a fixed set of files that turn "what and why" into something explicit and checkable *before* code gets written, and that a future session can read to get full context without re-deriving decisions from scratch.

This is what "restate the feature as a spec" (see the Kickoff gate section in SKILL.md) actually means in practice — not a paragraph of prose, a defined set of artifacts with a defined job each.

## **Why a fixed set of files, not a free-form brief**

A free-form project brief tends to cover whatever the person happened to think of when writing it — usually the happy path, usually the visible screens, rarely the error states or the exact library APIs being targeted. Ambiguity that isn't caught here doesn't disappear; per the Kickoff gate reasoning in SKILL.md, it gets built into the code and becomes progressively more expensive to unwind. A fixed checklist of files forces the gaps to surface at the cheapest possible point — before a single component exists — rather than three features in.

## **When to generate the full set**

Full set: any project heading toward production, anything with a client attached, anything more than a handful of screens. Skip or thin out for a genuine one-off prototype or spike (see "Calibrating rigor" in SKILL.md) — but even then, `project-overview.md` and a lightweight `user-flows.md` are worth five minutes, because they're what prevents building the wrong thing quickly rather than the right thing quickly.

---

## **1\. `project-overview.md`**

The single source of truth for *what this is and isn't*. Contents:

* **Problem** — what's broken or missing that this project addresses, in one or two sentences a non-technical stakeholder would recognize as accurate.  
* **Users & Autonomous UX Research Intelligence**:
  - **Audience Archetypes**: Demographics, seniority, device profiles, online communities (subreddits, Discord, LinkedIn), and digital discovery behavior.
  - **Persona Mental Models**: Cognitive expectations, domain mental models, and emotional triggers.
  - **3-Level Jobs-To-Be-Done (JTBD)**: Minimum 5–7 jobs mapped across Functional, Emotional, and Social progress with Critical/High/Supporting ratings.
  - **Pain Points & Frustrations Hierarchy**: Minimum 8 pain points with severity ratings, root causes, workarounds, and verified public evidence.
  - **Competitive Map & Whitespace**: Direct/Indirect competitors, 5-second value proposition clarity, trust architecture gaps, and defensible market whitespace.
  - **Language Intelligence Repository**: Verbatim user phrases describing problems, ideal solutions, competitor recommendations, and complaints. Fuels all headline, CTA, and value proposition copy.
  - **Strategic Recommendations**: Positioning statement, hero value prop, top 5 objection handlers, and Critical/High/Supporting UX priorities.
* **Pages/nav** — the top-level map of the product, not full detail (that's `user-flows.md` and `build-plan.md`).  
* **Core flow** — the one journey that, if it doesn't work, the product has failed at its job.  
* **In-scope / out-of-scope** — explicit. "Out of scope" is as valuable as "in scope": it's what stops scope creep from being silently absorbed mid-build, and it's the first place to check when a request mid-project doesn't obviously fit.  
* **Success criteria** — how anyone (including a future session) would know this shipped successfully. Prefer criteria that are actually checkable, not vibes ("users can complete signup in under 2 minutes" beats "signup should feel easy").

## **2\. `user-flows.md`**

This is where most of the ambiguity that would otherwise become a build-time surprise gets caught. Contents:

* **Sitemap** — every screen/page, how they nest.  
* **One flow diagram per core journey** — entry point → every decision point → every branch → every end state. A flow diagram that only shows the happy path isn't a flow diagram, it's a wish. If a decision point has a branch that hasn't been thought through (what happens if payment fails mid-checkout?), that's exactly the kind of gap this file exists to surface before it's a half-built code path.  
* **A task flow for each primary action** — the specific click-by-click sequence for the actions that matter most (sign up, check out, submit).  
* **A state inventory per screen** — default, empty, loading, error, and edge cases, not just the happy path. This is the direct source for the "does every async operation handle loading/success/error/empty" discipline in `testing.md` — a screen with no defined empty state here is a screen that will ship with an undefined (probably broken-looking) empty state later.  
* **Information hierarchy per screen** — primary / secondary / tertiary content. This is a content and UX decision, not visual design, but it directly constrains layout decisions downstream.  
* **How flows connect** — where one journey hands off into another (e.g., "complete checkout" flow ends where "order confirmation / account creation" flow begins).

## **3\. `architecture.md`**

The technical shape of the system, decided once and referenced repeatedly rather than re-decided per feature:

* **Data model** — entities, relationships, and their key fields. Doesn't need to be a full schema on day one, but the shape should be stable enough that adding a feature later doesn't require restructuring existing tables.  
* **System/integration diagram** — what talks to what (frontend, backend, database, third-party APIs/services, auth provider, email, payments). This is where a missing piece gets caught before it's an afterthought bolted onto a near-finished checkout flow.  
* **Observability & Monitoring Topology** — error tracking (**Sentry** client/server SDKs with React Error Boundaries; **LogRocket** session capture for complex interactive flows) and performance monitoring (**Datadog** APM and RUM for Core Web Vitals, API latency, and server health). Includes strict PII scrubbing specifications.
* **The Stack Decision writeup** — the actual reasoning for the chosen framework/hosting/database, tied to constraints identified in Kickoff.

## **4\. `library-docs.md`**

Current documentation excerpts for exactly the libraries in the locked stack (including **Radix UI** primitives, **shadcn/ui**, **Sentry**, **LogRocket**, and **Datadog** SDKs) — **pulled live via search/fetch at kickoff time, never reconstructed from training-data memory.** Library APIs, especially for fast-moving frameworks, change often enough that recalled-from-memory usage is a real source of subtly wrong code.

Keep this focused — the libraries actually in the stack, the APIs actually being used, not a general tour of the framework's full surface area.

## **5\. `code-standards.md`**

Two layers, kept separate because they change independently:

**Stack-agnostic layer** — applies regardless of what gets chosen in `architecture.md`:

* Engineering mindset (consistency over cleverness)  
* Error handling conventions (React Error Boundaries hooking to Sentry, global server error filters, PII sanitization helpers)  
* Comment discipline (comments explain *why*, not *what*)  
* A full **Accessibility & Quality Floor** section: contrast ratios, keyboard navigation, semantic HTML, `prefers-reduced-motion` support, and responsive behavior down to 375px width.

**Stack-specific layer** — written fresh for the locked stack each time, not copy-pasted from a previous project's stack:

* Folder structure  
* Naming conventions  
* Code patterns specific to this stack's idioms (e.g., Server Components vs. Client Components conventions in Next.js, composable patterns in the chosen state library)

## **6\. `ui-tokens.md` / `ui-rules.md` / `ui-registry.md`**

The living design system contracts. Once generated, all build work strictly consumes them:
* **The shadcn/ui + Radix UI Foundation**: All interactive components are built on unstyled headless **Radix UI** primitives wrapped in **shadcn/ui**. Zero component guessing or ad-hoc unstyled divs.
* **The Atomic Principle**:
  - **Atoms**: Indivisible primitives (`Button`, `Input`, `Label`, `Badge`, `Avatar`, `Separator`, `Icon`).
  - **Molecules**: Compound functional units (`SearchBar` = Input + SearchIcon + Button; `FormField` = Label + Input + ErrorText).
  - **Organisms**: Distinct composite sections (`ProductCard` = Media atom + Title/Price atoms + Rating molecule + AddToCart molecule; `HeaderNav` = Logo atom + NavLinks molecule + UserMenu organism).
* **Global CSS Single-Knob Cascade (Figma Webhook Parity)**: All colors and radiuses are configured as CSS variables in `globals.css` (`--primary`, `--background`, `--card`, `--radius`) mapped to Tailwind. Modifying a single variable in `globals.css` cascades instantaneously and re-themes every Atom, Molecule, and Organism app-wide without touching component code—mirroring a live Figma Tokens API webhook.
* **Sprint Design System Immutability**: Any subsequent sprint build or unplanned feature must strictly assemble existing Atoms and Molecules from `context/ui-registry.md` without prompting.

## **7\. `build-plan.md`**

The phased milestone and structural feature blueprint, combining Information Architecture with execution runbooks. Built directly from `user-flows.md` and Bootcapt IA standards:

* **Information Architecture & Sitemap**:
  - Full hierarchical sitemap (Primary navigation, Secondary footer/sub-pages, Utility routes).
  - Navigation structure (Desktop, Mobile collapse, Primary CTA button placement).
* **Section-by-Section Architecture (Bootcapt Standard)**:
  - For every screen and section, specifies:
    ```markdown
    SECTION: [Name]
    Position: [Order index]
    Purpose: [What it accomplishes for the user]
    Contents: [Exact elements, headline direction, button text, image intent]
    Rationale: [Why it appears in this position in the sequence]
    ```
* **Content Relationships & Pathways**:
  - Internal content linking rules (e.g. Case Study Card ➔ Detail Page ➔ Inquire CTA).
  - 3 Core Landing-to-Conversion User Pathways.
  - Priority Order of Information (1st, 2nd, 3rd priority).
* **UI before logic.** Build the UI for a phase with mock/static data first, wire real logic in second. This catches layout and information-hierarchy problems while they're still cheap to fix (before they're entangled with data-fetching code).  
* **Every feature's UI section includes its states from `user-flows.md`** — not just the default/happy-path state. If `user-flows.md` defined an empty state and an error state for a screen, `build-plan.md`'s task list for that screen includes building those states, not just noting they exist.  
* **A Definition of Done on every feature**, consistently applied:  
  * Screenshot comparison against the design reference (if one exists)  
  * Quality-floor check (the Accessibility & Quality Floor section of `code-standards.md` — treat this as the same checklist, not a separate audit)  
  * Component-level genericness check — does this look like a distinctive, intentional piece of this product, or a template default that could belong to any project? (Ties to the anti-generic standards this skill's design-facing counterpart enforces, where applicable.)  
  * Progress-tracker update (see file 8)

This Definition of Done is the Build gate and Ship gate, applied per-feature instead of only at the very end — it's what prevents "looks done" from being confused with "is done" at the point where it's cheapest to catch.

## **8\. `progress-tracker.md`**

The living record of where the project actually stands:

* **Phase/status table** — tied directly to the Definition of Done in `build-plan.md`. A feature's status should reflect whether it's actually passed its Definition of Done, not whether code exists for it.  
* **Decisions Made During Build log** — any decision made mid-build that wasn't already captured in `architecture.md` or `project-overview.md` (a scope call, a tradeoff, a "we decided X instead of Y because Z"). This is what lets a future session understand *why* the code looks the way it does, instead of just what it does — the single biggest source of a future session confidently "fixing" something that was actually an intentional decision.  
* **Notes** — anything that doesn't fit the above but matters (known issues deferred on purpose, follow-ups, open questions for the user).

---

## **How this connects to the rest of the skill**

* Files 1–4 are produced at the **Kickoff gate**, before scaffolding begins.  
* File 5 (`code-standards.md`) is the project-specific instantiation of `architecture.md`, `security.md`, `accessibility.md`, `performance.md`, and `testing.md` in this skill — write it by applying those reference files to the locked stack, not by inventing separate standards.  
* File 7 (`build-plan.md`) is where the **Build gate**'s four lenses get applied feature-by-feature, via its Definition of Done.  
* File 8 (`progress-tracker.md`) is what the **Ship gate**'s pre-ship checklist gets checked against at the end — a feature that hasn't reached "done" in the tracker isn't ready for the pre-ship checklist regardless of how complete it looks.
