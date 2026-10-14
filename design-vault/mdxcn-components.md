# Shadcn MDX Components Registry (`mdxcn`)

> **Origin**: Consolidated from `shadcn-labs/mdxcn` (`mdxcn.dev`).
> **Directive**: Provides 30+ accessible, copy-and-paste components optimized for MDX documentation, onboarding walkthroughs, changelogs, and technical guides.

---

## 1. Core Component Catalog

All components are built with TypeScript, Tailwind CSS, and Radix UI primitives:

| Component | Role | Usage |
|---|---|---|
| `<Steps>` / `<Step>` | Step-by-step progress instructions | Onboarding guides, multi-stage migration runbooks |
| `<Terminal>` | Shell execution preview with copy | CLI instructions, command verification snippets |
| `<Callout>` | Styled informational alerts (tip, note, warning) | Architectural notes, edge-case callouts |
| `<Timeline>` | Chronological event milestones | Project changelogs, company roadmaps, release logs |
| `<AsciiFrame>` | ASCII architectural layout framing | Retro diagrams, console output containers |

---

## 2. Usage Examples in MDX / React

### The Interactive Step Wizard (`<Steps>`)
```tsx
import { Steps, Step } from "@/components/mdx/steps";

export function InstallationGuide() {
  return (
    <Steps>
      <Step title="Initialize Design System Tokens">
        Configure your HSL CSS variables in <code>globals.css</code> mapped through <code>tailwind.config.ts</code>.
      </Step>
      <Step title="Lock the Logic Freeze Boundary">
        Declare your business logic and API endpoints as READ-ONLY before invoking <code>/redesign</code>.
      </Step>
      <Step title="Execute Surgical UI Elevation">
        Run <code>/redesign</code> to upgrade layout geometry and typography while preserving working handlers.
      </Step>
    </Steps>
  );
}
```

### The Interactive Terminal Preview (`<Terminal>`)
```tsx
import { Terminal } from "@/components/mdx/terminal";

export function CliTerminalPreview() {
  return (
    <Terminal
      title="bash — Antigravity Agent"
      command="powershell ./sync-skills.ps1"
      output="[OK] All 14 skills successfully synchronized across your AI IDEs!"
    />
  );
}
```
