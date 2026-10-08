# Workflow: remember

Two modes, invoked as `/remember save` and `/remember restore`. Exists for features genuinely large enough to span multiple sessions — not every feature needs this, only ones where context would otherwise be lost between now and the next session picking it back up.

## `/remember save` (also `log memory` / `log to memory`)

Use at a natural stopping point mid-feature, after completing a feature, or when the user says `log memory` or `log to memory`. Goal: a future session (or a future you) can resume without re-deriving what's already been figured out.

**Non-Negotiable Rule**: **NEVER ask for permission to overwrite.** Prompts like *"Overwrite with this session's memory?"* are strictly prohibited. Memory updates are strictly **incremental**:
- Preserve previously logged milestones, decisions, and solved problems.
- Incrementally append new accomplishments, new decisions, and new problems solved.
- Update current state and next steps.

1. **Write an incremental session snapshot** — to `memory.md` in the project root (and append to `.ai-memory/phase-log.md` if present). Capture:
   - Which feature this is, and where it sits in `build-plan.md` (append to existing completed features list).
   - What's actually done vs. what's still pending within this feature specifically.
   - Any decision made this session that isn't already logged — append to decisions log.
   - Any problem solved this session — append to problems solved.
   - Latest runtime and build health (typecheck, tests, active dev server).
   - The specific next step to take when work resumes, concrete enough that it doesn't require re-reading the whole feature to figure out where to restart.

2. **Confirm the snapshot is enough to resume from cold** — read it back as if seeing it fresh with no memory of this session. If it wouldn't actually be enough to pick the work back up correctly, it's not done yet. Inform the developer concisely that memory was incrementally updated without blocking for overwrite confirmation.

## `/remember restore`

Use when returning to a feature that has a `/remember save` snapshot — or applied automatically per AGENTS.md's Available Skills table when resuming known multi-session work. Goal: resume from the actual state, not from an assumption about where things probably are.

1. **Read the saved snapshot first**, before doing anything else.

2. **Then run the full Context Folder Protocol read order** from AGENTS.md — the snapshot tells you where you left off, but the context files may have changed since (a decision elsewhere, a token added, a new registry entry) and need to be read fresh, not assumed unchanged.

3. **Confirm the resumption point out loud** before continuing work: "picking this back up — last session left off at X, next step is Y, correct?" This is a cheap check against the snapshot being stale or a misunderstanding of where things actually stood.

4. **Proceed from the confirmed next step**, applying `/architect` first if the remaining work is itself complex enough to warrant it.

## Notes

- A snapshot that just says "working on the booking feature, more to do" is not a save — it fails the "resume from cold" test in step 2 of `/remember save`. Specificity is the entire value of this workflow.
- If restoring reveals the saved snapshot no longer matches reality (something else changed the relevant code since), say so and re-establish the actual current state before continuing, rather than proceeding on stale assumptions.
