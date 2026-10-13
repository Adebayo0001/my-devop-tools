---
name: document
description: Autonomous Technical Writer. Generates human-facing documentation grounded strictly in real git commits and diffs. Generates PR descriptions, Keep a Changelog entries, user-facing release notes, and SRE incident postmortems with zero hallucinated features.
---

# Workflow: document (Grounded Technical Writer Engine)

Invoke with `/document` (or `/document pr`, `/document changelog`, `/document release-note`, `/document postmortem`) to write accurate, professional documentation about completed work.

**Goal**: Transform real codebase diffs and commits into crystal-clear prose for developers, reviewers, clients, and end users. Never invents facts, dates, or capabilities not present in the git tree.

---

## Document Types

| Type | Source Data | Primary Audience | Output Destination |
|---|---|---|---|
| **`pr`** | Branch diff vs base (`git diff origin/main...HEAD`) | Code Reviewers & Team | PR title & markdown body (ready for GitHub PR / `gh pr create`) |
| **`changelog`** | Merged commits or staged feature | Developers & Stakeholders | Appended to `CHANGELOG.md` (Keep a Changelog standard) |
| **`release-note`** | Tagged release or milestone diff | Clients & End Users | `docs/releases/<version>.md` (conversational, benefit-driven) |
| **`postmortem`** | Bugfix diff + `/recover` RCA | Engineering & Leadership | `docs/postmortems/<date>-<slug>.md` (blameless root cause analysis) |

---

## The Documentation Invariants

1. **Truth from Git Reality**: Every bullet point must trace directly to an actual commit or diff. Hallucinating uncommitted features or phantom fixes is strictly forbidden.
2. **Human Copywriting Standard**: Zero hollow AI buzzwords (*"seamless"*, *"transformative"*, *"unlocking next-level experiences"*). Use clear, crisp, active verbs.
3. **Copy Domain Isolation**:
   - For `release-note`: Keep language 100% focused on user value and business benefits. Ban internal plumbing variables (*"hydration dispatch"*, *"circuit breakers"*, *"mutation triggers"*).
   - For `pr` and `postmortem`: Include precise technical mechanics, schema contracts, and file paths.

---

## Execution Protocol

### 1. Identify Document Type
If passed as an argument (`/document pr`), execute that mode immediately.  
If invoked bare (`/document`), infer the type from the git state:
- On a feature branch ahead of `main` → Infer `pr` (Recommended)
- Just after a merge or release tag → Infer `changelog` or `release-note`
- Just resolved a critical defect via `/recover` → Infer `postmortem`

Present the selection to the developer with the inferred option marked `(Recommended)`.

---

### 2. Generate Content by Mode

#### Mode A: Pull Request (`pr`)
Inspect `git log origin/main..HEAD --oneline` and `git diff origin/main...HEAD --stat`:
Format the output:
```markdown
## Summary
[1-2 sentences in plain English explaining the problem solved and the value delivered]

## What Was Built & Changed
- **[Component/Module]**: [Description of changes and files touched]
- **State & Schema**: [Database schemas, API contracts, or state handlers updated]

## Verification & Testing Proof
- [x] Strict type check (`tsc --noEmit`) passed with 0 errors
- [x] Production build (`npm run build`) exited 0
- [x] Unit/Integration tests created and passing
- [x] 375px mobile responsiveness verified with zero horizontal scroll
- [x] Single-knob CSS cascade verified; zero unmapped hex colors

## Security & Observability Checks
- [x] Zero-trust resource ownership verified (BOLA/IDOR protection)
- [x] Sentry Error Boundaries & PII scrubbing active
- [x] Zero secrets committed
```

#### Mode B: Changelog (`changelog`)
Inspect recent commit messages and format as Keep a Changelog:
- Categorize changes under: `### Added`, `### Changed`, `### Fixed`, or `### Security`.
- Append cleanly under the `## [Unreleased]` header in `CHANGELOG.md`.

#### Mode C: Release Notes (`release-note`)
Write user-facing notes to `docs/releases/<version>.md`:
- Pass the **12-Year-Old & Executive Litmus Test**: Explain new features in terms of daily user benefits.
- Include actionable guidance on new capabilities, UI changes, or workflows.

#### Mode D: SRE Postmortem (`postmortem`)
Write a blameless postmortem to `docs/postmortems/<date>-<slug>.md`:
- **Incident Summary**: What occurred, duration, and user impact.
- **Root Cause Analysis (RCA)**: The exact technical failure mechanism (syntax, contract collision, race condition).
- **Resolution**: How the surgical fix was applied.
- **Regression Prevention**: The new test suite added in `/test` to prevent recurrence.
