# AUTH-SUITE: Master Authentication & Onboarding Layout Registry (10 Screen Architectures)

> **Source Reference:** Figma Landing & Auth UI Kit / Community Master Collection  
> **Reference Asset:** `design-vault/reference-images/auth-onboarding-10-screens.png`  
> **Visual Tone:** High-converting, frictionless sign-up and onboarding suites ranging from 3D obsidian split stages to multi-step KYC wizards and ambient aurora glass modals.

---

## Master Taxonomy: The 10 Authentication Screen Archetypes

| Screen ID | Architecture Archetype | Core Spatial Mechanics | Best Fit Use Cases | Mobile Collapse (375px) |
|---|---|---|---|---|
| **AUTH-01** | **Split 50/50 3D Obsidian Stage** | Left 50% crisp form / Right 50% dark 3D floating geometric cubes | Web3, AI Infrastructure, Hardware, Creative Tech | 3D visual collapses into a subtle header banner; form takes 100% width |
| **AUTH-02** | **Full-Bleed Aurora Mesh + Right Panel** | Vibrant ambient chromatic gradient with right-anchored floating card | Consumer SaaS, AI Generative Apps, Lifestyle, Media | Aurora gradient remains as top ambient header; card becomes full-width sheet |
| **AUTH-03** | **Iridescent Hero Sphere Split with Nav** | Persistent top utility navbar + 50/50 split with floating chromatic bubble | SaaS Platforms, Developer Cloud, Modern Fintech | Top nav collapses to hamburger; sphere scales down 40% above the form |
| **AUTH-04** | **Centered Glass Modal on Vignette Scrim** | Moody dark plum background + centered floating white modal dialog with close trigger | Quick-auth dialogs, Paywall triggers, Modal overlays | Modal fills 100vw/100vh with corner close 'X' button; zero horizontal scroll |
| **AUTH-05** | **Multi-Step Onboarding Stepper (KYC)** | Centered modal with step counter ("Step 1 of 3"), country flag dialer & DOB dropdowns | FinTech, Banking, Regulated SaaS, Telehealth | Inputs stack vertically; DOB 3-dropdown grid collapses to native datepicker |
| **AUTH-06** | **Segmented Dual-Tab Switcher Modal** | Floating card with integrated top pill tab `[Sign In \| Sign Up]` on aurora scrim | Community portals, Forums, Content platforms | Segmented tab stretches to full width; social buttons stack vertically |
| **AUTH-07** | **Minimalist Horizontal Progress Wizard** | Stark white canvas + multi-step horizontal line stepper `(1) ─── (2) ─── (3)` | Enterprise self-serve, Complex setups, B2B SaaS | Stepper changes from horizontal text labels to compact step dots `● ── ○ ── ○` |
| **AUTH-08** | **Centered Column with Multi-OAuth Strip** | Focused narrow column form + bottom flat OAuth pill strip (Apple, Google, Meta) | Minimalist consumer tools, Newsletters, Micro-SaaS | Inputs expand to full touch targets (48px); social pills wrap or stack |
| **AUTH-09** | **Asymmetric Form + Architectural Wireframe** | Left form with company/role selectors + right architectural vector sculpture | B2B Enterprise, Engineering tools, DevSecOps | Wireframe graphic hides or scales down as a subtle top watermark |
| **AUTH-10** | **Inverted High-Contrast Split (Obsidian/White)** | Left 40% dark manifesto card ("Design with us") + Right 60% clean input canvas | Creative tools, Design marketplaces, Agency portals | Left dark card becomes top banner with white typography; form flows below |

---

## Detailed Specifications: Screen by Screen

### AUTH-01: Split 50/50 3D Obsidian Stage
* **Spatial Grid:** 2-column equal split (`grid grid-cols-1 lg:grid-cols-2 min-h-screen`).
  - Left Column (Form): `max-w-md mx-auto py-12 px-8 flex flex-col justify-center`.
  - Right Column (Showcase): `bg-[#0E1015] relative overflow-hidden flex items-center justify-center`. Houses dark obsidian 3D floating cubes with ambient amber light point reflections.
* **Typographic Pairing:** **Syne** (Headline: "Welcome to Design Community", 28px, tracking -0.03em) + **Plus Jakarta Sans** (Input labels & body, 14px).
* **Form Mechanics:** Email input + Password with eye visibility icon toggle + Terms checkbox + Primary full-width CTA + Social auth fallback.
* **375px Mobile Invariant:** At `< 1024px`, the 3D visual column collapses. Form expands to 100% width with 20px padding.

---

### AUTH-02: Full-Bleed Aurora Mesh + Right-Anchored Panel
* **Spatial Grid:** Full-viewport fluid canvas with a dynamic `radial-gradient` mesh (yellow, magenta, cyan, violet).
  - Left Zone: 60% negative space allowing the vibrant aurora artwork to breathe.
  - Right Zone: 40% anchored white card container with soft 24px corner radius (`rounded-3xl shadow-2xl p-8 lg:p-12`).
* **Form Mechanics:** Split Name Row (First Name + Last Name) + Email + Password + Primary CTA + "Continue with Google" social trigger.
* **375px Mobile Invariant:** On mobile, the aurora mesh blurs into a subtle top header glow; the card expands to fill the entire mobile viewport (`rounded-none min-h-screen p-6`).

---

### AUTH-03: Iridescent Hero Sphere Split with Top Nav
* **Spatial Grid:** Full-page layout with a persistent top navigation bar:
  - Top Bar: `h-16 border-b border-border/50 px-8 flex items-center justify-between` (Brand mark, Docs link, API link, Log In / Sign Up triggers).
  - Body: 50/50 split below the nav. Left column features an iridescent floating 3D bubble/sphere over a sunset gradient; Right column houses the auth form.
* **Social Auth Flow:** Top "Continue with Google" button with hairline border, followed by a subtle "or" divider, followed by manual email inputs.

---

### AUTH-04: Centered Glass Modal on Dark Scrim
* **Spatial Grid:** Centered dialog layout (`fixed inset-0 bg-[#120F1D]/80 backdrop-blur-md flex items-center justify-center p-4`).
* **Modal Dimensions:** `w-full max-w-md bg-card rounded-2xl p-8 border border-white/10 shadow-2xl relative`.
* **Signature Elements:** Top-right close icon (`X`), top-stacked OAuth buttons ("Continue with Facebook", "Continue with Google"), horizontal divider with clean "OR" label, single-field email capture.
* **375px Mobile Invariant:** The modal adapts to a full-screen sheet on mobile (`h-full rounded-none justify-between`).

---

### AUTH-05: Multi-Step KYC Stepper Modal
* **Spatial Grid:** Centered structured modal on dark plum backdrop.
* **Step Header:** Centered logo dot + "Sign up" + subtle secondary indicator "Step 1 of 3".
* **Complex Input Matrix:**
  - Full Name input.
  - International Phone Field: Custom country dropdown with flag SVG + dial code prefix (`+1`, `+44`, `+234`) + phone number input.
  - Date of Birth Triplet: 3 inline dropdowns (Month, Day, Year) with equal widths (`grid grid-cols-3 gap-2`).
  - Next Step Action: Primary button ("Next") triggering smooth step transitions.

---

### AUTH-06: Segmented Dual-Tab Switcher Modal
* **Spatial Grid:** Floating card on vibrant aurora gradient backdrop.
* **Header Architecture:** Integrated segmented pill controller:
  ```html
  <div class="inline-flex p-1 bg-muted rounded-full w-full">
    <button class="flex-1 py-2 text-sm rounded-full bg-background shadow-sm font-semibold">Sign in</button>
    <button class="flex-1 py-2 text-sm rounded-full text-muted-foreground">Sign up</button>
  </div>
  ```
* **Body Flow:** Dual social buttons -> "or" divider -> First/Last Name split inputs -> Email -> Submit button.

---

### AUTH-07: Stark Minimalist Horizontal Progress Wizard
* **Spatial Grid:** Pure white, non-distracting canvas (`bg-background max-w-2xl mx-auto py-16 px-6`).
* **Horizontal Stepper:**
  - Checkpoint 1: Active circle `(1)` with label "Account details" (Dark text, bold).
  - Connecting Line: 1px horizontal rule (`h-px bg-border flex-1`).
  - Checkpoint 2: Inactive circle `(2)` with label "Personal info" (Muted text).
  - Connecting Line: 1px horizontal rule.
  - Checkpoint 3: Inactive circle `(3)` with label "Verification".
* **Focus State:** Only displays inputs relevant to the active step, eliminating cognitive overload.

---

### AUTH-08: Centered Column with Multi-OAuth Badge Strip
* **Spatial Grid:** Ultra-clean centered single column (`max-w-sm mx-auto`).
* **Input Rhythm:** Full Name -> Work Email -> Password with strength meter -> Terms Agreement -> Solid CTA.
* **Bottom OAuth Strip:** Horizontal row of 3 minimalist outlined pills with official provider icons:
  - `[ Facebook ]` `[ Google ]` `[ Apple ]`

---

### AUTH-09: Asymmetric Form + Architectural Wireframe Duo
* **Spatial Grid:** 60/40 Asymmetric split on clean stark white canvas.
  - Left 60%: First/Last Name split + Work Email + Organization Size / Team Role dropdown + Primary action.
  - Right 40%: Minimalist isometric vector sculpture with technical coordinate markers, providing visual gravity without decorative stock photography.
* **Best Fit:** Engineering platforms, CAD/Architectural software, DevTools.

---

### AUTH-10: Inverted High-Contrast Split (Obsidian Manifesto + Form)
* **Spatial Grid:** Master 2-column container (`max-w-5xl mx-auto rounded-3xl overflow-hidden shadow-2xl border border-border`).
  - Left Column (Dark Obsidian `#0D0E12`): 40% width. Heavy display typography ("Design with us"), value proposition bullets ("Access to thousands of design resources and templates"), geometric line vector.
  - Right Column (Crisp White `#FFFFFF`): 60% width. Header "Sign up now", international phone input with country flag, terms checkbox, solid CTA button.
* **Conversion Physics:** Displays immediate credibility and social proof in the left column while the user fills out the form on the right.

---

## Google Stitch Deterministic Prompts (Ready-to-Paste)

### Stitch Formula for Split 3D Obsidian Stage (AUTH-01):
```text
Flat 2D desktop application screenshot, 16:9 widescreen, 1920x1080 resolution, direct front-facing view, NO 3D perspective tilt, NO laptop mockup frame, NO claymockups.
Zone Architecture: 2-column equal split screen; Left 50% clean white minimalist authentication canvas with modern sans-serif typography, clean input fields, password eye toggle, and solid black CTA button; Right 50% deep obsidian black canvas featuring floating 3D geometric isometric blocks with subtle amber edge glow.
Locked Palette: Pure white #FFFFFF form surface, obsidian black #0E1015 showcase surface, dark border lines #E2E8F0, primary button #000000.
Typography Character: Architectural display title "Welcome to Design Community", clean interface typography, zero clutter.
STRICT NEGATIVE CONSTRAINTS: NO laptop frames, NO mobile phone mockups, NO messy colorful illustrations, NO 3D isometric tilt on the overall page, flat clean 2D web application view only.
```

### Stitch Formula for Inverted High-Contrast Split (AUTH-10):
```text
Flat 2D desktop application screenshot, 16:9 widescreen, 1920x1080 resolution, direct front-facing view, NO 3D perspective tilt, NO laptop mockup frame, NO claymockups.
Zone Architecture: Centered 1200px container with rounded corners; Left 40% dark obsidian panel with bold white typography "Design with us", benefit bullet points, and an architectural geometric line sculpture; Right 60% crisp white card featuring "Sign up now", country flag phone selector, email input, and primary action button.
Locked Palette: Dark obsidian panel #101216, white form surface #FFFFFF, subtle hairline borders #E5E7EB, high-contrast dark text #111827.
Typography Character: Heavy bold display heading on the dark panel, ultra-clean form labels, crisp monospace country dial code.
STRICT NEGATIVE CONSTRAINTS: NO generic cartoon vectors, NO 3D desk objects, NO gradient blobs, clean high-end SaaS authentication screen only.
```
