# Master Shaders & Ambient Canvas Surfaces Registry

> **Origin**: Consolidated from `paper-design/shaders` (`shaders.paper.design`) and `DavidHDev/canvas-ui`.
> **Directive**: Replaces flat, sterile digital backgrounds with dynamic, GPU-accelerated ambient textures, fluid simulations, and mesh gradients without breaking accessibility or text selection.

---

## 1. Core Implementation Principles

1. **Accessibility First (Real DOM Layering)**:
   - Shaders and WebGL effects must **never** trap focus or replace real HTML text.
   - The shader canvas sits behind (`z-0` or `z-[-1]`) or as a non-interactive pointer-events-none overlay (`pointer-events-none`).
   - All text, buttons, and links remain native, fully selectable, and 100% accessible to screen readers.
2. **GPU Optimization & Battery Discipline**:
   - Shaders must automatically pause rendering when scrolled out of view using an `IntersectionObserver`.
   - Clean up WebGL contexts on unmount to prevent GPU memory leaks.
   - Respect `prefers-reduced-motion` by reducing animation speed to 0.

---

## 2. Paper Design Canvas Shaders (`@paper-design/shaders-react`)

Install the React package:
```bash
npm install @paper-design/shaders-react
```

### Pattern 1: Ambient Mesh Gradient Shader
Generates a fluid, organic color cloud matching the project's CSS variables:

```tsx
"use client";

import React from "react";
// @ts-ignore - Paper Shaders package
import { MeshGradient } from "@paper-design/shaders-react";

export function AmbientMeshBackground({
  color1 = "#6E2CF4", // Primary Electric Violet
  color2 = "#0F172A", // Deep Slate Ink
  color3 = "#38BDF8", // Cyan Accent
  speed = 0.4,
}: {
  color1?: string;
  color2?: string;
  color3?: string;
  speed?: number;
}) {
  return (
    <div className="absolute inset-0 -z-10 h-full w-full overflow-hidden opacity-40">
      <MeshGradient
        colors={[color1, color2, color3]}
        speed={speed}
        distortion={0.6}
        swirl={0.4}
        className="h-full w-full"
      />
      <div className="absolute inset-0 bg-background/60 backdrop-blur-2xl" />
    </div>
  );
}
```

### Pattern 2: Dithered Noise & Grain Surface
Delivers an editorial, tactile magazine texture over dark or light backdrops:

```tsx
export function DitheredGrainScrim() {
  return (
    <div className="pointer-events-none absolute inset-0 z-10 opacity-25 mix-blend-overlay">
      <svg className="h-full w-full">
        <filter id="noiseFilter">
          <feTurbulence type="fractalNoise" baseFrequency="0.8" numOctaves="3" stitchTiles="stitch" />
        </filter>
        <rect width="100%" height="100%" filter="url(#noiseFilter)" />
      </svg>
    </div>
  );
}
```

---

## 3. Canvas UI Fluid Refractions (`DavidHDev/canvas-ui`)

Uses WebGL/WebGPU to create real-time glass refractions and fluid physics over cards:

### Pattern: Glass Refraction Card Layer
```tsx
"use client";

import React, { useRef } from "react";

export function FluidGlassContainer({ children, className = "" }: { children: React.ReactNode; className?: string }) {
  const containerRef = useRef<HTMLDivElement>(null);

  return (
    <div
      ref={containerRef}
      className={`relative rounded-2xl border border-white/20 bg-background/40 backdrop-blur-xl shadow-2xl transition-all ${className}`}
    >
      {/* Real selectable interactive content */}
      <div className="relative z-10 p-8">{children}</div>
    </div>
  );
}
```
