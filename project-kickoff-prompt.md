# Project Kickoff Prompt

Paste this into your brainstorming tool (a plain Claude/ChatGPT chat — not the build agent) at the very start of every new project. It runs the full discovery → stack decision → file generation process before any code gets touched.

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
If I said I have reference material but no finished design: ask me to
describe what I like about each reference in terms of layout rhythm, type
personality, color temperature, and overall mood — not specific elements.
Then write me a Google Stitch generation prompt using only those abstracted
qualities plus the actual subject of this product. Never name the source
product/app the reference came from in that prompt.

If I said I already have a finished design: skip this stage.

If I said design needs to be brainstormed with no reference at all: run a
short design brainstorm — ground it in the actual subject matter, propose a
palette (4–6 named hex values), a type pairing, a layout concept, and one
signature element. Check it against the question "would this look the same
for any other brand in this space" before finalizing.

STAGE 4 — FILE GENERATION
Generate the following files in this exact order, each depending on what
came before:

1. project-overview.md — problem, users, pages/nav, core flow, in-scope,
   out-of-scope, success criteria
2. user-flows.md — sitemap, one flow diagram per core journey (entry point
   → every decision point → every branch → end state), a task flow for
   each primary action, a state inventory per screen (default, empty,
   loading, error, edge cases — not just the happy path), information
   hierarchy per screen (primary/secondary/tertiary content), and how
   flows connect to each other
3. architecture.md — data model, system/integration diagram, and the Stack
   Decision writeup from Stage 2
4. library-docs.md — current documentation excerpts for exactly the
   libraries in the locked stack, pulled live, not from memory
5. code-standards.md — two layers: a stack-agnostic layer (engineering
   mindset, error handling, comment discipline, and a full Accessibility &
   Quality Floor section covering contrast ratios, keyboard nav, semantic
   HTML, reduced motion, and responsive behavior down to 375px), and a
   stack-specific layer written fresh for the locked stack (folder
   structure, naming conventions, code patterns)
6. ui-tokens.md / ui-rules.md / ui-registry.md — only if Stage 3 produced a
   design or one already existed
7. build-plan.md — phased feature list built from user-flows.md, UI built
   with mock data before logic is wired, every feature's UI section
   includes its states from user-flows.md (not just default), and a
   Definition of Done on every feature: screenshot comparison against the
   design reference, quality-floor check, component-level genericness
   check, progress-tracker update
8. progress-tracker.md — phase/status table tied to the Definition of Done
   above, a Decisions Made During Build log, a Notes section

Before finalizing, check your own output: does every screen in
user-flows.md have more than just its happy-path state listed? Is the Stack
Decision actually justified with reasons rather than just asserted? If
either is thin, go back and fill it in rather than handing me an incomplete
file.
```

---

## Notes on using it

- Run this in a fresh chat, separate from the actual build session — keeps the build agent's context clean and focused on execution, not planning.
- If Stage 1 answers are vague on scale or constraints, let the AI say so explicitly rather than assuming — a wrong assumption at Stage 2 propagates into every file after it.
- The output of Stage 4 is the full file set — review it against the Human Review Checkpoint in `context-file-generation-framework.md` before handing it to Claude Code / Codex / Cursor.
