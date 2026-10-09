# VISUAL DECONSTRUCTION & DESIGN INGESTION PROTOCOL

> **Purpose:** The step-by-step reverse-engineering pipeline to "train" the DevOps Engineering Suite on hundreds of elite web designs, Dribbble shots, Behance portfolios, and Figma templates.
> Transforms raw visual inspiration into actionable spatial contracts, layout geometry, and responsive tokens.

---

## The Philosophy: "Deconstruct Geometry, Not Pixel Mimicry"

When an amateur tries to copy a design, they copy colors and text.
When a Silicon Valley Creative Director reverse-engineers a design, they extract **Spatial Geometry, Mathematical Proportions, and Interaction Tension**:
1. How does the grid divide space?
2. Where is the negative space concentrated?
3. How do elements behave when collapsing to a 375px mobile screen?
4. What is the single signature moment that makes this design memorable?

---

## The 4-Step Ingestion Pipeline

```
[Raw Visual / Figma File] 
       │
       ▼
[Step 1: Visual Screening (Passes the 5-Second & Anti-AI-Slop Tests)]
       │
       ▼
[Step 2: Automated AI Deconstruction Prompt (Multimodal Inspection)]
       │
       ▼
[Step 3: Layout Card Generation (Saved into design-vault/archetypes/)]
       │
       ▼
[Step 4: Master Index Registration (Instantly Available to /kickoff & Stitch)]
```

---

## Step 1: The Input Sources

You can feed the vault from 4 primary sources:

1. **Dribbble & Behance Shots**: High-resolution screenshots of concepts, dashboard interactions, and editorial layouts.
2. **Awwwards & Siteinspire Production Sites**: Live URL screenshots capturing real, responsive production sites.
3. **Figma Community Templates & UI Kits**:
   - UI Kits (e.g., Untitled UI, Relume, Craftwork, bespoke agency kits).
   - Component frames (Navbars, Heroes, Pricing Tables, Feature Bento Cards).
4. **WordPress & Custom Theme Layouts**:
   - High-converting section flows and lander architecture.

---

## Step 2: The Automated AI Deconstruction Prompt

When you have a screenshot, image file, or Figma frame, paste the image into your AI chat (Claude 3.7 Sonnet, Gemini 2.5 Pro, or Antigravity) along with this prompt:

```text
You are an elite Creative Director and Principal UI/UX Architect.
Inspect this design reference image/screenshot with deep forensic precision.
Do NOT describe superficial colors or generic marketing text.
Extract the structural design DNA and reverse-engineer this into a production-grade Design Archetype Specification.

Generate the output following this exact Markdown schema:

---
ARCHETYPE TITLE: [Name of the layout, e.g. "Kinetic Editorial Showcase"]
SOURCE REFERENCE: [Dribbble / Behance / Figma Kit / Live URL]
PRIMARY VISUAL CHARACTER: [3-sentence summary of the aesthetic atmosphere and architectural tone]

1. SPATIAL GRID & PROPORTIONS
- Desktop Grid Structure: [e.g. 12-column asymmetric, 8/4 split, or 4-row bento]
- Viewport Max Width: [e.g. 1440px container, 1600px edge-bleed, or 1280px boxed]
- Negative Space Density: [High (40%+ whitespace), Medium (20-30%), or Dense (<15%)]
- Signature Layout Tension: [What makes this layout unforgettable? e.g. "Overlapping headline crossing container boundary", "Asymmetric offset cards", "Floating glass inspector"]

2. TYPOGRAPHIC ARCHITECTURE & ROLES
- Display Role: [Character description, weight, line-height ratio, letter-spacing]
- Interface/Body Role: [Legibility traits, scale ratio]
- Tabular/Utility Role: [Monospace or neutral grotesk usage]
- Non-Generic Pairing Recommendation: [e.g. Syne + Plus Jakarta Sans, Instrument Serif + Inter]

3. SECTION-BY-SECTION WIREFRAME FLOW
- Section 1 (Hero): [Layout geometry, focal point, CTA placement]
- Section 2 (Social Proof / Proof Strip): [Horizontal density, styling]
- Section 3 (Core Feature / Narrative): [Bento layout, asymmetric columns, or visual showcase]
- Section 4 (Conversion / Final Gate): [Friction-reducing form, pricing matrix, or bold single action]

4. MOBILE COLLAPSE LOGIC (375px STRICT AUDIT)
- Stacking Hierarchy: [How does multi-column geometry collapse to 1 column?]
- Typography Scaling: [H1 reduction percentage and line-height tightening]
- Touch Target Preservation: [Button and interactive hitboxes >= 44x44px]
- Zero Horizontal Overflow: [Exact container constraints]

5. GOOGLE STITCH DETERMINISTIC FORMULA
Write the exact 5-part Google Stitch prompt that reproduces this layout structure without hallucinating generic AI template slop:
- Viewport Lock: [Flat 2D, 16:9 widescreen, 1920x1080]
- Zone Architecture: [Explicit pixel/percentage spatial zones]
- Named Element Inventory: [Concrete buttons, cards, forms]
- Locked Palette Guidance: [Dominant surfaces, CTA accent, text contrast]
- Strict Negative Constraints: [Banned elements: NO crypto charts, NO floating bubbles, NO generic templates]
---
```

---

## Step 3: Save to the Vault

Save the output as a `.md` file inside:
- `design-vault/archetypes/` (for page and screen layouts)
- `design-vault/figma-kits/` (for Figma template components)
- `design-vault/wordpress-patterns/` (for high-converting lander flows)

---

## Step 4: Stealth Ingestion (How Agents Use It)

Once saved in `design-vault/`:
* The `/kickoff` skill automatically draws on the spatial layouts during Stage 3 (Visual Intake) and Stage 5 (Google Stitch Prompts).
* The `/architect` skill references the wireframe geometry when building feature blueprints.
* **The Stealth Rule**: The agent does **not** mention "I am using archetype file X" to the user. It naturally recommends:
  > *"For your product, I propose an asymmetric 8/4 grid layout with a sticky contextual metadata rail on the left and a fluid bento showcase on the right. This gives us 40% negative space on desktop and collapses into a clean card stream on mobile."*
