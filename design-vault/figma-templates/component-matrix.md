# Figma Template to Code Component Matrix

This matrix specifies how to ingest and convert components from Figma community templates and design kits (e.g. Untitled UI, Flowbite, Tailwind UI, Relume, craft agency kits) into code-ready, accessible, and theme-tokenized React/Tailwind/Radix components.

---

## 1. Frame-to-Primitive Translation Map

| Figma Structure | Layout Model | HTML Semantic | React / Radix Primitive | Tailwind Implementation |
|---|---|---|---|---|
| **Top Frame (Desktop)** | Fixed width `1440px` / Centered | `<main className="...">` | Root Layout Container | `w-full max-w-7xl mx-auto px-4 sm:px-6 lg:px-8` |
| **Top Frame (Mobile)** | Fixed width `375px` / Vertical stack | `<main className="...">` | Root Layout Container | `w-full px-4 overflow-x-hidden` |
| **Auto-Layout (Row)** | Direction: Horizontal, Space-Between | `<nav>`, `<header>`, `<div>` | Flexbox Container | `flex items-center justify-between gap-4` |
| **Auto-Layout (Col)** | Direction: Vertical, Packed / Spaced | `<section>`, `<article>` | Flex Column / Grid | `flex flex-col gap-6 lg:gap-8` |
| **Auto-Layout Grid** | Direction: Wrap / Responsive Grid | `<div>`, `<ul>` | CSS Grid | `grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6` |
| **Overlay / Dialog Frame**| Centered Overlay with Scrim | `<dialog>` | `@radix-ui/react-dialog` | `fixed inset-0 bg-black/60 backdrop-blur-sm z-50 flex items-center justify-center` |
| **Dropdown / Menu Frame** | Anchored Floating Frame | `<div>` | `@radix-ui/react-dropdown-menu` | `absolute right-0 mt-2 z-50 rounded-lg shadow-xl border border-border bg-popover` |

---

## 2. Token Ingestion (Variables & Styles to CSS)

When inspecting a Figma template's local variables or color/font styles:

```css
/* Ingested into globals.css single-knob cascade */
:root {
  /* Map Figma 'Color/Primary/600' -> --primary */
  --primary: hsl(222.2 47.4% 11.2%);
  --primary-foreground: hsl(210 40% 98%);
  
  /* Map Figma 'Color/Base/Background' -> --background */
  --background: hsl(0 0% 100%);
  --foreground: hsl(222.2 84% 4.9%);

  /* Map Figma 'Corner Radius' -> --radius */
  --radius: 0.5rem; /* e.g. 8px */
}

.dark {
  --background: hsl(222.2 84% 4.9%);
  --foreground: hsl(210 40% 98%);
}
```

---

## 3. Component Variant Taxonomy (`class-variance-authority`)

Translate Figma variant matrices into typed CVA recipes:

```typescript
// Example: Converting Figma Button Variants (Primary, Secondary, Ghost, Destructive)
import { cva, type VariantProps } from "class-variance-authority";

export const buttonVariants = cva(
  "inline-flex items-center justify-center rounded-md text-sm font-medium transition-colors focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-ring disabled:pointer-events-none disabled:opacity-50",
  {
    variants: {
      variant: {
        default: "bg-primary text-primary-foreground hover:bg-primary/90 shadow-sm",
        destructive: "bg-destructive text-destructive-foreground hover:bg-destructive/90 shadow-sm",
        outline: "border border-input bg-background hover:bg-accent hover:text-accent-foreground",
        secondary: "bg-secondary text-secondary-foreground hover:bg-secondary/80",
        ghost: "hover:bg-accent hover:text-accent-foreground",
        link: "text-primary underline-offset-4 hover:underline",
      },
      size: {
        default: "h-10 px-4 py-2",
        sm: "h-9 rounded-md px-3",
        lg: "h-11 rounded-md px-8 text-base",
        icon: "h-10 w-10",
      },
    },
    defaultVariants: {
      variant: "default",
      size: "default",
    },
  }
);
```

---

## 4. Figma Template Ingestion Checklist
1. **Identify the Grid Baseline**: Did the designer use a 12-column 1440px grid, a 1280px tight grid, or an asymmetric fluid grid?
2. **Extract the Spacing Ladder**: Map Figma auto-layout padding (`4px, 8px, 12px, 16px, 24px, 32px, 48px, 64px, 96px, 128px`) to Tailwind gap/p scales.
3. **Audit Responsive Constraints**: Inspect how cards resize inside Figma frames:
   - Does the frame use `Fill container` (translates to `flex-1` or `col-span-*`)?
   - Does it use `Hug contents` (translates to `w-fit`)?
   - Does it use `Fixed width` (must be audited for mobile 375px responsiveness)?
