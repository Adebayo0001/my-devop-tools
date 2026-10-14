# mini-AGENTS.md — High-End Standards for Mini-Websites & Landing Pages (Tier 1)

## Why These Rules Exist

Marketing websites, landing pages, and portfolio sites have a specific failure mode when built by AI:
- The AI introduces **AI Slop**: ugly pill-shaped badges above every heading, generic 3-column card grids, hollow buzzwords, and template colors.
- The AI ignores mobile viewports, breaking layouts on actual phone screens (<375px).
- The AI treats copy as an afterthought, inventing placeholder text that sounds like corporate jargon.

These rules hold the agent to the standard of an award-winning creative studio.

---

## The Mini-Context Protocol

Before writing or modifying any HTML, CSS, or component code, **read the project's context files in this strict sequence**:
1. `context/site-overview.md` (What is being built, audience profile, synthesized **User UX Research** [skepticism, JTBD, cognitive friction], and conversion mandate)
2. `context/design-tokens.md` (The locked **shadcn/Radix** token system, CSS variables in `globals.css`, typography scale, spacing system, and micro-interactions)
3. `context/page-specs.md` (Atomic layout definitions [Atoms, Molecules, Organisms] and exact human copy)
4. `context/build-checklist.md` (The Definition of Done: responsive, a11y, Core Web Vitals, and **Sentry** error tracking)

If any required context file is missing, **stop and flag it to the developer** rather than guessing.

---

## Standing Invariants (Non-Negotiable)

### 1. The Anti-Pill / Anti-Badge Law (Strictly Banned)
* **BANNED**: Placing rounded pill badges, emoji tags, or miniature uppercase chips above headings (e.g., `[✨ OUR SERVICES]`, `[🚀 INNOVATION]`, or rounded border pills).
* **ENFORCED**: Clear, commanding typographic hierarchy. Use standard semantic tags (`h1`, `h2`, `h3`) styled with intentional scale, font weight, line-height, and tracking.
* An eyebrow label is ONLY permitted if it encodes real structural metadata (e.g., a published date `OCTOBER 2026`, or an article category `CASE STUDY`).

### 2. Zero-Placeholder & Human Copywriting Guarantee
* **BANNED**: `Lorem Ipsum`, `// TODO`, `feature title here`, or hollow AI buzzwords (*"seamless"*, *"cutting-edge"*, *"streamline"*, *"game-changing"*).
* **ENFORCED**: Use the exact, pre-defined human copy from `context/page-specs.md`. Every sentence must read like it was written by an elite copywriter.

### 3. shadcn/ui + Radix UI Atomic Foundation (Zero Component Guessing)
* **ENFORCED**: All interactive components must be built on **shadcn/ui** using headless **Radix UI** primitives. No component may ever be guessed, improvised, or built from unstyled divs.
* **The Atomic Principle**:
  - **Atoms**: Basic indivisible primitives (`Button`, `Input`, `Label`, `Badge`, `Avatar`, `Separator`).
  - **Molecules**: Purpose-built combinations (`NewsletterForm` = Input + Button; `SocialProofBadge` = AvatarGroup + StarRating).
  - **Organisms**: Distinct composite sections (`PricingCard` = Header + FeatureList molecule + CTA button atom; `Navbar` = Logo + NavLinks + ActionButton).
* **Sprint Design System Immutability**: Any subsequent sprint addition or new section must be assembled strictly from registered Atoms and Molecules without prompting.

### 4. Global CSS Single-Knob Cascading (Figma Webhook Parity)
* All theme tokens MUST be configured as CSS variables in `globals.css` (e.g. `--primary`, `--background`, `--card`, `--radius`) and wired to Tailwind.
* Changing a single color variable in `globals.css` must cascade instantaneously across every Atom, Molecule, and Organism app-wide—matching the behavior of a live Figma Tokens API / webhook updater. Hardcoded hex codes and raw Tailwind colors (`bg-blue-600`) are strictly banned.

### 5. Flawless Mobile Responsiveness (375px Floor)
* Every layout must be fully responsive down to `375px` viewport width without horizontal scrolling or squished typography.
* Touch targets must be at least `44x44px`.
* Desktop navbars must collapse gracefully into a clean mobile drawer with focus trapping.

### 6. Accessibility Baseline (WCAG 2.1 AA)
* Text contrast must meet or exceed `4.5:1` for normal text and `3:1` for large text against all backgrounds.
* All interactive elements must be keyboard-accessible with visible `focus-visible` styling. Never remove focus outlines without a custom replacement.
* All images must feature descriptive `alt` tags (`alt=""` only for purely decorative SVGs).
* Forms must use real `<label>` tags linked to inputs via `id`. Placeholders are never a substitute for labels.

### 8. Human Copywriting & Copy Domain Isolation
* **12-Year-Old & Executive Litmus Test**: Client-facing copy must be conversational, crystal-clear, plain English, and benefit-driven.
* **Strict Quarantine on Internal Plumbing**: Developer jargon, architecture mechanisms, and state variables (*"dispatch gates"*, *"circuit breakers"*, *"mutation triggers"*, *"BOLA checks"*, *"ingest pipelines"*) must NEVER appear on client screens. Quarantine internal terms strictly to logs, comments, and developer runbooks.

### 9. The Typography Containment & Monospace Quarantine Law
* **Strict Monospace Quarantine**: `font-mono` is strictly quarantined to code blocks (`<pre><code>`) and developer terminals.
* **Strictly Banned**: Applying monospace fonts to client-facing cards, headings, buttons, form inputs, badges, navigation menus, or body text.
* Explicit brand font (e.g. `Plus Jakarta Sans`, `Inter`, `Outfit`, `Geist Sans`) in `tailwind.config.ts` with bulletproof system fallbacks. All UI tokens must bind to `--font-sans`.

### 10. Human-Centered UX & Jakob's Law ($1M Craft + Effortless Flow)
* **$1M Aesthetic**: Bespoke color harmony, crisp typographic hierarchy, refined micro-interactions, and premium whitespace.
* **Effortless Usability (Jakob's Law)**: Users expect your website to behave like top products they already use. Adopt familiar navigation, scroll behavior, and form interactions. Never invent bizarre mechanisms that confuse visitors.
* Zero cognitive friction: maximum 1 primary CTA per viewport, clear visual hierarchy, immediate feedback.

### 11. Agile Working Software Invariant (Upfront Foundation + Methodical Layered Slices)
* **Working software is the primary measure of progress**.
* **Upfront Foundation First**: Dependencies, packages, `globals.css` design tokens, and the Master App Shell (Header/Navbar, Footer, Root Error Boundary) are built upfront before individual page sections.
* **DEV HARNESS QUARANTINE & PRODUCTION SURFACE INTEGRITY (ANTI-HARNESS-LEAK LAW)**:
  - Internal developer test harnesses, token inspectors (`/test-tokens`), component variant showcases (`/shell-preview`), crash simulators, and mock launchers must **NEVER** enter shared production navigation bars (`HeaderNav` `navItems`), the public root landing page (`app/page.tsx` or `/`), or customer product views.
  - All developer verification harnesses must be isolated under dedicated non-production routes (e.g. `app/(dev)/_workbench/...` or `app/(dev)/_tokens/...`) or automated test suites (`/test`), completely detached from public sitemaps and navigation menus.
  - The root home page (`app/page.tsx` or `/`) is the sacred public front door. It must strictly render the customer landing page or authentic product entrypoint defined in `site-overview.md` and `page-specs.md`. Overwriting the root page with buttons like *"Open Shell"* or *"Inspect Design Tokens"* is an architectural defect.
  - Zero framework plumbing in public UI: footers and public copy must never display internal framework specifications (e.g., *"Governed by Tier 1 Mini-Website Invariants"* or database architecture specs).
* **Methodical Layered Slices**: Sections must be built methodically, layer upon layer, directly connecting into the App Shell. No section or page may ever be an isolated disconnected island.
* **The Stop & Test Gate**: After each section or feature is built, the agent **STOPS COLD**, outputs the Feature Verification Card, and awaits verified test confirmation before moving forward.

### 12. The Mandatory Pre-Flight Grounding Mandate (Anti-Blind-Coding Law)
* Before an agent calls ANY code-modifying tool (`write_to_file`, `replace_file_content`, `multi_replace_file_content`), the agent **MUST prove it has read the project's rules and active context**.
* The agent must output the **Pre-Flight Grounding Card** before generating code diffs:
  1. **3 Governing Invariants Cited**: Exact 3 rules from `mini-AGENTS.md` governing this build step.
  2. **Target Blast Radius**: Exact files, functions, and lines to modify.
  3. **Protected Working Surface ("DO NOT TOUCH")**: Pre-existing working features and routes to remain 100% untouched.
  4. **Dev Quarantine Verification**: Confirmation that no test harness, token inspector, or developer launcher is leaking into `HeaderNav` or public routes.
* Calling code-writing tools without outputting this Pre-Flight Grounding Card is an **automatic architectural defect**.

### 13. The Mandatory `.agents/` Root Architecture & Multi-IDE Discovery Shim
* In every project repository root, there must ALWAYS be a `.agents/` directory:
  - `.agents/rules/` containing `mini-AGENTS.md` (or `AGENTS.md` / `GEMINI.md`).
  - `.agents/skills/` for local project-level skills.
* Every project root must maintain native discovery shims linking or mirroring `AGENTS.md` so that NO agent skips rules regardless of IDE:
  - `AGENTS.md` — Canonical standards.
  - `CLAUDE.md` — Native for Claude Code (contains `@AGENTS.md` reference + core pre-flight instructions).
  - `.cursorrules` — Native for Cursor (forces Cursor to load `AGENTS.md` into prompt context).
  - `.windsurfrules` — Native for Windsurf.
  - `GEMINI.md` — Native for Antigravity IDE.

---

## Execution Discipline & 6-Phase Lifecycle

1. **Phase 1: Discovery & Site Specs**: Audience profile, Demographic & Tech Literacy Audit, Jakob's Law pattern selection, and conversion mandate.
2. **Phase 2: Upfront Foundation (The Shell)**: Dependencies, `globals.css` tokens, font cascade, and Master Shell (Navbar + Footer).
3. **Phase 3: Methodical Layered Sprints**:
   - Assemble each vertical section using locked tokens and Radix/shadcn atomics.
   - Inspect all 5 screen states (Default, Loading, Empty, Error, Edge Case).
   - Check 375px mobile responsiveness and zero monospace leaks.
   - Present **Feature Verification & Testing Card** (What was built, what works, what to look out for, deterministic test script).
   - Stop and wait for user or browser agent test confirmation before moving to the next section.
4. **Phase 4: Production Hardening**: Lighthouse Core Web Vitals (LCP < 1.5s, CLS < 0.1, INP < 150ms), a11y contrast audit, Sentry runtime monitoring initialization.
5. **Phase 5: Brand Launch & Cutover**: Production build (`npm run build`), custom domain & DNS setup, SSL, OpenGraph social share cards.
6. **Phase 6: Client Handover & Ops**: Repo transfer, credentials vault transfer, client admin guide, 30-day warranty log.


