---
name: kickoff
description: Universal project kickoff, UX research discovery, and context generator across Tier 1 (Mini-Website), Tier 2 (Standard Solid), Tier 3 (Advanced SaaS), and Tier 4 (Intake/Redesign). Sets up AGENTS.md and compiles context/*.md with shadcn/Radix, single-knob CSS variables, and Sentry/Datadog observability.
---

# Workflow: kickoff (Universal Silicon Valley Kickoff & Context Engine)

Invoke with `/kickoff` (or `/devop-kickoff`) whenever starting a new website, web app, or software project.

**Goal**: Transform raw project ideas into an elite, production-grade engineering repository. Conducts mandatory User UX Research, eliminates AI guesswork, configures design tokens with single-knob cascading, locks in shadcn/ui and Radix UI atomic foundations, and compiles the exact human-readable `.md` context suite before any application code is generated.

---

## The Kickoff Invariants

1. **Zero Premature Code Generation**: Strictly forbidden from writing `src/`, routes, or components during Kickoff. The context files MUST be generated, reviewed, and locked in first.
2. **The Anti-Pill / Anti-Badge Law**: Strictly ban rounded badge pills and emoji chips (`[✨ OUR SERVICES]`). Headings must rely on pure typographic hierarchy.
3. **The Single-Knob Global CSS Cascade**: All theme colors must be declared as HSL/OKLCH CSS variables in `globals.css` mapped to `tailwind.config.ts`. Modifying a single variable in `globals.css` must cascade globally (Figma Tokens API / webhook updater parity).
4. **The Atomic UI Registry Lock**: Interactive elements must build on **shadcn/ui** and headless **Radix UI** primitives, classified as Atoms, Molecules, and Organisms in `context/ui-registry.md`.
5. **Observability Baseline**: Every production project must configure **Sentry** (exception tracking/Error Boundaries) and/or **LogRocket**, plus **Datadog** (APM/RUM) with strict PII scrubbing.
6. **The Interactive Visual Intake Law (Zero Unilateral Aesthetic Imposition)**: The agent MUST NOT skip Phase 3 visual discovery, rush to context generation, or impose un-discussed fonts, colors, and aesthetics upon the builder.
7. **Modern Stack Freshness, RAG Docs Verification & Auto-Update Invariant**: All tools, frameworks, and AI models must strictly be the latest stable versions. The agent MUST consult live documentation via RAG and MCP tools (e.g. `context7`) before locking dependencies. The architecture must include automated auto-update configurations (Dependabot/Renovate).
8. **Financial Scope Calibration & Tool Consolidation Invariant (Anti-Tool Sprawl)**: Must ask the builder about the financial/operational scope. Ban introducing 7–10 disjointed tools when 1 battle-tested platform achieves multiple purposes. Deliver a 2-Stage Evolution Roadmap (Launch vs Scale).
9. **Deterministic Google Stitch Protocol**: Generate a brief project visual overview before screen prompting. Strictly forbid font family names in Stitch prompts. Ground in concise layout zones with strict negative constraints.

---

## Step-by-Step Protocol

### Stage 1: Tier Calibration

When invoked, inspect the user's initial description or ask the Calibration Questions:
1. **What is being built?** (Product mission & target audience)
2. **What is the operational scope?**
3. **Calibrate the Tier**:

| Scope | Tier Selected | Action & Reference Suite Loaded |
|---|---|---|
| 2–3 page sites, portfolios, landing pages | **Tier 1: Mini-Website** | Load `references/tier-1-mini/` (Generates 4 Lean Context Files) |
| Standard full-stack CRUD apps, MVPs, dashboards | **Tier 2: Standard Solid** | Load `references/tier-2-solid/` (Generates Standard 8-File Suite) |
| Multi-tenant SaaS, fintech, enterprise, billing/auth | **Tier 3: Advanced SaaS** | Load `references/tier-3-advanced/` (Generates 11-File Production Suite + `.ai-memory`) |
| Unorganized AI code intake or live site redesign | **Tier 4: Intake & Redesign** | Switch to `/intake` or load `references/tier-4-redesign/` |

---

### Stage 2: The 4 Conversational Discovery Pillars (No Overwhelm, High Coverage)

Instead of tedious single-question interrogation loops or overwhelming technical walls, discovery is structured into **4 conversational pillars with helpful examples**, allowing the user to provide critical information they might not have thought of without feeling fatigued:

#### Pillar 1: Product Mission, Target Users & Real Problem
- *Core Purpose*: What commercial problem or operational bottleneck is being solved?
- *Target User*: Who is the primary user, what is their technical fluency (non-technical operator vs executive vs engineer), and what is their daily digital environment?
- *Narrative User Journey*: What is the ideal flow from landing on the product to the core "aha!" moment?

#### Pillar 2: Brand Identity & Visual Atmosphere (Always Inquire Upfront)
- *Existing Assets*: *"Do you have an existing brand identity, logo, or color scheme to provide/upload, or are we starting completely from scratch?"*
- *Atmosphere & Mood*: Crisp light mode, deep dark mode, or clean modern hybrid? Authoritative and corporate, energetic, or clinical and precise?
- *Typography Preferences*: Any required brand fonts, or should tailored non-generic pairings be proposed?

#### Pillar 3: People, Roles & Access Control (Plain-English Database & RLS from Day 1)
- *User Types*: Who interacts with this app? (e.g., Just customers? Team managers? Platform administrators?)
- *Permission Boundaries*: What can each person see or do? (e.g., *"Customers can only view and edit their own projects; Admins can review all projects, manage billing, and delete users."*)
- *Authentication Flow*: How do they sign in? (Email + password, Google one-click, magic links?)
- *Data Architecture*: What core records need to be saved, and where does data sovereignty reside? (Directly defines PostgreSQL tables and Row-Level Security [RLS] policies).

#### Pillar 4: Crucial Operations & Hidden Needs (Quietly Enforcing the 111-Item Production Safeguards)
- *Financial & Operational Scope*: Bootstrapped MVP ($0/month recurring SaaS burn using generous free tiers) vs Funded Startup / Enterprise (high-availability infrastructure from Day 1).
- *Payments & Subscriptions*: Are there paid tiers, one-time checkouts, or trials?
- *Transactional Communications*: Do users need automated welcome emails, password resets, or payment receipts?
- *File Storage & Uploads*: Will users upload images, PDFs, or files? Who has access to view/download them?
- *External APIs & Webhooks*: What third-party platforms must connect?
- *The Autonomous UX Secondary Research Engine (Runs Under the Hood)*:
  Drawing on public, verifiable data sources (Reddit, App Store reviews, G2/Trustpilot, Product Hunt, Google Trends), the agent synthesizes research-grade intelligence (Jakob's Law market patterns, 3-level JTBD, pain point hierarchy, verbatim human copy vault) quietly into `context/project-overview.md`.

---

### Stage 3: Tech Stack Decision & Tool Consolidation (Plain English Rationale)

Propose the production tech stack following these non-negotiable standards:

1. **Latest Stable Versions Only**:
   - Verify that all framework, library, runtime, and model versions are the latest stable releases (e.g. latest Next.js App Router, React 19 / latest, Tailwind CSS v4, cutting-edge frontier models including OpenAI Astra, latest OpenAI o-series/reasoning models, latest Gemini, and latest Claude). Query live documentation to verify exact active model strings.
2. **RAG & Docs Research Gate**:
   - Query live documentation using RAG and MCP tools (e.g., `context7` with `resolve-library-id` / `query-docs`, or web search) to verify API signatures, configuration schemas, and current best practices. Never guess from training memory.
3. **The Tool Consolidation Invariant (Anti-Tool Sprawl)**:
   - Ban tool sprawl! Do not suggest 8 separate niche tools when 1 battle-tested platform handles multiple needs:
     - Consolidate DB + Auth + File Storage + Realtime into unified platforms (e.g. Supabase or Convex) instead of splintering (Auth0 + Neon + S3 + Pusher).
     - Consolidate API and backend logic into modern full-stack frameworks (e.g., Next.js App Router Server Actions & Route Handlers) before introducing dedicated server tiers.
4. **The Two-Stage Evolution Roadmap**:
   - **Stage 1 (Launch / MVP)**: Cost-effective, consolidated, production-grade foundation aligned with the builder's financial scope.
   - **Stage 2 (Scale Migration)**: Clearly defined roadmap for decoupling compute, introducing dedicated caching (Redis), read replicas, and microservices when active traffic surges.
5. **Plain English & Silicon Valley Reality**:
   - Present 2–3 alternatives in plain English with transparent trade-offs, explaining how top Silicon Valley engineering teams run them in real production.
   - Deliver a clear, authoritative recommendation capable of handling the most complex demands of the product.
6. **Evergreen Auto-Update Infrastructure**:
   - Include automated dependency management (Dependabot / Renovate), lockfile integrity, and CI audit scans in the architecture plan.
7. **Wait for Builder Approval**:
   - Present the stack rationale and wait for the builder to confirm (*"Stack Approved"*) before proceeding to the visual stage.

---

### Stage 4: Interactive Visual Intake & Brand Exploration (MANDATORY STOP GATE — ZERO SHORTCUTS)

> [!IMPORTANT]
> The agent MUST NOT guess, assume, or unilaterally impose visual styles, color palettes, or fonts. The entire process must be followed sequentially as if manual copy-and-paste prompts were used.

The agent MUST stop and ask the builder the **Visual Intake Inquiries**:

1. **Existing Brand Assets**:
   > *"Do you have an existing brand identity, logo, or color scheme to provide/upload, or are we starting completely from scratch?"*
2. **Color Palette & Atmosphere**:
   > *"What are your color preferences? (Primary brand accent color, background mood: deep dark mode, crisp light, or hybrid, and emotional temperature: authoritative, energetic, clinical, luxurious)?"*
3. **Typography & Font Preferences**:
   > *"Do you have specific font preferences, or should I propose tailored, high-character typographic pairings?"*

#### When the Builder Provides Brand Assets / Colors:
- Honor and lock the builder's hex codes, logo files, and font choices directly into `context/design.md` and `context/ui-tokens.md`.

#### When the Builder is Starting Fresh with No Existing Brand:
- Propose **3 distinct, curated visual directions** grounded in the product's domain.
- **Design Vault Spatial Grounding (Stealth Persona Invariant)**:
  - The agent silently draws on the spatial layouts and architectural tension in the Master Design Vault (located at `C:\Users\user\Desktop\My DevOp Tools\design-vault\` or local `design-vault/`, including archetypes `ARCH-01` through `ARCH-06`, Figma templates, and high-converting patterns).
  - **THE STEALTH RULE (Zero Internal File Leakage)**: The agent MUST NOT break character or mechanically state *"I am referencing design-vault/archetypes/..."* or cite internal `.md` filenames. Instead, articulate the proposal with the effortless authority of an elite Creative Director: speak about mathematical proportions, 8/4 asymmetric column splits, negative space tension, and signature moments as native design mastery.
- **Anti-Generic Typography Floor**: Strictly avoid default, generic pairings (e.g. `Inter + Roboto`, `Arial`). Propose distinctive, elite pairings:
  - Direction A (Modern Tech / Architectural): e.g. **Syne** (Headings) + **Plus Jakarta Sans** (Body) + **JetBrains Mono** (Metrics)
  - Direction B (High-Authority / Executive Editorial): e.g. **Instrument Serif** (Display) + **Inter** (Body) + **Geist Mono** (Utility)
  - Direction C (Dynamic / High-Energy SaaS): e.g. **Clash Display** or **Cabinet Grotesk** (Headings) + **Satoshi** or **General Sans** (Body)
- Explain the psychological rationale of each direction and let the builder select or customize.
- **Confirm Selection**: Wait for the builder's confirmation before locking `design.md` or moving to Stitch prompts.

---

### Stage 5: Google Stitch UI Pipeline (Product Designer Mode)

Once the visual direction and color palette are locked, prepare visual mockups using the calibrated Google Stitch protocol:

#### 1. Mandatory Screen Inventory Mapping
Map every screen required across the user journey based on user stories:
- `SCR-01`: Landing / Public Front Door
- `SCR-02`: Authentication & Onboarding (Sign-In / Sign-Up)
- `SCR-03`: Primary User Dashboard / Main Overview
- `SCR-04`: Core Interactive Workspace / Task Detail Screen
- `SCR-05`: Account, Team & Billing Settings

#### 2. Full-Fidelity Google Stitch Prompts (For All Screens)
Generate ready-to-paste prompts for **all** core screens using the 5-part formula (calibrated with spatial grid geometry from `design-vault/`):
1. **Viewport & Framing Lock**: `Flat 2D desktop application screenshot, 16:9 widescreen, 1920x1080 resolution, direct front-facing view, NO 3D perspective tilt, NO laptop mockup frame, NO claymockups.`
2. **Spatial Zone Architecture**: Explicit pixel/percentage layout divisions (e.g. `Zone 1: Left 280px navigation rail. Zone 2: Center main workspace. Zone 3: Right 360px inspector sidebar.`).
3. **Named Element Inventory**: Enumerate exact cards, buttons, inputs, form labels, and headings down to granular details.
4. **Locked Palette**: Specify exact hex codes from `design.md`.
5. **No Font Names**: Describe typographic style and hierarchy (e.g. *"clean geometric sans-serif headings, high-legibility interface typography, crisp tabular metrics"*). **DO NOT** name specific font families like Syne or Inter in the prompt, letting Google Stitch render typography naturally without diffusion distortion.
6. **Strict Negative Constraints**: `STRICT NEGATIVE CONSTRAINTS: NO analytics charts, NO line graphs, NO bar charts, NO floating decorative bubbles, NO colorful gradients, NO mobile frames, clean minimalist professional interface only.`

#### 3. The HTML Screen Vault (`context/screens/`)
- Save generated HTML screens (or screenshots) directly into `context/screens/<screen-name>.html` (e.g. `context/screens/scr-01-landing.html`, `context/screens/scr-03-dashboard.html`).
- During sprint phases, the agent directly reads and inspects each HTML file to replicate layout, spacing, and micro-copy with 1:1 visual fidelity.

---

### Stage 6: Information Architecture & UX Wireframe Specifications

Draft the structural backbone:
- **Hierarchical Sitemap**: Primary, Secondary, and Utility navigation.
- **User Journey Maps**: Step-by-step emotional and functional stages from arrival to conversion.
- **Section-by-Section Wireframe Specifications**:
  - For every section on every page: `Position`, `Purpose`, `Layout`, `Visual Weight`, `Element Inventory`, `Interaction Notes`, and `Mobile Collapse Behavior (375px)`.
- **Friction Audit & Micro-Copy Requirements**: Real CTA button copy, form labels, and error messages (zero placeholder text).

---

### Stage 7: Instant Batched Context Generation & Repo Lock-In

All context files are generated in a **single comprehensive pass**, completely eliminating multi-turn approval bottlenecks while maintaining 100% technical depth:

Read the schema definitions from the selected Tier's context generation framework:
- For Tier 1: `references/tier-1-mini/mini-context-framework.md`
- For Tier 2: `references/tier-2-solid/solid-context-file-generation-framework-2.md`
- For Tier 3: `references/tier-3-advanced/advanced-context-framework.md`

#### Files Generated (All-at-Once Pass):
1. **Governing Rulebooks & Native IDE Discovery Shims**:
   - Create `.agents/` directory in the project root: `.agents/rules/AGENTS.md` and `.agents/skills/`.
   - Stamp canonical `AGENTS.md` in the project root.
   - Stamp native multi-IDE discovery shims in project root so NO agent ignores the rules regardless of which IDE is used:
     - `CLAUDE.md` (Native for Claude Code: imports `@AGENTS.md` + pre-flight citation rule).
     - `.cursorrules` (Native for Cursor: forces Cursor to load `AGENTS.md` into prompt context).
     - `.windsurfrules` (Native for Windsurf).
     - `GEMINI.md` (Native for Antigravity IDE).
2. **Write Context Files into `context/`**:
   - `context/project-overview.md` (or `site-overview.md`): PRD, User Personas, Synthesized UX Research (JTBD, Pain Points, Verbatim Copy Quotes, Demographic & Tech Literacy Audit, Jakob's Law Market Patterns).
   - `context/architecture.md`: System topology, DB schemas with Row Level Security (RLS) policies, Sentry/Datadog observability, Evergreen auto-update configuration, 2-Stage Evolution Roadmap.
   - `context/design.md`: Approved visual direction, locked color tokens, non-generic typography hierarchy with **Strict Monospace Quarantine**, and Google Stitch prompt registry.
   - `context/ui-tokens.md`: CSS variables bound to `globals.css` (Single-knob cascade, `--font-sans` bound to all UI tokens).
   - `context/ui-rules.md`: Atomic composition rules, forms, dialogs, Wireframe Element Hierarchy, Anti-Pill Law, plain-English copy contracts.
   - `context/ui-registry.md`: Living component catalog classified by `[ATOM]`, `[MOLECULE]`, `[ORGANISM]` initialized with shadcn/Radix primitives.
   - `context/code-standards.md`: Zero-trust BOLA/IDOR checks, Zod validation schemas, PII scrubbing.
   - `context/library-docs.md`: Live documentation excerpts verified via RAG/MCP.
   - `context/build-plan.md` (or `page-specs.md`): Structured into the **Complete 6-Phase Production Lifecycle**:
     - *Phase 1: Discovery & Architecture Specs*
     - *Phase 2: Upfront Foundation (The Shell)* — dependencies, packages, `globals.css` tokens, master App Shell (Navbar, Layout, Footer, root Error Boundary), DB tables with RLS policies, and global loading skeletons. **Enforce Dev Quarantine**: all verification harnesses (token swatches, component matrices) must be quarantined to `app/(dev)/_workbench/...` or test suites—strictly forbidden from entering `HeaderNav` or the public landing page.
     - *Phase 3: Methodical Layered Sprints (Pure User Stories & Working Software)* — vertical slices built along the user journey (UI + working state handlers + live seed data + 5 screen states) with mandatory Stop & Test Gate after each feature. **Zero repetitive plumbing**: do not repeat foundation loading states or boilerplates. Inspect `context/screens/*.html` for 1:1 visual fidelity. Includes **In-Phase API Setup Gates** (pause to request external keys so features work live immediately).
     - *Phase 4: Production Hardening & Security Audit* — CWV (LCP < 2.5s), zero-trust sweep, `.env.production`.
     - *Phase 5: Brand Launch & Live Cutover* — `npm run build` verification, DNS/domain, SSL, OpenGraph cards.
     - *Phase 6: Formal Handover, Vault & Post-Launch Ops* — GitHub transfer, 1Password vault, Loom admin guide, Sentry live telemetry, 30-day warranty log.
   - `context/progress-tracker.md` (or `build-checklist.md`): Milestone status checklist tied to all 6 phases and Decisions Log.

---

### Stage 8: Approval & Handover to Build Gate (`/architect`)

Present a crisp summary of the locked context suite to the developer:
```markdown
### 🚀 Project Kickoff Complete: [Project Name] (Tier [1/2/3])
- **AGENTS Rulebook**: Locked in project root
- **Financial Scope**: Calibrated (Consolidated Stack, 2-Stage Roadmap)
- **Tech Stack**: RAG-verified latest versions locked in context/architecture.md
- **Visual Direction**: Approved palette & non-generic typography locked in context/design.md
- **Google Stitch Mockups**: Seeded in context/designs/
- **Information Architecture**: Complete sitemap & section wireframes in context/build-plan.md
- **Design Tokens**: Configured in globals.css (Single-knob CSS cascade verified)
- **UI Registry**: Initialized with Atomic shadcn/Radix primitives
- **Observability**: Sentry Error Boundaries & Datadog APM defined
- **Build Plan**: Milestone 1 ready for execution

Confirm with "Approved" to proceed to Milestone 1 under /architect.
```

Wait for human confirmation before writing application code.
