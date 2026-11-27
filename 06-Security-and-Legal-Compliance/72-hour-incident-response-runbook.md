# 72-Hour Legal Incident Response Runbook
### Emergency Cyber Attack & Data Breach Protocol (Nigeria, UK, EU, US)

> [!CAUTION]
> Under Nigeria's **Cybercrimes (Amendment) Act 2024 Section 21**, failure to report a cyber attack or disruption to your sectoral CERT/SOC within 72 hours carries a **mandatory statutory fine of ₦2,000,000**.
> Under the **NDPA 2023**, **EU GDPR**, and **UK GDPR**, personal data breaches must be reported to data protection regulators within **72 hours** of discovery.

---

## The Synchronized 4-Step Incident Lifecycle

```
[Minute 0]  Detection & Alert (SIEM/SOAR/WAF/User Report)
   │
   ▼
[Hour 0–2]  Step 1: Triage, Containment & Forensic Preservation
   │        • Assign Incident Commander & Lead Engineer
   │        • START THE 72-HOUR COUNTDOWN IMMEDIATELY
   │        • Isolate compromised hosts / revoke active sessions via RASP/WAF
   │        • Preserve disk/memory snapshots & immutable logs (DO NOT WIPE)
   │
   ▼
[Hour 2–24] Step 2: Secret Rotation & Certificate Escalation
   │        • Rotate all database credentials, machine keys, and API tokens
   │        • If rogue TLS certificate: File Certificate Problem Report with CA (24h SLA)
   │
   ▼
[Hour 24–72]Step 3: Parallel Regulatory Breach Notifications
   │        • Nigeria ngCERT / Sectoral CERT/SOC (Cybercrimes Act s.21)
   │        • Nigeria Data Protection Commission (NDPC - NDPA s.40)
   │        • Lead EU DPA (GDPR Art. 33) / UK Information Commission (PECR)
   │
   ▼
[Post 72h]  Step 4: Class Remediation & Blameless Post-Mortem
            • Eradicate vulnerability class across repository
            • Publish 24–48h internal blameless post-mortem
            • Encode regression gate into CI/CD pipeline
```

---

## Step-by-Step Incident Execution Plan

### Step 1: Immediate Triage & Forensic Preservation (Hours 0–2)
1. **Open Incident War Room**:
   * Designate **Incident Commander (IC)**, **Security Lead**, and **Legal/Communications Lead**.
   * Start a shared, timestamped incident log.
2. **Start the Clock**:
   * Start the **72-hour countdown timer** from the earliest timestamp of intrusion or disruption.
3. **Containment Without Evidence Destruction**:
   * *DO NOT* immediately delete, overwrite, or power off affected virtual machines or containers.
   * Terminate malicious sessions via WAF or database session revocation.
   * Apply egress firewall blocks to prevent data exfiltration.
   * Take forensically sound memory dumps and disk snapshots.

---

### Step 2: Secret Rotation & CA Escalation (Hours 2–24)
1. **Comprehensive Secret Invalidation**:
   * Immediately rotate all database passwords, session signing keys, JWT secrets, and third-party API tokens.
   * Invalidate all active user refresh tokens to force re-authentication.
2. **Unauthorized TLS Certificate Escalation**:
   * If an unauthorized certificate is discovered via Certificate Transparency logs (CertStream, Cert Spotter):
   * Immediately identify the issuing Certificate Authority (e.g. Let's Encrypt, DigiCert).
   * Submit an urgent **Certificate Problem Report** requesting revocation. Under CA/Browser Forum Baseline Requirements, the CA is legally required to investigate and revoke unauthorized certificates within **24 hours**.

---

### Step 3: Statutory Regulatory Notifications (Hours 24–72)
Assemble the incident report: date/time of occurrence, systems affected, categories of data subjects, potential consequences, and remedial measures taken. Submit parallel notifications:

| Authority / Regulator | Statutory Mandate | Submission Route & Deadline | Mandatory Inclusions |
|---|---|---|---|
| **Nigeria ngCERT & Sectoral SOC** | Cybercrimes Act 2024 s.21 | Sectoral CERT portal / `incident@cert.gov.ng` within **72 hours** | Description of attack, system disruption status, IP indicators, mitigation actions taken. |
| **Nigeria NDPC** | NDPA 2023 s.40 | Official NDPC breach portal / `info@ndpc.gov.ng` within **72 hours** | Number of Nigerian data subjects affected, categories of personal data, potential risk, DPO contact. |
| **EU Lead Supervisory Authority** | EU GDPR Art. 33 | Designated national DPA breach portal within **72 hours** | Nature of breach, categories of data, DPO details, likely consequences, measures taken. |
| **UK Information Commission** | UK GDPR & PECR | Official electronic breach form within **72 hours** | Nature of security incident, volume of records, impact assessment, remediation timeline. |

---

### Step 4: Class-Level Remediation & Audit Closure (Post-72 Hours)
1. **Eradicate the Vulnerability Class**:
   * Never simply patch the single vulnerable endpoint.
   * If a BOLA bug occurred, audit every single route in the codebase for missing ownership validation.
   * If dynamic SQL occurred, configure ESLint/compiler rules to ban string concatenation across all queries.
2. **Runbook Verification Run**:
   * Execute automated end-to-end synthetic smoke tests verifying that login, checkout, and critical user journeys pass cleanly.
3. **Blameless Post-Mortem**:
   * Publish an internal post-mortem within 48 hours:
     * Executive Summary & Incident Timeline.
     * Root Cause Analysis (5 Whys).
     * What went well, what went wrong, and where were we lucky.
     * Preventive Action Items with assigned owners and deadlines.
4. **CI/CD Regression Encoding**:
   * Write an automated integration test or custom SAST rule reproducing the attack pattern so it can never be deployed again.
