# The Taste & Spatial Calculus Engine

> **Origin**: Consolidated from `Leonxlnx/taste-skill`, `madebymustafa/design-taste`, and Silicon Valley Design Systems.
> **Directive**: Eliminates the "AI-generated look", uneven spatial padding, and awkward visual clustering. Every layout mathematically adheres to modular geometric rhythm and human design intent.

---

## 1. The 8px Modular Spacing Calculus

AI models frequently mix arbitrary Tailwind spacing classes (e.g. `mt-7`, `p-5`, `gap-3`), leading to jarring, uneven layouts. In contrast, human designers at Apple, Stripe, and Linear work within a strict **8px modular grid**.

### The Spatial Grid Scale

| Token | Pixels | Semantic Role | Common Tailwind Utilities |
|---|---|---|---|
| **Space-1** | `4px` | Micro-gap (icons next to text, badge padding) | `gap-1`, `p-1`, `space-x-1` |
| **Space-2** | `8px` | Compact element spacing (button padding, input internal padding) | `gap-2`, `px-3 py-2`, `space-y-2` |
| **Space-3** | `12px` | Intermediate grouping (list items, tags) | `gap-3`, `p-3`, `space-y-3` |
| **Space-4** | `16px` | Component container base (cards, form field stacks) | `gap-4`, `p-4`, `space-y-4` |
| **Space-6** | `24px` | Major card padding, modal content padding | `gap-6`, `p-6`, `space-y-6` |
| **Space-8** | `32px` | Card section dividers, prominent dialogs | `gap-8`, `p-8`, `space-y-8` |
| **Space-12** | `48px` | Section sub-grouping, hero content gaps | `gap-12`, `py-12`, `space-y-12` |
| **Space-16** | `64px` | Standard page section vertical padding | `py-16`, `gap-16` |
| **Space-24** | `96px` | Landmark hero section vertical padding (Desktop) | `py-24`, `my-24` |
| **Space-32** | `128px` | Editorial breathing room (Luxury / Minimalist) | `py-32` |

### The Anti-Uneven-Spacing Rules
1. **Never Mix Odd Values**: Never use arbitrary odd spacing (`p-5`, `mt-7`, `px-9`). Stick strictly to multiples of 8 (or 4 for micro elements).
2. **Harmonized Padding/Margin Cascade**: If an outer container uses `p-6` (24px), internal child stacks must use `space-y-4` (16px) or `space-y-3` (12px), never larger than the parent padding.
3. **Responsive Spacing Halving**: On mobile (375px), large section spacing halves cleanly: `py-24` (96px) on desktop becomes `py-12` (48px) on mobile; `p-8` (32px) becomes `p-4` (16px) or `p-5` (20px).

---

## 2. The 3 Master Taste Dials

To avoid homogeneous, template-driven designs, every screen must calibrate three dials based on industry, audience, and intent:

```
[0.0 ────────────── 0.5 ────────────── 1.0]
        THE TASTE DIAL MATRIX
```

### Dial 1: Design Variance (Symmetry vs. Artistic Tension)
- **Low (0.1 – 0.3) — Corporate Symmetry**:
  - Balanced two-column or centered layouts, uniform card grids, standard navigation bars.
  - *Best Fit*: B2B compliance software, healthcare portals, government tools.
- **Medium (0.4 – 0.6) — Structured Personality**:
  - Bento grids with one dominant focal card (ARCH-02), subtle offsets, intentional badges.
  - *Best Fit*: Developer platforms, productivity tools, SaaS dashboards.
- **High (0.7 – 0.9) — Editorial Asymmetric Tension**:
  - Asymmetric 62/38 or 8/4 Golden Ratio splits (ARCH-01), overlapping floating layers, sculptural typography breaks.
  - *Best Fit*: Creative studios, marketing sites, luxury brands, cutting-edge AI apps.

### Dial 2: Visual Density (Airy Museum vs. High-Density Console)
- **Low (0.1 – 0.3) — Luxury Breathing Room**:
  - 40%–50% negative space, generous line-heights (`leading-relaxed`), spacious cards.
  - *Best Fit*: Consumer luxury, architectural portfolios, brand manifestos.
- **Medium (0.4 – 0.6) — Standard Product Density**:
  - Balanced whitespace (`p-6` cards, `gap-6` grids), comfortable touch targets.
  - *Best Fit*: SaaS onboarding, e-commerce checkout, account settings.
- **High (0.7 – 0.9) — Operator Console**:
  - Tight compact tables, 32px row heights, collapsible sidebars, dense data metrics.
  - *Best Fit*: Fintech trading, cloud infrastructure, analytics dashboards.

### Dial 3: Motion Intensity (Static vs. Cinematic Physics)
- **Low (0.0) — Instant & Accessible**:
  - Zero decorative animation. Instant transitions, standard hover color shifts.
  - *Mandatory*: Under `prefers-reduced-motion: reduce`.
- **Medium (0.3 – 0.5) — Micro-Interaction Precision**:
  - Magnetic buttons, smooth accordion expansions, border-beam glows, subtle opacity fades (`duration-200`).
  - *Best Fit*: Modern web apps, SaaS products, interactive dashboards.
- **High (0.6 – 0.8) — Cinematic Staged Reveals**:
  - Physics-based spring animations (`stiffness: 300, damping: 25`), staggered layout entries, fluid canvas shaders.
  - *Best Fit*: Agency hero sections, interactive onboarding flows, product launches.

---

## 3. Typographic Tension & Intentional Font Pairing

Human designers treat typography as structural architecture, not cosmetic decoration:

1. **Hierarchy Ratio (The Minor Third or Golden Scale)**:
   - Display H1: `text-4xl md:text-6xl font-bold tracking-tight`
   - Section H2: `text-2xl md:text-3xl font-semibold tracking-tight`
   - Card Title H3: `text-lg md:text-xl font-medium`
   - Body Copy: `text-sm md:text-base text-muted-foreground leading-relaxed`
   - Micro Metadata: `text-xs uppercase tracking-wider text-muted-foreground/80`
2. **Intentional Font Pairings**:
   - *Option A (Modern High-Craft)*: High-contrast geometric sans (e.g., Plus Jakarta Sans / Outfit) for headings + Neutral Neo-grotesk (Inter / Geist) for body.
   - *Option B (Editorial Authority)*: Characterful editorial serif (e.g., Fraunces / Playfair) for display moments + Crisp modern sans (Geist / Inter) for body.
   - *Option C (Technical Developer Precision)*: Razor-sharp grotesk (Geist / Roboto) for headings + clean body, with Monospace strictly quarantined to code blocks (`font-mono`).
3. **The 75-Character Reading Limit**:
   - Body paragraphs must always be constrained with `max-w-prose` (approx. 65ch) or `max-w-xl`. Never allow multi-line text to span 100% of an ultrawide desktop monitor.
