# Project Kickoff Prompt

Paste this into your brainstorming tool (a plain Claude/ChatGPT chat — not the build agent) at the very start of every new project. It runs the full discovery → stack decision → visual direction → file generation process before any code gets touched, generating one file (and one design screen) at a time so nothing comes out vague or bundled.

---

## The prompt

```
You're helping me plan a new software project from scratch. Do not write any
code and do not generate any design files yet — this session is discovery
and planning only. We'll produce a set of context files that I'll hand to a
separate build agent afterward.

Work through this in four stages. Do not skip ahead to a later stage until
the current one is done.

STAGE 1 — DISCOVERY
Ask me the following questions one at a time, waiting for my answer before
asking the next one. Don't bundle them:
- What is being built, in one sentence
- Who is the user, and what's their technical comfort level
- What are the 3–6 core user flows / pages
- Scale expectations — side project, funded startup, enterprise
- Hard constraints — compliance, latency, offline support, budget ceiling,
  existing infrastructure it must integrate with
- Any known team/personal stack preferences or existing skills to bias
  toward
- Timeline pressure
- Do I already have a visual design or reference material, or does design
  need to be brainstormed as part of this

STAGE 2 — TECH STACK DECISION
Based on my answers, propose a stack. Before you lock it:
- State your selection criteria in order: fit to actual scale, currency and
  quality of official documentation, ecosystem fit with what I need to
  integrate, hosting/cost fit, my stated familiarity, maturity over hype
- Actually search for current versions and current best-practice guidance
  for your shortlisted options — don't rely on training data, it may be
  stale
- Give me 2–3 alternatives you considered and why the one you're proposing
  won
- Wait for my confirmation before locking it

STAGE 3 — VISUAL DIRECTION
If I already have a finished design: skip this stage.

Otherwise, this stage is sequential and gated — generate one thing at a
time and wait for my approval before the next:

1. From user-flows.md (or a first pass at the sitemap if that's not
   written yet), identify up to 5 core screens: screens every other
   screen extends, reuses components from, or navigates through, covering
   the widest range of UI patterns the product needs (a data-dense view,
   a form-heavy view, a list view, a detail view, a first-run/empty
   view).
2. If I have reference material, ask me to describe what I like about it
   in terms of layout rhythm, type personality, color temperature, and
   mood — never specific elements, and never name the source product. If
   I have no reference, derive the direction from the product and
   audience directly.
3. Lock that direction into a short design.md containing only the color
   palette (4-6 named values) and type pairing. Show it to me and wait
   for approval — nothing after this point re-specifies color or font.
4. Write the Stitch prompt for the FIRST core screen only. This one
   carries full product context plus the locked design.md direction, and
   establishes the button/card/input/badge shapes every later screen will
   reuse. Give me this prompt, I'll run it in Stitch, and I'll confirm
   before you continue.
5. One at a time for each remaining core screen: write a short prompt
   that references the established system in design.md and describes
   only what that screen needs to show and do — no color or font
   respecified. Wait for my approval after each one before writing the
   next.

STAGE 4 — FILE GENERATION
Hard rule: generate exactly ONE file per message, in full detail, never
compressed or summarized. State which file you're producing, generate it
completely against the requirements below, then STOP and wait for my
explicit approval before starting the next file. If I ask for changes,
revise that same file and wait for approval again — never move to the
next file until the current one is approved as-is. Do not bundle two
files together under any circumstance, even if they seem related.

Generate in this exact order:

1. project-overview.md — write this as a PRD, not a summary. Include, each
   as its own full section: a detailed explanation of the project, the
   problem it solves, target users, navigation, pages (pulled from
   user-flows.md), a "Core User Flow" section where EACH STEP gets its own
   sub-heading with a full explanation of the logic and flow (not a
   bullet list), onboarding and profile setup where applicable (same
   explained standard), data architecture explained (not just labeled),
   specific features in scope, specific features out of scope, and
   success criteria. Every section must be instructive enough that
   someone who wasn't in this conversation could build correctly from it
   alone.

2. user-flows.md — sitemap; one flow diagram per core journey covering
   EVERY branch including failure branches (e.g. what happens if payment
   fails mid-checkout, not just the happy path); a task flow for each
   primary action; a state inventory per screen (default, empty, loading,
   error, edge cases); information hierarchy per screen
   (primary/secondary/tertiary); how flows connect to each other.

3. architecture.md — the Stack Decision from Stage 2; data flow for each
   major operation; folder structure, complete; system boundaries;
   invariants (rules that must never be violated by later features); every
   API route with method/purpose/request/response shape; and a specific,
   detailed database schema — every table, every column with its type,
   every relationship, every meaningful index.

4. library-docs.md — specific, detailed documentation for exactly the
   libraries in the locked stack: real method signatures, config shapes,
   usage patterns pulled from current live docs. Not a summary of what
   each library does.

5. code-standards.md — two layers. Layer 1 (identical every project):
   detailed engineering mindset, error-handling philosophy, comment
   discipline, and the full Accessibility & Quality Floor. Layer 2
   (written fresh for this stack): file/folder naming, component
   structure, API route handler pattern with a real example, server
   actions pattern with a real example, agent code conventions if
   applicable, error handling pattern, environment variables (all of
   them, with purpose and client/server exposure), key domain-specific
   constants defined once, approved dependency list with reasoning, and
   import alias conventions.

6. design.md, ui-tokens.md, ui-rules.md — only if Stage 3 produced a
   design or one already existed. ui-rules.md covers: font, layout,
   navbars, cards, typography hierarchy, badges, buttons, form inputs,
   empty states, tables, progress bars, and any project-specific rules.
   ui-tokens.md covers: how to use, global CSS/complete token definition,
   color usage guide, page layout, typography, spacing, component tokens,
   any domain-specific indicator tokens this project actually needs
   (score colors, status badges, activity markers, chart colors —
   whatever applies), logo, and invariants.

7. build-plan.md — phased, each phase a direct continuation of the last;
   a short paragraph of general information at the top of each phase;
   features numbered continuously across the whole project (not restarting
   per phase); every feature defines BOTH its UI (with states pulled from
   user-flows.md) and its logic — never just one; more than one feature
   per phase where the underlying user flow actually has multiple distinct
   pieces of logic; and a build-anchor prompt at the end that the build
   agent re-reads before starting each phase, restating: UI-before-logic,
   states come from user-flows.md, screens match context/designs/, code
   follows code-standards.md including the Accessibility & Quality Floor,
   and nothing is done until its Definition of Done passes.

8. progress-tracker.md — phase/status table tied to the Definition of Done
   in build-plan.md, a Decisions Made During Build log, a Notes section.

After each file is approved, move to the next. Do not generate a
"finalizing" summary at the end that recaps everything — the individually
approved files are the deliverable.
```

---

## Notes on using it

- Run this in a fresh chat, separate from the actual build session — keeps the build agent's context clean and focused on execution, not planning.
- If Stage 1 answers are vague on scale or constraints, let the AI say so explicitly rather than assuming — a wrong assumption at Stage 2 propagates into every file after it.
- Expect this to be a long back-and-forth, not one big generation — that's the point. Stage 3 alone can be 5–6 exchanges (one design.md approval + one approval per core screen), and Stage 4 is 8 separate approvals, one per file. If the AI ever tries to generate more than one file or more than one screen in a single message, stop it and ask it to redo just the first one.
- The output of Stage 4 is the full file set — review it against the Human Review Checkpoint in `context-file-generation-framework.md` before handing it to Claude Code / Codex / Cursor.
