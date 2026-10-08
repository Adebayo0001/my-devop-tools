# Workflow: architect

Invoke with `/architect` before starting any complex feature — or applied automatically per AGENTS.md's Available Skills table when a request is non-trivial and no plan exists yet for it. "Complex" means: touches more than one entity in the data model, introduces a new permission/ownership boundary, involves an async/background process, touches financial/auth logic, introduces multi-step UI flows, or the approach genuinely isn't obvious. A simple CRUD form on an already-established pattern doesn't need this — that's what makes it a judgment call, not a mechanical trigger.

Goal: think before building. A plan gets reviewed in a minute; a wrong architecture gets discovered three features later, entangled with everything built on top of it.

## Steps

1. **Read the context folder** in the order from AGENTS.md's Context Folder Protocol — specifically `project-overview.md` (personas & UX research), `architecture.md` (invariants & observability), `ui-tokens.md`, `ui-registry.md` (existing atoms, molecules, organisms), and `build-plan.md`'s entry for this feature.

2. **Conduct UX Research & Behavioral Mental Model Pre-Check**: State target persona, user mental model, Jobs-To-Be-Done (JTBD), and how this feature eliminates user friction and cognitive overload.

3. **State the technical approach in plain terms before writing code**: what this feature does, what data it touches, what it depends on, what depends on it. If `build-plan.md` already has an anchor prompt for this feature, this is where it gets read and confirmed, not silently overridden.

4. **Check against `architecture.md`'s invariants explicitly.**
   - Does this feature touch, or risk violating, any rule marked as an invariant (an ownership boundary, a uniqueness constraint, a data-consistency rule)?
   - **Observability Architecture**: Which **Sentry** / **LogRocket** Error Boundary wraps this feature? What PII scrubbing (`beforeSend`) is configured? What are the **Datadog** APM latency budgets and RUM Core Web Vitals targets?

5. **Atomic UI Decomposition & `ui-registry.md` Pre-Check**:
   - Decompose UI into **Atoms** (built on **shadcn/ui** and headless **Radix UI** primitives), **Molecules** (`SearchBar`, `FormField`), and **Organisms** (`ProductCard`, `DataGrid`).
   - Check `ui-registry.md`: Does a component that does this already exist? If yes, extend or reuse it.
   - **Sprint Immutability Check**: Verify that the new feature strictly composes existing registered Atoms and Molecules. Never invent ad-hoc card or button variants.
   - **Single-Knob CSS Variable Cascade**: Verify all colors consume HSL/OKLCH CSS variables from `globals.css` (e.g. `hsl(var(--primary))`) so modifying them cascades globally (Figma Tokens API / webhook updater parity).

6. **Surface any genuine ambiguity as a question** rather than picking an interpretation and building on it. This is the same principle as the Kickoff gate, scoped down to one feature instead of the whole project.

7. **Get a lightweight approval** — not a full context file, just confirmation the blueprint is right (summarizing UX rationale, schemas, observability boundaries, atomic UI breakdown, and single-knob CSS cascade check) before generating code.

8. **Then proceed to the Build gate** (Gate 2 in AGENTS.md) as normal for the actual implementation.

## Notes

- This is deliberately lighter than the Kickoff gate — it's a five-minute think-first pass for one feature, not a project-level planning phase.
- If, partway through, the feature turns out to be bigger or more ambiguous than expected, say so rather than pushing through — that's a signal to slow down further, not a reason to have skipped this step.
