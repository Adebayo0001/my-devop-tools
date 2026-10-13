---
name: test
description: Autonomous Silicon Valley Test Engineer. Inspects uncommitted git changes, classifies modified files (component, page/flow, api/server, logic, cli), reads/saves test-preferences.json, and writes robust test suites tied to acceptance criteria with zero slop.
---

# Workflow: test (Silicon Valley Automated Test Suite Engine)

Invoke with `/test` after implementing or modifying a feature, bugfix, or API route — before running `/check` or creating a pull request.

**Goal**: Write high-confidence, lasting test suites for the exact code changed in the current branch. Tests what callers and users rely on, proves business rules and edge cases, and verifies zero-trust authorization boundaries.

---

## The Testing Invariants

1. **Target Working Git Tree**: Automatically scopes tests to changed, uncommitted files (`git diff HEAD` + untracked files). Never forces testing of unchanged boilerplate.
2. **Acceptance Criteria Tracing**: When a spec exists (`docs/specs/` or `context/build-plan.md`), every test case must explicitly trace back to a numbered acceptance criterion (e.g., `// Verifies AC-1: Authenticated user can only mutate owned records`).
3. **Zero Test Slop Guarantee**:
   - ZERO empty test stubs or `expect(true).toBe(true)`.
   - ZERO snapshot tests on unstable mock data.
   - ZERO tests asserting on leaked internal plumbing variables.
4. **Three Mandatory Async States**: Any tested UI component or async handler must verify all 3 states: **Loading**, **Error** (clear user message), and **Empty** (clear guidance state).
5. **Zero-Trust Security & Ownership Test**: Every API route or mutation handler must include at least one negative test asserting that unauthorized users or non-owners are rejected (BOLA/IDOR protection).
6. **Accessibility & Interaction Assertions**: Component tests must assert on accessible roles (`getByRole`), visible text, and keyboard triggerability, never opaque test IDs or raw CSS selectors.

---

## Step-by-Step Protocol

### 1. Scope Changed Files via Git
Run cross-platform git commands to isolate modified source files:
- Tracked changes: `git diff --name-only --diff-filter=ACMR HEAD`
- Untracked files: `git ls-files --others --exclude-standard`
- If no previous commits exist: `git diff --name-only --diff-filter=ACMR --cached`

**Filter out non-code assets**:
- Exclude existing test files (`*.test.*`, `*.spec.*`, `__tests__/`, `e2e/`)
- Exclude config, lockfiles, generated bundles (`dist/`, `.next/`, `node_modules/`, `build/`)
- Exclude documentation, specs, tokens (`*.md`, `test-preferences.json`, `context/`)

If no testable source files are modified, notify the developer: *"No uncommitted code changes detected to test."*

---

### 2. Classify Each Changed File
Categorize every scoped file to select the optimal testing strategy:

| Path / Filename Pattern | File Class | Testing Strategy | Primary Verification |
|---|---|---|---|
| `*.tsx`, `*.jsx`, `*.vue`, `*.svelte` (components) | **Component** | Component Test (`vitest` + `@testing-library/react`) | Render, user event interaction, ARIA roles, 3 states (Loading/Empty/Error), keyboard navigation. |
| `app/**/page.*`, `pages/**`, `*Screen.*`, `*View.*` | **Page / Flow** | Integration / E2E Candidate | Full journey flow, routing parameters, breadcrumbs, responsive layout triggers. |
| `app/api/**`, `pages/api/**`, `*.controller.*`, `*.handler.*`, `actions.*` | **API / Server** | Integration Test | Boundary Zod schema parsing, status codes, BOLA/IDOR ownership checks, error payloads. |
| `utils/*`, `hooks/*`, `services/*`, `lib/*`, domain files | **Logic** | Pure Unit Test | Happy path inputs/outputs, boundary edge cases, null/undefined safety, error throws. |
| `cli.*`, `bin/**`, `cmd/**` | **CLI** | Process Execution Test | Arg parsing, exit codes (`0` vs `1`), stdout/stderr format. |

If more than 10 files are changed in a single pass, ask the developer:
> *"10+ files modified. Prioritize testing: (1) Logic & API boundaries first (Recommended), (2) Full batch, or (3) Specific directory?"*

---

### 3. Load or Configure Test Preferences (`test-preferences.json`)
Inspect `test-preferences.json` at the project root:
- If present, read `runner` (e.g., `vitest`, `jest`, `playwright`, `pytest`), `testDir`, `filePattern`, and `packageManager`.
- If missing, auto-detect the project stack from `package.json` / workspace files and prompt:
  > *"No test preferences detected. I detected [e.g. Next.js / TypeScript]. Would you like to use:  
  > 1. Vitest + React Testing Library (Recommended)  
  > 2. Jest  
  > 3. Playwright (E2E)  
  > 4. Other"*  
  Save the selection to `test-preferences.json`.

---

### 4. Author the Test Suite
Write tests directly matching project conventions:
- Place tests in the co-located directory or `__tests__` per project standards.
- Import real types and schemas; avoid loose `any` casts in test suites.
- Provide clean, deterministic mock factories for external third-party network APIs (e.g., Stripe, external webhooks); never mock internal database models when an in-memory/test DB is available.

---

### 5. Execution Decision Gate
Once the test suite is generated, pause and ask the developer:
> **Test Suite Generated Successfully.**  
> - **Option A (Recommended)**: Run the new test suite now in the terminal and report results.  
> - **Option B**: Skip execution for now and proceed to `/check verify` or `/review`.
