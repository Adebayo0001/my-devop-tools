# Comprehensive Pre-Flight Compliance & Production Security Checklist

Use this checklist during `/review`, `/check`, or before final production cutover to verify that an application satisfies **OWASP ASVS 5.0.0**, **NIST SSDF SP 800-218**, **PCI DSS v4.0.1**, **Nigerian statutory laws (NDPC, FCCPC, CAC, ngCERT)**, and international privacy standards (**GDPR, CCPA/GPC, EAA 2025**).

---

## 1. Engineering, DevSecOps & Architecture Gates
* [ ] **OWASP ASVS 5.0.0 Level 2 Verification**: Business-logic and authorization flows manually verified; zero critical findings.
* [ ] **NIST SSDF Least-Privilege CI/CD**: Build runners use least-privilege OIDC workload federation (zero standing admin keys in GitHub Actions/GitLab CI).
* [ ] **Software Supply Chain Integrity**:
  * Software Composition Analysis (SCA) cross-referenced against the **CISA Known Exploited Vulnerabilities (KEV)** catalog.
  * Signed build provenance (**SLSA v1.0–v1.2**) and automated **SBOM** generated.
* [ ] **Backend-for-Frontend (BFF) Pattern**: Browser JavaScript never holds raw JWT/bearer tokens in `localStorage` or `sessionStorage`. Tokens are encapsulated server-side in `HttpOnly; Secure; SameSite=Lax` cookies.
* [ ] **OAuth 2.1 & Modern Auth**: PKCE enforced on all authorization code grants; WebAuthn/FIDO2 passkeys or hardware MFA mandatory for administrative roles; minimum 12-character passwords (PCI DSS 4.0.1 Req 8.3.6).
* [ ] **Mass Assignment Protection**: Explicit Data Transfer Object (DTO) field allowlists enforced (never binding raw request JSON to database models).
* [ ] **Forward-Compatible Staged Database Migrations**: Two-phase schema migration (add new column/table first, backfill, deprecate old schema in subsequent release); automated pre-deploy DB snapshot verified.
* [ ] **Staging Environment Sanitization**: Staging uses 100% anonymized or synthetic data; **zero live customer PII**.
* [ ] **Certificate Transparency Leak Prevention**: No public TLS certificates issued for internal/unreleased staging subdomains.
* [ ] **Sustained Load Testing Floor**: Performance validated at **≥3× peak expected volume** (k6/Gatling) confirming rate limits and SLOs hold.
* [ ] **Governed Exception Process**: Any temporary bypass of a failing gate requires a logged failure, named approver sign-off, and an expiration date.

---

## 2. Anti-Hacker Hardening & OWASP Top 10 Countermeasures
* [ ] **BOLA / IDOR Verification (CWE-862, 639)**: Centralized object-ownership validation on every parent and nested child route (`WHERE organization_id = session.org_id`); non-guessable UUIDv4s used.
* [ ] **PostgreSQL Row-Level Security (RLS)**: Enabled and active on all multi-tenant tables.
* [ ] **Injection Defense (CWE-89, CWE-78)**: 100% of queries parameterized via typed ORMs (Prisma, Drizzle); dynamic shell/eval calls completely banned.
* [ ] **XSS & Rendering Defense (CWE-79)**: Context-aware auto-escaping; zero unsanitized `dangerouslySetInnerHTML`.
* [ ] **Strict HTTP Security Headers**:
  ```http
  Strict-Transport-Security: max-age=63072000; includeSubDomains; preload
  Content-Security-Policy: default-src 'self'; script-src 'self' ...
  X-Content-Type-Options: nosniff
  X-Frame-Options: DENY
  Referrer-Policy: strict-origin-when-cross-origin
  Permissions-Policy: camera=(), microphone=(), geolocation=(), payment=()
  ```
* [ ] **SSRF & Rate Limiting**: Network egress blocks preventing server-side fetchers from reaching RFC 1918 private IPs and cloud metadata (`169.254.169.254`). Rate limiting active on auth, payment, and AI endpoints.
* [ ] **Payment Page Protection (PCI DSS v4.0.1 Req 6.4.3 & 11.6.1)**:
  * Every script running on payment forms has documented business justification and verified Subresource Integrity (SRI) hashes.
  * Client-side tamper detection active against Magecart formjacking.

---

## 3. Nigerian Statutory Legal Governance
* [ ] **CAC CAMA 2020 Corporate Identity Imprint (ss. 304, 729)**:
  * Website legal footer, contact page, and digital receipts state:
    1. Registered corporate company name.
    2. **RC Number** (Registration Company Number).
    3. Registered physical office address.
    4. Particulars of company directors (names, former names, non-Nigerian nationality).
* [ ] **FCCPC Consumer Protection & Anti-"No Refund" Invariant (FCCPA 2018 ss. 114–132)**:
  * Plain, jargon-free Terms & Conditions hyperlinked before checkout.
  * **Zero blanket "No Refund" text**: Policies declare statutory remedies (refund, repair, replacement for defective/misdescribed goods or failed SaaS).
  * Displayed pricing matches final checkout total with zero hidden markups (s.115).
  * Itemized digital receipts provided (s.118); second-hand/reconditioned items labeled (s.117).
* [ ] **ONSA / ngCERT 72-Hour Cyber Attack Readiness (Cybercrimes Act 2024)**:
  * Emergency incident runbook prepared to report cyber disruptions to sectoral CERT/SOC within 72h (s.21) avoiding ₦2M fine.
  * Subscriber and traffic data retention active for 2 years (s.38).
* [ ] **NDPC GAID 2025 Tiering & Compliance**:
  * Entity tier classified (UHL, EHL, OHL). DPO appointed (s.32).
  * Licensed DPCO engaged for 5-pillar audit; annual Compliance Audit Return (CAR) scheduled for March 31.
  * GAID Art. 44 AI safeguards verified (DPIA, data anonymization, low-risk testing).
* [ ] **NITDA IT Clearance**: Verified if building software for Federal Public Institutions (FPIs) or Nigerian MDAs.

---

## 4. International Privacy, Disclosures & Standards
* [ ] **Global Privacy Control (GPC)**:
  * Automatic detection and honoring of `Sec-GPC: 1` request headers and `navigator.globalPrivacyControl === true`.
  * Public, unauthenticated `/.well-known/gpc.json` served across data-processing domains.
* [ ] **Responsible Disclosure (`/.well-known/security.txt`)**:
  * RFC 9116 / ISO 29147 file published with security contact, PGP key, and explicit authorized testing scope under Nigerian Cybercrimes Act s.6(2).
* [ ] **Cookie Consent Engineering**:
  * Zero pre-consent tracking scripts execute before affirmative user opt-in.
  * Equal-weight "Reject All" button (zero dark patterns).
  * Persistent footer link for cookie preference withdrawal.
* [ ] **Accessibility (WCAG 2.1 AA / EAA 2025)**:
  * Full keyboard navigability, focus rings, ARIA contracts, and minimum 4.5:1 contrast.
  * Accessibility Statement published with feedback channel.
* [ ] **UK Data (Use and Access) Act 2025 (DUAA)**:
  * Accessible electronic data protection complaints form with statutory 30-day response acknowledgement.
* [ ] **Data Subject Access Rights (DSAR)**:
  * Self-serve **Data Export** (JSON/CSV) in account settings.
  * Cascading **Account Deletion** ("Right to be Forgotten") purging or anonymizing all records.
* [ ] **AI Data Training Opt-Out**:
  * User settings toggle: `[ ] Allow my data to train AI models`.
  * Third-party LLM APIs confirmed to enforce Zero Data Retention (ZDR).
  * `robots.txt` blocking AI bots (`GPTBot`, `CCBot`) with `X-Robots-Tag: noai` header.

---

## 5. Real-Time Monitoring & Availability
* [ ] **Edge WAF + Runtime RASP**: Dual-layer defense active blocking DDoS and in-process zero-day injection.
* [ ] **Active BOLA Enumeration Alerting**: SIEM/OpenTelemetry rule alerting on spikes in 401/403/404 or sequential ID requests per user token.
* [ ] **Certificate Transparency (CT) Monitoring**: Automated streams (Cert Spotter/CertStream) watching for unauthorized certificates; 24h CA revocation escalation ready.
* [ ] **DNS & Email Hardening**: DNSSEC active, CAA records set (`accounturi`, `validationmethods`), and DMARC set to `p=reject` or `p=quarantine`.
* [ ] **Synthetic Journey Monitoring & RUM**: Synthetic checks running for login, cart, and checkout; live RUM monitoring Core Web Vitals (LCP < 2.5s, INP < 200ms, CLS < 0.1).
* [ ] **Synchronized 72-Hour Legal Incident Runbook**: Tested and accessible in `06-Security-and-Legal-Compliance/72-hour-incident-response-runbook.md`.
