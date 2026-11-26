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

STAGE 1 — THE 4 CONVERSATIONAL DISCOVERY PILLARS (No Overwhelm, High Coverage)
Guide me through discovery using 4 conversational pillars with helpful examples, capturing critical requirements without cognitive fatigue:
1. Pillar 1: Product Mission, Target Users & Real Problem
   - What core commercial problem is being solved? Who is the primary paying user, what is their technical fluency, and what is the end-to-end user journey from first landing to the core "aha!" moment?
2. Pillar 2: Brand Identity & Visual Personality
   - Do we have existing brand guidelines, logo files, or hex codes to provide/upload, or are we creating the design system from scratch? If starting fresh: what visual atmosphere fits best (crisp light, deep dark, or modern clean tech)?
3. Pillar 3: People, Roles & Access Control (Plain-English Database & RLS)
   - Who logs in (Customers, Team Managers, Platform Admins)? What can each user see or edit? (e.g., "Customers only see their own projects; Admins review all projects, manage billing, and delete users"). This defines database tables, ownership boundaries, and Row Level Security (RLS) policies from Day 1.
4. Pillar 4: Crucial Operations & Hidden Needs (Quietly Enforcing the 111-Item Production Safeguards)
   - Will users make payments or subscriptions? Do they need automated transactional emails/receipts? Will they upload sensitive files? What third-party APIs/webhooks are needed? Is this a lean MVP ($0/month free-tier target) or a funded scale architecture?

STAGE 2 — TECH STACK DECISION, TOOL CONSOLIDATION & PLAIN-ENGLISH RATIONALE
Based on my answers, propose a stack explained in plain, everyday English:
- State selection criteria in order: fit to actual scale, currency and quality of official documentation, ecosystem fit with what I need to integrate, hosting/cost fit, my stated familiarity, maturity over hype.
- Consolidate DB + Auth + File Storage + Realtime into unified platforms (e.g. Supabase or Convex) instead of multi-vendor sprawl.
- Propose a 2-stage evolution roadmap (Launch / MVP vs Scale Migration).
- Wait for my confirmation before locking it.

STAGE 3 — VISUAL DIRECTION & GOOGLE STITCH PIPELINE (PRODUCT DESIGNER MODE)
1. Visual Intake Stop Gate:
   - If I have existing branding (logo, colors, fonts): Ask me to provide/upload them, and lock them directly.
   - If starting from scratch: Propose 3 distinct, curated visual directions with non-generic typography.
   - Wait for my confirmation before finalizing.

2. Google Stitch Mockup Protocol:
   - Screen Inventory Mapping: Map out all core screens required across the user journey (e.g. SCR-01 Landing, SCR-02 Auth, SCR-03 Dashboard, SCR-04 Workspace, SCR-05 Settings).
   - Full-Fidelity Google Stitch Prompts: Write ready-to-paste prompts for ALL core screens using the 5-part formula (viewport lock, spatial zones, named elements, locked palette, strict negative constraints—no font family names).
   - HTML Screen Vault (`context/screens/`): Generated HTML files are saved into `context/screens/*.html` and inspected 1:1 during subsequent sprint builds.

STAGE 4 — INSTANT BATCHED FILE GENERATION (ZERO QUALITY LOSS)
Generate all 8 context files in a **single comprehensive pass**, completely eliminating multi-turn approval bottlenecks while embedding full technical depth:

1. project-overview.md — problem, users, pages/nav, core journey, in-scope, out-of-scope, success criteria.
2. user-flows.md — sitemap, one flow diagram per core journey, a task flow for each primary action, a 5-state inventory per screen (default, empty, loading, error, edge cases), and information hierarchy.
3. architecture.md — data model with full SQL DDL and Row Level Security (RLS) policies, system/integration diagram, the Stack Decision writeup from Stage 2, and Observability topology (Sentry, Datadog with PII scrubbing).
4. library-docs.md — current documentation excerpts for exactly the libraries in the locked stack, pulled live via search.
5. code-standards.md — stack-agnostic layer (zero-trust security, 111-concept safeguards, error handling with React Error Boundaries hooking into Sentry) + stack-specific layer.
6. ui-tokens.md / ui-rules.md / ui-registry.md — shadcn/Radix atomic primitives, single-knob CSS cascade, Sprint Design System Immutability.
7. build-plan.md — phased feature list derived from real **User Stories**. Features build pure user flows (zero repetitive boilerplate loading states from foundation) and include **In-Phase API Setup Gates** and deterministic 3-step verification runbooks.
8. progress-tracker.md — phase/status table tied to the Definition of Done above, a Decisions Made During Build log, a Notes section.

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
