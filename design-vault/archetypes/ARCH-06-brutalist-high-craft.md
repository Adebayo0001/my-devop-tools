# ARCH-06: Brutalist High-Craft (Raw Elegance & Cult Developer Aesthetic)

> **Source Inspiration:** Playful, MSCHF, Teenage Engineering, Gumroad redesign, Poolsuite, Cargo Site of the Day  
> **Visual Tone:** Unapologetic individuality, deliberate structural collisions, high-contrast black borders, tactile physical hardware cues, raw neo-brutalist charm.

---

## 1. Spatial Grid & Proportions
* **Desktop Grid Structure:** Asymmetric offset grid with deliberate visual tension and overlapping elements.
  - Border weight: Visible **2px or 3px solid borders** (`border-2 border-foreground`).
  - Hard shadows: Hard unblurred box shadows (`shadow-[4px_4px_0px_0px_rgba(0,0,0,1)]` or dark accent).
* **Negative Space Tension:** 28% dense whitespace. High information vitality, physical hardware stickers, stamp tags, and deliberate visual collisions.
* **Tactile Surface Mechanics:**
  - Buttons depress visibly on click (`active:translate-x-[2px] active:translate-y-[2px] active:shadow-none`).
  - Subtle noise texture overlay (2% SVG noise pattern).
  - High-contrast corner accents and technical bracket indicators (`[+ -]`).

---

## 2. Typographic Architecture & Roles
* **Display Role:** **Space Grotesk** or **Druk Wide** or **Syne** (Display / H1). Weight 800 / ExtraBold, line-height `0.98`, tracking `-0.05em`. Raw, explosive typography that demands immediate attention.
* **Interface & Body Role:** **Plus Jakarta Sans** or **DM Sans**. Weight 500, line-height `1.5`, letter-spacing `-0.01em` for readable grounding amidst bold borders.
* **Utility Role:** **Space Mono** or **Commit Mono**. Bold uppercase labels, boxed tags (`[BETA v1.4]`, `STATUS: ONLINE`), and raw technical stamps.
* **Pairing Philosophy:** Heavy industrial brutalist display paired with structured geometric body and mechanical monospace utility.

---

## 3. Section-by-Section Wireframe Flow
1. **Colliding Hero Showcase:**
   - Massive 72px headline with an intentional slight overlap over a bordered preview card.
   - Distinctive physical-feeling action button with 3px border and 4px solid shadow.
   - Interactive tactile toggle switches resembling physical audio synthesizer dials or metal toggle switches.
2. **Sticker / Stamp Credibility Strip:**
   - Instead of a generic logo row, logos are framed inside individual physical "collector cards" or monochrome stamps with slight alternating rotation angles (`-1deg`, `+1.5deg`).
3. **High-Contrast Feature Blocks:**
   - 3-column masonry with thick 2px borders, high-contrast accent backgrounds (e.g., safety yellow, electric lime, or stark monochrome), and raw typography.
4. **Physical Receipt / Spec Summary:**
   - Bottom conversion container styled as a digital perforated receipt or hardware specification sheet with monospace itemized breakdown and bold checkout trigger.

---

## 4. Mobile Collapse Logic (375px Strict Audit)
* **Shadow and Offset Simplification:** Hard shadows scale from `4px` to `2.5px` to prevent viewport overflow.
* **Rotations Neutralized:** Rotated stamp cards straighten to `rotate-0` on screens `<= 640px` to maintain strict column alignment.
* **Button Stacking:** Action buttons stretch to full container width with large `h-14` tactile click zones.
* **Horizontal Safety Margin:** Strict `px-4` padding with `overflow-x-clip` on parent containers.

---

## 5. Google Stitch Deterministic Prompt Formula
```text
Flat 2D desktop application screenshot, 16:9 widescreen, 1920x1080 resolution, direct front-facing view, NO 3D perspective tilt, NO laptop mockup frame, NO claymockups.
Zone Architecture: High-craft neo-brutalist software interface with 2px solid black borders, hard unblurred drop shadows, massive oversized grotesque display typography, tactile physical synthesizer-style toggles, and itemized hardware specification cards.
Locked Palette: Stark canvas #F4F4F0 (warm paper white) or deep slate #121316, high-contrast 2px dark borders #000000, punchy accent #FF5A1F (safety orange) or electric lime, dark ink text #0A0A0A.
Typography Character: Ultra-heavy grotesque display headings with tight negative tracking, clear geometric sans body text, stamped uppercase monospace labels.
STRICT NEGATIVE CONSTRAINTS: NO fuzzy gradient drop shadows, NO generic AI purple glow, NO template corporate stock vectors, raw high-craft physical neo-brutalist web application layout only.
```
