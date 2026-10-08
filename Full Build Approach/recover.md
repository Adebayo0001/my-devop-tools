# Workflow: recover

Invoke with `/recover` when something breaks and one corrective prompt already failed to fix it — this is mandatory per AGENTS.md's Rules That Never Change, not optional. The trigger is specific: **one** failed correction attempt, not several. The whole point of this workflow is to stop the pattern of a second, third, and fourth blind attempt each making the actual problem harder to isolate.

## Steps

1. **Stop generating new fixes immediately.** No more corrective attempts until the diagnosis steps below are done — the instinct to try "one more thing" is exactly what this workflow exists to interrupt.

2. **Re-read the actual error, in full**, not a remembered summary of it. If there's a stack trace, read where it actually originates, not just the top-level message.

3. **Check `context/progress-tracker.md`'s Decisions Made During Build log** for anything recent that could explain this — a mid-build decision, a changed assumption, a recent feature that touches the same area. The cause is often something already decided and logged, not a new mystery.

4. **Check `context/architecture.md`'s invariants** — did the original fix attempt (the one that just failed) violate one of them? A fix that "worked" by quietly breaking an invariant elsewhere is a common reason a correction doesn't hold.

5. **Isolate the actual scope of the problem** before proposing a second fix: what specifically is broken, since when, and what changed right before it started. If this isn't answerable from the current session's context, say so rather than guessing.

6. **Propose the fix, with the reasoning for why it addresses the actual cause** (from step 5) rather than another symptom-level patch like the first attempt. If the fix involves anything destructive (see AGENTS.md's standing rule) — reverting a migration, dropping data, restoring from a backup — that gets an explicit, separate confirmation before executing, same as any other destructive action, no exception for being in recovery mode.

7. **Log the incident** in `context/progress-tracker.md`'s Notes or Decisions Made During Build section: what broke, what the actual cause was, what fixed it. This is what stops the same failure mode from costing another full `/recover` cycle next time it's approached.

## Notes

- If diagnosis genuinely can't determine the cause with the information available, say that plainly and ask for what's needed (a screenshot, a specific reproduction step, access to a log) rather than proposing a guess dressed up as a diagnosis.
- This workflow is a deliberate slowdown. That's the intended behavior, not a failure of the workflow — the cost of one careful pass is much lower than the cost of a fourth blind attempt.
