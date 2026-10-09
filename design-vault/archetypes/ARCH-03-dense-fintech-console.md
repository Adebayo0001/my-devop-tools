# ARCH-03: Dense Operator Console (Fintech, Trading & Mission-Critical Ops)

> **Source Inspiration:** Bloomberg Terminal, Stripe Dashboard, Retool, Datadog Console, TradingView  
> **Visual Tone:** Extreme information density, sub-second glanceability, keyboard-first velocity, zero decorative fluff.

---

## 1. Spatial Grid & Proportions
* **Desktop Grid Structure:** 3-Pane Persistent Spatial Split:
  - Left Pane (`260px` fixed): Collapsible icon-and-label system navigation tree.
  - Center Stage (Fluid 65% width): Tabular data grid with sticky header, multi-column sorting, and filter chips.
  - Right Inspector (`380px` fixed): Slide-out contextual details panel, audit logs, and action drawer.
* **Viewport Max Width:** 100% full-bleed edge-to-edge desktop viewport (`1920px` optimized).
* **Negative Space Tension:** Ultra-dense micro-spacing (4px–8px cell gaps, 36px row heights). Whitespace is tightly controlled to maximize visible rows above the fold.
* **Signature Tension:** Muted grayscale surface contrast punctuated by sharp functional status dots (emerald green for active, amber for pending, crimson for failed).

---

## 2. Typographic Architecture & Roles
* **Display Role:** **Plus Jakarta Sans** or **Inter**. Weight 600, `20px`–`24px` compact section headers.
* **Interface & Body Role:** **Inter** or **Geist**. Compact `13px / 18px` cell typography with strict vertical alignment.
* **Tabular & Utility Role:** **JetBrains Mono** or **Geist Mono**. Used for all monetary figures, currency codes, UUIDs, timestamps, and hashes with tabular lining figures (`font-variant-numeric: tabular-nums`).

---

## 3. Section-by-Section Wireframe Flow
1. **Utility Header:** Global search bar (`⌘K`), environment switcher (`Production / Sandbox`), real-time ping indicator (`14ms`), user avatar badge.
2. **Metric Summary Strip:** 4 compact cards displaying Volume, Settlement Rate, Active Sessions, and Exception Count with sparkline micro-trends.
3. **Primary Data Grid:**
   - Multi-column sortable table with checkbox row selection, column reordering, and sticky column freezing.
   - Bulk action floating bar appearing upon selecting $\ge 1$ rows.
4. **Contextual Action Inspector:**
   - Tabs: `Overview`, `JSON Payload`, `Audit Trail`.
   - Primary action buttons: `Retry Event`, `Export CSV`, `Revoke Token`.

---

## 4. Mobile Collapse Logic (375px Strict Audit)
* **Stacking Hierarchy:** The 3-pane layout transforms into a single fluid view with bottom-sheet drawer navigation.
* **Table to Card Conversion:** Wide tabular columns automatically transform into stacked card units on mobile, preserving key metrics in a compact 2-column key-value layout.
* **Right Inspector:** Converts into a full-height slide-over modal triggered on row tap.

---

## 5. Google Stitch Deterministic Prompt Formula
```text
Flat 2D desktop application screenshot, 16:9 widescreen, 1920x1080 resolution, direct front-facing view, NO 3D perspective tilt, NO laptop mockup frame, NO claymockups.
Zone Architecture: Zone 1 Left 260px navigation rail with icon labels; Zone 2 Center main workspace displaying high-density financial data table with sticky headers; Zone 3 Right 380px detail inspector drawer.
Locked Palette: Dark graphite canvas #0D0E12, elevated panel surface #151820, subtle border grid #222634, action blue #2563EB, success green #10B981, crisp tabular text #E2E8F0.
Typography Character: Compact modern interface typography, monospace tabular figures for all currency and timestamps.
STRICT NEGATIVE CONSTRAINTS: NO floating bubbles, NO cartoon graphics, NO marketing landing page hero cards, NO decorative gradients, clean professional high-density operator software only.
```
