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

### Stage 2: Intake, Financial Scope & Autonomous UX Secondary Research Engine

Execute discovery sequentially:

#### 1. Phase 0 & Phase 1 Intake & Financial Scope Inquiry
- Transform raw human intent (brief, voice note transcript, screenshots) into structured discovery.
- **Financial & Operational Scope Inquiry**:
  Ask the builder:
  > *"What is the financial and operational scope of this project?*  
  > *A) Bootstrapped MVP / Lean Startup (target near-$0/month recurring SaaS burn using generous free tiers and consolidated BaaS, without compromising production quality)*  
  > *B) Funded Startup / Enterprise Client (ready to invest in premium infrastructure from Day 1 for maximum high-availability and reliability)"*
- **Strict Assumption Flagging**: Do not invent missing facts. Flag every unverified assumption and open question explicitly.

#### 2. The Autonomous UX Secondary Research Engine (Runs Under the Hood)
Drawing on public, verifiable data sources (Reddit discussions, App Store / Google Play reviews, G2/Trustpilot feedback, Product Hunt launches, Quora/Stack Exchange threads, Google Trends, industry analyst reports), the agent autonomously synthesizes research-grade intelligence:
1. **User Intelligence**: Demographics, seniority, device profiles, psychographics, online communities.
2. **Jobs-To-Be-Done (JTBD) Matrix**: Minimum 5–7 distinct jobs categorized across Functional, Emotional, and Social levels.
3. **Pain Points & Frustrations Hierarchy**: Minimum 8 real-world pain points categorized by severity with **Verbatim User Language** from public forums.
4. **Existing Mental Models & Conventions**: Established user expectations vs product reality.
5. **Competitive Landscape & Whitespace Mapping**: Tier 1 (Direct), Tier 2 (Indirect), Tier 3 (Category Alternatives) with positioning whitespace.
6. **Search & Language Intelligence (Human Copywriting Vault)**: High-intent queries and verbatim words users use to describe problems and ideal solutions. Fuels all headlines, eliminating hollow AI buzzwords.
7. **Strategic Priorities**: Opportunity areas, hypothesis statements, and "How Might We" (HMW) design sprint statements.

---

### Stage 3: Tech Stack Decision & Tool Consolidation (RAG-Verified & Latest Versions)

Propose the production tech stack following these non-negotiable standards:

1. **Latest Stable Versions Only**:
   - Verify that all framework, library, runtime, and model versions are the latest stable releases (e.g. Next.js 15 App Router, React 19, Tailwind CSS v4 / v3.4, current Claude 3.7 / Gemini 2.5 / OpenAI o3-mini models).
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

### Stage 5: Google Stitch Visual Mockup Generation

Once the visual direction and color palette are locked, prepare visual mockups using the calibrated Google Stitch protocol:

#### 1. Mandatory Pre-Prompt Brief Overview
Before writing the first page prompt, output a concise **Project Visual Overview**:
- Product mission and core user persona
- Locked color tokens (Surface, Elevated Card, Primary CTA, Accent, Text)
- Visual atmosphere, spatial zoning, and density rules (minimalist, high-converting, professional)

#### 2. Deterministic Google Stitch Prompt (First Core Screen Only)
Generate the ready-to-paste prompt for the **first foundational screen only** using the 5-part formula (calibrated with the spatial grid geometry from `design-vault/`):
1. **Viewport & Framing Lock**: `Flat 2D desktop application screenshot, 16:9 widescreen, 1920x1080 resolution, direct front-facing view, NO 3D perspective tilt, NO laptop mockup frame, NO claymockups.`
2. **Spatial Zone Architecture**: Explicit pixel/percentage layout divisions (e.g. `Zone 1: Left 280px navigation rail. Zone 2: Center main workspace. Zone 3: Right 360px inspector sidebar.`).
3. **Named Element Inventory**: Enumerate exact cards, buttons, inputs, and headings.
4. **Locked Palette**: Specify exact hex codes from `design.md`.
5. **No Font Names**: Describe typographic style and hierarchy (e.g. *"clean geometric sans-serif headings, high-legibility interface typography, crisp tabular metrics"*). **DO NOT** name specific font families like Syne or Inter in the prompt, letting Google Stitch render typography naturally without diffusion distortion.
6. **Strict Negative Constraints**: `STRICT NEGATIVE CONSTRAINTS: NO analytics charts, NO line graphs, NO bar charts, NO floating decorative bubbles, NO colorful gradients, NO mobile frames, clean minimalist professional interface only.`

Provide this prompt to the builder, allow them to run it in Google Stitch, and await confirmation or adjustments before generating subsequent core screen prompts.

---

### Stage 6: Information Architecture & UX Wireframe Specifications

Draft the structural backbone:
- **Hierarchical Sitemap**: Primary, Secondary, and Utility navigation.
- **User Journey Maps**: Step-by-step emotional and functional stages from arrival to conversion.
- **Section-by-Section Wireframe Specifications**:
  - For every section on every page: `Position`, `Purpose`, `Layout`, `Visual Weight`, `Element Inventory`, `Interaction Notes`, and `Mobile Collapse Behavior (375px)`.
- **Friction Audit & Micro-Copy Requirements**: Real CTA button copy, form labels, and error messages (zero placeholder text).

---

### Stage 7: Context Suite Generation & Repo Lock-In

Read the schema definitions from the selected Tier's context generation framework:
- For Tier 1: `references/tier-1-mini/mini-context-framework.md`
- For Tier 2: `references/tier-2-solid/solid-context-file-generation-framework-2.md`
- For Tier 3: `references/tier-3-advanced/advanced-context-framework.md`

#### Files Generated:
1. **Governing Rulebook**: Stamp `AGENTS.md` in the project root.
2. **Write Context Files into `context/`**:
   - `context/project-overview.md` (or `site-overview.md`): PRD, User Personas, Synthesized UX Research (JTBD, Pain Points, Verbatim Copy Quotes).
   - `context/architecture.md`: System topology, DB schemas, Sentry/Datadog observability, Evergreen auto-update configuration, 2-Stage Evolution Roadmap.
   - `context/design.md`: Approved visual direction, locked color tokens, and non-generic typography hierarchy.
   - `context/ui-tokens.md`: CSS variables bound to `globals.css` (Single-knob cascade).
   - `context/ui-rules.md`: Atomic composition rules, forms, dialogs, Wireframe Element Hierarchy, Anti-Pill Law.
   - `context/ui-registry.md`: Living component catalog classified by `[ATOM]`, `[MOLECULE]`, `[ORGANISM]` initialized with shadcn/Radix primitives.
   - `context/code-standards.md`: Zero-trust BOLA/IDOR checks, Zod validation schemas, PII scrubbing.
   - `context/library-docs.md`: Live documentation excerpts verified via RAG/MCP.
   - `context/build-plan.md` (or `page-specs.md`): Information architecture, sequenced feature milestones with 5 UI states per screen.
   - `context/progress-tracker.md` (or `build-checklist.md`): Milestone status checklist and Decisions Log.

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
