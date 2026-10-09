# LOGIN-SUITE: Master Authentication & Sign-In Registry (15 Screen Architectures)

> **Source Reference:** Figma Master Sign-In & Login Collection  
> **Reference Asset:** `design-vault/reference-images/login-signin-15-screens.png`  
> **Visual Tone:** 15 distinct, battle-tested sign-in patterns ranging from multi-account avatar switchers and mobile device showcases to QR instant login, culinary splits, and cinematic landscape scrims.

---

## Master Taxonomy: The 15 Sign-In Archetypes

| Screen ID | Architecture Archetype | Core Spatial Mechanics | Best Fit Use Cases | Mobile Collapse (375px) |
|---|---|---|---|---|
| **LOGIN-01** | **Cinematic Scrim Modal** | Full-bleed scenic road landscape + centered floating white modal | Travel, Automotive, Outdoor Lifestyle, Hospitality | Background photo dims with 80% dark overlay; modal expands to 100vw |
| **LOGIN-02** | **Vibrant Culinary 50/50 Split** | Left 50% warm orange card with 5 stacked OAuth buttons / Right 50% overhead food photo | Food delivery, Restaurants, Hospitality, E-commerce | Right photo stacks above the form as a 16:9 hero banner |
| **LOGIN-03** | **Stark Monolith Centered Form** | Clean white canvas, zero decorative distractions, high-contrast inputs | Developer tools, High-ticket consultancies, Privacy apps | Preserves centered 380px column; full 48px touch targets |
| **LOGIN-04** | **Triple OAuth Pill Hub** | Centered card with 3 horizontal social pills (FB, Google, Apple) + email/pass | Consumer web apps, Media portals, Marketplaces | Social pills stack vertically or wrap gracefully |
| **LOGIN-05** | **Mosaic Wall + 6-Tier Social Stack** | Photographic mosaic grid backdrop + 6-tier vertical OAuth options (Phone, Apple, Google, etc.) | Social networks, Photography communities, Creator platforms | Mosaic grid dims; 6 social buttons fill full mobile width |
| **LOGIN-06** | **Obsidian Tech Circuit Split** | Left 50% dark circuit art + Right 50% clean form with dual social buttons | AI platforms, Cybersecurity, Cloud DevOps, Hardware | Dark circuit collapses to top header; form takes full screen |
| **LOGIN-07** | **3D Isometric Neon Grid Scrim** | Dark glowing isometric blocks background + centered white modal | Web3, Gaming, Crypto, Frontier AI tools | 3D grid darkens to prevent contrast failure; modal takes 100vw |
| **LOGIN-08** | **Classic Brand Seal Centered Card** | Top brand logo dot + 3 social buttons + email/password + "Keep me signed in" | Standard SaaS, Productivity apps, Internal dashboards | Modal container expands to full width with 20px edge margins |
| **LOGIN-09** | **Dual Device Ecosystem Stage** | Left 50% dual smartphone renders / Right 50% form + App Store/Google Play badges | Mobile-first SaaS, Fintech apps, Fitness/Health | Smartphone renders collapse into a single floating mobile preview |
| **LOGIN-10** | **Multi-Account Profile Switcher** | Left side "Recent Logins" avatar tile (One-Click Sign-In) / Right side manual login form | Enterprise multi-seat SaaS, Google/Slack-style workflows | Stacks recent avatar tile directly above manual login form |
| **LOGIN-11** | **Dual-Card Side-by-Side Canvas** | Left card "Sign In" + Right card "Create Account" simultaneously on cyan backdrop | High-conversion portals, Direct comparison access | Cards stack vertically into a toggle or tabbed view |
| **LOGIN-12** | **Desktop Form with Mobile App Badges**| Centered card + official App Store & Google Play badge triggers in footer | Cross-platform SaaS, Messaging tools, Banking | App store badges wrap into a 2-column grid at bottom |
| **LOGIN-13** | **Botanical Lush Foliage Scrim** | Dark green moody plant leaf backdrop + centered floating frosted white card | Wellness, Sustainable brands, Organic commerce | Foliage image maintains dark vignette; modal fills screen |
| **LOGIN-14** | **Personalized "Welcome Back" Avatar**| Cinematic background + centered modal with user profile avatar circle & 1-click Google auth | Returning user flows, Subscription platforms, CRM portals | Avatar circle remains centered; action button expands to full width |
| **LOGIN-15** | **Minimalist Form with Social Icon Strip**| Clean white form with bottom horizontal row of monochrome brand icons | Minimalist agencies, Portfolio sites, Luxury retail | Icons maintain 44x44px touch hitbox on mobile |

---

## Detailed High-Impact Architectures

### LOGIN-10: Multi-Account Profile Switcher (The Google / Slack Enterprise Pattern)
* **Spatial Layout:** 60/40 Asymmetric split inside a centered 960px container.
  - Left Section (Recent Logins): Displays saved account cards:
    - User avatar image (64x64px rounded-full).
    - User name ("Jessica Fox") + email address.
    - Close badge ('x') to remove saved account.
    - "Add Account" secondary dashed card trigger.
  - Right Section (Standard Login): Manual email/password inputs + "Log in" button.
* **Why this converts:** Reduces friction for returning power users from 45 seconds to a single click, while still supporting guest or secondary logins.

### LOGIN-09: Dual Device Ecosystem Stage (The Cross-Platform SaaS Pattern)
* **Spatial Layout:** 2-column split with physical hardware cues.
  - Left 50%: Two tilted smartphone frames displaying the live iOS/Android application interface.
  - Right 50%: Web application login form with email, password, and primary button.
  - Bottom Footer: Official SVG badges for Apple App Store and Google Play Store.
* **Mobile Invariant:** The dual phones collapse on screens `< 1024px`, placing a single hero device screenshot above the form.

---

## Google Stitch Deterministic Prompt Formula

### Stitch Prompt for Multi-Account Profile Switcher (LOGIN-10):
```text
Flat 2D desktop application screenshot, 16:9 widescreen, 1920x1080 resolution, direct front-facing view, NO 3D perspective tilt, NO laptop mockup frame, NO claymockups.
Zone Architecture: Centered 1000px clean white container with subtle hairline border; Left zone features "Recent Logins" with saved user profile avatar card showing photo, name "Jessica Fox", and a secondary dashed "Add Account" card; Right zone features clean manual login form with email and password inputs, submit button, and "Forgot password" link.
Locked Palette: Clean background #F8FAFC, white card container #FFFFFF, subtle borders #E2E8F0, dark text #0F172A, primary action #2563EB.
Typography Character: Modern geometric sans-serif headings, high-legibility interface copy, clean avatar captions.
STRICT NEGATIVE CONSTRAINTS: NO 3D perspective, NO floating decorative balls, NO neon gradients, clean enterprise profile switcher interface only.
```
