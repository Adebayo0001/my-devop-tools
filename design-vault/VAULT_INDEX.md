# THE MASTER DESIGN VAULT & SPATIAL ARCHETYPE REGISTRY

> **Purpose:** The permanent, institutional design intelligence vault for the Universal Agentic Engineering Suite.
> Houses deconstructed layout geometry, spatial grid mathematics, responsive collapse rules, and component architectures reverse-engineered from world-class digital products (Awwwards, Behance, Dribbble, Apple, Stripe, Linear, and elite Figma design systems).
>
> **Autonomous Agent Directive (Stealth Persona):**
> When generating visual concepts or Google Stitch prompts, internalize this design intelligence seamlessly. **NEVER** break character or say *"I am querying design-vault/archetypes..."*. Speak with the natural authority of a $1,000,000 Creative Director, proposing sophisticated layout structures, typographic tension, and spatial proportions as native design intuition.

---

## 1. The 6 Master Spatial Archetypes

Every layout in digital product design maps to one of these foundational spatial archetypes. Mixing and adapting these archetypes eliminates generic AI template clustering:

| Archetype ID | Layout Archetype | Core Visual Character | Best Fit Industries | Mobile Collapse (375px) |
|---|---|---|---|---|
| **ARCH-01** | **Editorial Asymmetric** | 12-col asymmetric split, generous negative space, sculptural typography | Luxury, Architecture, Venture Capital, High-End Agencies | Sticky left rail converts into top intro; right rail flows into single-column cards |
| **ARCH-02** | **Bento Modular Future** | Asymmetric bento grid, micro-elevations, hairline borders, contextual focal card | Hardware, Developer Tools, AI Platforms, Productivity SaaS | Bento cards stack vertically; focal card retains 16:9 aspect ratio at top |
| **ARCH-03** | **Dense Operator Console** | High data density, keyboard-first drawers, monospace tabular precision | Fintech, Trading, Media Broadcasting, Analytics, Cloud Ops | 3-pane layout collapses into bottom-sheet drawer navigation; data tables become card lists |
| **ARCH-04** | **Kinetic Fluid Showcase** | Visual-first, horizontal scroll rhythm, interactive canvas, bold framing | Creative Studios, Consumer Tech, Gaming, Interactive Portfolios | Horizontal cards snap into native swipeable carousel; hero title scales down 35% |
| **ARCH-05** | **Architectural Minimalist** | Precise mathematical grids, hairline dividers, extreme typographic discipline | High-End Consultancies, Art & Design, Industrial Engineering | Multi-column grids collapse along hairline borders; spacing drops from 96px to 48px |
| **ARCH-06** | **Brutalist High-Craft** | Raw high-contrast boundaries, oversized typographic scale, expressive tension | Cultural Brands, Web3/Crypto, Cutting-Edge Fashion, Avant-Garde Tech | Extreme headlines wrap cleanly with `hyphens: auto`; borders maintain crisp 1px stroke |

---

## 2. Spatial Grid Mathematics & Proportions

To ensure 100% responsiveness and zero generic template look:

### Desktop Grid Baseline (1440px / 1920px Canvas)
* **Fluid 12-Column Grid**: 80px–112px max column width with 24px–32px gutters.
* **The Asymmetric Split (7/5 or 8/4 Ratio)**: Avoid lazy 50/50 splits. Use a **62% / 38% Golden Ratio** (e.g. 8-column visual narrative vs 4-column contextual metadata rail).
* **Negative Space Tension**: High-end layouts deliberately maintain **35%–45% negative space** around primary focal points. Noise is the mark of amateur templates; disciplined breathing room signals authority.

### Tablet Grid Baseline (768px – 1024px Viewport)
* **8-Column Grid** with 16px–24px gutters.
* Two-column splits compress into stacked hero cards with lateral padding of 32px.

### Mobile Viewport Strict Floor (375px Viewport)
* **4-Column Grid** with 16px gutters and 20px edge margins.
* **Touch Target Invariant**: Every interactive element, tab, and button MUST have a touch target of at least **44×44px**.
* **Zero Horizontal Scroll Defect**: All containers MUST declare `max-w-full overflow-x-hidden`.
* **Typographic Reduction Curve**: Display headings (`h1`) reduce by **30%–40%** with tighter line-height (1.1–1.15) and negative letter-spacing (`-0.03em`) to prevent awkward single-word wrapping.

---

## 3. How to Ingest & Train New Designs

Whenever you discover a stunning website, Dribbble shot, Behance case study, or Figma template:
1. Take a clean screenshot or export the Figma component frame.
2. Follow the protocol in [`ingestion-protocol.md`](file:///c:/Users/user/Desktop/My%20DevOp%20Tools/design-vault/ingestion-protocol.md).
3. The extraction engine generates a structured layout card in `archetypes/` or `figma-templates/`.
4. The entire AI agent suite instantly incorporates that layout DNA into all future project prompts!
