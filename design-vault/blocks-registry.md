# Master Blocks Registry (`blocks.so` & `ui-layouts`)

> **Origin**: Consolidated from `ephraimduncan/blocks` (`blocks.so`) and `ui-layouts/uilayouts`.
> **Directive**: Provides 80+ accessible, production-ready Shadcn React blocks that eliminate scaffolding boilerplate for complex forms, AI chat bars, stats dashboards, and sidebars.

---

## 1. Remote Registry Configuration (`components.json`)

To pull blocks directly into your project via the standard shadcn CLI, configure your project's `components.json`:

```json
{
  "$schema": "https://ui.shadcn.com/schema.json",
  "style": "default",
  "rsc": true,
  "tsx": true,
  "tailwind": {
    "config": "tailwind.config.ts",
    "css": "src/app/globals.css",
    "baseColor": "slate",
    "cssVariables": true
  },
  "registries": {
    "@blocks-so": "https://blocks.so/r/{name}.json"
  }
}
```

---

## 2. Master Blocks Catalog

### Category 1: AI Chat & Multimodal Interfaces
- `@blocks-so/ai-chat-01`: Expandable chat input with voice dictation toggle and file dropzone.
- `@blocks-so/ai-prompt-bar`: Sticky bottom prompt bar with model selector and token indicator.
- `@blocks-so/ai-artboard-controls`: Canvas zoom, pan, and resolution presets.

### Category 2: Form Layouts & Conversational Intake
- `@blocks-so/login-01`: Split-screen auth with ambient gradient and social OAuth pills.
- `@blocks-so/onboarding-stepper`: Multi-step horizontal wizard with validation feedback.
- `@blocks-so/file-uploader-01`: Drag-and-drop zone with image thumbnail previews and progress bars.

### Category 3: Navigation & Shell Layouts
- `@blocks-so/sidebar-01`: Collapsible desktop sidebar with nested navigation groups and keyboard shortcuts (`Cmd+K`).
- `@blocks-so/stats-dashboard-01`: 4-metric KPI grid with sparklines and percentage delta badges.
- `@blocks-so/filter-drawer-01`: Responsive slide-over filter sheet with faceted multi-select.

---

## 3. Instant Installation Commands

```bash
# Install an AI chat interface
npx shadcn@latest add @blocks-so/ai-chat-01

# Install an advanced sidebar shell
npx shadcn@latest add @blocks-so/sidebar-01

# Install a responsive file uploader
npx shadcn@latest add @blocks-so/file-uploader-01
```
