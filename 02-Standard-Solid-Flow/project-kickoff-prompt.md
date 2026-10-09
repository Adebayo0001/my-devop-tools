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

STAGE 1 — DISCOVERY & FINANCIAL SCOPE INTAKE
Ask me the following questions one at a time, waiting for my answer before
asking the next one. Don't bundle them:
- What is being built, in one sentence
- Who is the user, what is their technical fluency, and what is their mental model
- Financial & Operational Scope: Is this a Bootstrapped MVP / Lean Startup
  (targeting near-$0/mo recurring SaaS burn using generous free tiers and consolidated
  BaaS, without compromising production quality) or a Funded Startup / Enterprise Client
  (ready to invest in premium infrastructure from Day 1 for maximum high-availability and reliability)?
- User UX Research: what are the user's primary friction points, skepticism, and the core Jobs-To-Be-Done (JTBD) they are hiring this product to solve
- What are the 3–6 core user flows / pages
- Hard constraints — compliance, latency, offline support, budget ceiling,
  existing infrastructure it must integrate with
- Any known team/personal stack preferences or existing skills to bias toward
- Timeline pressure
- Visual assets: Do I have an existing brand identity, logo, or color scheme to provide/upload,
  or are we starting completely from scratch?

STAGE 2 — TECH STACK DECISION, TOOL CONSOLIDATION & OBSERVABILITY
Based on my answers, propose a stack. Before you lock it:
- Selection criteria: fit to actual scale, financial scope, ecosystem fit, and maturity.
- LATEST STABLE VERSIONS ONLY: Every framework, library, and AI model must strictly be the
  latest stable release (e.g. latest Next.js App Router, latest React, latest Tailwind CSS, frontier
  models including OpenAI Astra / latest o-series, latest Gemini, latest Claude). Specifying outdated versions or deprecated APIs is an architectural defect.
- RAG & DOCS RESEARCH GATE: Retrieve and verify current documentation via RAG and MCP tools
  (e.g., context7 or official docs) before locking dependencies. Never guess from training memory.
- TOOL CONSOLIDATION INVARIANT (ANTI-TOOL SPRAWL): Strictly ban introducing 7-10 separate SaaS
  tools when 1 battle-tested platform achieves multiple purposes:
  * Consolidate DB + Auth + File Storage + Realtime into unified platforms (e.g. Supabase or Convex)
    instead of splintering into separate vendors (Auth0 + Neon + AWS S3 + Pusher).
  * Consolidate API and backend logic into modern full-stack frameworks (e.g., Next.js App Router
    Server Actions / Route Handlers) before introducing dedicated backend servers.
- TWO-STAGE EVOLUTION ROADMAP: Provide:
  * Stage 1 (Launch / MVP): Highly consolidated, cost-effective, production-grade foundation.
  * Stage 2 (Scale Migration): Clear path for decoupling compute, adding read replicas, caching tiers (Redis), and dedicated workers when traffic explodes.
- UI Component Standard: Confirm usage of **shadcn/ui** powered by **Radix UI** primitives as the un-guessed design system base.
- Observability Standard: Specify **Error Tracking** (Sentry exception tracking and/or LogRocket session replay) and **Performance Monitoring** (Datadog APM/RUM for system health and Core Web Vitals) with PII scrubbing.
- Evergreen Auto-Update: Include automated dependency updates (Dependabot/Renovate) and lockfile integrity.
- Plain English & Silicon Valley Reality: Explain options in plain English alongside how traditional
  Silicon Valley engineering teams run them in real production. Provide clear choices, trade-offs, and a recommended default capable of handling the most complex demands of the product.
- Wait for my confirmation before locking it.

STAGE 3 — VISUAL DIRECTION & GOOGLE STITCH PROTOCOL (MANDATORY STOP GATE)
Do NOT skip this stage, do NOT assume my visual preferences, and do NOT impose fonts or colors.
The entire process must be followed sequentially as if manual copy-and-paste prompts were used:

1. Visual Intake Stop Gate:
   - If I have existing branding (logo, colors, fonts): Ask me to provide/upload them, and lock them directly.
   - If I am starting from scratch: Ask for my color preferences (primary brand accent, background feel: deep dark mode, crisp light, or hybrid, and emotional mood) and typography preferences.
   - Propose 3 distinct, curated visual directions with NON-GENERIC typography (e.g. Syne + Plus Jakarta Sans, Outfit + Plus Jakarta Sans, Instrument Serif + Inter, Clash Display + Satoshi, Geist + Geist Mono). Strictly ban generic pairings like Inter + Roboto.
   - Wait for my confirmation and approval before finalizing.

2. Google Stitch Mockup Protocol:
   - Mandatory Pre-Prompt Project Visual Overview: Before writing the first screen prompt, output a brief overview summarizing the product mission, chosen colors, and layout mood.
   - Screen 1 Deterministic Stitch Prompt:
     * Write the prompt for the FIRST core screen only using the 5-part formula (viewport lock, spatial zones, named elements, locked palette, strict negative constraints).
     * NO FONT NAMES IN THE PROMPT: Describe typographic style and rendering character (e.g. "clean geometric sans-serif headings, high-legibility interface typography, crisp tabular metrics"). Never specify exact font family names in the prompt, letting Google Stitch render typography naturally without distortion.
     * Give me this prompt, allow me to run it in Stitch, and wait for my confirmation before generating subsequent prompts.

STAGE 4 — FILE GENERATION
Generate the following files in this exact order, each depending on what
came before:

1. project-overview.md — problem, users with synthesized User UX Research
   (mental models, JTBD, friction audit), pages/nav, core flow, in-scope,
   out-of-scope, success criteria
2. user-flows.md — sitemap, one flow diagram per core journey (entry point
   → every decision point → every branch → end state), a task flow for
   each primary action, a state inventory per screen (default, empty,
   loading, error, edge cases — not just the happy path), information
   hierarchy per screen (primary/secondary/tertiary content), and how
   flows connect to each other
3. architecture.md — data model, system/integration diagram, the Stack
   Decision writeup from Stage 2, and the Observability & Monitoring topology
   (Sentry, LogRocket, Datadog with PII scrubbing pipelines)
4. library-docs.md — current documentation excerpts for exactly the
   libraries in the locked stack (Radix UI, shadcn/ui, Sentry, LogRocket, Datadog),
   pulled live, not from memory
5. code-standards.md — two layers: a stack-agnostic layer (engineering
   mindset, zero-trust security, error handling with React Error Boundaries hooking
   into Sentry, comment discipline, and a full Accessibility & Quality Floor
   section covering contrast ratios, keyboard nav, semantic HTML, reduced motion,
   and responsive behavior down to 375px), and a stack-specific layer written fresh
   for the locked stack (folder structure, naming conventions, code patterns)
6. ui-tokens.md / ui-rules.md / ui-registry.md — 
   - Built on shadcn/ui and headless Radix UI primitives from established colors
   - Atomic Design hierarchy (Atoms, Molecules, Organisms)
   - Global CSS variable single-knob cascade (Figma webhook parity)
   - Sprint Design System Immutability: future sprint features must strictly reuse existing Atoms and Molecules
7. build-plan.md — phased feature list built from user-flows.md, UI built
   with mock data before logic is wired, every feature's UI section
   includes its states from user-flows.md (not just default), and a
   Definition of Done on every feature: screenshot comparison against the
   design reference, quality-floor check, component-level genericness
   check, atomic registry compliance, progress-tracker update
8. progress-tracker.md — phase/status table tied to the Definition of Done
   above, a Decisions Made During Build log, a Notes section

Before finalizing, check your own output: does every screen in
user-flows.md have more than just its happy-path state listed? Is the Stack
Decision actually justified with reasons rather than just asserted? Is the
atomic design system and single-knob CSS cascade explicitly locked? If
anything is thin, go back and fill it in rather than handing me an incomplete
file.
```

---

## Notes on using it

- Run this in a fresh chat, separate from the actual build session — keeps the build agent's context clean and focused on execution, not planning.
- If Stage 1 answers are vague on scale or constraints, let the AI say so explicitly rather than assuming — a wrong assumption at Stage 2 propagates into every file after it.
- The output of Stage 4 is the full file set — review it against the Human Review Checkpoint in `context-file-generation-framework.md` before handing it to Claude Code / Codex / Cursor.
