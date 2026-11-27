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

STAGE 1 — THE 4 CONVERSATIONAL DISCOVERY PILLARS (Strictly One Pillar at a Time)
Guide me through discovery using 4 conversational pillars, presented **STRICTLY ONE PILLAR AT A TIME**. Ask me Pillar 1 first and STOP to wait for my answer before presenting Pillar 2, etc. **NEVER use raw legal jargon or section numbers**—use the **3-Part Decision Formula** (Plain-English Question + Clear Options + Friendly "Why It Matters" Explanation):
1. Pillar 1: Product Mission, Target Users, User Journey & Feature Wishlist
   - What core commercial problem is being solved, and who is the primary paying user?
   - Can you describe the ideal user journey—how should someone actually use or navigate the website/app from first landing to achieving their goal?
   - Are there any specific features, tools, or pages you are considering that the app or website should definitely include? *(Ask this and wait for my response)*
2. Pillar 2: Brand Identity & Visual References (Always Inquire Upfront)
   - Do we have existing brand guidelines, logo files, or visual references (competitor URLs, moodboards, screenshots, Dribbble comps)? If references are provided, synthesize a unique, non-generic design concept matching `design-vault/` archetypes (zero cloning, zero generic AI defaults). Right in the kickoff chat, output the exact CSS color combo (`--background`, `--card`, `--primary`, `--secondary`, `--border`, `--foreground`) and a live rendered UI component preview (buttons, elevated card, input) so we visually confirm the aesthetic before locking tokens. *(Present this and wait for my confirmation)*
3. Pillar 3: People, Roles & Access Control (Demystifying Database, BFF & Account Security)
   - Who will log in (Customers, Team Managers, Platform Admins)? How do they sign in? What can each user see or edit?
   - *(Why it matters: Defines database tables, non-guessable UUIDv4s, Backend-for-Frontend [BFF] session token encapsulation, and Row Level Security [RLS] policies from Day 1).* *(Ask this and wait for my response)*
4. Pillar 4: Crucial Operations, Privacy & Statutory Legal Safeguards (Demystifying Compliance)
   - *Customer Locations*: Where are your users located (Nigeria/Africa, UK/Europe, US, or Global)?
     *(Why it matters: Quietly activates the right privacy protection rules—NDPC in Nigeria, GDPR in Europe, or CCPA in California—avoiding regulatory fines).*
   - *Cookies & Analytics*: Will you use marketing or analytics tools (Google Analytics, Meta Pixel)?
     *(Why it matters: If yes, activates an automatic Cookie Banner with equal-weight Accept/Reject buttons blocking scripts until accepted).*
   - *Payments & Pricing*: Will you sell products, subscriptions, or digital checkouts?
     *(Why it matters: Consumer laws require checkout prices to match advertised prices, itemized receipts, and fair cancellation/refund terms—banning void 'No Refund' clauses).*
   - *Company Registration*: Is this website for a registered business (official name & CAC RC number)?
     *(Why it matters: By corporate law, registered businesses must display their registered name, RC number, and official address in footers and on digital receipts).*
   - *AI Features & Data*: Will user questions, files, or interactions be used to train AI models?
     *(Why it matters: Privacy laws require an explicit opt-out toggle in user settings and Zero Data Retention API guarantees).*
   - *Account Deletion & Data*: Will users create accounts?
     *(Why it matters: Mandates a self-serve button in settings for users to export data or permanently delete accounts).*
   - *Financial Scope*: Bootstrapped MVP ($0/month free tiers) vs Funded Startup / Enterprise.

STAGE 2 — TECH STACK DECISION, TOOL CONSOLIDATION & PLAIN-ENGLISH RATIONALE
Based on my answers, propose a stack explained in plain, everyday English:
- Selection criteria: fit to actual scale, financial scope, ecosystem fit, and maturity.
- LATEST STABLE VERSIONS ONLY: Every framework, library, and AI model must strictly be the
  latest stable release (e.g. latest Next.js App Router, latest React, latest Tailwind CSS, frontier
  models).
- RAG & DOCS RESEARCH GATE: Retrieve and verify current documentation via RAG and MCP tools
  (e.g., context7 or official docs) before locking dependencies. Never guess from training memory.
- TOOL CONSOLIDATION INVARIANT (ANTI-TOOL SPRAWL): Strictly ban introducing 7-10 separate SaaS
  tools when 1 battle-tested platform achieves multiple purposes:
  * Consolidate DB + Auth + File Storage + Realtime into unified platforms (e.g. Supabase or Convex).
  * Consolidate API and backend logic into modern full-stack frameworks (e.g., Next.js App Router
    Server Actions / Route Handlers) before introducing dedicated backend servers.
- TWO-STAGE EVOLUTION ROADMAP: Provide Launch / MVP vs Scale Migration.
- UI Component Standard: Confirm usage of **shadcn/ui** powered by **Radix UI** primitives.
- Observability Standard: Specify **Error Tracking** (Sentry) and **Performance Monitoring** (Datadog APM/RUM) with PII scrubbing.
- Plain English & Silicon Valley Reality: Explain options in plain English alongside how traditional
  Silicon Valley engineering teams run them in real production. Provide clear choices, trade-offs, and a recommended default.
- Wait for my confirmation before locking it.

STAGE 3 — VISUAL DIRECTION & GOOGLE STITCH PIPELINE (PRODUCT DESIGNER MODE)
1. Visual Intake Stop Gate:
   - If I have existing branding (logo, colors, fonts): Ask me to provide/upload them, and lock them directly.
   - If I am starting from scratch: Propose 3 distinct, curated visual directions with NON-GENERIC typography (e.g. Syne + Plus Jakarta Sans, Outfit + Plus Jakarta Sans, Instrument Serif + Inter, Clash Display + Satoshi).
   - Wait for my confirmation and approval before finalizing.

2. Google Stitch Mockup Protocol:
   - Comprehensive 111-System Screen Inventory Mapping: Map all screens required across the user journey derived from the 111 Core Systems Concepts:
     * `SCR-01: Landing & Conversion` (Value Prop, Pricing, FAQ)
     * `SCR-02: Identity & Auth Security` (Sign-In, Sign-Up, MFA/2FA, Password Reset — *Concepts 68–73*)
     * `SCR-03: Workspace Onboarding` (Team Invite, Role Assignment, Seed Data)
     * `SCR-04: Primary Workspace Dashboard` (Telemetry Stream, Core Canvas, Metrics — *Concepts 1–19, 22–24*)
     * `SCR-05: Entity Management & Detail Inspector` (Filterable Grid, Entity Detail View, Empty States — *Concepts 25–27, 36–37*)
     * `SCR-06: Administrative Governance Console` (User Management, RLS Matrix, Audit Log — *Concepts 68, 81–82*)
     * `SCR-07: Billing & Usage Quotas` (Stripe Portal, Tier Management, Quota Alerts — *Concept 88*)
     * `SCR-08: Platform & Webhook Settings` (API Vault, Webhook Dispatcher, Rate-Limit Analytics — *Concepts 67, 101–103*)
     * `SCR-09: Resilience & Error Boundaries` (500 Error Recovery Boundary, 404, 429 Rate-Limit Throttled Screen — *Concepts 10–13, 55, 83–85, 109–111*)
     * `SCR-10: Trust, Privacy & Legal Hub` (Privacy Policy, Terms of Service, Cookie Preference Center with granular opt-in & equal-weight Reject All, Data Subject Rights [DSAR] Account Deletion / Data Export page, and Accessibility Statement — *Concepts 68, 71, 74, 111*)
   - Full-Fidelity Google Stitch Prompts: Write ready-to-paste prompts for ALL core screens using the 5-part formula (viewport lock, spatial zones, named elements, locked palette, strict negative constraints—no font family names).
   - HTML Screen Vault (`context/screens/`): Generated HTML files are saved into `context/screens/*.html` and inspected 1:1 during subsequent sprint builds.

STAGE 4 — INSTANT BATCHED FILE GENERATION (ZERO QUALITY LOSS)
Generate all 8 context files in a **single comprehensive pass**, completely eliminating multi-turn approval bottlenecks while embedding full technical depth:

1. project-overview.md — problem, users with synthesized User UX Research (mental models, JTBD, friction audit), pages/nav, core journey, in-scope, out-of-scope, success criteria.
2. user-flows.md — sitemap, one flow diagram per core journey, a task flow for each primary action, a 5-state inventory per screen (default, empty, loading, error, edge cases), and information hierarchy.
3. architecture.md — data model with full SQL DDL and Row Level Security (RLS) policies, system/integration diagram, the Stack Decision writeup from Stage 2, and Observability & Monitoring topology (Sentry, LogRocket, Datadog with PII scrubbing).
4. library-docs.md — current documentation excerpts for exactly the libraries in the locked stack, pulled live via search.
5. code-standards.md — stack-agnostic layer (zero-trust security, 111-concept safeguards, error handling with React Error Boundaries hooking into Sentry) + stack-specific layer.
6. ui-tokens.md / ui-rules.md / ui-registry.md — 
   - Built on shadcn/ui and headless Radix UI primitives from established colors.
   - Atomic Design hierarchy (Atoms, Molecules, Organisms).
   - Global CSS variable single-knob cascade (Figma webhook parity).
   - Sprint Design System Immutability: future sprint features must strictly reuse existing Atoms and Molecules.
7. build-plan.md — phased feature list derived from real **User Stories**. Features build pure user flows (zero repetitive boilerplate loading states from foundation) and include **In-Phase API Setup Gates** and deterministic 3-step verification runbooks.
8. progress-tracker.md — phase/status table tied to the Definition of Done above, a Decisions Made During Build log, a Notes section.

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
