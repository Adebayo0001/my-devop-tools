# High-End Web Design Rules — AI Build Framework

**Purpose:** Paste this into any AI coding tool (Claude Code, Cursor, Codex, v0, etc.) at the start of a web/app project. It exists to stop AI builders from defaulting to generic, templated, inaccessible output, and to push toward the standard of a paid design studio.

---

## 1. Anti-Template Rules (kill the "AI-generated" look)

AI tools cluster around a small number of lazy defaults. Ban these unless the brief specifically calls for them:

- **The cream-and-terracotta look:** warm cream background (~#F4F1EA) + high-contrast serif + terracotta/clay accent (~#D97757). This is now recognizable as an AI tell.
- **The near-black-and-neon look:** near-black background with a single acid-green or vermilion accent, used regardless of subject matter.
- **The broadsheet look:** hairline rules, zero border-radius, dense newspaper columns, used as a default rather than a considered choice.

**Rule for the AI:** Before designing anything, it must name the actual subject, audience, and the page's single job — then derive every visual choice from that, not from what's statistically common in training data. If a choice would look identical on a different brand's site, it's wrong.

**Two-pass process to require:**
1. **Plan first, in writing:** a compact token system — 4–6 named hex colors, 2–3 typefaces with defined roles, a layout concept (described in prose + ASCII wireframe if useful), and one "signature element" the page will be remembered by.
2. **Self-critique before building:** run the same brief mentally as if for a different brand — if the output would be indistinguishable, revise the plan and note what changed and why. Only then write code.

---

## 2. Typography System

Typography carries the personality of the entire page — treat it as a primary design decision, not a formatting afterthought.

- **Minimum 2, ideally 3 type roles:**
  - *Display face* — characterful, used with restraint (headlines, hero moments only)
  - *Body face* — highly legible, complementary to the display face (not the same family)
  - *Utility face* — for captions, labels, data, timestamps (can be monospace or a neutral grotesk)
- **Never pair the "safe default" combo** every AI tool reaches for by default (e.g., Inter + Inter, or a generic serif + generic sans with no relationship). The pairing should be a deliberate contrast or a deliberate harmony — not a coincidence.
- **Define an actual type scale** — not just semantic tags (h1–h6) with browser defaults. Specify sizes, weights, line-heights, and letter-spacing at each level. A scale should feel intentional at every breakpoint, not just proportionally shrunk.
- **Line length:** body copy should sit around 45–75 characters per line for readability — enforce with `max-width` on text blocks, not full-bleed paragraphs.
- **Never sacrifice legibility for style.** Display faces at small sizes, low contrast, or tight tracking on body text are common high-end-looking-but-broken mistakes.

---

## 3. Color System

- **4–6 named, hex-defined colors** — not "primary/secondary/accent" left vague. Name them by role: background, surface, text-primary, text-secondary, accent, accent-alt.
- **Derive the palette from the subject**, not from a mood board of "what looks premium." A fintech product and a chef's portfolio should never default to the same palette logic.
- **Contrast is a design constraint, not an afterthought** — every color pairing used for text must be checked against WCAG AA before it's accepted (see Accessibility section).
- **Dark mode, if included, is a second deliberate palette** — not an automatic CSS invert. Contrast and hierarchy must be re-verified, not assumed to carry over.

---

## 4. Layout & Grid Principles

- **Bento grids, broken grids, and asymmetric layouts are tools, not requirements.** Use bento only when content is genuinely made of discrete, comparably-weighted chunks (features, stats, product specs). Using it purely for visual interest is decoration masquerading as structure.
- **Structural devices must encode real information.** Numbered steps (01/02/03), dividers, eyebrows, and labels should only appear if they represent something true — a real sequence, a real category, a real hierarchy. If content isn't actually a sequence, don't number it.
- **Whitespace is a decision, not a leftover.** Generous spacing near a signature element; tighter, denser spacing in data-heavy or utility areas. Spacing should shift intentionally as the page's purpose shifts section to section.
- **One signature moment per page.** Identify the single element the page should be remembered by (a hero interaction, an unusual transition, a distinctive layout break) and keep everything else disciplined around it. Spending "boldness" everywhere reads as noisy, not premium.
- **Match complexity to the vision.** A maximalist direction needs elaborate, well-executed detail throughout. A minimalist direction needs near-obsessive precision in spacing and alignment — minimalism executed sloppily looks cheap, not clean.

---

## 5. Motion & Interaction

- **Motion should be orchestrated, not scattered.** One well-considered sequence (page load, scroll-triggered reveal, or a hero interaction) reads as more premium than a dozen small hover effects sprinkled everywhere.
- **Every animation must justify itself.** If it doesn't clarify hierarchy, guide attention, or reinforce the brand's character, cut it. Excess micro-animation is one of the most common AI "tells."
- **Respect `prefers-reduced-motion` unconditionally.** Provide a non-animated fallback for every meaningful transition — this is a hard requirement, not optional polish.
- **Micro-interactions (magnetic buttons, cursor states, hover feedback) should feel like they belong to this brand specifically** — generic bounce/scale-on-hover applied everywhere is template behavior.
- **Loading and transition states are part of the design**, not an engineering afterthought — skeleton states, fade-ins, and progressive reveals should be considered at design time.

---

## 6. Accessibility Rules (non-negotiable — this is what "for everyone" means)

This is the section most often skipped in AI-generated ("vibe coded") sites, and it's the clearest signal of amateur vs. professional work.

**Color & contrast**
- Text contrast minimum **4.5:1** (normal text) and **3:1** (large text ≥18pt/24px bold, and UI components/icons), per WCAG 2.1 AA.
- Never rely on color alone to convey meaning (errors, status, required fields) — pair with icon, text, or pattern.

**Keyboard & focus**
- Every interactive element must be reachable and operable via keyboard alone — no mouse-only interactions.
- Visible focus states on all interactive elements — never remove `outline` without providing a clear replacement.
- Logical tab order that matches visual/reading order.
- Provide a "skip to main content" link for keyboard/screen-reader users.

**Semantic structure**
- Use real semantic HTML (`<button>`, `<nav>`, `<header>`, `<main>`, `<footer>`) — divs styled to look like buttons are not buttons.
- Heading hierarchy (`h1`→`h2`→`h3`) must reflect actual document structure, not be chosen for visual size.
- Landmarks and ARIA roles used only where semantic HTML can't cover the case — ARIA is a supplement, not a substitute.

**Images, icons, and media**
- Alt text on every meaningful image; empty `alt=""` for purely decorative images.
- `aria-label` on icon-only buttons/links (a trash icon with no visible text still needs a spoken label).
- Captions/transcripts for video and audio content where applicable.

**Forms & dynamic content**
- Every input has a visible, associated `<label>` — placeholder text is not a label.
- Errors are announced (aria-live regions), specific about what went wrong, and specific about how to fix it.
- Required fields marked in a way that isn't color-only.

**Responsive & scalable**
- Fully responsive down to real mobile widths (test at 375px, not just a resized browser window).
- Layouts must not break at 200% browser zoom — avoid fixed pixel values that trap text size.
- Touch targets minimum ~44×44px on mobile.

**Motion & sensory**
- No content that flashes more than 3 times per second (seizure risk).
- Reduced-motion fallback for every meaningful animation (see Motion section above).

---

## 7. Content & Copy Rules

Words are design material, not decoration — treat copy with the same intentionality as spacing and color.

- **Write from the user's side of the screen.** Name things by what people control and recognize ("Save changes"), never by internal system logic ("Submit config").
- **Active voice, plain verbs, no filler.** Be specific rather than clever — specificity is what makes an interface trustworthy.
- **Vocabulary stays consistent through a whole flow.** A button labeled "Publish" should lead to a confirmation that says "Published" — not "Success!" or "Done."
- **Empty states are invitations, not dead ends.** Explain what's missing and what action fills it.
- **Error states are direct, not apologetic or vague.** State what happened and exactly how to fix it — never a generic "Something went wrong."
- **Every element does exactly one job.** A label labels. An example demonstrates. Nothing quietly does double duty and confuses the user about what they're looking at.

---

## 8. Process Rules to Give the AI Builder

Tell the AI to work in explicit passes, not one-shot generation:

1. **Ground the brief** — name the subject, audience, and the page's single job before any design decision is made.
2. **Plan before building** — produce the token system (color, type, layout, signature element) as a written plan first.
3. **Self-critique against genericness** — check the plan against "would this look the same for any other brand?" before writing code.
4. **Build to a quality floor silently, without being asked each time:**
   - Fully responsive
   - Accessible (per Section 6)
   - Reduced-motion respected
   - Semantic HTML throughout
5. **Watch CSS specificity conflicts** — type-based selectors (`.section`) and element-based selectors (`.cta`) can silently cancel each other, especially on spacing/padding between sections. Flag and resolve, don't leave to chance.
6. **Screenshot and self-review before calling it done** — visually check hierarchy, spacing, and whether the "one signature element" actually reads as intended.
7. **Cut one thing before shipping.** Before finalizing, deliberately remove one decorative element — if the design survives (or improves), it wasn't earning its place.

---

## 9. Pre-Launch QA Checklist (quick reference)

- [ ] No default AI palette (cream/terracotta, near-black/neon, broadsheet) unless deliberately chosen
- [ ] 2–3 typefaces with clear, distinct roles and a real type scale
- [ ] 4–6 named colors, all text pairings pass 4.5:1 / 3:1 contrast
- [ ] One clear signature element; everything else disciplined around it
- [ ] Bento/broken grids used only where content structure justifies them
- [ ] Motion is orchestrated, not scattered; reduced-motion fallback works
- [ ] Full keyboard navigation + visible focus states
- [ ] Semantic HTML + correct heading hierarchy
- [ ] Alt text / aria-labels on all images and icon-only controls
- [ ] Forms have real labels; errors are specific and announced
- [ ] Responsive tested at real mobile width (375px) and 200% zoom
- [ ] Copy uses active voice, consistent vocabulary, no vague errors/empty states
- [ ] Screenshot self-review completed; one decorative element deliberately cut

---

## 10. AI Visual Mockup Generation Protocol (Google Stitch & Diffusion Tools)

When generating UI mockups with Google Stitch or AI design generators, models naturally drift toward generic, cluttered SaaS dashboards (hallucinating unwanted analytics charts, crypto graphs, and random floating bubbles). To force AI tools to produce human-grade, minimalist, production-ready interfaces:

### Step 10.1: Mandatory Pre-Prompt Project Visual Overview
Before generating the prompt for the first screen, output a concise **Project Visual Overview** summarizing:
- Product core mission and user persona.
- Locked color tokens (Surface, Cards, Primary CTA, Accent, Text).
- Visual atmosphere, layout density, and emotional mood.
This grounds the generator and eliminates random styling drift.

### Step 10.2: The Calibrated Deterministic Prompt Formula (Screen 1 Only)

Every Stitch prompt must contain these 6 structural blocks:

1. **Viewport & Framing Lock**:
   - Specify: `Flat 2D desktop application screenshot, 16:9 widescreen, 1920x1080 resolution, Windows 11 studio software, direct front-facing view, NO 3D perspective tilt, NO laptop mockup frame, NO claymockups.`
2. **Strict Layout Zones (Zone Architecture)**:
   - Divide the canvas into explicit proportions: e.g. `Zone 1: Left 280px navigation rail. Zone 2: Center 60% widescreen preview stage. Zone 3: Right 360px inspector sidebar.`
3. **Explicit Element Inventory**:
   - Explicitly enumerate the exact buttons, labels, and widgets. If an element is not listed, the model must not add it. Keep it concise; avoid over-describing or fighting the prompt.
4. **Locked Palette & Token Enforcement**:
   - List the exact hex values from `design.md` (e.g. `#08090B` background, `#13171F` surfaces, `#D92534` primary CTA, `#F59E0B` tags, `#F8FAFC` text).
5. **No Font Names (Typography Style Descriptors Only)**:
   - Strictly forbid specifying font family names (e.g. "use Syne and Plus Jakarta Sans"). Instead, describe rendering character: `clean geometric sans-serif headings, high-legibility interface typography, crisp tabular metrics`. Let Google Stitch choose and render typography naturally without diffusion distortion.
6. **Mandatory Negative Constraints (Negative Prompt)**:
   - `STRICT NEGATIVE CONSTRAINTS: NO analytics charts, NO bar charts, NO line graphs, NO floating decorative bubbles, NO colorful gradients, NO mobile app frames, NO cluttered widgets, NO crypto tickers, clean minimalist professional software only.`

---

*Reusable across projects — pair this file with your existing tech-stack rules file so the AI builder has both structural (stack, journey logic) and aesthetic/accessibility (this file) guardrails in every session.*

