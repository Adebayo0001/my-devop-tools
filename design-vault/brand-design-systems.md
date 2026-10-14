# Master Brand Design Systems & Token Presets

> **Origin**: Consolidated from `marvkr/better-design`, `superdesigndev/superdesign-skill`, and `plugin87/ux-ui-agent-skills`.
> **Directive**: Provides battle-tested design tokens, typographic scales, elevation levels, and semantic variables reverse-engineered from world-class tech companies (Linear, Stripe, Vercel, Notion, Apple, Supabase).

---

## 1. The 6 Iconic Design Presets

### Preset 1: The Linear Precision Dark System
- **Character**: Focused, ultra-crisp developer experience. High density, hairline 1px borders, subtle violet/indigo glow.
- **Tokens (`globals.css`)**:
  - `--background`: `240 10% 4%` (Deep Obsidian `#0A0A0C`)
  - `--card`: `240 10% 7%` (`#111115`)
  - `--border`: `240 6% 15%` (`#23232A`)
  - `--primary`: `245 80% 64%` (Linear Electric Indigo `#5E6AD2`)
  - `--radius`: `0.5rem` (8px)

### Preset 2: The Stripe Radiant Commerce System
- **Character**: Approachable, crystal-clear, premium trustworthiness. Crisp white canvas, rich navy typography, vibrant purple/cyan accents.
- **Tokens (`globals.css`)**:
  - `--background`: `0 0% 100%` (`#FFFFFF`)
  - `--card`: `210 20% 98%` (`#F8FAFC`)
  - `--border`: `214 32% 91%` (`#E2E8F0`)
  - `--primary`: `250 85% 60%` (Stripe Blurple `#635BFF`)
  - `--foreground`: `222 47% 11%` (Deep Slate `#0F172A`)
  - `--radius`: `0.75rem` (12px)

### Preset 3: The Vercel Minimalist Monolith
- **Character**: High-contrast, stark brutalist engineering. Monolithic monochrome canvas with zero blur shadows.
- **Tokens (`globals.css`)**:
  - `--background`: `0 0% 0%` (Pure Black `#000000`)
  - `--card`: `0 0% 5%` (`#0D0D0D`)
  - `--border`: `0 0% 18%` (`#2E2E2E`)
  - `--primary`: `0 0% 100%` (Pure White `#FFFFFF`)
  - `--radius`: `0.375rem` (6px)

### Preset 4: The Notion Warm Editorial System
- **Character**: Warm, tactile, literary productivity. Muted cream backdrop, warm charcoal typography.
- **Tokens (`globals.css`)**:
  - `--background`: `40 20% 97%` (Warm Parchment `#F7F6F3`)
  - `--card`: `0 0% 100%` (`#FFFFFF`)
  - `--border`: `40 10% 88%` (`#E4E3DF`)
  - `--primary`: `25 15% 20%` (Charcoal Ink `#2F2D2B`)
  - `--radius`: `0.375rem` (6px)

### Preset 5: The Apple Human Interface System
- **Character**: Sculptural, rounded, ultra-polished elegance. Frosted glass scrims (`backdrop-blur-xl`), generous negative space.
- **Tokens (`globals.css`)**:
  - `--background`: `0 0% 100%`
  - `--card`: `0 0% 97%` (`#F5F5F7`)
  - `--primary`: `211 100% 50%` (System Blue `#0071E3`)
  - `--radius`: `1rem` (16px)

### Preset 6: The Supabase Developer Matrix
- **Character**: Emerald green accents, dark hacker aesthetic, high data density.
- **Tokens (`globals.css`)**:
  - `--background`: `160 20% 6%` (`#121815`)
  - `--card`: `160 15% 10%` (`#17221C`)
  - `--primary`: `154 75% 46%` (Supabase Emerald `#24B47E`)
  - `--radius`: `0.5rem` (8px)

---

## 2. Universal Single-Knob Cascade Rule

In any of these systems, modifying a single CSS variable in `globals.css` (e.g., changing `--primary` from indigo to violet) must immediately propagate through every button, border-beam, card glow, and text accent across the entire project without requiring component-level edits.
