# Production-Readiness, Cybersecurity, Legal & Monitoring Master Handbook
### Silicon Valley Principal Engineer, SRE, and Regulatory Engineering Standard

This handbook establishes the definitive engineering, security, regulatory, and monitoring standard for taking modern software and web applications from development into hostile production environments—meeting **OWASP ASVS 5.0.0**, **NIST SSDF SP 800-218 v1.2**, **PCI DSS v4.0.1**, **Nigerian statutory frameworks (NDPC, FCCPC, CAC, ngCERT, NITDA)**, and extraterritorial laws (**EU GDPR, UK DUAA 2025, California CCPA/CPRA, EAA 2025**).

---

## Table of Contents
1. [Part 1: Engineering, QA & DevSecOps Production Gates](#part-1-engineering-qa--devsecops-production-gates)
2. [Part 2: Essential Governing Bodies & Statutory Legal Policies](#part-2-essential-governing-bodies--statutory-legal-policies)
3. [Part 3: Industry-Standard Data Protection, Cookies & AI Governance](#part-3-industry-standard-data-protection-cookies--ai-governance)
4. [Part 4: Common Developer Mistakes & CWE Prevention (OWASP / MITRE 2025)](#part-4-common-developer-mistakes--cwe-prevention)
5. [Part 5: 5-Layer Real-Time Monitoring & Availability Architecture](#part-5-5-layer-real-time-monitoring--availability-architecture)
6. [Part 6: Synchronized 72-Hour Legal Incident Response Runbook](#part-6-synchronized-72-hour-legal-incident-response-runbook)

---

## Part 1: Engineering, QA & DevSecOps Production Gates

Production readiness replaces late pre-launch bottlenecks with continuous verification across four mature industry frameworks:
* **OWASP ASVS 5.0.0 (May 30, 2025)**: 345 requirements across 17 chapters categorized into:
  * **Level 1 (Baseline)**: Automated verification floor (covers <50% of security requirements).
  * **Level 2 (Standard for PII, Healthcare & Financial Apps)**: Required for all production SaaS handling customer accounts, payments, and private data. Demands targeted manual business-logic and authorization review.
  * **Level 3 (Critical / Defense-in-Depth)**: For critical infrastructure, banking, and government applications.
* **NIST SSDF SP 800-218 (v1.1 & draft v1.2 Dec 2025)**: Secures the software development environment (PO.5, PS.1). CI/CD runners must eliminate static cloud credentials in favor of least-privilege OIDC workload federation.
* **OWASP SAMM & DSOMM**: Measures organizational and CI/CD DevSecOps maturity.
* **SLSA v1.0–v1.2 & SBOM**: Every build generates signed build provenance and a Software Bill of Materials (SBOM) for supply chain transparency.
* **SOC 2 Type II & ISO/IEC 27001:2022 (Annex A 8.29 & 8.32)**: Auditability requires retaining immutable evidence linking each deployed artifact digest to its passing tests, scans, and approvals.

### 1.1 The 4-Stage CI/CD Release Gates
| Pipeline Gate | QA Verification Criteria | DevSecOps & Security Criteria | Enforcement & Failure Action |
|---|---|---|---|
| **Commit / Pull Request** | Unit tests pass (≥70% coverage of core logic); peer review signed off; test cases traced to requirements. | Pre-commit and CI secrets scanning with automatic block; SAST and IaC misconfiguration scans; signed commits. | Merge blocked until tests pass and critical findings/secrets are resolved. |
| **Build / Artifact** | Integration tests and build smoke tests pass; dependency lockfiles committed and reproducible. | Software Composition Analysis (SCA) cross-referenced against **CISA Known Exploited Vulnerabilities (KEV)**; container scans against CIS Benchmarks; signed SLSA provenance & SBOM generated. | Artifact rejected from staging promotion; vulnerable builds quarantined. |
| **Pre-Release / Staging** | Full regression suite passes; zero open critical defects; cross-browser, accessibility (WCAG 2.1 AA), and **≥3× peak load tests** pass; UAT signed off. | Authenticated DAST; manual business-logic & BOLA verification; cloud posture checks; OWASP ASVS L2 evidence archived; **zero live customer PII** in staging (synthetic/masked data only). | Release held; emergency shipping requires a logged, approver-signed exception with a hard expiration date. |
| **Production Cutover** | End-to-end synthetic smoke tests verify login, checkout, and error paths (beyond HTTP 200); canary metrics monitored. | Runtime WAF/RASP active; payment script integrity verified (PCI DSS 6.4.3); immutable audit logs linked to deployment digests. | Automated or runbook-driven rollback for code faults; disaster recovery failover for data corruption. |

### 1.2 Environment Parity & Forward-Compatible Migrations
* **Environment Parity**: Dev, QA, Test, Ephemeral PR Previews, and Staging must mirror production OS, middleware, and network topology via Infrastructure as Code (IaC).
* **Certificate Transparency Leak Prevention**: Never issue public TLS certificates for internal/unreleased staging or preview subdomains (`project-titan-staging.company.com`). Public CT logs broadcast internal infrastructure to attackers. Use private internal PKI or wildcard certs.
* **Forward-Compatible Staged Database Migrations**:
  1. *Phase 1*: Add new nullable column/table; deploy code that dual-writes to both old and new schemas.
  2. *Phase 2*: Backfill historic data.
  3. *Phase 3*: Switch reads to the new column.
  4. *Phase 4*: Deprecate and drop the old column in a subsequent release.
  * Automated pre-deploy DB snapshots and tested RTO/RPO disaster recovery drills are mandatory.

---

## Part 2: Essential Governing Bodies & Statutory Legal Policies

Publishing a web application binds operators to the laws of their corporate domicile, operating regions, and user locations.

### 2.1 Nigerian Statutory Bodies & Legal Requirements
| Governing Body | Core Law / Regulation | Key Website Obligations & Enforceable Deadlines | Maximum Statutory Penalties |
|---|---|---|---|
| **NDPC (Nigeria Data Protection Commission)** | **NDPA 2023 & GAID 2025** (Replaced NDPR) | • Classify as Data Controller/Processor of Major Importance: **UHL** (>5k subjects, all banks/fintechs/insurers), **EHL** (1k–5k subjects, MDAs), or **OHL** (200–1k subjects).<br>• Appoint DPO (s.32); conduct DPIA for high-risk data (s.28); display prominent homepage privacy & cookie notices; opt-in non-essential cookies; report breaches in 72h.<br>• Engage licensed DPCO to audit 5 pillars and file annual **Compliance Audit Return (CAR)** by **March 31** (2026 cycle extended to May 30, 2026; next due March 31, 2027).<br>• GAID Art. 44: AI deployments require DPIA, data anonymization, and low-risk environment testing. | UHL/EHL: Greater of **₦10,000,000 or 2% of preceding year's gross revenue** (late CAR adds up to 50% filing fee). Standard tier: ₦2,000,000 or 2%. |
| **FCCPC (Federal Competition & Consumer Protection Commission)** | **FCCPA 2018** (Part XV, ss. 114–132) & E-Commerce Guidance | • Plain, jargon-free Terms & Conditions hyperlinked before checkout.<br>• **Anti-"No Refund" Invariant**: Blanket "No Refund" or "Goods sold are not returnable" disclaimers are **strictly void** under s.129. Policies must define statutory remedies (refund, repair, replacement) for defective goods or failed SaaS.<br>• Pricing transparency: Displayed price must strictly match final checkout total (s.115).<br>• Itemized digital receipts provided (s.118); second-hand/reconditioned goods labeled (s.117). | Liability waivers void (s.129); product recalls, compliance orders, and statutory operational sanctions. |
| **CAC (Corporate Affairs Commission)** | **CAMA 2020** (ss. 304, 729) | • **Corporate Identity Legal Imprint**: Legibly state on website footers, contact pages, and digital invoices/receipts:<br>  1. Registered corporate company name.<br>  2. **RC Number** (Registration Company Number).<br>  3. Registered physical office address.<br>  4. Directors' particulars (names, former names, non-Nigerian nationality).<br>• **Active enforcement begins August 1, 2026**. | Statutory sanctions against the company and defaulting corporate officers. |
| **ONSA / ngCERT & Sectoral CERTs/SOCs** | **Cybercrimes (Amendment) Act 2024** | • **Mandatory 72-Hour Cyber Reporting**: Report any cyber attack, disruption, or intrusion to the sectoral CERT/SOC (feeding ngCERT) within 72 hours (s.21).<br>• Route/integrate traffic to sectoral SOCs (s.41).<br>• Retain traffic and subscriber data for **2 years** under NDPA (s.38). Online payment fraud covered (s.30). | **Mandatory ₦2,000,000 fine** for failing to report within 72h; ₦7M–₦10M+ fines and 2–14 years prison for cyber offences; ≥2% turnover fine for levy default. |
| **NITDA** | **NITDA Act 2007** & IT Project Clearance Guidelines (2026) | • Mandatory for Federal Public Institutions (FPIs)/MDAs: Pre-project IT clearance and independent QA certification via Licensed Compliance Assurance Firms. | Criminal offence under NITDA Act sections 17 & 18. |

### 2.2 Extraterritorial Governing Bodies & Regulations
* **European Union (EU)**:
  * **EU GDPR & EDPB**: Prior explicit opt-in for tracking cookies, 72h breach notification to DPAs, Art. 13/14 transparency notices. Fines up to **€20M or 4% of global turnover**.
  * **European Accessibility Act (EAA, Dir. 2019/882)**: Applied since June 28, 2025 (transitional window to 2030 for existing services). Mandates **EN 301 549 / WCAG 2.1 AA** compliance and an Accessibility Statement for e-commerce, banking, media, and SaaS serving EU users (microenterprises <10 staff and ≤€2M turnover exempt).
  * **EU AI Act**: GPAI training data transparency documentation active August 2, 2026; ban on untargeted facial scraping active December 2, 2026.
* **United Kingdom**:
  * **Information Commission (Succeeded ICO Sept 30, 2026)**: Enforces UK GDPR, DPA 2018, PECR, and the **Data (Use and Access) Act 2025 (DUAA)**.
  * Mandatory electronic data protection complaints process with **statutory 30-day response acknowledgement** (active June 19, 2026). Fines up to **£17.5M or 4% global turnover**.
* **United States (California)**:
  * **CPPA & Attorney General (CCPA / CPRA)**: "Do Not Sell or Share My Personal Information" link; **automated detection and honoring of Global Privacy Control (GPC)** browser signals; unauthenticated `/.well-known/gpc.json`. Fines up to $7,988 per intentional violation.
* **Global Payment Security**:
  * **PCI Security Standards Council (PCI DSS v4.0.1 — Full Enforcement March 31, 2025)**:
    * **Req 6.4.3**: Authorize, document business justification, and verify integrity/hashes of every JavaScript file running on customer payment pages.
    * **Req 11.6.1**: Deploy client-side tamper detection guarding against Magecart and formjacking.
    * **Req 6.3.3**: Patch critical vulnerabilities within 1 month.

### 2.3 Required Website Legal Components Summary
1. `SCR-10: Trust, Privacy & Legal Hub` — Centralized navigation in footer.
2. **Privacy Notice** (`/privacy`): Controller identity, DPO contact, lawful basis, data retention, international safeguards, user rights.
3. **Cookie Banner & Preferences** (`/cookies`): Equal-weight Accept/Reject, zero pre-consent tracking, persistent withdrawal link.
4. **Terms of Service** (`/terms`): Clear language, UCC contract terms, limitation of liability, dispute jurisdiction.
5. **Refund & Cancellation Policy** (`/refunds`): FCCPA s.129 compliant statutory remedies (refund, repair, replace); no void "No Refund" text.
6. **CAC Legal Corporate Imprint** (`/imprint` or footer): Registered name, RC number, registered office, directors' particulars.
7. **Accessibility Statement** (`/accessibility`): WCAG 2.1 AA / EN 301 549 conformance status and feedback contact.
8. **Responsible Disclosure** (`/.well-known/security.txt`): Security contact, PGP key, and authorized scope under Cybercrimes Act s.6(2).
9. **Global Privacy Control** (`/.well-known/gpc.json`): Machine-readable GPC support declaration.

---

## Part 3: Industry-Standard Data Protection, Cookies & AI Governance

### 3.1 Identity, Cryptography & Architecture Invariants
* **Cryptographic Standards**:
  * **TLS 1.3 enforced** across all endpoints. TLS 1.2 permitted only with forward-secret AEAD ciphers (`ECDHE-ECDSA/RSA with AES-256-GCM` or `CHACHA20-POLY1305`). Disallow SSL, TLS 1.0, and TLS 1.1.
  * HSTS with `max-age=63072000` (2 years), `includeSubDomains`, and `preload`.
  * **AES-256-GCM envelope encryption** at rest with automated 90-day key rotation inside FIPS 140-2 Level 3 HSMs or Cloud KMS.
* **Backend-for-Frontend (BFF) Pattern**:
  * **Zero Raw Bearer Tokens in Browser JavaScript**: Browser JS must never store access tokens in `localStorage` or `sessionStorage` (where XSS can exfiltrate them).
  * The BFF server holds the tokens and exchanges them with the browser via secure, encrypted `HttpOnly; Secure; SameSite=Lax/Strict` cookies.
* **OAuth 2.1 & Modern Authentication**:
  * OAuth 2.1 mandating **PKCE (Proof Key for Code Exchange)** on all authorization code grants.
  * **Phishing-Resistant MFA**: WebAuthn / FIDO2 passkeys or hardware security keys mandatory for administrators and privileged roles.
  * Minimum 12-character password requirement (PCI DSS 4.0.1 Req 8.3.6).

### 3.2 Cookies & Global Privacy Control (GPC)
* **Zero-Pre-Consent Tracking**: No analytics or advertising tracking scripts (Google Analytics, Meta Pixel) execute prior to affirmative opt-in.
* **Global Privacy Control (GPC)**:
  * Application middleware detects the `Sec-GPC: 1` request header and JavaScript `navigator.globalPrivacyControl === true`.
  * Automatically suppresses all third-party data selling, sharing, or tracking without displaying intrusive banners.
  * Serve `/.well-known/gpc.json`:
    ```json
    {
      "gpc": true,
      "lastUpdate": "2026-03-31"
    }
    ```

### 3.3 AI Model Training & Scraping Governance
* **3-Layer Outbound Scraping Defense**:
  1. *Declarative Layer*: `robots.txt` blocking bots (`GPTBot`, `CCBot`), `ai.txt`, express Text and Data Mining (TDM) opt-out headers (`X-Robots-Tag: noai, noimageai`), and explicit ToS prohibitions.
  2. *Access Layer*: Placing user directories, customer profiles, and proprietary data strictly behind authenticated session walls.
  3. *Technical Layer*: Edge rate limiting, behavioral bot detection (Cloudflare Turnstile/Bot Management), and IP reputation filtering.
* **Inbound AI Training Compliance**:
  * **EDPB Guidelines 03/2026 & GAID Art. 44**: Legitimate Interest for AI training requires a documented 3-part balancing test, respect for `robots.txt`, and automated pre-ingestion PII filtering.
  * **Zero Data Retention (ZDR)**: Commercial integrations with LLM APIs (OpenAI, Anthropic, Google) must enforce enterprise Zero Data Retention agreements preventing customer queries from training public models.
  * **User Opt-Out Toggle**: Provide an explicit toggle in user settings: `[ ] Allow my data to train AI models`.

---

## Part 4: Common Developer Mistakes & CWE Prevention (OWASP / MITRE 2025)

| Vulnerability Class | 2025 / 2023 Ranking | Common Developer Mistake | Attacker Exploit & Impact | Industry-Standard Prevention |
|---|---|---|---|---|
| **Cross-Site Scripting (XSS)** | **#1 CWE Top 25** (CWE-79, score 60.38); OWASP A05:2025 | Rendering untrusted input into HTML/DOM templates without context-aware encoding. | Hijacks user sessions, performs unauthorized actions in user context. | Context-aware auto-escaping (React default), strict CSP, HTTP-only cookies via **BFF pattern**. |
| **Broken Object-Level Auth (BOLA / IDOR)** | **#4 CWE-862**, #17 CWE-863, #24 CWE-639; OWASP A01:2025, API1:2023 | Verifying authentication on `/api/orders/5001` without checking if the user owns order 5001; sequential IDs. | Attacker iterates IDs to dump or alter other tenants' data (~40% of API attacks). | Centralized ownership middleware on every parent and nested child route; PostgreSQL **Row-Level Security (RLS)**; non-guessable **UUIDv4s**. |
| **SQL & Command Injection** | **#2 CWE-89** SQLi, **#9 CWE-78** OS Command (#1 on 2025 KEV list) | Concatenating strings into SQL queries or passing user input to shell/eval interpreters. | Full database exfiltration, authentication bypass, Remote Code Execution (RCE). | Parameterized queries / typed ORMs (Prisma, Drizzle) strictly enforced by linters; dynamic shell/eval calls completely banned. |
| **CSRF & SSRF** | **#3 CWE-352** CSRF; **#22 CWE-918** SSRF; OWASP A01:2025 & API7:2023 | Accepting cookie mutations without anti-CSRF tokens; fetching user-supplied URLs server-side (webhooks, previews). | Forces victim browser into unwanted actions; SSRF queries cloud metadata (`169.254.169.254`) to steal IAM credentials. | SameSite cookies + CSRF tokens; strict domain allowlists and network egress blocks on RFC 1918 private IPs and cloud metadata addresses. |
| **Supply Chain & Payment Formjacking** | OWASP A03 & A08:2025; **#15 CWE-502** (Deserialization) | Deserializing untrusted objects; unpinned dependencies; loading unverified third-party JS on payment forms. | Server RCE; browser Magecart/formjacking card skimming. | Safe JSON parsing; SLSA provenance & SBOM; **PCI DSS 6.4.3** script inventory and SRI hash verification. |
| **Unrestricted File Upload** | **#6 CWE-22** (Path Traversal), **#12 CWE-434** File Upload | Serving uploaded files from web-executable paths; trusting user-supplied filenames containing `../`. | Web shell uploads leading to server compromise; arbitrary config/credential reads. | Non-executable object storage (S3/R2); random UUID filenames; magic-byte MIME validation; path canonicalization. |
| **Mass Assignment & Shadow APIs** | **#21 CWE-306**; OWASP API3:2023, A07:2025 | Binding raw request JSON bodies directly to database models (allowing `isAdmin: true`). | Privilege escalation, account takeover. | **Explicit DTO field allowlists**; per-endpoint rate limits; continuous API discovery and retirement of deprecated `/v1/` routes. |
| **Misconfiguration & Fail-Open Errors** | OWASP A02 & A10:2025; **#13 CWE-476**, **#20 CWE-200** | Shipping debug stack traces, exposed `.env` files, open cloud buckets, or auth checks that fail open on error. | Credential theft, authorization bypass triggered by malformed inputs. | **Fail-closed** error handling, automated secret scanning in CI/CD, PII/secret masking in logs. |

### The Three Damaging Habits to Eliminate
1. **Patching Instances Instead of Banning Classes**: Never fix one SQL injection by escaping a string while leaving raw concatenation permitted elsewhere. Enforce ESLint rules that ban raw queries across the entire repository.
2. **Deploying Code Fixes Without Rotating Secrets**: After discovering path-traversal or information disclosure bugs, immediately rotate all database credentials, session signing keys, and API tokens that could have been read.
3. **Broadcasting Previews via Public TLS**: Never create public TLS certificates for internal test environments; use private PKI or wildcard certs to avoid leaking infrastructure to Certificate Transparency logs.

---

## Part 5: 5-Layer Real-Time Monitoring & Availability Architecture

```
                  ┌────────────────────────────────────────┐
                  │ 1. Edge WAF & DDoS Protection (Edge)   │
                  └───────────────────┬────────────────────┘
                                      ▼
                  ┌────────────────────────────────────────┐
                  │ 2. Runtime Application Self-Protection │
                  │    (RASP - In-Process Zero-Day Guard)  │
                  └───────────────────┬────────────────────┘
                                      ▼
                  ┌────────────────────────────────────────┐
                  │ 3. Client-Side Payment Script Monitor  │
                  │    (PCI DSS 11.6.1 Tamper Detection)   │
                  └───────────────────┬────────────────────┘
                                      ▼
                  ┌────────────────────────────────────────┐
                  │ 4. OpenTelemetry, SIEM & SOAR Engine   │
                  │    (Active BOLA Enumeration Detection) │
                  └───────────────────┬────────────────────┘
                                      ▼
                  ┌────────────────────────────────────────┐
                  │ 5. Certificate Transparency & External │
                  │    Attack Surface Watch (DNSSEC, CAA)  │
                  └────────────────────────────────────────┘
```

1. **Edge WAF + Runtime RASP (Runtime Application Self-Protection)**:
   * Edge WAF absorbs volumetric DDoS, blocks bad bots, and filters known injection signatures.
   * RASP embeds directly inside the runtime, inspecting data flows into SQL drivers, deserializers, and OS calls. Blocks zero-day attacks and terminates malicious sessions even if traffic bypasses the WAF.
2. **Client-Side Script Tamper Detection (PCI DSS v4.0.1 Req 11.6.1)**:
   * Continuously audits rendered payment pages and checkout forms. Alerts immediately on unauthorized DOM modifications, script hash mismatches, or unexpected external network transmissions (Magecart defense).
3. **OpenTelemetry, SIEM & Active BOLA Enumeration Detection**:
   * Telemetry pipelines stream correlated logs, traces, and metrics into Cloud SIEM/SOAR.
   * **Active BOLA Detection Rule**: Flags and throttles any single user/token that generates anomalous spikes in `401`, `403`, or `404` errors, or sequentially increments numeric entity IDs.
   * Automated SOAR playbooks trigger instant session revocation and IP throttling while logging MTTA/MTTR metrics for SOC 2 and ISO 27001 audits.
4. **Synthetic Transaction Monitoring & Real User Monitoring (RUM)**:
   * Scripted synthetic journeys (Sign-in ➔ Add to Cart ➔ Checkout ➔ Dashboard) execute continuously from global checkpoints.
   * Passive RUM tracks live user Core Web Vitals (LCP < 2.5s, INP < 200ms, CLS < 0.1) and JavaScript runtime errors.
5. **Certificate Transparency (CT) & External Attack Surface Watch**:
   * Continuous CT monitoring (Cert Spotter, CertStream) alerts within minutes if a rogue certificate is issued for your domains due to DNS compromise, dangling CNAMEs, or CA mis-issuance.
   * Immediate escalation: File a Certificate Problem Report with the issuing CA (which must investigate and revoke unauthorized certificates within **24 hours** under CA/Browser Forum rules).
   * Track certificate validity against CA/B Forum lifespan cuts (200 days in March 2026, 100 days in March 2027, 47 days in March 2029).
   * Continuous fuzzy Levenshtein and Punycode monitoring to detect lookalike homograph phishing domains.
   * Enforce **DNSSEC**, **CAA records** (`accounturi` and `validationmethods`), and strict email authentication (**DMARC `p=reject` or `p=quarantine`**, SPF, DKIM).

---

## Part 6: Synchronized 72-Hour Legal Incident Response Runbook

When monitoring detects an active intrusion, unauthorized TLS certificate, or personal data breach, engineering and legal teams execute this synchronized 4-step runbook:

### Step 1: Triage, Classify & Start the 72-Hour Clock
* SIEM/SOAR alert opens a dedicated emergency incident war room.
* Assign Incident Commander and Lead Security Engineer.
* **Start the 72-Hour Countdown Immediately**: Under the Nigerian Cybercrimes (Amendment) Act 2024, start the clock from the **earliest sign of intrusion or disruption** rather than waiting for post-mortem confirmation.

### Step 2: Contain the Attack & Preserve Evidence
* Isolate compromised server instances or containers.
* Block attacker IPs and revoke affected session tokens via WAF and RASP.
* Revoke and rotate all potentially exposed API keys, database credentials, and signing secrets.
* If an unauthorized TLS certificate appears: Immediately submit a Certificate Problem Report to the issuing CA (24-hour mandatory revocation).
* **Preserve Forensic Evidence**: Take live memory and disk snapshots, and secure immutable audit logs (never wipe or power off servers blindly).

### Step 3: File Parallel Regulatory Notifications Within 72 Hours
1. **Nigerian Sectoral CERT / SOC (Feeding ngCERT)**:
   * Mandatory under **Cybercrimes (Amendment) Act 2024 Section 21**. Report any cyber attack or disruption liable to hinder system functioning within 72 hours to avoid the **₦2,000,000 non-reporting fine**.
2. **Nigeria Data Protection Commission (NDPC)**:
   * If personal data is impacted, file statutory breach notification under **NDPA 2023 Section 40** detailing nature of breach, categories of data subjects, likely consequences, and mitigation measures.
3. **European Union DPAs (if EU users affected)**:
   * Notify lead Supervisory Authority under **GDPR Article 33** within 72 hours.
4. **UK Information Commission (if UK users affected)**:
   * Submit breach notification aligned to 72 hours under UK GDPR and PECR.

### Step 4: Remediate Classes, Rotate Secrets & Close Audit Loop
* Eradicate the entire vulnerability class across the repository (e.g. static analysis rules banning dynamic SQL or eval).
* Rotate every machine key, service account, and signing secret.
* Verify recovery through automated synthetic smoke tests.
* Publish a blameless post-mortem within 24–48 hours detailing root cause, timeline, and permanent architectural preventative measures.
* Encode new regression checks into the CI/CD pipeline gate.
