# Master Motion & Animation Registry

> **Origin**: Consolidated from `ui.spectrumhq.in` (Spectrum UI), `Hyperiux-Immersion-Labs/hyperiux-components`, and Framer Motion (`motion/react`).
> **Directive**: Provides orchestrated, physics-based micro-interactions and transitions. Every animation must guide user attention, provide tactile feedback, or clarify spatial hierarchy—never serving as noisy decoration.

---

## 1. Core Physics Curves & Timing Tokens

All motion across the application must consume these standardized transition tokens:

```typescript
// Standard Framer Motion Physics Tokens
export const motionTokens = {
  // Spring Physics for Interactive Elements (Modals, Dropdowns, Drawers)
  springGentle: {
    type: "spring",
    stiffness: 260,
    damping: 20,
    mass: 0.8,
  },
  springSnappy: {
    type: "spring",
    stiffness: 400,
    damping: 28,
  },
  springBouncy: {
    type: "spring",
    stiffness: 300,
    damping: 15,
  },

  // Eased Curves for Page Reveals and Opacity Fades
  easeOutCubic: {
    duration: 0.4,
    ease: [0.33, 1, 0.68, 1],
  },
  easeOutExpo: {
    duration: 0.5,
    ease: [0.16, 1, 0.3, 1],
  },

  // Stagger Children Timing
  staggerFast: 0.05,
  staggerStandard: 0.08,
  staggerDeliberate: 0.12,
};
```

---

## 2. Accessible Motion Invariant (`prefers-reduced-motion`)

Every animated component must respect user motion preferences unconditionally:

```tsx
import { motion, useReducedMotion } from "framer-motion";

export function AccessibleCard({ children }: { children: React.ReactNode }) {
  const shouldReduceMotion = useReducedMotion();

  const variants = {
    hidden: { opacity: 0, y: shouldReduceMotion ? 0 : 20 },
    visible: { 
      opacity: 1, 
      y: 0, 
      transition: shouldReduceMotion ? { duration: 0 } : motionTokens.easeOutExpo 
    },
  };

  return (
    <motion.div initial="hidden" animate="visible" variants={variants}>
      {children}
    </motion.div>
  );
}
```

---

## 3. High-Craft Micro-Interactions (Spectrum UI Patterns)

### Pattern 1: Staggered Container & Children Entrance
Used for feature cards, list views, and search result grids:

```tsx
export const containerVariants = {
  hidden: { opacity: 0 },
  visible: {
    opacity: 1,
    transition: {
      staggerChildren: 0.08,
      delayChildren: 0.1,
    },
  },
};

export const itemVariants = {
  hidden: { opacity: 0, y: 16 },
  visible: {
    opacity: 1,
    y: 0,
    transition: { type: "spring", stiffness: 350, damping: 25 },
  },
};
```

### Pattern 2: Magnetic CTA Button
Gives buttons an organic, tactile pull toward the cursor:

```tsx
import { useRef, useState } from "react";
import { motion } from "framer-motion";

export function MagneticButton({ children, onClick }: { children: React.ReactNode; onClick?: () => void }) {
  const ref = useRef<HTMLButtonElement>(null);
  const [position, setPosition] = useState({ x: 0, y: 0 });

  const handleMouseMove = (e: React.MouseEvent<HTMLButtonElement>) => {
    const { clientX, clientY } = e;
    if (!ref.current) return;
    const { left, top, width, height } = ref.current.getBoundingClientRect();
    const x = (clientX - (left + width / 2)) * 0.25;
    const y = (clientY - (top + height / 2)) * 0.25;
    setPosition({ x, y });
  };

  const handleMouseLeave = () => setPosition({ x: 0, y: 0 });

  return (
    <motion.button
      ref={ref}
      onMouseMove={handleMouseMove}
      onMouseLeave={handleMouseLeave}
      animate={{ x: position.x, y: position.y }}
      transition={{ type: "spring", stiffness: 300, damping: 20, mass: 0.5 }}
      onClick={onClick}
      className="inline-flex items-center justify-center rounded-xl bg-primary px-6 py-3 font-medium text-primary-foreground shadow-sm hover:shadow-md transition-shadow"
    >
      {children}
    </motion.button>
  );
}
```

### Pattern 3: Border-Beam Glow Card
Subtle, high-end ambient border illumination without distracting flash:

```tsx
export function BorderBeamCard({ children, className = "" }: { children: React.ReactNode; className?: string }) {
  return (
    <div className={`relative overflow-hidden rounded-2xl border border-border bg-card p-6 shadow-sm transition-all hover:shadow-md ${className}`}>
      <div className="pointer-events-none absolute -inset-px opacity-0 transition-opacity duration-300 group-hover:opacity-100">
        <div className="absolute inset-0 bg-gradient-to-r from-primary/20 via-transparent to-primary/20 [mask-image:radial-gradient(ellipse_at_center,transparent_20%,black)]" />
      </div>
      {children}
    </div>
  );
}
```

---

## 4. Spectrum UI MCP Server Integration

To allow AI coding agents (Claude Code, Antigravity, Cursor) to browse, search, and install animated components autonomously:

### MCP Server Configuration
Add to your environment's MCP configuration (`mcp_config.json`):

```json
{
  "mcpServers": {
    "spectrum-ui": {
      "command": "npx",
      "args": ["-y", "@spectrumui/mcp"]
    }
  }
}
```

### CLI Component Scaffolding
Install components directly via standard CLI:
```bash
npx shadcn@latest add "https://ui.spectrumhq.in/r/border-beam.json"
npx shadcn@latest add "https://ui.spectrumhq.in/r/animated-tabs.json"
```
