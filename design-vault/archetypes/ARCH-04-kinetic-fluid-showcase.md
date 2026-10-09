# ARCH-04: Kinetic Fluid Showcase (High-Motion Dynamic SaaS)

> **Source Inspiration:** Linear App, Raycast, Spline, Apple Product Reveal Pages  
> **Visual Tone:** Forward-leaning velocity, refined kinetic energy, magnetic depth, tactile light diffusion, and precision micro-surfaces.

---

## 1. Spatial Grid & Proportions
* **Desktop Grid Structure:** Fluid 12-column canvas anchored by a centered dynamic stage (`1280px` max-width container).
  - Central Stage (Columns 2–11, 83.3% width): Hero focal point with floating interactive product perspective.
  - Edge Margins (Columns 1 & 12): Controlled lateral breathing room with subtle vertical coordinate markings.
* **Negative Space Tension:** 36% calibrated negative space. Dynamic breathing room allows high-motion interactive elements to command attention without visual noise.
* **Depth & Layering System:** Multi-plane spatial hierarchy:
  - Plane 0 (Canvas): Deep ambient gradient mesh with subtle grain texture (`radial-gradient` subtle glow at 15% opacity).
  - Plane 1 (Structural Wireframe): 1px hairline border grids with `rgba(255, 255, 255, 0.08)`.
  - Plane 2 (Active Cards): Frosted backdrop blur (`backdrop-blur-md bg-card/60 border-white/10`).
  - Plane 3 (Interactive Floating Tokens): Magnetic hover-responsive tags and floating metric pills with subtle drop shadows.

---

## 2. Typographic Architecture & Roles
* **Display Role:** **Clash Display** or **Cabinet Grotesk** (Display / H1). Weight 700, line-height `1.04`, tracking `-0.04em`. Kinetic headlines that hit with visual momentum.
* **Interface & Body Role:** **Satoshi** or **General Sans**. Smooth geometric legibility, line-height `1.6`, letter-spacing `-0.015em`.
* **Utility Role:** **Geist Mono** or **Space Mono**. Monospace technical indicators, micro-metrics, and velocity coordinates (`LATENCY: 12ms`, `FPS: 60`).
* **Pairing Philosophy:** High-impact dynamic grotesque headline paired with an ultra-fluid modern neutral body face.

---

## 3. Section-by-Section Wireframe Flow
1. **Kinetic Hero Stage:**
   - Over-sized centered headline with inline interactive pill or gradient text mask.
   - Dual high-velocity CTA: Primary solid glowing button (`h-12 px-8 rounded-full`) + secondary ghost video preview trigger.
   - Interactive 3D/video canvas focal card with subtle floating micro-inspectors pinned to its corners.
2. **Infinite Velocity Ticker:**
   - Seamless horizontal marquee with subtle edge fading (CSS mask linear gradient left & right).
   - Speed calibrated to 28s per cycle, pauses seamlessly on hover.
3. **Interactive Feature Showcase (Fluid Tabbed Viewport):**
   - Left 4 cols: Sticky vertical feature selector with active timeline progress bar indicators.
   - Right 8 cols: Fluid viewport switching interactive product mockups with buttery CSS spring transitions.
4. **Interactive Bento Grid with Kinetic Cards:**
   - Asymmetric 3-card layout: 1 large spotlight card (2-row span) with interactive canvas + 2 stacked micro-telemetry cards.
5. **High-Impact Closing Banner:**
   - Full-bleed gradient glow container with bold kinetic value proposition and one-click trial action.

---

## 4. Mobile Collapse Logic (375px Strict Audit)
* **Stacking Hierarchy:** The sticky feature selector transforms into a smooth horizontal scroll snap bar (`overflow-x-auto snap-x snap-mandatory`).
* **Interactive Canvas Fallback:** Heavy 3D/canvas elements gracefully collapse into optimized high-res WebP video clips or static crisp previews on touch viewports.
* **Touch Targets & Margins:** Button heights locked to `48px` minimum. Lateral page padding locked to `16px` to maximize screen real estate.
* **Overflow Invariant:** Strict horizontal scroll locking (`w-full overflow-x-hidden`) on all root wrappers.

---

## 5. Google Stitch Deterministic Prompt Formula
```text
Flat 2D desktop application screenshot, 16:9 widescreen, 1920x1080 resolution, direct front-facing view, NO 3D perspective tilt, NO laptop mockup frame, NO claymockups.
Zone Architecture: Top navigation with glassmorphism blur; Centered 1200px dynamic stage featuring bold kinetic grotesque typography, dual glowing action buttons, and an expansive centered interactive product canvas with floating micro-metric badges; Bottom horizontal partner marquee with soft edge-fade masks.
Locked Palette: Deep midnight canvas #080A10, glowing cyan accent #06B6D4, frosted card surfaces #101524 with subtle 1px white border at 10% opacity, crisp white text #FFFFFF.
Typography Character: Expressive geometric grotesque display titles with ultra-tight tracking, modern clean sans body text, technical monospace metric chips.
STRICT NEGATIVE CONSTRAINTS: NO cheesy cartoon illustrations, NO chaotic neon rainbows, NO cluttered dashboard charts, NO mobile phone frames, clean high-velocity software reveal page only.
```
