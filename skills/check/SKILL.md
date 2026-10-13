---
name: check
description: Dual-mode Silicon Valley Pre-Merge Verification Gate. `/check verify` executes runtime application testing against specs and acceptance criteria. `/check review` performs a senior code review on the git diff, ranking findings by severity (P0/P1/P2) and auditing zero-trust security, design tokens, and human copywriting.
---

# Workflow: check (Dual-Mode Pre-Merge Verification Gate)

Invoke with `/check` (or specifically `/check verify` or `/check review`) before creating a pull request or merging a feature.

**Goal**: Deliver absolute proof that a change works in runtime and meets all production standards. Eliminates "works on my machine" and self-review blind spots.

---

## The Modes

| Mode | Trigger | Verification Target | Output |
|---|---|---|---|
| **`/check verify`** | After `/develop` or feature completion | **Runtime Proof**: Drives the live application to prove behavior against every numbered acceptance criterion. | Live runtime verification report; screenshot/recording telemetry. |
| **`/check review`** | Before PR / merge | **Diff Inspection**: A senior code audit of the git diff evaluating security, architecture, design tokens, and anti-slop rules. | Prioritized P0/P1/P2 defect report in `docs/reviews/` or chat. |

---

## Mode 1: `/check verify` Protocol (Runtime Proof)

### 1. Load Spec & Acceptance Criteria
- Read the active spec in `docs/specs/` or `context/build-plan.md`.
- Extract all numbered Acceptance Criteria (`AC-1`, `AC-2`, etc.).

### 2. Verify Runtime Environment
- Check if the dev server or local application is running. If not, start it (e.g. `npm run dev`).
- Confirm database migrations and seed data are applied.

### 3. Drive Application & Assert Behaviors
Drive the application using terminal commands or the browser subagent:
- **Default State**: Navigate to the route. Confirm layout hierarchy, primary CTA, and data render.
- **Interactive Mutation**: Perform user actions (submit form, trigger filter, invoke API). Confirm responsive feedback.
- **The 5 States Audit**:
  - [ ] **Default**: Standard state operates smoothly.
  - [ ] **Loading**: Skeletons or loaders display during latency.
  - [ ] **Empty**: Zero-data guidance is clear and helpful.
  - [ ] **Error**: User-friendly toast or boundary message renders (zero raw stack traces).
  - [ ] **Edge Cases**: 375px mobile viewport has zero horizontal scroll; long strings truncate gracefully.
- **Observability Check**: Check browser console for errors or unhandled rejections. Verify Sentry breadcrumbs and Datadog APM headers.

### 4. Verification Verdict
Output the runtime proof report:
- Mark each acceptance criterion as `PASSED` or `FAILED`.
- If any criterion fails, route immediately to `/debug` or `/recover`.

---

## Mode 2: `/check review` Protocol (Code Review & Anti-Slop Audit)

### 1. Scope the Git Diff
- Examine changed files against the base branch (`git diff main...HEAD` or `git diff HEAD`).
- Focus on substantive additions and modifications.

### 2. Silicon Valley Standards Audit
Audit the diff across 7 mandatory categories:

1. **Security & Zero-Trust (BOLA/IDOR)**:
   - Does every database query or route handler verify that the authenticated user owns the resource?
   - Are all inputs parsed via strict schemas (Zod)? Zero un-sanitized HTML injection.
2. **Non-Destructive Blast Radius & Anti-Regression Check**:
   - Did the diff modify ANY file, function, or line outside the declared blast radius? (P0 violation if unapproved files touched).
   - Were any previously working features, component props, exported handlers, or layout sections broken or silently deleted? (P0 violation if regressions introduced).
   - Are all changes surgical block diffs rather than destructive wholesale file rewrites?
3. **100% Detail Ingestion & Traceability Check**:
   - Are 100% of the user-explained prompt details (`D-1`, `D-2`, etc.) present in the implementation? Zero dropped constraints or ignored edge cases.
4. **Typography Containment & Monospace Quarantine**:
   - Is `font-mono` strictly quarantined to code blocks (`<pre><code>`) and developer terminals?
   - Zero monospace leaks across public cards, buttons, badges, navigation, or headings.
5. **Anti-Pill / Anti-Badge Law**:
   - Zero rounded pill badges or emoji chips (`[✨ OUR SERVICES]`) placed above headings.
   - Headings rely on pure typographic hierarchy.
6. **Human Copywriting & Copy Domain Isolation**:
   - Did public UI copy pass the **12-Year-Old & Executive Litmus Test**?
   - **Zero Leaked Plumbing**: Are internal engineering variables (*"dispatch gates"*, *"circuit breakers"*, *"mutation triggers"*, *"BOLA checks"*) completely absent from user screens?
   - Zero `Lorem Ipsum`, zero placeholder text, zero hollow AI buzzwords (*"seamless"*, *"transformative"*).
7. **Atomic Composition & Single-Knob CSS Cascade**:
   - Are UI components composed from registered Atoms and Molecules from `context/ui-registry.md`?
   - Do all styles consume CSS variables in `globals.css`? Zero hardcoded `#hex` colors or unmapped utilities.
   - Core Web Vitals checks: images sized, zero unbounded lists, clean mobile collapse at 375px.

### 3. Deliver Prioritized Review Report
Deliver findings structured into standard severity tiers:

```markdown
### 🛡️ Check Review Report: [Feature Name]

#### 🔴 P0 — Release Blockers (Must fix before merge)
- [Accidental regressions, collateral damage to previously working code, unauthorized blast-radius expansion, security vulnerabilities, BOLA holes, build failures]

#### 🟡 P1 — Critical Quality & Standards (High priority)
- [Omitted prompt details from Requirement Ingestion Matrix, monospace leaks, unmapped hex codes, leaked internal plumbing copy, missing Sentry PII scrubbing, N+1 query risks]

#### 🟢 P2 — Polish & Enhancements (Minor items)
- [Micro-copy refinement, subtle layout polish, spacing adjustments]

#### 📋 Verdict
- **[PASSED / ACTION REQUIRED]**
```

Optionally save the review record to `docs/reviews/<date>-<feature-slug>.md`.
