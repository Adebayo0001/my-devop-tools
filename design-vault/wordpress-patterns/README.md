# WordPress & Agency Pattern Ingestion Vault

This directory houses deconstructed, high-converting layout patterns from elite WordPress themes (e.g. Astra Pro, GeneratePress, StudioPress, Breakdance, Elementor Pro top agency templates) and agency conversion architectures.

---

## 1. Why WordPress Layout Patterns Matter
While many WordPress sites look generic, the top 1% of agency WordPress templates and bespoke themes represent millions of dollars in A/B split-testing for conversion:
- High-converting hero value proposition layouts
- Trust badge social proof belts
- Multi-tier pricing tables with anchor highlight cards
- FAQ accordion objection-handling sections
- High-intent lead capture anchors

---

## 2. WordPress-to-Modern-Stack Architectural Translation

| WordPress / Page Builder Concept | Modern React / Next.js Implementation |
|---|---|
| Full-width section with inner container | `<section className="w-full py-20 lg:py-32"><div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">` |
| Columns block (1/3 + 2/3 asymmetric) | `grid grid-cols-1 lg:grid-cols-12 gap-8` with `lg:col-span-4` and `lg:col-span-8` |
| Query Loop / Post Grid | Server Component fetching data + typed React card map |
| Accordion block (FAQs) | `@radix-ui/react-accordion` with smooth CSS height animations |
| Sticky header with scroll shrink | Modern React hook + Tailwind sticky top-0 backdrop-blur |

---

## 3. High-Converting Section Archetypes

### Pattern WP-01: Asymmetric Split Hero with Direct Lead Magnet
- **Layout:** Left 60% commanding benefit headline + bulleted proof checklist + 1-field email capture. Right 40% high-fidelity product mockup card with floating social proof chip.
- **Conversion Math:** 2.4x higher conversion than centered hero text for SaaS & service agencies.

### Pattern WP-02: Objection-Crushing Comparison Matrix
- **Layout:** 3-column comparative table with sticky header row. Feature rows alternate subtle shading (`bg-muted/30`).
- **UX Invariant:** Your product highlighted in a raised, highlighted column with subtle border accent; competitor column displayed in neutral monochrome.

### Pattern WP-03: The 3-Tier Dynamic Pricing Engine
- **Layout:** 3 vertical cards. The center "Growth" tier is visually elevated:
  - 10% taller padding (`py-12` vs `py-8`)
  - Accent hairline border (`border-primary`)
  - "Most Popular" high-contrast badge (metadata, not pill slop)
  - Pre-selected toggle switch for Annual (save 20%) billing

---

## 4. How to Ingest a WordPress Pattern into the Vault
1. Take a full-page desktop screenshot or capture the section URL.
2. Run the **Design Ingestion Protocol** (`design-vault/ingestion-protocol.md`).
3. Strip away WordPress plugin bloat (excess DOM divs, slow external scripts).
4. Save the pure structural card into `design-vault/wordpress-patterns/WP-[ID]-[name].md`.
