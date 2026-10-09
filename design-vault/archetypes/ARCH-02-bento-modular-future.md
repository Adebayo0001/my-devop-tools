# ARCH-02: Bento Modular Future (Hardware & Modern Developer SaaS)

> **Source Inspiration:** Apple Event Keynotes, Linear App, Raycast, Vercel, Teenage Engineering  
> **Visual Tone:** Tactile precision, modular clarity, micro-elevations, deliberate dark mode depth, engineering excellence.

---

## 1. Spatial Grid & Proportions
* **Desktop Grid Structure:** 12-column dynamic bento grid with asymmetric aspect ratios:
  - Row 1: Large Focal Card (8 cols) + Secondary Action Card (4 cols).
  - Row 2: 3 Equal Modular Feature Cards (4 cols + 4 cols + 4 cols).
  - Row 3: Stat Strip (6 cols) + Interactive Code/Terminal Preview (6 cols).
* **Viewport Max Width:** `1280px` boxed container for tight, focused visual coherence.
* **Negative Space Tension:** 24px uniform card gaps; inner card padding is generous (`32px`–`40px`), allowing individual widgets to breathe.
* **Signature Tension:** Subtle gradient hairline borders (`border border-white/10`) with ambient glow (`shadow-[0_0_50px_-12px_rgba(255,255,255,0.05)]`) on hovered cards.

---

## 2. Typographic Architecture & Roles
* **Display Role:** **Outfit** or **Geist**. Weight 600 / Bold, tracking `-0.03em`, sharp optical geometry.
* **Interface & Body Role:** **Geist** or **Inter**. Crisp neutral sans, tall x-height, neutral letterforms.
* **Utility Role:** **Geist Mono** or **JetBrains Mono**. Code syntax, keyboard shortcuts (`⌘K`), tabular analytics.

---

## 3. Section-by-Section Wireframe Flow
1. **Hero Section:**
   - Centered high-impact headline + 2-sentence value proposition + command bar input (`⌘K to search or start`).
   - Floating interactive product preview card with simulated tab bar.
2. **The Signature Bento Grid:**
   - Card 1 (Span 8): Real-time interactive canvas with simulated hardware or chart control.
   - Card 2 (Span 4): Feature spotlight with animated toggle switch.
   - Cards 3, 4, 5 (Span 4 each): Discrete feature deep-dives with micro-illustrations and status chips.
3. **Interactive Metric / Terminal Strip:**
   - Left 6 cols: 3 tabular performance metrics with percentage delta indicators.
   - Right 6 cols: Live syntax-highlighted code block with instant copy button.

---

## 4. Mobile Collapse Logic (375px Strict Audit)
* **Stacking Hierarchy:** Bento grid collapses cleanly into a single vertical stream. The 8-col focal card remains at the top, maintaining a 16:9 ratio.
* **Typography Curve:** Hero H1 scales from `48px` to `32px`.
* **Touch Targets:** All card action buttons and command inputs maintain `min-h-[48px]`.
* **Card Padding Adjustment:** Inner card padding adjusts from `36px` on desktop down to `24px` on mobile to maximize viewport efficiency.

---

## 5. Google Stitch Deterministic Prompt Formula
```text
Flat 2D desktop application screenshot, 16:9 widescreen, 1920x1080 resolution, direct front-facing view, NO 3D perspective tilt, NO laptop mockup frame, NO claymockups.
Zone Architecture: Top centered headline with command search bar; Main body structured as an asymmetric bento grid with one dominant 60% widescreen card and smaller modular cards with 1px hairline borders.
Locked Palette: Deep midnight canvas #08090C, elevated bento surface #10121A, subtle border stroke #1E2230, high-intent action accent #3B82F6, crisp white text #F1F5F9.
Typography Character: Clean geometric tech sans-serif headings, high-legibility interface copy, monospaced keyboard shortcuts and code blocks.
STRICT NEGATIVE CONSTRAINTS: NO messy crypto tickers, NO floating bubbles, NO cartoon characters, NO 3D isometric tilt, clean minimalist modular software only.
```
