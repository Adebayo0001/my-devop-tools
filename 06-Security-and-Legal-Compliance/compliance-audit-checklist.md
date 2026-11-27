# Pre-Flight Compliance & Production Security Checklist

Use this checklist during `/review`, `/check`, or before final production cutover to verify that an application complies with international cyber-defense standards, data protection laws, and accessibility mandates.

---

## 1. Anti-Hacker & OWASP Hardening
* [ ] **BOLA / IDOR Verification**: Every server endpoint and database mutation verifies ownership (`WHERE organization_id = session.org_id`).
* [ ] **PostgreSQL Row-Level Security (RLS)**: Enabled and tested on all multi-tenant tables.
* [ ] **Input Sanitization & Schema Validation**: 100% of external payloads parsed with typed schemas (e.g., Zod). Zero concatenated raw SQL queries.
* [ ] **Strict HTTP Security Headers**:
  ```http
  Strict-Transport-Security: max-age=63072000; includeSubDomains; preload
  Content-Security-Policy: default-src 'self'; script-src 'self' ...
  X-Content-Type-Options: nosniff
  X-Frame-Options: DENY
  Referrer-Policy: strict-origin-when-cross-origin
  Permissions-Policy: camera=(), microphone=(), geolocation=(), payment=()
  ```
* [ ] **Session Cookie Quarantine**: Cookies set with `HttpOnly; Secure; SameSite=Lax` (or `SameSite=Strict`).
* [ ] **Rate Limiting Active**: Brute-force throttling enabled on `/login`, `/signup`, `/checkout`, and `/api/ai`.
* [ ] **SSRF Defense**: Outbound webhooks and URL fetchers disallow internal private IP ranges (RFC 1918) and cloud link-local metadata addresses (`169.254.169.254`).

---

## 2. Statutory Legal Pages & Disclosures
* [ ] **Privacy Policy (`/privacy`)**:
  * Accessible from the persistent footer on all screens.
  * Categories of personal data collected enumerated.
  * Named third-party data processors (e.g. Supabase, Stripe, Sentry, Resend).
  * Data retention windows explicitly defined.
  * Contact email for Data Protection Officer (DPO) or privacy inquiries provided.
* [ ] **Terms of Service (`/terms`)**:
  * Governing jurisdiction specified.
  * Limitation of liability and warranty disclaimer present.
  * Acceptable Use Policy (AUP) and account termination rights stated.
* [ ] **Cookie Consent Banner & Policy (`/cookies`)**:
  * Explicit **Opt-In** before non-essential tracking scripts (Google Analytics, Meta Pixel) fire.
  * Equal-weight "Reject All" button (zero dark patterns).
  * Granular preferences center (Essential, Analytics, Marketing).
* [ ] **Terms of Sale & Refund Policy (`/refunds` or inside `/terms`)**:
  * Legally mandated cancellation rights ("Click to Cancel" rule).
  * 14-day statutory withdrawal period disclosed if serving European consumers.
* [ ] **Accessibility Statement (`/accessibility`)**:
  * Conformance target stated (**WCAG 2.1 AA**).
  * Dedicated accessibility feedback email/contact published.
* [ ] **Legal Notice / Impressum (`/imprint` or `/impressum`)**:
  * Mandatory if targeting users in Germany, Austria, or Switzerland.
  * Full corporate legal name, physical registered address, commercial register number, VAT ID, phone, and email.

---

## 3. Data Protection, Privacy & AI Model Ethics
* [ ] **Data Subject Access Rights (DSAR)**:
  * Self-serve **Data Export** (JSON/CSV) available in user account settings.
  * Cascading **Account Deletion** ("Right to be Forgotten") purging or anonymizing all user records.
* [ ] **AI Data Training Disclosures**:
  * Users informed if prompts, files, or interactions are processed by AI models.
  * Explicit opt-out toggle provided: `[ ] Allow my inputs to train AI models`.
  * Third-party AI API providers confirmed to have **Zero Data Retention (ZDR)** agreements.
  * `robots.txt` configured with `User-agent: GPTBot / Disallow: /` and `X-Robots-Tag: noai` if restricting external AI scrapers.

---

## 4. DevOps, QA & Performance Gates
* [ ] **The 5 Screen States Handled**: Default, Loading Skeleton, Empty, Error Boundary, Edge Cases.
* [ ] **Mobile Responsive Floor**: 375px viewport tested with 0 horizontal scroll and minimum 44×44px touch targets.
* [ ] **Core Web Vitals Thresholds**: LCP < 2.5s, INP < 200ms, CLS < 0.1.
* [ ] **APM & Crash Observability**: Sentry Error Boundaries active with PII scrubbing (`beforeSend`).
* [ ] **CI/CD Build Cleanliness**: `tsc --noEmit` and `npm run build` exit 0 with zero warnings.
