---
name: remember
description: Multi-session state persistence and cold resumption protocol. Snapshots exact feature progress, architectural choices, and next steps into memory.md using an append/merge discipline. Enforces automated secret redaction and reconciles git reality on restore.
---

# Workflow: remember (Evergreen Silicon Valley Session Persistence)

Two modes, invoked as `/remember save` and `/remember restore`. 

**Goal**: Eliminate context amnesia between sessions. Allow any future session — on any AI model, version, or harness — to resume complex multi-step work from a cold start with zero context loss and zero architectural drift.

---

## The Evergreen Memory Invariants

1. **Strict Append/Merge Discipline (Never Overwrite)**:
   - **NEVER** overwrite `memory.md` or ask the developer *"Do you want to overwrite?"*.
   - Always preserve historical milestones, completed features, and previous decisions. Append new progress and update the current state pointer and next steps.
2. **Automated Secret Sanitization**:
   - Never write API keys, access tokens, passwords, private keys, connection strings, or user credentials into `memory.md` or session logs. Replace any sensitive values with `[REDACTED_SECRET]`.
3. **Cold-Start Completeness**:
   - A snapshot must be specific enough that a completely fresh session (with zero prior conversation memory) can read it and immediately know the exact next terminal command or code edit to make.
4. **Reality Reconciliation on Restore**:
   - When restoring, do not assume code matches the snapshot blindly. Verify against `git status` and terminal state to detect any external changes made between sessions.

---

## Mode 1: `/remember save` (Session Checkpoint)

Invoke at a natural stopping point, when context window limits approach, or when ending a work session:

### 1. Identify Milestone Progress
Extract:
- Current active feature name and milestone ID from `context/build-plan.md`.
- Exact sub-steps completed this session.
- Remaining sub-steps pending for this feature.
- New architectural choices, library configs, or patterns established.

### 2. Formulate Structured Snapshot
Update or append to `memory.md` (and `context/progress-tracker.md`) with this standardized structure:

```markdown
## Session Checkpoint: [Feature Name] ([ISO Timestamp])

### 1. Work Completed This Session
- [Sub-step 1]: Implemented [Component/Function] in `[filepath]`.
- [Sub-step 2]: Connected [API/Store] with zero-trust validation.
- [Verification]: `tsc --noEmit` and tests passing green.

### 2. Architectural Decisions & Deviations
- Decided [Decision] because [Rationale].
- Invariants respected: [Ownership checks, tokens used].

### 3. Pending Sub-Steps (Immediate Backlog)
- [ ] [Next exact sub-step to build]
- [ ] [Subsequent sub-step]

### 4. Cold Resumption Prompt & Exact Next Step
- **Immediate Next Action**: [Concrete action, e.g., "Implement scripture search filter in ScriptureReel.tsx"]
- **Required Context**: [Key files to open upon resumption]
```

### 3. Confirm Save
Confirm to the developer:
`Session snapshot saved to memory.md. Context is safely preserved for cold resumption.`

---

## Mode 2: `/remember restore` (Cold Resumption)

Invoke at the start of any new session or when switching tasks:

### 1. Read the Saved Snapshot
Read `memory.md` and the latest checkpoint in `context/progress-tracker.md` to identify:
- What was completed.
- Where the prior session stopped.
- The exact documented next step.

### 2. Execute Context Folder Protocol
Read project context files in the mandatory sequence defined in `AGENTS.md` (skipping any that do not exist):
1. `context/project-overview.md`
2. `context/architecture.md`
3. `context/ui-tokens.md` & `ui-rules.md`
4. `context/ui-registry.md`
5. `context/code-standards.md` & `context/library-docs.md`
6. `context/build-plan.md`

### 3. Reconcile Code Reality
Check active files and run `git status`:
- Does the git working tree match what the checkpoint described?
- If differences exist, notify the developer before proceeding.

### 4. State the Resumption Plan Out Loud
Present the resumption alignment to the developer before writing code:

```markdown
### 🔄 Session Resumed: [Feature Name]
- **Last State**: [Brief recap of what was completed]
- **Confirmed Next Step**: [The exact next file to touch or feature to implement]
- **Ready to proceed**: Say "Go" or provide updated instructions.
```
