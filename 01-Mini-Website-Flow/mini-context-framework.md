# Mini-Context Framework (Tier 1)

**Scope:** 2–3 page websites, marketing landing pages, portfolios, product showcases, and event sites.  
**Objective:** Deliver an uncompromising $1,000,000 bespoke visual standard without saddling the project with unnecessary database schemas, auth matrices, or state machines.

---

## Why a Dedicated Mini-Context Framework?

When building marketing or landing pages, traditional agentic frameworks fail in one of two opposite directions:
1. **The Overkill Trap**: Generating 11 full-stack context files with database migrations, server action error-handlers, and RBAC matrices for a static 3-page site. This wastes context window tokens and slows momentum.
2. **The Underkill Trap ("Vibe Coding")**: Prompting with a vague brief. The AI immediately defaults to generic templates: cream backgrounds with terracotta buttons, repetitive 3-card grids, rounded pill-badges with emojis above headings, and Lorem Ipsum fluff.

The **Mini-Context Framework** is the calibrated sweet spot: a tight, disciplined 4-file suite that anchors creative direction, exact human copy, and structural tokens before a single line of code is scaffolded.

---

## The 4 Lean Context Files

```text
context/
├── site-overview.md       <-- The Brand, Persona & Conversion Intent
├── design-tokens.md       <-- The Visual System (Bespoke Palette, Type & Rhythm)
├── page-specs.md          <-- Section-by-Section Wireframes & Final Human Copy
└── build-checklist.md     <-- Mobile, Accessibility & Performance Floor
```

---

### 1. `context/site-overview.md`
The single source of truth for the site's identity, UX research, and conversion mandate:
* **The Core Offer**: What is being sold, showcased, or announced in 1–2 sharp sentences.
* **User UX Research Synthesis**:
  - **Target Visitor Persona**: Technical literacy, primary skepticism, and emotional trigger.
  - **Jobs-To-Be-Done (JTBD)**: "When [situation], the visitor wants to [action], so they can [desired outcome]."
  - **Conversion Friction Audit**: Exact objections, cognitive overload points, and reassurance metrics needed.
* **The 2–3 Page Sitemap**: Exact pages/routes (e.g., `/` Home, `/work` Case Studies, `/contact` Inquiries) and each page's single primary job.
* **Conversion Hierarchy**: Primary CTA (e.g., "Schedule a Consultation") and secondary CTA (e.g., "Download Case Study").
* **Explicit Out-of-Scope**: Features intentionally omitted (e.g., "No user accounts or logins," "No e-commerce cart—checkout redirects to Stripe payment link").

---

### 2. `context/design-tokens.md`
The aesthetic and technical contract. Anchored on **shadcn/ui** and headless **Radix UI** primitives:
* **shadcn/Radix Theme Tokens & Global CSS Variable Layer**:
  - Defined as CSS custom properties in `globals.css` at `:root` and `.dark` (`--background`, `--foreground`, `--primary`, `--secondary`, `--accent`, `--card`, `--border`, `--radius`).
  - **Single-Knob Cascading (Figma Webhook Parity)**: Changing `--primary` or `--radius` in `globals.css` must cascade instantaneously and update every atom, molecule, and organism app-wide without manual overrides.
  - Contrast ratios verified for WCAG 2.1 AA (≥4.5:1 for body copy).
* **Typography System**:
  - **Display / Heading Face**: High-character font for titles (e.g., Syne, Outfit, Plus Jakarta Sans, Playfair).
  - **Body Face**: Highly legible, complementary sans-serif (e.g., Inter, DM Sans, Satoshi).
  - **Type Scale**: Exact Desktop and Mobile font sizes, line heights, and letter spacing (tracking).
* **Spacing Rhythm & Grid**:
  - Container widths: Max desktop width (e.g., `1200px` or `1440px`), section vertical padding (`py-16` to `py-32`).
  - Asymmetric layout ratios where appropriate (e.g., 60/40 split, bento-grid where justified by distinct content chunks).
* **Motion & Micro-Interactions**:
  - Intentional interactive polish: magnetic button hover, subtle border glow, image zoom transitions.
  - Mandatory `@media (prefers-reduced-motion: reduce)` fallback.

---

### 3. `context/page-specs.md`
The blueprint that eradicates "AI Slop" and enforces Atomic Principles:
* **Zero Lorem Ipsum Guarantee**: Every single headline, sub-headline, paragraph, and button label is written in advance with finalized, publication-grade copy.
* **Atomic Component Architecture (No Guessing)**:
  - **Atoms**: Identify the exact Radix/shadcn building blocks needed (`Button`, `Input`, `Badge`, `Avatar`).
  - **Molecules**: Define compound interactions (`SearchBar`, `NewsletterForm`, `SocialProofChip`).
  - **Organisms**: Structure complete page sections (`HeroSection`, `FeatureComparisonGrid`, `PricingTable`).
* **Sprint Design System Immutability**: Any subsequent page or section added later must strictly reuse these established Atoms and Molecules without prompting.
* **Section-by-Section Architecture**:
  - **Section Name & Role**: (e.g., "Social Proof Bar", "Core Solution Asymmetric Split", "Interactive Pricing Calculator").
  - **Layout Specification**: Visual rhythm description (e.g., "Left: bold 48px headline + 2 proof metrics; Right: interactive live preview card").
  - **Copy Contract**:
    ```markdown
    Headline: "Enterprise Data Pipelines Built for Extreme Concurrency."
    Body: "Eliminate query bottlenecks across BigQuery and Snowflake with self-healing ingest pipelines."
    CTA Label: "Book an Architecture Review"
    ```
* **The Anti-Pill Invariant**: Explicitly forbids adding generic badge pills or tags (`[✨ FEATURES]`) above section headers.

---

### 4. `context/build-checklist.md`
The deterministic Definition of Done. The agent cannot claim the site is finished until every box is validated:
* **Multi-Device Responsiveness**:
  - Tested and pixel-perfect at `375px` (Mobile), `768px` (Tablet), and `1280px+` (Desktop).
  - Navigation switches smoothly to a mobile menu with proper focus trapping.
* **Accessibility (WCAG 2.1 AA Baseline)**:
  - Valid semantic tags (`<header>`, `<nav>`, `<main>`, `<section>`, `<footer>`, `<button>`, `<a>`).
  - Real form `<label>` elements connected via `htmlFor`/`id` (placeholder text is never a label).
  - Visible keyboard focus rings (`focus-visible`).
  - Meaningful `alt` text for images; `alt=""` for purely decorative illustrations.
* **Observability & Error Tracking**:
  - Lightweight **Sentry** browser SDK initialized with release tracking to capture runtime uncaught crashes.
* **Design System & Cascading Verification**:
  - Verified that all interactive UI consumes shadcn/Radix primitives.
  - Single-knob CSS cascade check: verified that changing `--primary` in `globals.css` cascades app-wide.
* **Performance & Core Web Vitals**:
  - LCP < 1.5s on mobile connections.
  - Zero layout shifts (CLS < 0.1) using explicit image dimensions.
  - Assets converted to WebP or optimized vector SVGs.
* **SEO Foundations**:
  - Unique `<title>` tag (< 60 chars) and descriptive `<meta name="description">` (< 160 chars).
  - OpenGraph social share card metadata.

---

## The Build Discipline
1. **Kickoff First**: Run `mini-kickoff-prompt.md` to produce the 4 files before opening the build environment.
2. **UI Before Wiring**: Build layout structure with locked tokens and final copy first.
3. **Audit Against Checklist**: Walk through `context/build-checklist.md` before claiming completion.
