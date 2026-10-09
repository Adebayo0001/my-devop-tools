# ONBOARD-SUITE: High-Impact Visual Onboarding & Split Hero Layouts (10 Screen Architectures)

> **Source Reference:** Figma Landing Page & Onboarding Kit Master Collection  
> **Reference Asset:** `design-vault/reference-images/auth-landing-screens-batch2.png`  
> **Visual Tone:** High-converting landing & sign-up hybrids featuring frosted glassmorphism, cinematic photography splits, contextual form tooltips, and architectural wireframe anchors.

---

## Master Taxonomy: The 10 Onboarding Archetypes

| Screen ID | Architecture Archetype | Core Spatial Mechanics | Best Fit Use Cases | Mobile Collapse (375px) |
|---|---|---|---|---|
| **ONBOARD-01** | **Frosted Glass Panel on 3D Discs** | Floating frosted glass card (`backdrop-blur-md`) over stacked 3D pastel circular discs | Creative agency portfolios, Design tools, Spatial software | Discs scale down 50% into ambient background; glass card expands to 100vw |
| **ONBOARD-02** | **Vibrant Cyan Travel Split + Floating Card** | Cyan sky with floating hot air balloons + right-anchored floating white card | Travel booking, Outdoor platforms, Adventure brands | Cyan sky stays as top 220px header; card stacks below |
| **ONBOARD-03** | **Dramatic Balloon Photography Split** | Left 50% high-res travel photography / Right 50% social-first registration form | Airlines, Hospitality, Event ticketing | Photo stacks on top with 16:9 aspect ratio; form flows below |
| **ONBOARD-04** | **Minimalist Form + Wireframe Iconography**| Clean white form on left + geometric vector wireframe on right + full site directory | Enterprise SaaS, Engineering platforms, DeepTech | Wireframe graphic hides on mobile; full footer links stack into accordions |
| **ONBOARD-05** | **Streaming Registration + reCAPTCHA** | Focused vertical column with Facebook/Google/Twitter auth + reCAPTCHA verification | Live streaming, Video platforms, Gaming portals | Social auth buttons stack; reCAPTCHA preserves responsive width |
| **ONBOARD-06** | **Cinematic Road Trip Split** | Left 50% sign-up form / Right 50% yellow camper van on desert highway through canyon | Vanlife, Automotive, Road trip booking, Lifestyle brands | Highway photo stacks at top with dark gradient fade; form below |
| **ONBOARD-07** | **Interactive Form Input Tooltip Guide** | Centered form with floating dark tooltip popover anchored to active input field | Complex registration, KYC verification, Security apps | Tooltip displays inline below active input on mobile instead of floating right |
| **ONBOARD-08** | **Botanical Moody Lotus Split** | Left 40% dark water lotus flower photography / Right 60% clean auth form | Beauty, Mindfulness, Wellness, Sustainable luxury | Lotus photo becomes top banner; form takes full mobile width |
| **ONBOARD-09** | **Fluid Chromatic Wave Backdrop** | Wavy cyan/magenta dynamic mesh canvas + centered white dialog modal | Generative AI, Audio/Music tech, Creative SaaS | Mesh canvas acts as background; modal fills viewport |
| **ONBOARD-10** | **Cyberpunk Circuit Grid Scrim** | Dark motherboard grid with glowing red node lines + centered high-contrast modal | Cybersecurity, Cloud security, Developer CLI tools | Grid lines dim to prevent contrast issues with text |

---

## Key Signature Mechanics

### ONBOARD-07: The Contextual Input Tooltip Popover
* **Spatial Tension:** A dark obsidian tooltip bubble (`bg-slate-900 text-white text-xs rounded-lg py-2 px-3 shadow-xl relative`) is mathematically pinned to the right edge of the active input:
  - Arrow anchor points directly to the input field.
  - Microcopy explains: *"We will send you an activation email to verify your address before unlocking your workspace."*
  - **Conversion impact:** Eliminates user drop-off caused by confusion around verification requirements.

### ONBOARD-01: Frosted Glassmorphism on 3D Discs
* **Spatial Tension:**
  - Background: Multi-plane pastel abstract discs stacked with realistic directional drop shadows.
  - Foreground: Frosted glass panel with `backdrop-filter: blur(16px)`, border `1px solid rgba(255, 255, 255, 0.4)`, and subtle specular highlight on the top edge.

---

## Google Stitch Deterministic Prompt Formula

### Stitch Prompt for Frosted Glass on 3D Discs (ONBOARD-01):
```text
Flat 2D desktop application screenshot, 16:9 widescreen, 1920x1080 resolution, direct front-facing view, NO 3D perspective tilt, NO laptop mockup frame, NO claymockups.
Zone Architecture: Left 50% frosted glassmorphism panel with smooth blurred transparency, containing bold heading "Design with us / Explore with us", single-line email input, and pill action button; Right 50% elegant stacked 3D pastel circular discs with soft directional shadows on a clean gradient canvas.
Locked Palette: Frosted white surface rgba(255,255,255,0.7), soft pastel coral and blue disc accents, dark charcoal text #0F172A.
Typography Character: Modern architectural sans-serif headings with tight line-height, crisp micro-copy.
STRICT NEGATIVE CONSTRAINTS: NO laptop frames, NO mobile mockups, NO messy neon colors, NO cartoon stickers, elegant high-end design tool reveal screen only.
```
