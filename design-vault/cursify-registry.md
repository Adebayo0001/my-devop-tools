# The Cursify Custom Cursor & Micro-Pointer Registry

> **Origin**: Consolidated from `ui-layouts/cursify` and Framer Motion (`motion/react`).
> **Directive**: Provides high-performance, lag-free interactive cursors that elevate consumer landing pages, creative agency portfolios, and marketing heroes.

---

## 1. Core Implementation Principles

1. **Strict Touch Screen Quarantine**: Custom cursors must be automatically disabled on mobile, tablet, or touch-screen devices (`(pointer: coarse)`). They must only render when a precise pointer mouse is present (`(pointer: fine)`).
2. **Zero-Lag Performance**: Use hardware-accelerated CSS `transform: translate3d(x, y, 0)` via Framer Motion springs (`damping: 28, stiffness: 400`).
3. **Accessibility**: Never hide the default system cursor unless the custom cursor provides a 100% visible, non-distracting dot indicator.

---

## 2. Master Cursor Components

### Component 1: Smooth Spring Follower
A sleek, magnetic circle that glides behind the system cursor:

```tsx
"use client";

import React, { useEffect, useState } from "react";
import { motion, useSpring } from "framer-motion";

export function SmoothCursor() {
  const [isVisible, setIsVisible] = useState(false);
  
  const cursorX = useSpring(0, { stiffness: 450, damping: 30 });
  const cursorY = useSpring(0, { stiffness: 450, damping: 30 });

  useEffect(() => {
    // Only run on desktop devices with fine pointer
    if (window.matchMedia("(pointer: coarse)").matches) return;

    const moveCursor = (e: MouseEvent) => {
      cursorX.set(e.clientX - 16);
      cursorY.set(e.clientY - 16);
      if (!isVisible) setIsVisible(true);
    };

    const handleMouseLeave = () => setIsVisible(false);
    const handleMouseEnter = () => setIsVisible(true);

    window.addEventListener("mousemove", moveCursor);
    document.addEventListener("mouseleave", handleMouseLeave);
    document.addEventListener("mouseenter", handleMouseEnter);

    return () => {
      window.removeEventListener("mousemove", moveCursor);
      document.removeEventListener("mouseleave", handleMouseLeave);
      document.removeEventListener("mouseenter", handleMouseEnter);
    };
  }, [cursorX, cursorY, isVisible]);

  if (!isVisible) return null;

  return (
    <motion.div
      className="pointer-events-none fixed left-0 top-0 z-50 h-8 w-8 rounded-full border border-primary/40 bg-primary/10 backdrop-blur-[1px]"
      style={{
        translateX: cursorX,
        translateY: cursorY,
      }}
    />
  );
}
```

### Component 2: Neural Glow Spotlight Cursor
Creates a subtle, ambient spotlight that illuminates cards and borders:

```tsx
"use client";

import React, { useEffect, useRef } from "react";

export function NeuralGlowCursor() {
  const glowRef = useRef<HTMLDivElement>(null);

  useEffect(() => {
    if (window.matchMedia("(pointer: coarse)").matches) return;

    const handleMouseMove = (e: MouseEvent) => {
      if (glowRef.current) {
        glowRef.current.style.transform = `translate3d(${e.clientX - 200}px, ${e.clientY - 200}px, 0)`;
      }
    };

    window.addEventListener("mousemove", handleMouseMove);
    return () => window.removeEventListener("mousemove", handleMouseMove);
  }, []);

  return (
    <div
      ref={glowRef}
      className="pointer-events-none fixed left-0 top-0 z-30 h-[400px] w-[400px] rounded-full bg-gradient-to-tr from-primary/15 to-transparent blur-3xl transition-transform duration-75 will-change-transform"
    />
  );
}
```
