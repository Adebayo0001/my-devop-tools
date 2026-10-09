# ARCH-01: Editorial Asymmetric (High-Authority Luxury)

> **Source Inspiration:** Studio Freight, Awwwards Site of the Year, High-End Architectural Agencies  
> **Visual Tone:** Uncompromising authority, intellectual prestige, generous breathing room, sculptural typography.

---

## 1. Spatial Grid & Proportions
* **Desktop Grid Structure:** 12-column asymmetric layout with an **8/4 Golden Ratio split**.
  - Columns 1–4 (Left 38%): Sticky narrative introduction, title, and primary CTA anchor.
  - Columns 5–12 (Right 62%): Fluid scrolling showcase of featured cards, artifacts, and case studies.
* **Viewport Max Width:** `1440px` centered container with `64px` horizontal gutters on desktop.
* **Negative Space Tension:** 42% calculated whitespace. Elements are never crowded; generous padding (`120px` vertical section rhythm) establishes elite calm.
* **Signature Tension:** Headlines intentionally extend past container boundaries with subtle letter-spacing overlap against subtle 1px hairline dividers.

---

## 2. Typographic Architecture & Roles
* **Display Role:** **Syne** or **Instrument Serif** (Display / H1). Weight 700 / SemiBold, line-height `1.08`, tracking `-0.035em`.
* **Interface & Body Role:** **Plus Jakarta Sans** or **Inter**. Crisp, tall x-height, line-height `1.55`, letter-spacing `-0.01em`.
* **Utility Role:** **JetBrains Mono**. All caps, `0.75rem / 12px`, letter-spacing `+0.08em` for metadata badges, timestamps, and section indexes (`01 / OVERVIEW`).
* **Pairing Philosophy:** High-contrast dramatic headline paired with an invisible, ultra-legible body face.

---

## 3. Section-by-Section Wireframe Flow
1. **Hero Section:**
   - Left 4 cols: Sticky product manifesto headline + short benefit paragraph + primary magnetic button.
   - Right 8 cols: Large 16:10 high-resolution media showcase with hairline border and subtle corner radius (`8px`).
2. **Proof Strip:**
   - Single-line horizontal ticker of minimalist monochrome partner insignias with 50% opacity, separated by subtle dot indicators (`•`).
3. **Core Feature Showcase (Asymmetric Stream):**
   - Staggered vertical cards: Card 1 spans cols 5–8; Card 2 spans cols 9–12 with an intentional 80px vertical offset, breaking standard row alignment.
4. **Closing Conversion Anchor:**
   - Centered 8-column text block with commanding 48px display typography and single high-contrast action button.

---

## 4. Mobile Collapse Logic (375px Strict Audit)
* **Stacking Hierarchy:** Sticky left rail un-sticks at `<= 1024px` and stacks naturally above the showcase media.
* **Typography Curve:** Hero H1 scales down from `56px` to `34px`, line-height tightens to `1.12`, preventing single-word orphans.
* **Touch Targets:** All buttons expand to `w-full` on mobile with `h-12` (`48px`) touch targets.
* **Overflow Protection:** Containers enforce `w-full overflow-x-hidden px-5`.

---

## 5. Google Stitch Deterministic Prompt Formula
```text
Flat 2D desktop application screenshot, 16:9 widescreen, 1920x1080 resolution, direct front-facing view, NO 3D perspective tilt, NO laptop mockup frame, NO claymockups.
Zone Architecture: Left 38% sticky narrative column with commanding geometric sans-serif heading and action button; Right 62% scrolling gallery showcase featuring staggered minimalist product cards with hairline borders.
Locked Palette: Dark obsidian canvas #0A0B0E, elevated card surfaces #14171F, high-contrast crisp text #F8FAFC, subtle hairline dividers #262B36.
Typography Character: Architectural geometric display titles with tight line spacing, ultra-legible clean body text, uppercase monospace metadata tags.
STRICT NEGATIVE CONSTRAINTS: NO analytics charts, NO line graphs, NO bar charts, NO floating decorative bubbles, NO colorful gradients, NO rounded mobile pill frames, clean minimalist editorial software only.
```
