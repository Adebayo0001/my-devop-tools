# ARCH-05: Architectural Minimalist (Swiss Precision & Monolith Layout)

> **Source Inspiration:** Rauno Freiberg (Craft), Minimalissimo, Dieter Rams / Braun Principles, Basecamp ONCE, Vercel Engineering  
> **Visual Tone:** Ruthless clarity, Swiss modernist mathematical rhythm, zero unnecessary decoration, profound typographic quietness.

---

## 1. Spatial Grid & Proportions
* **Desktop Grid Structure:** Strict mathematical 16-column modular grid with hairline 1px borders dissecting sections.
  - No floating rounded cards. Layout consists of crisp, interconnected rectangular quadrants.
  - Border system: `border-b border-r border-border` creating architectural grid lines that anchor every piece of copy.
* **Viewport Max Width:** `1200px` container anchored with razor-sharp 1px outer bounding box.
* **Negative Space Tension:** 48% whitespace ratio. Extreme breathing room around compact, authoritative statements.
* **Elevation & Shadow Invariant:** Exactly **0px blur shadows**. Elevation is achieved solely through contrast, background tone shifting (`bg-muted/30`), and 1px borders.

---

## 2. Typographic Architecture & Roles
* **Display Role:** **Geist** or **Neue Montreal** (Display / H1). Weight 500 / Medium (not bold), line-height `1.15`, tracking `-0.03em`. Quiet, intellectual confidence that never screams.
* **Interface & Body Role:** **Inter** or **Geist**. Weight 400, line-height `1.65`, letter-spacing `-0.01em`, color locked to subtle off-white / charcoal for zero eye fatigue.
* **Utility Role:** **IBM Plex Mono** or **Geist Mono**. Weight 400, `0.75rem / 12px`, tracking `+0.05em`. Used for coordinate timestamps, dimension marks (`[1200 x 800]`), and index numbers (`01`, `02`, `03`).
* **Pairing Philosophy:** Monolithic neo-grotesque family paired with a mechanical monospace companion.

---

## 3. Section-by-Section Wireframe Flow
1. **Architectural Grid Hero:**
   - Quadrant 1 (Top-Left 8 cols): Quiet, monumental statement headline + 2-line precise domain summary.
   - Quadrant 2 (Top-Right 4 cols): Index breakdown with technical spec sheet (Release version, build timestamp, architecture type).
   - Quadrant 3 (Bottom-Left 8 cols): Razor-sharp inline interactive terminal or code snippet preview.
   - Quadrant 4 (Bottom-Right 4 cols): Single monochrome CTA trigger (`h-10 px-6 border border-foreground hover:bg-foreground hover:text-background transition-colors`).
2. **Spec Table Matrix (Feature Breakdown):**
   - Clean tabular ledger with 1px border lines separating each capability row.
   - Left column: Feature identifier (`SEC-01`, `SEC-02`).
   - Middle column: Core architectural capability explanation.
   - Right column: Performance metric or benchmark status.
3. **Monochrome Artifact Gallery:**
   - High-contrast black-and-white visual renders of the interface with zero colorful gradients or drop-shadow gimmicks.
4. **Quiet Closing Terminal:**
   - Single-line input field or terminal command copy trigger (`npx create-app@latest`) with instant clipboard feedback.

---

## 4. Mobile Collapse Logic (375px Strict Audit)
* **Quadrant Stacking:** Multi-column quadrants collapse into a vertical stack with continuous 1px horizontal separator lines.
* **Table to Ledger Transform:** The 3-column spec matrix transforms into stacked key-value blocks with border-bottom dividers.
* **Typographic Consistency:** Headlines scale down smoothly while preserving their medium-weight quietness (`28px` to `24px` on mobile).
* **Zero Horizontal Overflow:** Guaranteed zero horizontal overflow with `box-border` on all 1px bordered containers.

---

## 5. Google Stitch Deterministic Prompt Formula
```text
Flat 2D desktop application screenshot, 16:9 widescreen, 1920x1080 resolution, direct front-facing view, NO 3D perspective tilt, NO laptop mockup frame, NO claymockups.
Zone Architecture: Strict Swiss architectural modular grid with 1px hairline border lines dividing distinct rectangular quadrants; Top-left commanding medium-weight neo-grotesque typography; Top-right technical specification index; Center crisp code terminal preview with monospace syntax; Bottom monochrome action trigger.
Locked Palette: Pure stark canvas #0D0D0E, subtle border lines #222226, crisp muted text #A1A1AA, primary white headers #FAFAFA, zero colorful gradients.
Typography Character: Quiet neo-grotesque sans-serif with medium weight and tight tracking, paired with precise monospace specification indices.
STRICT NEGATIVE CONSTRAINTS: NO colorful glowing gradients, NO 3D isometric shapes, NO drop shadows, NO rounded pill tags, NO marketing hype badges, pure Swiss minimalist engineering aesthetic only.
```
