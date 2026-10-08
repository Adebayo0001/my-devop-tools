# The Universal Agentic Engineering Framework (UAEF)
## A Reusable, End-to-End Operating System for Building Production Software with AI

> **Framework Version**: 2.0 (Silicon Valley Tier-1 Standard)  
> **Author / Architect**: Distilled from the Production Build Lifecycle of LifeStream  
> **Audience**: AI Software Developers, Vibe Coders, Agency Founders, Technical Directors  
> **Core Objective**: A repeatable, zero-ignorance framework that guides anyone from a raw voice note and rough screenshots to an enterprise-grade, fully verified software product with zero AI hallucinations, zero style drift, and zero spaghetti code.

---

## The Philosophy: "Architecture Before Syntax"

Most people approach AI coding with **"Prompt-and-Pray"**:
1. Type a vague prompt: *"Build me an app for X."*
2. AI guesses the design, makes up database schemas, and writes 500 lines of messy code.
3. Feature 3 breaks Feature 1. Spacing drifts. Dependencies conflict. The project collapses.

The **Universal Agentic Engineering Framework** flips this completely:
$$\text{Raw Human Intent} \longrightarrow \text{Rigorous 6-Role Blueprint} \longrightarrow \text{Atomic Execution} \longrightarrow \text{Human Verification Gate}$$

You do not act as a manual coder; you act as the **Technical Director & Principal Architect**, governing autonomous AI agents with the same documentation and verification pipelines used at Google, Apple, and Stripe.

---

# The 7-Stage Universal Build Lifecycle

```
Stage 1: RAW INGESTION & DISCOVERY
   │   (Voice Note + Reference Images + The 7 Inquiries)
   ▼
Stage 2: TECH STACK LOCK
   │   (Physical Constraints + Version Locking)
   ▼
Stage 3: VISUAL DIRECTION & STITCH PROMPTING
   │   (Design Tokens + Google Stitch / Figma Mockups)
   ▼
Stage 4: THE 11-FILE CONTEXT SUITE GENERATION
   │   (PRD, Sitemaps, Architecture, Tokens, Build Plan)
   ▼
Stage 5: THE AGENT OPERATING SYSTEM (AGENTS.md)
   │   (The 6 Non-Negotiable Laws + Skills Integration)
   ▼
Stage 6: ATOMIC EXECUTION & VERIFICATION LOOP
   │   (One Feature at a Time + UI-First + Recovery Protocol)
   ▼
Stage 7: CLIENT HANDOVER & PACKAGING
       (Vault Handover, Runbooks, 30-Day Warranty)
```

---

# Stage 1: Raw Ingestion & Discovery

Every project begins with raw, unvarnished human thought: a voice note, a client brief, or screenshots of existing apps.

### 1.1 The Human Starter Input
To kick off any project, the user provides 3 raw inputs:
1. **The Voice Note / Vision Prompt**: A 2-to-5 minute explanation of the product, who uses it, where it is used, and what problem it solves.
2. **Visual Inspiration**: 2 to 5 screenshots of existing apps or designs they admire.
3. **Core Environmental Constraints**: Is it web, mobile, or offline desktop? Who is the operator (volunteer, expert, consumer)?

### 1.2 The 7 Discovery Inquiries (The AI Kickoff Prompt)
Before writing any file or code, the AI must interview the human across these **7 Pillars**:

| Pillar | What Must Be Answered | Example from LifeStream |
| :--- | :--- | :--- |
| **1. The Core Problem & Persona** | Who uses this daily, in what environment, under what stress? | Church media volunteers during live, noisy services. |
| **2. Screen Inventory** | What are the exact 5 core screens of the product? | 1. Operator Console, 2. Projection Output, 3. Scripture Explorer, 4. Template Editor, 5. Hardware Routing. |
| **3. Non-Negotiable Constraints** | What must NEVER happen? (Hard invariants). | 100% offline-first. Never stretch camera video aspect ratio. |
| **4. Safety Gates & Verification** | How do we prevent mistakes or false AI triggers? | AI stages verses in preview; operator must press Spacebar to air. |
| **5. Data & Persistence Model** | Where does data live? Cloud, SQLite, JSON, local files? | Local embedded SQLite with WAL mode & FTS5 full-text indexing. |
| **6. Visual Brand Identity** | What is the color palette, typography, and mood? | Obsidian Black, Imperial Crimson, Sacred Gold; Outfit & Inter. |
| **7. Scope Boundaries** | What is strictly OUT OF SCOPE for Phase 1? | No cloud sync, no mobile apps, no multi-church networking. |

---

# Stage 2: Tech Stack Decision Matrix

Never let the AI pick a default stack. The stack must be chosen based on **physics, platform constraints, and verified library versions**.

### 2.1 The Evaluation Matrix Template

```markdown
### Stack Selection Rationale
- Primary Shell: [Electron / Next.js / Vite / React Native] — Why? (e.g. multi-display hardware access)
- UI Library: [React 19 / Vue 3 / Svelte] — Why?
- Styling Engine: [Vanilla CSS Design Tokens] — Why? (Eliminates Tailwind purge/version bugs)
- Data Store: [better-sqlite3 / PostgreSQL / Supabase] — Why?
- Engine / AI Runtime: [ONNX Runtime Node / WebAssembly] — Why?
```

### 2.2 Version Locking Rule
Always lock dependencies with exact versions in `context/architecture.md` before generating `package.json`. This prevents the AI from mixing deprecated APIs (e.g. Electron remote module vs modern `contextBridge`).

---

# Stage 3: Visual Direction & Two-Tier Mockup Architecture

High-end software requires **Visual Anchors** so the developer and AI know the target before building. Never guess visual layouts in code.

### 3.1 Extracting Design Tokens from References
From the reference screenshots, extract:
* **Base Surface**: Deepest background color (`#08090B`).
* **Elevated Surface**: Card and modal background (`#13171F`).
* **Brand Primary**: High-intent action color (`#D92534` Crimson).
* **Accent Highlight**: Badges and focus points (`#F59E0B` Amber Gold).
* **Typography Pairing**: One high-character display font (Outfit) + one ultra-legible neutral body font (Inter) + one tabular monospace font (JetBrains Mono).

### 3.2 The Screen & Modal Inventory Matrix
Do NOT assume an app only has 5 screens. A production system has 15–25 surfaces. In `user-flows.md`, catalog every surface into two tiers:
1. **Tier 1: Core Anchor Screens (5 Pillars)**: Generated upfront during kickoff to establish visual identity, tokens, and aesthetic tone.
2. **Tier 2: Feature Sub-Screens & Modals**: Generated Just-In-Time (JIT) right before their specific feature in `build-plan.md` is coded.

### 3.3 The Deterministic 5-Part Google Stitch Formula
To prevent Google Stitch or AI design tools from hallucinating unwanted clutter (random analytics graphs, floating bubbles, crypto tickers):

```text
DETERMINISTIC STITCH PROMPT FORMULA:
1. [VIEWPORT LOCK]: Flat 2D desktop application screenshot, 16:9 widescreen, 1920x1080 resolution, Windows 11 studio software, direct front-facing view, NO 3D perspective tilt, NO laptop mockup frame, NO claymockups.
2. [ZONE ARCHITECTURE]: Zone 1 (Left 280px rail), Zone 2 (Center 60% widescreen preview stage), Zone 3 (Right 360px inspector).
3. [ELEMENT INVENTORY]: Exact named buttons, exact cards, exact form inputs. Zero unspecified elements.
4. [LOCKED PALETTE]: Canvas #08090B, Surface #13171F, Primary CTA #D92534, Gold badges #F59E0B, Holy White text #F8FAFC.
5. [STRICT NEGATIVE CONSTRAINTS]: NO analytics charts, NO line graphs, NO bar charts, NO floating decorative bubbles, NO colorful gradients, NO rounded mobile pill frames, clean minimalist broadcast interface only.
```

### 3.4 The Mockup Ingestion Rule
Save all approved mockup PNGs into `context/designs/` (e.g. `context/designs/live_service_console.png`). These serve as the visual ground truth for visual regression checks and 1:1 code implementation.

---

# Stage 4: The 11-File Context Suite Generation

The secret to building enterprise software with AI is generating the **Context Suite** file-by-file with human review. All files live inside `context/`:

```
context/
├── project-overview.md       # 1. PRD, Core flows, Data architecture, Scope boundaries
├── user-flows.md             # 2. Sitemaps, Mermaid journeys, 5 UI states per screen
├── architecture.md           # 3. Stack rationale, Folder tree, Invariants, IPC/API contracts, DB schema
├── library-docs.md           # 4. Concrete API signatures for core packages
├── code-standards.md         # 5. Engineering mindset, error handling, IPC patterns, import aliases
├── design.md                 # 6. Locked color palette, typography scales, contrast standards
├── ui-tokens.md              # 7. CSS variables, safe margins, broadcast indicators
├── ui-rules.md               # 8. Component styling rules, layout constraints, broadcast invariants
├── ui-registry.md            # 9. Living component pattern registry managed by /imprint
├── build-plan.md             # 10. Sequential phases, numbered Features 1..N, Definition of Done
└── progress-tracker.md       # 11. Interactive checklists & decision log
```

### 4.1 The Non-Negotiable "5 UI States" Rule
In `context/user-flows.md`, every single screen must define all 5 states:
1. **Default State**: Populated with realistic data.
2. **Empty State**: First-run or zero data with a clear call-to-action.
3. **Loading State**: Skeleton screens or progress indicators (< 50ms).
4. **Error State**: Graceful inline alerts with recovery actions.
5. **Edge Case State**: Extreme strings, single-monitor setups, disconnected hardware.

---

# Stage 5: The Master Operating System (`AGENTS.md`)

`AGENTS.md` is placed in the project root and mirrored at `.agent/AGENTS.md`. It governs the AI's behavior like a strict principal engineer.

### The 6 Non-Negotiable Operational Laws

```
┌────────────────────────────────────────────────────────────────────────┐
│                   THE 6 NON-NEGOTIABLE LAWS                            │
├────────────────────────────────────────────────────────────────────────┤
│ Law 1: Atomic Execution — Build strictly ONE numbered feature at a     │
│        time from build-plan.md. Never bundle features.                 │
│ Law 2: Absolute Scope Clamping — Zero unapproved additions or extra    │
│        libraries. Features marked Out-of-Scope are never touched.      │
│ Law 3: UI-First with Verification — Build visual UI with mock data     │
│        and all 5 states first; wire database & IPC logic second.       │
│ Law 4: Testing & Verification Gate — Run typechecks and automated     │
│        builds, then present a 3-step test script to the human.         │
│ Law 5: Anti-Generic Design Excellence — Apply tokens, GPU compositing, │
│        cubic-bezier springs, and custom typography. Kill AI slop.      │
│ Law 6: Zero Placeholder Content — No Lorem Ipsum, no // TODOs.         │
│        All data must be real and production-ready from day one.        │
└────────────────────────────────────────────────────────────────────────┘
```

### Specialized Skills Lifecycle
* **`/architect`**: Invoke before beginning any phase to analyze edge cases and state transitions.
* **`/imprint`**: Invoke immediately after completing any UI component to extract tokens into `ui-registry.md`.
* **`/review`**: Invoke at feature completion to audit code against `code-standards.md`.
* **`/recover`**: Invoke on any build crash or bug to classify the failure mode before patching.
* **`/remember`** (or `log memory`): Invoke at session breaks or after completing features to perform an **incremental update** into `memory.md` and `.ai-memory/phase-log.md` (strictly incremental, never prompts to overwrite).

---

# Stage 6: The Atomic Execution & Verification Loop

Development proceeds strictly through the numbered features in `build-plan.md`. Never code blind or guess layouts.

```text
For Each Numbered Feature (Feature 01, Feature 02, ... Feature N):
   │
   ├── Step 1: Visual Reference Check & JIT Blueprinting
   │           ├── Check if exact screen/modal mockup exists in context/designs/
   │           └── IF MISSING: Output ASCII Wireframe + Deterministic Stitch Prompt
   │               (Negative constraints applied; user/agent saves PNG to context/designs/)
   ├── Step 2: Implement UI with Mock Data (All 5 States matching design reference)
   ├── Step 3: Wire Database, IPC, and State Logic
   ├── Step 4: Run Automated Typecheck (npm run typecheck)
   ├── Step 5: Run Multi-Target Production Build (npm run build)
   ├── Step 6: Run /imprint to register new component in ui-registry.md
   ├── Step 7: Present 3-Step Human Verification Script to the User
   ├── Step 8: User Tests & Confirms Feature Passes
   └── Step 9: Append Checkpoint to .ai-memory/phase-log.md & Update progress-tracker.md
```

### The Surgical Recovery Protocol
When an error occurs (e.g. `ENOENT` spawn failure, missing binary, or unhandled event):
1. **Never guess or patch blind**. Inspect raw file buffers, paths, and logs.
2. Check for invisible characters (like trailing `\n` in config files).
3. Validate binary existence before spawning child processes.
4. Verify event propagation (hardware hotkeys vs DOM event listeners).

---

# Stage 7: Professional Client Handover

When the project concludes, deliver the **Tier-1 Handover Package**:

1. **Vault Transfer (1Password / Bitwarden)**:
   * Domain registrar & DNS records.
   * Cloud hosting / server root credentials.
   * Master database connection strings & encryption keys.
   * Third-party API keys (Stripe, Twilio, OpenAI).
2. **Codebase & Release Artifacts**:
   * Ownership transfer of the Git repository.
   * Production `.exe` / `.dmg` / web production bundles.
   * Database schema migrations and baseline seed scripts.
3. **Operational Documentation**:
   * Architecture Runbook (`architecture.md`).
   * Client Admin User Manual with short Loom video walkthroughs.
   * Environment configuration dictionary (`.env.example`).
4. **Legal & Warranty Protection**:
   * IP Assignment Contract (100% intellectual property transfer upon final settlement).
   * **30-Day Bug Warranty**: Contractual guarantee fixing genuine bugs at zero cost.
   * Optional monthly Maintenance SLA for ongoing updates.

---

## The Master Kickoff Prompt (Copy-Paste for New Projects)

When starting any new project in the future, paste this prompt to your AI coding agent:

```text
I am initiating a new software project using the Universal Agentic Engineering Framework (UAEF).

Here are my project vision and materials:
- Project Name: [Project Name]
- Vision / Voice Note Summary: [Paste summary or voice transcript]
- Environmental Constraints: [Web / Desktop / Mobile, Offline vs Cloud, User Persona]
- Reference Screenshots: [Paths to reference images]

Follow the UAEF protocol strictly:
1. Do NOT write any application code yet.
2. Conduct the Stage 1 Discovery interview across the 7 Pillars.
3. Propose the Stage 2 Tech Stack Decision Matrix with locked version numbers.
4. Generate the Google Stitch prompts for our 5 core screens.
5. Produce the 11 context files in context/ one by one for my approval.
6. Initialize AGENTS.md with the 6 Non-Negotiable Operational Laws.
7. Prepare build-plan.md for atomic, feature-by-feature execution.

Acknowledge this framework and ask your first set of discovery questions.
```
