---
name: sync
description: Post-merge Context & State Synchronizer. Reconciles progress-tracker.md, spec statuses, and AGENTS.md based strictly on repository evidence and git diffs. Performs surgical single-line updates, advances completed feature statuses, flags unratified Assumed specs, and never overwrites curated prose.
---

# Workflow: sync (Repository State & Context Synchronizer)

Invoke with `/sync` as the final step after a feature is merged, or when resuming work to bring project documentation into alignment with actual code reality.

**Goal**: Keep durable knowledge files (`context/progress-tracker.md`, `context/build-plan.md`, `AGENTS.md`, and `docs/specs/`) completely synchronized with what was actually committed, eliminating spec drift and phantom documentation.

---

## The Synchronization Invariants

1. **Surgical Updates Only**: Make single-line targeted edits (updating status badges, ticking checkboxes, adding pointers). Never clobber or rewrite human-authored prose.
2. **Evidence-Based Advancement**: Only tick tasks or mark features as `COMPLETED` / `Accepted` if verified by concrete repository evidence (working code in place, passing tests, updated types).
3. **Spec Lifecycle Integrity**:
   - Updates spec status line from `Proposed` → `In Progress` → `Accepted` when features ship.
   - **Assumed Spec Guard**: If a spec has `Status: Assumed`, `/sync` MUST NEVER advance it to `Accepted`. It must leave it `Assumed` and explicitly flag it as architectural debt requiring `/architect` ratification.
4. **Nested Area Docs**: If a net-new major domain directory was introduced (e.g. `src/billing/`), offer to create a nested `<area>/AGENTS.md` and add a pointer to the root `AGENTS.md`.

---

## Step-by-Step Protocol

### 1. Scope the Changeset from Git
Run git commands to identify what shipped:
- Base branch: `main` or `master`.
- Diff against base: `git diff --name-status origin/main...HEAD` (or `git log -n 5 --stat` if already merged).
- Categorize added (`A`), modified (`M`), and deleted (`D`) files.

---

### 2. Reconcile Progress Tracker & Build Plan
Inspect `context/progress-tracker.md` (or `context/build-plan.md`):
- Find the feature matching the committed files.
- If all components, state handlers, and tests exist in the repo:
  - Advance the feature state in the progress table to `COMPLETED`.
  - Check off completed milestones in the build plan.
- If work is partial or ongoing:
  - Keep state as `IN PROGRESS` and tick only the specific milestones verified by code.

---

### 3. Reconcile Spec Statuses (`docs/specs/`)
Inspect active specs in `docs/specs/`:
- For specs governing shipped features:
  - Surgically update the header line: `**Status**: Accepted`.
- For specs marked `Status: Assumed`:
  - Keep `Status: Assumed`.
  - Surface a prominent notice to the developer:
    > *"⚠️ Architectural Debt Flag: Spec [NNNN-name] is currently marked 'Assumed'. Run `/architect` to ratify and complete its rationale."*

---

### 4. Sync Design Tokens & UI Registry Pointers
- If new UI atoms, molecules, or organisms were added, check `context/ui-registry.md`:
  - If missing, prompt the developer: *"New UI components detected. Run `/imprint` to record them in context/ui-registry.md."*
- If new CSS variables were added in `globals.css`, verify that `context/ui-tokens.md` reflects them.

---

### 5. Report Sync Summary
Output a concise sync summary:

```markdown
### 🔄 Context Synchronization Summary

- **Progress Tracker**: Updated status of `[Feature Name]` to `COMPLETED`.
- **Specs Synchronized**: `docs/specs/[NNNN-name].md` marked `Accepted`.
- **Architectural Debt**: [0 unratified specs / List any Assumed specs].
- **UI Registry**: [All components imprinted / Prompt to run /imprint].
- **Context Integrity**: All files synchronized with git reality.
```
