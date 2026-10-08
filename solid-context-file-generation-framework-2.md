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
* **Users** — who actually uses this, and anything about them that shapes decisions (technical fluency, device/connection constraints, language).  
* **Pages/nav** — the top-level map of the product, not full detail (that's `user-flows.md`).  
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
* **System/integration diagram** — what talks to what (frontend, backend, database, third-party APIs/services, auth provider, email, payments). This is where a missing piece (e.g., "how does the payment provider actually notify us of success?") gets caught before it's an afterthought bolted onto a near-finished checkout flow.  
* **The Stack Decision writeup** — the actual reasoning for the chosen framework/hosting/database, tied to the constraints identified in the Kickoff gate (traffic, team size, budget, deployment target). Write the reasoning, not just the conclusion — "Next.js on Vercel because X, Y, Z" is useful to a future session; "Next.js" alone isn't, because it can't be checked against changed constraints later.

## **4\. `library-docs.md`**

Current documentation excerpts for exactly the libraries in the locked stack — **pulled live via search/fetch at kickoff time, never reconstructed from training-data memory.** Library APIs, especially for fast-moving frameworks, change often enough that recalled-from-memory usage is a real source of subtly wrong code (a deprecated prop, a renamed hook, a changed default). Treat any specific API call, config option, or setup step for a locked-stack library as something to verify against current docs before relying on it, not something to assume is still accurate from training.

Keep this focused — the libraries actually in the stack, the APIs actually being used, not a general tour of the framework's full surface area.

## **5\. `code-standards.md`**

Two layers, kept separate because they change independently:

**Stack-agnostic layer** — applies regardless of what gets chosen in `architecture.md`:

* Engineering mindset (consistency over cleverness, the reasoning already covered in `architecture.md`/SKILL.md's "How to work within this")  
* Error handling conventions (how errors surface, get logged, get shown to users)  
* Comment discipline (comments explain *why*, not *what* — code that needs a comment to explain what it does is a candidate for renaming/restructuring instead)  
* A full **Accessibility & Quality Floor** section: contrast ratios, keyboard navigation, semantic HTML, `prefers-reduced-motion` support, and responsive behavior down to 375px width. This is the enforceable, checkable version of `accessibility.md` — the same standards, written as a floor nothing is allowed to fall below, not a suggestion.

**Stack-specific layer** — written fresh for the locked stack each time, not copy-pasted from a previous project's stack:

* Folder structure (see `architecture.md` reference file for the general shape; this is the project-specific instantiation of it)  
* Naming conventions  
* Code patterns specific to this stack's idioms (e.g., Server Components vs. Client Components conventions in Next.js, composable patterns in the chosen state library)

## **6\. `ui-tokens.md` / `ui-rules.md` / `ui-registry.md`**

Only generated if a design stage produced one, or one already exists. These live outside this skill's scope (design system and visual-language decisions belong to the design process, not the engineering-standards process this skill covers) but are treated as a hard input once they exist: component-level work in the Build gate should consume the locked tokens/rules/registry rather than improvising new spacing, color, or component variants on the fly. A registry entry that already defines a "primary button" is the correct thing to reuse — not a reason to write a new one that's 90% the same.

## **7\. `build-plan.md`**

The phased feature list, built directly from `user-flows.md` — not a separate invention. Rules:

* **UI before logic.** Build the UI for a phase with mock/static data first, wire real logic in second. This catches layout and information-hierarchy problems while they're still cheap to fix (before they're entangled with data-fetching code).  
* **Every feature's UI section includes its states from `user-flows.md`** — not just the default/happy-path state. If `user-flows.md` defined an empty state and an error state for a screen, `build-plan.md`'s task list for that screen includes building those states, not just noting they exist.  
* **A Definition of Done on every feature**, consistently applied:  
  * Screenshot comparison against the design reference (if one exists)  
  * Quality-floor check (the Accessibility & Quality Floor section of `code-standards.md` — treat this as the same checklist, not a separate audit)  
  * Component-level genericness check — does this look like a distinctive, intentional piece of this product, or a template default that could belong to any project? (Ties to the anti-generic standards this skill's design-facing counterpart enforces, where applicable.)  
  * Progress-tracker update (see file 8\)

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

