---
name: recover
description: Site Reliability and Circuit Breaker workflow triggered after ONE failed correction attempt. Halts blind code patches, conducts forensic git and error log inspection, classifies failures via a 3-tier taxonomy, and applies a verified surgical fix with regression testing.
---

# Workflow: recover (Evergreen Silicon Valley SRE Edition)

Invoke with `/recover` immediately when an unexpected error occurs and **one corrective attempt has already failed** to resolve it — mandatory per `AGENTS.md`.

**The Circuit Breaker Rule**: The trigger is exactly **one** failed correction. The core purpose of `/recover` is to halt the compounding spiral where successive blind attempts destabilize the codebase, pollute context, and obscure the true root cause.

---

## The Evergreen Recovery Invariants

1. **Immediate Execution Freeze**: Stop generating iterative code patches. Do not "try one more thing."
2. **Inspect the Git Baseline**: Before diagnosing, inspect `git status` and `git diff` to understand what was touched in the failed attempt. Never let speculative edits linger.
3. **No Hallucinated Diagnoses**: If logs, terminal outputs, or stack traces are ambiguous, state the missing data and ask for it. Never present a guess as a diagnosis.
4. **Mandatory Regression Shield**: Every bug resolved via `/recover` must result in a regression test or an explicit manual QA reproduction step to guarantee it cannot be reintroduced.

---

## Step-by-Step Protocol

### 1. Halt and Assess Git State
Run `git status` and inspect the diff of the recent failed attempt:
- What files were modified?
- Did the failed attempt introduce unintended edits or collateral damage?
- If the failed attempt made things worse, revert the speculative diff before proceeding.

### 2. Forensic Log Inspection
Re-read the **complete, raw error output and stack trace**:
- Trace the failure to its true point of origin, not merely the top-level unhandled rejection.
- Identify the subsystem: Is it a build/compile error, a runtime network failure, a database constraint violation, or an Electron IPC error?

### 3. Classify Failure Mode (The 3-Tier Taxonomy)

| Failure Tier | Symptoms | Mandatory Recovery Action |
|---|---|---|
| **Tier 1: Localized Defect** | Isolated syntax, type error, or single logic flaw. Rest of app healthy. | **Surgical Fix**: Isolate the exact failing line/interface. Apply targeted fix without touching surrounding architecture. |
| **Tier 2: Contract / State Collision** | Race condition, state desync, cache invalidation bug, or violated `architecture.md` invariant. | **Architectural Realignment**: Revert broken attempt. Review state lifecycle in `architecture.md`. Re-wire data flow properly. |
| **Tier 3: Context Collapse / Hallucination Loop** | Agent is running in circles, inventing phantom APIs, or patching patches across 5+ files. | **Session Reset Protocol**: Save clean snapshot via `/remember save`. Start a fresh session and reload via `/remember restore`. |

### 4. Cross-Reference Architectural Decisions
Inspect `context/progress-tracker.md` (Decisions Made During Build):
- Did a recent decision alter an underlying assumption or interface?
- Check `context/architecture.md` invariants: Did the failed code violate an ownership boundary, type contract, or state rule?

### 5. Formulate Root Cause Analysis (RCA) & Propose Surgical Refinement
Present the RCA and surgical modification contract to the developer. Strictly enforce the **Bootcapt Surgical Refinement Law**: never rebuild what is working. Isolate what is functioning and specify only the surgical delta:

```markdown
### 🚨 Root Cause Analysis (RCA) & Surgical Refinement Plan
- **Symptom**: [What failed]
- **True Root Cause**: [Specific mechanism that broke]
- **Failure Classification**: [Tier 1 / Tier 2 / Tier 3]
- **Destructive Action Check**: [None / Warning if data or migrations affected]

#### 🛠️ Surgical Modification Contract:
WHAT IS WORKING — DO NOT CHANGE:
- [List verified functioning components, routes, state logic, and design tokens to keep untouched]

WHAT NEEDS TO CHANGE:
1. [Targeted surgical modification with exact specification]
2. [Targeted surgical modification with exact specification]

(After making these changes, zero untouched components or styles will be modified.)
```

*Destructive Safeguard*: If the fix involves reverting migrations, dropping data, or deleting files, stop for explicit human confirmation.

### 6. Test-Driven Verification & Incident Logging
1. Write a failing reproduction test or execute the exact failing command.
2. Apply the surgical fix strictly adhering to the "What is working vs What needs to change" contract.
3. Confirm the test passes green and terminal commands (`tsc`, tests) exit `0`.
4. Append an incident record into `context/progress-tracker.md` (Notes / Decisions section):
   `- Incident [Date]: [Issue] caused by [Root Cause]. Resolved via [Fix]. Regression guard added.`
