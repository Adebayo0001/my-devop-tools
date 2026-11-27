---
name: review
description: Silicon Valley DevOps and Quality Assurance release gate. Executes deterministic terminal verification (tsc, build, secret scans), audits BOLA/IDOR zero-trust authorization, checks Atomic UI registry consistency, verifies Sentry/Datadog observability, and outputs a prioritized P0/P1/P2 defect report.
---

# Workflow: review (Evergreen Silicon Valley Release Gate)

Invoke with `/review` before client demos, major milestone deployments, or whenever a build "feels off" — or applied automatically per `AGENTS.md` before finalizing any release.

**Goal**: Act as the final Quality Assurance, DevOps, and Observability release gate. Catch security vulnerabilities, type regressions, design system drift, observability gaps, and accessibility barriers before software reaches production.

---

## The Evergreen Review Invariants

1. **Deterministic Verification Over "Looks Good"**: A visual inspection is necessary but insufficient. The review must execute deterministic terminal validation commands (`tsc`, `build`, `test`, secret scans).
2. **Prioritized Severity Reporting**: Findings must be structured into industry-standard P0 (Blocker), P1 (Critical), and P2 (Polish) categories so the developer can immediately triage what matters.
3. **No Unplanned In-Flight Patches**: The review workflow audits and reports; it does not silently rewrite code during review. Fixes are planned and executed as deliberate, verified steps.

---

## Step-by-Step Protocol

### 1. Terminal CI & Verification Suite
Execute and verify each command in the terminal:
- **Strict Type Check**: Run `tsc --noEmit` (or language compiler). Must exit `0` with zero errors and zero `as any` / `@ts-ignore` evasions.
- **Production Build**: Run `npm run build` (or framework build). Must exit `0` with zero bundle or asset failures.
- **Automated Secret Scan**: Inspect modified files for accidental credential commits (`sk-...`, `AIza...`, `ghp-...`, private keys).
- **Dependency Integrity & CISA KEV**: Cross-reference Software Composition Analysis (SCA) against CISA's Known Exploited Vulnerabilities (KEV) catalog. Verify that no unvetted or hallucinated packages exist in `package.json`.

### 2. Cybersecurity, OWASP ASVS 5.0.0 & Legal Compliance Gate
Verify against `06-Security-and-Legal-Compliance/compliance-audit-checklist.md` and `production-readiness-security-legal-handbook.md`:
- [ ] **OWASP ASVS 5.0.0 Level 2 Verification**: Manual verification of business logic, authorization boundaries, and tenant isolation; zero critical defects.
- [ ] **Authorization & Ownership (BOLA / IDOR Defense)**: Do all database mutations and endpoints verify that the authenticated user owns the resource (`WHERE organization_id = session.org_id`)? Non-guessable UUIDv4s used.
- [ ] **Backend-for-Frontend (BFF) Token Encapsulation**: Browser JS must never hold raw bearer tokens or JWTs in `localStorage`/`sessionStorage`. Tokens encapsulated in `HttpOnly; Secure; SameSite=Lax` cookies.
- [ ] **Mass Assignment Defense**: Are all incoming payloads validated through strict Data Transfer Object (DTO) field allowlists (Zod)? Raw JSON bodies never bound directly to DB models.
- [ ] **Row-Level Security (RLS)**: Is PostgreSQL RLS active on all multi-tenant tables?
- [ ] **Boundary Validation & Injection Defense**: 100% of queries parameterized via typed ORMs (Prisma, Drizzle); dynamic shell/eval calls completely banned.
- [ ] **Safe Rendering & XSS Protection**: Context-aware auto-escaping; zero un-sanitized `dangerouslySetInnerHTML`. Strict Content Security Policy (CSP) active.
- [ ] **Payment Page Protection (PCI DSS v4.0.1 Req 6.4.3 & 11.6.1)**: If payments exist, verify SRI hashes and business justification for every client script, and verify client-side tamper detection.
- [ ] **CAC CAMA 2020 Corporate Identity Imprint**: Does the legal footer and digital invoice template state registered company name, **RC Number**, registered office address, and directors' particulars?
- [ ] **FCCPC Consumer Protection**: No blanket "No Refund" text (statutory remedies declared for defective goods/failed SaaS); checkout price strictly matches displayed price; itemized digital receipts generated.
- [ ] **Global Privacy Control (GPC)**: Automatic detection of `Sec-GPC: 1` request header and `navigator.globalPrivacyControl`; `/.well-known/gpc.json` served.
- [ ] **Responsible Disclosure**: `/.well-known/security.txt` published with authorized testing scope under Cybercrimes Act s.6(2).
- [ ] **Mandatory Statutory Legal Pages**: Privacy Policy (`/privacy`), Terms of Service (`/terms`), Accessibility Statement (`/accessibility` WCAG 2.1 AA / EAA 2025), and Refund Policy (`/refunds`) live with verified DPO contact details.
- [ ] **Cookie Consent Compliance**: Zero pre-consent tracking; Cookie Banner features equal-weight "Reject All" button (zero dark patterns).
- [ ] **Data Subject Rights & AI Ethics**: Functional self-serve Account Deletion ("Right to be Forgotten") and Data Export (JSON/CSV); AI model training opt-out toggle and ZDR API contracts confirmed.
- [ ] **72-Hour Legal Incident Readiness**: Verified incident protocol linking to `06-Security-and-Legal-Compliance/72-hour-incident-response-runbook.md` (ngCERT, NDPC, EU DPAs).
- [ ] **Error Tracking Integration (Sentry / LogRocket)**:
  - Do Error Boundaries wrap all major organism routes and screen layouts?
  - Are unhandled promise rejections and window errors captured?
  - Is client-side and server-side PII scrubbing (`beforeSend` / sanitize hooks) active to prevent token/password leakage?
- [ ] **Performance Monitoring Integration (Datadog)**:
  - Are APM distributed tracing headers configured across backend routes?
  - Is Datadog RUM tracking front-end vitals (INP, LCP, CLS)?
  - Are critical endpoints protected with latency alert thresholds?

### 3. Atomic Design, Typography Quarantine & Single-Knob CSS Consistency
Audit against `context/ui-tokens.md`, `globals.css`, and `context/ui-registry.md`:
- [ ] **Atomic Hierarchy Compliance**: Are UI components correctly structured into Atoms, Molecules, and Organisms?
- [ ] **shadcn/ui + Radix UI Foundation**: Are interactive primitives (buttons, dialogs, dropdowns, inputs) built on accessible **Radix UI** primitives and **shadcn/ui** patterns? Zero raw, unaccessible custom widgets.
- [ ] **Typography Containment & Monospace Quarantine**:
  - Is `font-mono` strictly quarantined to code blocks and developer consoles? Zero monospace leaks across public cards, buttons, badges, navigation, or text.
  - Is the primary brand font loaded cleanly with bulletproof system fallbacks in `tailwind.config.ts`?
- [ ] **Single-Knob Global CSS Cascade Test**:
  - Do all colors consume HSL/OKLCH CSS variables in `globals.css` (e.g., `hsl(var(--primary))`) mapped through `tailwind.config.ts`?
  - Zero hardcoded `#hex` values or unmapped Tailwind utility colors (`bg-blue-600`).
  - Does changing `--primary` in `globals.css` cascade cleanly across all Atoms, Molecules, and Organisms without broken selectors?
- [ ] **Sprint Design System Immutability**: Did new feature screens strictly compose existing registered Atoms and Molecules rather than hallucinating ad-hoc, un-imprinted card or button variants?

### 4. User UX Research, Jakob's Law & Human Copywriting Domain Gate
Audit against UX research findings in `context/project-overview.md` and Bootcapt Review standards:
- [ ] **The 5-Second Test**:
  - Can a first-time visitor identify what the product does within 5 seconds?
  - Can they immediately identify who it is for?
  - Is the primary onward action obvious and unambiguous?
- [ ] **Jakob's Law Usability & Cognitive Friction**:
  - Does the interaction model feel intuitive and familiar based on top market apps (Stripe, Linear, Notion, Airbnb)?
  - Are users spared from having to "learn" a convoluted custom flow? Maximum 1 primary CTA per viewport.
- [ ] **Human Copywriting & Copy Domain Isolation**:
  - Did the copy pass the **12-Year-Old & Executive Litmus Test**?
  - **Zero Internal Plumbing Leaks**: Are engineering terms (*"dispatch gates"*, *"circuit breakers"*, *"mutation triggers"*, *"BOLA checks"*) completely absent from public UI?
  - Zero `Lorem Ipsum`, zero placeholder text, zero hollow AI buzzwords (*"seamless"*, *"transformative"*).
- [ ] **Keyboard Navigability (WCAG 2.1 AA)**: All interactive elements reachable via Tab and activatable via Enter/Space.
- [ ] **Focus Rings & Contrast**: Visible, tokenized focus rings present (`outline: none` strictly forbidden without ring replacement). Text contrast meets WCAG AA (≥4.5:1 for body copy; ≥3:1 for large display text and UI components).
- [ ] **Screen Readers**: Meaningful `alt` on informational images; `alt=""` for decorative assets; `aria-label` on icon-only buttons; real connected `<label>` elements on forms.

### 5. Responsive, Layout & Performance Sanity Pass
- [ ] **Mobile 375px Viewport Audit**:
  - Tested at 375px width — zero horizontal scroll or layout clipping.
  - Navigation collapses smoothly with proper focus trapping.
  - All interactive elements and touch targets are minimum 44×44px.
  - Mobile body text is never below 16px to prevent iOS auto-zoom and illegibility.
- [ ] **Tablet (768px) and Desktop (1440px) Grid Alignment**:
  - Content containers do not stretch uncontrollably (max-width enforced, body text line-length capped at 45–75 characters / max 680px).
- [ ] **Performance Sanity**:
  - No N+1 queries in data loaders.
  - Dynamic lists exceeding 50 items are paginated or virtualized.
  - Images have explicit width/height dimensions to eliminate Cumulative Layout Shift (CLS < 0.1).
  - Modern formats used (WebP / AVIF).

### 6. Deliver the Prioritized Review Report
Deliver findings clearly categorized by severity:

```markdown
### 🛡️ Release Review Report: [Feature/Milestone]

#### 🔴 P0 — Release Blockers (Must fix before shipping/demo)
- None (or list any security holes, build errors, missing Error Boundaries, data loss risks, or broken 375px responsive views)

#### 🟡 P1 — Critical Quality, Observability & Compliance (High priority)
- [Missing Sentry PII scrubbing, unmapped hex codes, leaked internal plumbing copy, monospace font leaks, accessibility gaps, N+1 query risks]

#### 🟢 P2 — Visual & Token Polish (Minor items)
- [Token alignment, spacing polish, subtle layout refinements, micro-copy tweaks]

#### 📋 Terminal Verification & Observability Summary
- `tsc --noEmit`: ✅ Exited 0
- `npm run build`: ✅ Exited 0
- Secret Scan: ✅ 0 credentials detected
- Observability: ✅ Sentry Error Boundaries active | ✅ Datadog RUM/APM active | ✅ PII scrubbing active
- Typography Containment: ✅ 0 monospace leaks | Brand font cascade verified
- Copy Domain Isolation: ✅ Passed (zero leaked plumbing, 12-year-old test passed)
- Atomic CSS Cascade: ✅ Single-knob variable test verified
- 5-Second Test: ✅ Passed (clear value prop & primary action)
- Responsive Floor: ✅ Verified at 375px, 768px, 1440px
- Post-Build Verification Handoff: ✅ All completed features verified via agent automated or human acceptance testing
- Overall Verdict: **[READY TO SHIP / ACTION REQUIRED]**
```

