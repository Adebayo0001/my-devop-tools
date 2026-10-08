# Workflow: review

Invoke with `/review` before a demo, or any time something feels off — or applied automatically per AGENTS.md's Available Skills table in either situation. Goal: catch what's actually wrong before someone else does, whether that's a client seeing a demo or a bug that's been quietly compounding.

## Steps

1. **Read `context/progress-tracker.md` first.** Which features claim to be "done," and does each one actually have a completed Definition of Done from `build-plan.md` behind that status? A feature marked done without one gets re-checked here, not taken on faith.

2. **Run the Gate 3 pre-ship checklist from AGENTS.md** against whatever's in scope for this review — secrets, server-side validation, auth boundaries, error handling, accessibility, performance sanity, responsive behavior, no undisclosed stubs, no unconfirmed destructive actions.

3. **Check Atomic UI consistency against `context/ui-registry.md` and `context/ui-tokens.md`.**
   - Are components classified into Atoms (`[ATOM]`), Molecules (`[MOLECULE]`), and Organisms (`[ORGANISM]`)?
   - Are interactive primitives built on **shadcn/ui** and headless **Radix UI**?
   - **Single-Knob Global CSS Cascade Test**: Do all colors consume HSL/OKLCH CSS variables from `globals.css` (e.g. `hsl(var(--primary))`)? Check that modifying `--primary` in `globals.css` cascades globally across all components without broken styles (Figma Tokens API / webhook updater parity).
   - **Sprint Immutability Check**: Verify that new sprint features strictly composed existing registered Atoms and Molecules rather than inventing un-imprinted ad-hoc card or button variants.

4. **Observability & Error Tracking Check**:
   - Are Error Boundaries with **Sentry** / **LogRocket** wrapping key route organisms to prevent unhandled application crashes?
   - Is client/server PII scrubbing (`beforeSend`) active to protect user privacy?
   - Is **Datadog** APM and RUM capturing Core Web Vitals (INP, LCP, CLS) and reporting trace performance without regressions?

5. **User UX Research Alignment & Genericness Check**:
   - Does the screen match the user mental models, task friction reduction, and Jobs-To-Be-Done (JTBD) established in UX research?
   - Does anything in scope look like a template default or contain banned rounded badge pills (`[✨ BADGE]`)? Headings must rely on pure typographic hierarchy.

6. **If "something feels off" was the trigger rather than a scheduled pre-demo review**, spend the first pass specifically trying to locate what's off before running the full checklist — a vague unease usually traces to one specific thing (a state that doesn't handle its empty case, an unhandled error state, or a flow that doesn't match what `project-overview.md` describes). Find that first, then run the broader checklist as a second pass.

7. **Report findings in plain terms**: what was checked, what passed, what needs a decision from the user — not a wall of checkmarks with no prioritization. Structure by P0 (Blockers), P1 (Critical Quality & Observability), P2 (Visual & Token Polish). If something is broken enough that it shouldn't be demoed as-is, say that plainly and early in the report, not buried at the end.

## Notes

- This workflow doesn't fix anything by default — it reports. Fixing what it finds is a separate, explicit step, especially right before a demo, where an unplanned fix under time pressure is its own risk.
- A review that finds nothing wrong is a legitimate outcome, not a sign the review was too shallow — say so plainly rather than manufacturing minor findings to justify the pass.
