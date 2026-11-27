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

### Stage 2: The 4 Conversational Discovery Pillars (One Pillar at a Time)

> [!IMPORTANT]
> **MANDATORY SEQUENTIAL INTERVIEW: PRESENT ONE PILLAR AT A TIME (ANTI-OVERWHELM GATE)**
> - **NEVER dump all 4 pillars or a wall of questions in a single response.** Presenting all questions at once causes cognitive overload and decision fatigue for the builder.
> - **Strict 1-Pillar-Per-Turn Rule**:
>   1. Output questions for **Pillar 1 ONLY**, then **STOP COLD** and wait for the builder to answer.
>   2. Once Pillar 1 is answered, acknowledge it and output **Pillar 2 ONLY** (along with the color palette combo and UI component preview), then **STOP COLD** and wait for visual confirmation.
>   3. Once Pillar 2 is confirmed, output **Pillar 3 ONLY**, then **STOP COLD** and wait for the builder's answer.
>   4. Once Pillar 3 is answered, output **Pillar 4 ONLY** (Crucial Operations & Legal Compliance), then **STOP COLD** and wait for the builder's answer.
>   5. Only after all 4 pillars are answered one-by-one, proceed to **Stage 3: Tech Stack Selection & Plain-English Rationale**.

> [!IMPORTANT]
> **The Plain-English Regulatory & Decision Question Invariant**:
> When asking questions to make architectural, security, or legal decisions, **NEVER** overwhelm the builder with raw statutory section numbers or legal jargon (e.g. *never ask: "Do you comply with NDPA Section 44 and CAMA Section 304?"*).
> Always use the **3-Part Decision Formula**:
> 1. **The Plain-English Question** (simple everyday words).
> 2. **Clear Options or Examples**.
> 3. **(Why it matters)**: A friendly 1-sentence explanation of what the agent will quietly set up behind the scenes to keep them compliant and protected.

Instead of tedious single-question interrogation loops or technical walls, discovery is structured into **4 conversational pillars presented strictly one at a time**:

#### Pillar 1: Product Mission, Target Users, User Journey & Feature Wishlist
- *Core Purpose*: What commercial problem or operational bottleneck is being solved?
- *Target User*: Who is the primary paying user, what is their technical fluency (non-technical operator vs executive vs engineer), and what is their daily digital environment?
- *Narrative User Journey*: Ask the builder: *"Can you describe the ideal user journey—how should someone actually use or navigate the website/app from the moment they land to achieving their main goal?"*
- *Specific Features in Mind*: Ask the builder: *"Are there any specific features, tools, or pages you already have in mind that the app or website should definitely include?"*

#### Pillar 2: Brand Identity & Visual Atmosphere (Always Inquire Upfront)
- *Existing Assets*: *"Do you have an existing brand identity, logo, or color scheme to provide/upload, or are we starting completely from scratch?"*
- *Atmosphere & Mood*: Crisp light mode, deep dark mode, or clean modern hybrid? Authoritative and corporate, energetic, or clinical and precise?
- *Typography Preferences*: Any required brand fonts, or should tailored non-generic pairings be proposed?

#### Pillar 3: People, Roles & Access Control (Plain-English Database & Account Security)
- **User Roles**: *"Who will log into this app? (e.g., Just customers? Team managers? Platform administrators?)"*
  *(Why it matters: This defines database permissions so team members only see what they are authorized to see).*
- **Sign-In Method**: *"How should users sign in? (e.g., Email + password, Google one-click, or biometric Passkeys/FaceID for admins?)"*
  *(Why it matters: We will set up modern, phishing-resistant authentication and protect user sessions so passwords can't be easily stolen).*
- **Data Boundaries**: *"What can each person see or do? (e.g., 'Customers only see their own projects; Admins can review all projects and manage billing')?"*
  *(Why it matters: We configure Row-Level Security in the database from Day 1 to prevent unauthorized data leaks).*

#### Pillar 4: Crucial Operations, Privacy & Statutory Legal Safeguards (Demystifying Compliance)
Ask these clear, everyday questions to quietly activate the correct statutory protections across the build:
1. **Target Customer Locations**:
   - *"Where are your customers or users located? (e.g., Nigeria/Africa, the UK/Europe, the US, or Global?)"*
   - *(Why it matters: This automatically activates the correct statutory protections—such as NDPC rules in Nigeria, GDPR in Europe, or CCPA in California—ensuring the site is legally compliant and immune to regulatory fines).*
2. **Cookies & Visitor Tracking**:
   - *"Will you use marketing or analytics tools (like Google Analytics, Facebook/Meta Pixel, or ad tracking) to track visitors?"*
   - *(Why it matters: If yes, privacy laws require us to generate a clean Cookie Banner with equal-weight 'Accept' and 'Reject' buttons that block tracking scripts until the user clicks Accept).*
3. **Payments, Pricing & Refunds**:
   - *"Will you accept payments, subscriptions, or digital checkouts on the website?"*
   - *(Why it matters: Consumer protection laws like the FCCPC require checkout totals to strictly match displayed prices, generate itemized receipts, and publish a fair cancellation/refund policy—banning void 'No Refund' clauses).*
4. **Registered Business Details (Legal Imprint)**:
   - *"Is this website for a legally registered company? If yes, what is your registered business name and registration number (e.g. CAC RC Number in Nigeria)?"*
   - *(Why it matters: Corporate law, such as Nigeria's CAMA regulations, mandates displaying the company's registered name, RC number, and official address in the website footer and on digital receipts).*
5. **AI Features & Customer Data**:
   - *"Will your app use customer questions, files, or interactions to train or improve AI models?"*
   - *(Why it matters: Data protection laws mandate giving users a clear toggle in settings to opt out of AI training, and we ensure third-party AI APIs keep your customer data 100% confidential).*
6. **Account Deletion & Data Export**:
   - *"Will users create accounts that hold their personal information?"*
   - *(Why it matters: Privacy regulations require giving users a simple self-serve button in settings to download their data or delete their account permanently).*
7. **Operational Scope & Free Tiers**:
   - *"Is this a lean MVP targeting $0/month free tiers, or a funded scale infrastructure from Day 1?"*
   - *(Why it matters: This determines whether we use generous serverless free tiers like Supabase and Cloudflare or provision dedicated enterprise clusters).*
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

### Stage 4: Interactive Visual Intake, Reference Synthesis & Live In-Chat UI Preview (MANDATORY STOP GATE)

> [!IMPORTANT]
> The agent MUST NOT guess, assume, or unilaterally impose visual styles, color palettes, or fonts. When the builder provides references, they MUST be used as conceptual inspiration while the system synthesizes a bespoke, non-generic design. The agent MUST generate the actual color combo and visual UI preview directly in the kickoff chat for the builder to see.

The agent MUST stop and ask the builder the **Visual Intake Inquiries**:

1. **Existing Brand Assets & Visual References**:
   > *"Do you have existing brand assets (logo, colors), or visual references (competitor links, moodboards, screenshots, Dribbble comps) to use as inspiration, or are we starting completely from scratch?"*
2. **Color Palette & Atmosphere**:
   > *"What are your color preferences? (Primary brand accent, background mood: deep dark mode, crisp light, or hybrid, and emotional temperature: authoritative, energetic, clinical, luxurious)?"*
3. **Typography & Font Preferences**:
   > *"Do you have specific font preferences, or should I propose tailored, high-character typographic pairings?"*

#### When the Builder Supplies Visual References:
- **Reference-to-Concept Synthesis (Zero Clones, Zero Generic Slop)**:
  - Treat references strictly as **conceptual inspiration**, never for literal cloning.
  - Extract abstract design qualities: layout rhythm (dense vs sparse, asymmetric vs modular), typographic character, color temperature, and atmospheric gravity.
  - Cross-reference with the **Master Design Vault** (`design-vault/`, archetypes `ARCH-01` through `ARCH-06`, high-converting patterns) to synthesize a **completely unique, bespoke design concept** for the builder's specific product domain. Ban generic AI defaults (no generic cream/terracotta buttons, no repetitive 3-card grids, no pill badges).

#### When the Builder Supplies Locked Brand Assets / Colors:
- Honor and lock the builder's hex codes, logo files, and font choices directly into `context/design.md` and `context/ui-tokens.md`.

#### When the Builder is Starting Fresh with No Existing Brand:
- Propose **3 distinct, curated visual directions** grounded in the product's domain using the stealth design vault archetypes and anti-generic typography floor (e.g. Syne + Plus Jakarta Sans, Instrument Serif + Inter, Clash Display + Satoshi).

#### Mandatory Live In-Chat Color Combo & UI Preview Generator:
Right in the kickoff chat, the agent MUST render the **Live Color Palette & Visual UI Preview** so the builder can see the tangible design before approving:
1. **The Live Color Palette & Contrast Matrix**:
   - Canvas Background (`--background`), Elevated Card (`--card`), Primary Brand Accent (`--primary`), Sub-Accent (`--secondary`), Border (`--border`), High-Contrast Text (`--foreground`). Every pairing verified for WCAG 2.1 AA contrast (≥4.5:1).
2. **The In-Chat Rendered UI Component Mockup**:
   - Render a live visual component block directly in the chat conversation (using Generative UI `<agent-embed>` HTML widget in Antigravity IDE and high-fidelity markdown visual swatch cards across all IDEs):
     - An elevated preview card with clean typography hierarchy.
     - Live Primary Action Button and Secondary Ghost Button in proposed brand colors.
     - Form input / badge with semantic border and focus states.
- **Confirm Selection**: Wait for the builder's explicit visual approval (*"Color and UI Approved"*) before locking `design.md` or moving to screen prompts.

---

### Stage 5: Google Stitch UI Pipeline (Product Designer Mode & 111-System Screen Mapping)

Once the visual direction and color palette are locked, prepare visual mockups using the calibrated Google Stitch protocol:

#### 1. Comprehensive 111-Core System Screen Inventory Mapping
A production-grade application requires complete screen coverage across the entire system. Derived from the **111 Core Systems, Architecture & DevOps Concepts**, map out every required screen:
- `SCR-01: Public Front Door & Conversion` (Landing Page, Value Proposition, Pricing & Comparison, FAQ)
- `SCR-02: Identity, Auth & Access Security` (Sign-In, Sign-Up, MFA/2FA Verification, Password Reset, Magic Link — *Concepts 68–73*)
- `SCR-03: Workspace Onboarding & Team Setup` (Workspace Setup, Role-Based Access Invitation, Initial Data Ingestion)
- `SCR-04: Primary Product Workspace Dashboard` (Live Telemetry Stream, Core Interactive Workspace / Studio / Canvas, Metric Cards — *Concepts 1–19, 22–24*)
- `SCR-05: Entity Management & Detail Inspector` (Searchable/Filterable Paginated Data View, Entity Detail / Edit View, Purposeful Empty States — *Concepts 25–27, 36–37*)
- `SCR-06: Administrative Governance & Audit Console` (User Management, RLS Role Switching, Permissions Matrix, Audit Trail & Activity Logs — *Concepts 68, 81–82*)
- `SCR-07: Billing, Quotas & Invoicing` (Stripe Customer Portal, Subscription Tier Management, Quota Alerts & Usage Metering — *Concept 88*)
- `SCR-08: Platform, Secrets & Webhook Settings` (API Keys Vault, Webhook Configuration & Dispatcher, Rate-Limit Analytics — *Concepts 67, 101–103*)
- `SCR-09: System Resilience & Error Boundaries` (Global 500 Error Recovery Boundary, 404 Not Found, 429 Rate-Limit Throttled Page with exponential backoff timer, Offline Sync Fallback — *Concepts 10–13, 55, 83–85, 109–111*)
- `SCR-10: Trust, Privacy & Legal Hub` (Privacy Policy, Terms of Service, Cookie Preference Center with granular opt-in & equal-weight Reject All, Data Subject Rights [DSAR] Account Deletion / Data Export page, and Accessibility Statement — *Concepts 68, 71, 74, 111*)

#### 2. Full-Fidelity Google Stitch Prompts (For All Mapped Screens)
Generate ready-to-paste prompts for **all** core screens using the 5-part formula (calibrated with spatial grid geometry from `design-vault/`):
1. **Viewport & Framing Lock**: `Flat 2D desktop application screenshot, 16:9 widescreen, 1920x1080 resolution, direct front-facing view, NO 3D perspective tilt, NO laptop mockup frame, NO claymockups.`
2. **Spatial Zone Architecture**: Explicit pixel/percentage layout divisions (e.g. `Zone 1: Left 280px navigation rail. Zone 2: Center main workspace. Zone 3: Right 360px inspector sidebar.`).
3. **Named Element Inventory**: Enumerate exact cards, buttons, inputs, form labels, and headings down to granular details.
4. **Locked Palette**: Specify exact hex codes from `design.md`.
5. **No Font Names**: Describe typographic style and hierarchy (e.g. *"clean geometric sans-serif headings, high-legibility interface typography, crisp tabular metrics"*). **DO NOT** name specific font families like Syne or Inter in the prompt, letting Google Stitch render typography naturally without diffusion distortion.
6. **Strict Negative Constraints**: `STRICT NEGATIVE CONSTRAINTS: NO analytics charts, NO line graphs, NO bar charts, NO floating decorative bubbles, NO colorful gradients, NO mobile frames, clean minimalist professional interface only.`

#### 3. The HTML Screen Vault (`context/screens/`)
- Save generated HTML screens (or screenshots) directly into `context/screens/<screen-name>.html` (e.g. `context/screens/scr-01-landing.html`, `context/screens/scr-04-workspace.html`).
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
