# ACCESS-SUITE: Next-Gen Access, QR Code Sync & Passkey Archetypes (10 Screen Architectures)

> **Source Reference:** Figma Next-Gen Authentication & QR Sync Collection  
> **Reference Asset:** `design-vault/reference-images/auth-qr-split-batch3.png`  
> **Visual Tone:** Modern, frictionless access gateways incorporating instant mobile QR code scanning, Google One-Tap popovers, passkey returning profiles, and side-by-side dual gateways.

---

## Master Taxonomy: The 10 Next-Gen Access Archetypes

| Screen ID | Architecture Archetype | Core Spatial Mechanics | Best Fit Use Cases | Mobile Collapse (375px) |
|---|---|---|---|---|
| **ACCESS-01** | **Device Security Context Popover** | Form with persistent inline warning tooltip for shared/public computer security | Banking, Enterprise IT, Healthcare portals | Tooltip docks directly below "Remember Me" toggle on mobile |
| **ACCESS-02** | **Passkey / Profile Welcome Back** | Single-click avatar card (*"Welcome back - Sign in to stay updated"*) | Returning users, Enterprise Slack/Google style auth | Avatar card takes full container width with high-contrast button |
| **ACCESS-03** | **Dual Split-Action Card on Wave** | Left half = Sign Up (Social triggers) / Right half = Log In (Credentials) on blue wave | Unified gateway portals, All-in-one platforms | Split card transforms into a segmented tab bar on mobile |
| **ACCESS-04** | **Google One-Tap Floating Popover** | Silky blue fluid backdrop + floating One-Tap trigger dialog (*"Continue as Emily"*) | Frictionless web applications, Direct Google Workspace integration | Dialog docks as a bottom-sheet drawer on mobile |
| **ACCESS-05** | **Instant QR Code Mobile Sync Gateway** | Left 50% password login / Right 50% prominent QR code with scan instructions | Desktop messaging (WhatsApp, Discord), Multi-device apps, Web3 | QR code hides on mobile; manual password or biometrics prioritized |
| **ACCESS-06** | **Split Dual-Gateway with Hairline Line** | Left side manual email/password / Right side OAuth buttons separated by vertical divider | SaaS platforms, Creative portals, Cloud tools | Vertical divider turns into horizontal "OR" divider line |
| **ACCESS-07** | **Sunset Chromatic Mesh + Social Strip** | Warm magenta/yellow sunset background + centered card with bottom 4-icon OAuth strip | Lifestyle apps, Social discovery, Creator communities | Social icon strip preserves 44x44px touch targets |
| **ACCESS-08** | **High-Fashion Editorial Studio Split** | Left 50% high-fashion photography / Right 50% ultra-minimalist white sign-in card | Luxury fashion, Modeling agencies, Premium retail | Editorial photo scales into a 1:1 top hero banner |
| **ACCESS-09** | **Side-by-Side Dual Gateway Cards** | Card 1: "Log in to your account" / Card 2: "Create your new account" side-by-side | B2B Marketplaces, Contractor portals, Dual-persona platforms | Dual cards stack vertically or switch via top segmented control |
| **ACCESS-10** | **Scenic Landscape Scrim + Phone Dialer**| Scenic mountain landscape + centered modal with country flag selector & phone input | Global apps, Travel networks, SMS verification flows | Modal fills full screen width; phone flag selector uses native picker |

---

## The Signature Modern UX Pattern: Instant QR Code Sync (ACCESS-05)

### Spatial Geometry & Mechanics:
* **Container:** 840px wide centered white card with `p-10 rounded-2xl shadow-2xl border border-border`.
* **Left Column (Manual Credentials, 50% width):**
  - Title: "Welcome back" + Subtitle: "Enter your account credentials".
  - Email input + Password input + "Log in" button.
* **Vertical Divider:** 1px hairline border with soft gray gradient.
* **Right Column (Mobile QR Sync, 50% width):**
  - Large High-Contrast QR Code: 160x160px with crisp 4px quiet zone border.
  - Heading: "Log in with QR code".
  - Subtext: "Scan this with your mobile app to sign in instantly without typing your password."
* **Mobile Invariant (375px):**
  - When viewed on a smartphone (<= 768px), displaying a QR code on the same screen the user is holding is redundant.
  - The QR column automatically hides on mobile viewports (`hidden lg:flex`), letting the manual login or native WebAuthn/Passkey take 100% of the screen.

---

## Google Stitch Deterministic Prompt Formula

### Stitch Prompt for QR Code Mobile Sync Gateway (ACCESS-05):
```text
Flat 2D desktop application screenshot, 16:9 widescreen, 1920x1080 resolution, direct front-facing view, NO 3D perspective tilt, NO laptop mockup frame, NO claymockups.
Zone Architecture: Centered 900px clean white modal container on a subtle mosaic background; Left half features traditional email and password login form with solid action button; Vertical 1px hairline divider; Right half features a large prominent black-and-white QR code with label "Log in with QR code" and instructional copy "Scan this with your mobile app to sign in instantly".
Locked Palette: Pure white card #FFFFFF, dark text #0F172A, crisp QR code #000000 on white, subtle hairline border #E2E8F0.
Typography Character: Clean modern sans-serif headings, high-legibility interface copy, uppercase monospace instruction labels.
STRICT NEGATIVE CONSTRAINTS: NO 3D perspective tilt, NO laptop mockups, NO phone mockups, flat crisp desktop web application interface only.
```
