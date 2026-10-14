# CLAUDE.md — Multi-IDE Standards for My DevOp Tools

> **Master Architecture Directive**: Read and strictly obey [AGENTS.md](file:///c:/Users/user/Desktop/My%20DevOp%20Tools/AGENTS.md) and [.agents/rules/AGENTS.md](file:///c:/Users/user/Desktop/My%20DevOp%20Tools/.agents/rules/AGENTS.md).
> All engineering standards, atomic primitives, anti-slop rules, and zero-trust invariants are locked in `AGENTS.md`.

## Mandatory Pre-Flight Grounding Mandate
Before executing any tool that creates or modifies code:
1. Prove you have read `AGENTS.md` and active context files.
2. Output the **Pre-Flight Grounding Card**:
   - 3 Governing Invariants cited from `AGENTS.md`.
   - Target Blast Radius (exact files and functions to modify).
   - Protected Working Surface ("DO NOT TOUCH") inventory.
   - Dev Quarantine Check (confirming no test harnesses enter shared navigation or public landing pages).

## Dev Harness Quarantine Law
- NEVER add developer test harnesses (`/test-tokens`, `/shell-preview`, crash simulators) to `HeaderNav` or public customer-facing routes.
- The root page (`/` or `app/page.tsx`) must strictly remain the genuine customer landing page.
- All verification harnesses must be quarantined to `app/(dev)/_workbench/...` or automated test suites.

## Mandatory `.agents/` Architecture
- Every project root must maintain `.agents/rules/` containing `AGENTS.md` and `GEMINI.md`.
- Every project root must maintain multi-IDE discovery shims (`CLAUDE.md`, `.cursorrules`, `.windsurfrules`, `GEMINI.md`).
