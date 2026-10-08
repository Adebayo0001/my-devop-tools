# Workflow: imprint

Invoke with `/imprint` after any new UI component is built — or applied automatically per AGENTS.md's Available Skills table right after a component ships. Goal: capture the atomic pattern so it gets reused correctly next time, instead of a slightly different version getting reinvented for the next similar need.

## Steps

1. **Check whether this component is actually new**, or a variant of something already in `context/ui-registry.md`. If it's a variant of an existing entry, update that entry (note the variant and when to use it) rather than creating a duplicate entry — a registry with three near-identical "card" entries is worse than no registry, because it stops answering the question it exists to answer.

2. **If it's genuinely new**, add an entry to `context/ui-registry.md` covering:
   - What it's called and where it lives (file path)
   - **Atomic Classification**: Tag explicitly as `[ATOM]` (primitives like Button, Input, built on shadcn/ui and headless Radix UI), `[MOLECULE]` (compositions of atoms like SearchBar, FormField), or `[ORGANISM]` (complex domain layouts like ProductCard, DataGrid).
   - What it's for and when to use it (vs. anything adjacent already in the registry)
   - **Single-Knob Global CSS Tokens**: Verify that background, text, borders, and rings consume HSL/OKLCH CSS variables from `globals.css` (e.g., `hsl(var(--primary))`). Check that altering `--primary` in `globals.css` cascades automatically across this component (Figma Tokens API / webhook updater parity).
   - Which rules from `context/ui-rules.md` it follows
   - Its states (default, empty, loading, error, disabled — whichever apply), so the next feature that needs this component knows what's already handled and what isn't
   - Its accessibility contracts (Radix primitive, ARIA bindings, keyboard triggers)

3. **Check the component against `ui-rules.md` and `ui-tokens.md` before imprinting it**, not after. If it introduces a hardcoded hex value, a raw Tailwind color class (`bg-blue-600`), or a spacing value that isn't a token, that's a Rules That Never Change violation (AGENTS.md) — fix it before it gets registered as the canonical pattern, since everything built after this will copy whatever gets imprinted.

4. **Sprint Immutability Check**: If building a new feature during an active sprint, verify that the component is composed of already-imprinted **Atoms** and **Molecules** rather than inventing an ad-hoc un-imprinted card or button variant.

5. **If this component genuinely needed something `ui-tokens.md` or `ui-rules.md` didn't already define** (a new badge variant, a new status color variable), that's a real gap — add the CSS variable token/rule to the relevant file explicitly, don't let the component reference an ad-hoc value that only exists in this one file.

6. **Update `context/progress-tracker.md`** per the standing rule in AGENTS.md — this happens every feature, not just ones that produced new UI.

## Notes

- The registry is only useful if it stays accurate. An entry for a component that got refactored or removed and never updated is worse than a missing entry, because it actively misleads the next `/architect` pass that checks it.
- This workflow is short on purpose — it should take a minute or two, not become its own mini-project. If capturing the pattern properly is taking longer than that, the component was probably more novel than "just a new UI component," and might have been worth an `/architect` pass first.
