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

---

## Step-by-Step Protocol

### Stage 1: Tier Calibration

When invoked, inspect the user's initial description or ask the 3 Calibration Questions:
1. **What is being built?** (Product mission & audience)
2. **What is the operational scope?**
3. **Calibrate the Tier**:

| Scope | Tier Selected | Action & Reference Suite Loaded |
|---|---|---|
| 2–3 page sites, portfolios, landing pages | **Tier 1: Mini-Website** | Load `references/tier-1-mini/` (Generates 4 Lean Context Files) |
| Standard full-stack CRUD apps, MVPs, dashboards | **Tier 2: Standard Solid** | Load `references/tier-2-solid/` (Generates Standard 8-File Suite) |
| Multi-tenant SaaS, fintech, enterprise, billing/auth | **Tier 3: Advanced SaaS** | Load `references/tier-3-advanced/` (Generates 11-File Production Suite + `.ai-memory`) |
| Unorganized AI code intake or live site redesign | **Tier 4: Intake & Redesign** | Switch to `/intake` or load `references/tier-4-redesign/` |

---

### Stage 2: Discovery & Autonomous UX Secondary Research Engine (Under the Hood)

Execute the intake and discovery from the selected Tier's kickoff prompt:
- For Tier 1: Follow `references/tier-1-mini/mini-kickoff-prompt.md`
- For Tier 2: Follow `references/tier-2-solid/project-kickoff-prompt.md`
- For Tier 3: Follow `references/tier-3-advanced/advanced-kickoff-prompt.md`

#### 1. Phase 0 & Phase 1 Discovery & Assumption Flagging
- Transform raw human intent (brief, voice note, screenshots) into structured discovery.
- **Strict Assumption Flagging**: Do not invent missing facts. Flag every unverified assumption and open question explicitly before proceeding to context lock-in.

#### 2. The Autonomous UX Secondary Research Engine (Runs Under the Hood)
Drawing on public, verifiable data sources (Reddit discussions, App Store / Google Play reviews, G2/Trustpilot feedback, Product Hunt launches, Quora/Stack Exchange threads, Google Trends, industry analyst reports), the agent autonomously synthesizes research-grade intelligence directly into the context suite:
1. **User Intelligence**:
   - Demographics & seniority range, device usage profiles.
   - Psychographics: Core motivations, self-perception, trusted publications and online communities (subreddits, Slack groups, Discord servers).
   - Digital Behavior: Discovery channels, decision cycle length, and conversion prerequisites.
2. **Jobs-To-Be-Done (JTBD) Matrix**:
   - Format: *"When [SITUATION], I want to [MOTIVATION], so I can [EXPECTED OUTCOME]."*
   - Minimum 5–7 distinct jobs categorized across **Functional**, **Emotional**, and **Social** levels with **Critical / High / Supporting** importance ratings.
3. **Pain Points & Frustrations Hierarchy**:
   - Minimum 8 real-world pain points categorized by Severity (Critical/High/Medium/Low).
   - Documents root cause, current manual workaround, and **Verbatim User Language** (direct quotes from public forums).
4. **Existing Mental Models & Conventions**:
   - Conventions users already expect from prior category experiences (navigation patterns, pricing structures, terminology).
   - Conflicts between user assumptions and what this product actually offers.
5. **Competitive Landscape & Whitespace Mapping**:
   - Tier 1 (Direct), Tier 2 (Indirect), Tier 3 (Category Alternatives).
   - Competitive UX Benchmarking: Hero 5-second clarity, trust signals, conversion friction, and competitor UX gaps.
   - Positioning Opportunity: Identifying crowded table-stakes vs defensible whitespace.
6. **Search & Language Intelligence (Human Copywriting Vault)**:
   - High-intent search queries and category content gaps.
   - **Language Intelligence Repository**: Verbatim words users use to describe the problem, the ideal solution, competitor recommendations, and competitor complaints. This repository fuels all headlines, CTA labels, and value proposition copy, eliminating hollow AI buzzwords.
7. **Insight Synthesis & Strategic Priorities**:
   - Key Research Insights (Observation, Inference, Implication, Tension, Confidence level).
   - Opportunity Areas & Hypothesis Statements (*"We believe that [decision] for [user] will result in [outcome] because [research]..."*).
   - 8–10 "How Might We" (HMW) design sprint statements.
   - Defensible Positioning Statement, Hero Value Proposition, Trust content requirements, top 5 Objection-handling sections, and Critical/High/Supporting UX priorities.

---

### Stage 3: Context Suite Generation & Repo Lock-In

Read the schema definitions from the selected Tier's context generation framework:
- For Tier 1: `references/tier-1-mini/mini-context-framework.md`
- For Tier 2: `references/tier-2-solid/solid-context-file-generation-framework-2.md`
- For Tier 3: `references/tier-3-advanced/advanced-context-framework.md`

#### Files Generated:

1. **Copy the Governing Rulebook into Project Root as `AGENTS.md`**:
   - Tier 1: Copy `references/tier-1-mini/mini-AGENTS.md`
   - Tier 2: Copy `references/tier-2-solid/AGENTS.md`
   - Tier 3: Copy `references/tier-3-advanced/advanced-AGENTS.md`
2. **Write the Context Suite into `context/` (or project root for Tier 1)**:
   - `context/project-overview.md` (or `site-overview.md`): Product mission, in/out of scope boundaries, full Synthesized UX Research Intelligence (User demographics/psychographics, JTBD Matrix, Pain Point Hierarchy, Language Intelligence Vault, Competitive Whitespace).
   - `context/architecture.md`: System topology, database schemas, Sentry/Datadog observability architecture, and system invariants.
   - `context/ui-tokens.md` (or `design-tokens.md`): HSL/OKLCH CSS variables bound to `globals.css` and `tailwind.config.ts`, 8px spatial grid, and typography scale.
   - `context/ui-rules.md`: Atomic composition rules, forms, dialogs, Wireframe Element Hierarchy, and the Anti-Pill Law.
   - `context/ui-registry.md`: Living component catalog classified by `[ATOM]`, `[MOLECULE]`, `[ORGANISM]` initialized with shadcn/Radix primitives.
   - `context/code-standards.md`: Zero-trust BOLA/IDOR ownership checks, Zod validation schemas, PII scrubbing.
   - `context/library-docs.md`: Curated live documentation for Radix UI, shadcn, Sentry, Datadog.
   - `context/build-plan.md` (or `page-specs.md`):
     - **Information Architecture & Sitemap**: Hierarchical sitemap (Primary, Secondary, Utility), navigation structure (Desktop, Mobile collapse, CTA placement).
     - **Page & Section Architecture**: For every section: `Position`, `Purpose`, `Contents`, and `Rationale`.
     - **Content Relationships & Pathways**: Internal link graph, 3 landing-to-conversion User Pathways, and Information Hierarchy Principles (1st, 2nd, 3rd priorities).
     - Sequenced milestones with 3-step verification runbooks.
   - `context/progress-tracker.md` (or `build-checklist.md`): Milestone status checklist and Decisions Log.

---

### Stage 4: Approval & Handover to Build Gate

Present a crisp summary of the locked context suite to the developer:
```markdown
### 🚀 Project Kickoff Complete: [Project Name] (Tier [1/2/3])
- **AGENTS Rulebook**: Locked in project root
- **UX Research & Language Vault**: Synthesized in context/project-overview.md (JTBD, Pain Points, Verbatim Copy Quotes)
- **Information Architecture**: Complete sitemap & section-by-section specs in context/build-plan.md
- **Design Tokens**: Configured in globals.css (Single-knob CSS cascade verified)
- **UI Registry**: Initialized with Atomic shadcn/Radix primitives
- **Observability**: Sentry Error Boundaries & Datadog APM defined
- **Build Plan**: Milestone 1 ready for execution

Confirm with "Approved" to proceed to Milestone 1 under /architect.
```

Wait for human confirmation before writing application code.
