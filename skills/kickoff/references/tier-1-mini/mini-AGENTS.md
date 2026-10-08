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

### 7. Observability & Crash Prevention
* Initialize lightweight **Sentry** browser monitoring to capture unexpected client runtime crashes and unhandled exceptions with release tracking.
* Track Core Web Vitals (LCP < 1.5s, CLS < 0.1, INP < 150ms).

---

## Execution Discipline

1. **Build UI with Locked Tokens First**: Assemble the visual structure and typography using `design-tokens.md` and `page-specs.md`.
2. **Compose Atomics**: Build atoms first, combine into molecules, and assemble into organisms.
3. **Never Drift**: Do not invent new components or styling classes that conflict with the design tokens.
4. **Circuit Breaker**: If a visual layout or styling bug persists after ONE failed correction, **stop immediately**. Do not guess blindly with random CSS tweaks. Inspect the root layout tree and apply a surgical fix.
5. **Pre-Ship Verification**: Verify the page against `context/build-checklist.md` (including single-knob CSS cascade check and Sentry initialization) before reporting completion.
