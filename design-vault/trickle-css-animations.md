# Trickle Zero-Runtime CSS Text Animations

> **Origin**: Consolidated from `akaieuan/trickle-UI-kit` (`tricklekit.dev`).
> **Directive**: Provides lightweight, zero-runtime pure CSS text animations that execute as React Server Components (RSC) with zero client JavaScript for blazing-fast first paints.

---

## 1. Pure CSS Keyframe Definitions (`globals.css`)

Add these optimized animation keyframes to your project's `globals.css`:

```css
@keyframes trickleFadeIn {
  from {
    opacity: 0;
    transform: translateY(6px);
  }
  to {
    opacity: 1;
    transform: translateY(0);
  }
}

@keyframes trickleShimmer {
  0% {
    background-position: -200% 0;
  }
  100% {
    background-position: 200% 0;
  }
}

@keyframes trickleTypewriter {
  from {
    width: 0;
  }
  to {
    width: 100%;
  }
}

.animate-trickle-fade {
  animation: trickleFadeIn 0.5s cubic-bezier(0.16, 1, 0.3, 1) forwards;
}

.animate-trickle-shimmer {
  background: linear-gradient(90deg, currentColor 0%, rgba(255, 255, 255, 0.6) 50%, currentColor 100%);
  background-size: 200% auto;
  color: transparent;
  -webkit-background-clip: text;
  animation: trickleShimmer 3s linear infinite;
}
```

---

## 2. Server Component (RSC) Usage

Because these animations rely purely on native CSS keyframes, they require **zero client-side React hydration**:

```tsx
// Pure Server Component — No "use client" needed!
export function HeadlineBadge({ text }: { text: string }) {
  return (
    <span className="inline-block animate-trickle-fade font-medium text-primary">
      {text}
    </span>
  );
}

export function ShimmerHeadline({ title }: { title: string }) {
  return (
    <h1 className="text-4xl md:text-6xl font-bold tracking-tight animate-trickle-shimmer">
      {title}
    </h1>
  );
}
```
