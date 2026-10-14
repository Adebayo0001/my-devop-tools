# Creative Agency Onboarding & Conversational Intake Archetypes

> **Origin**: Consolidated from `ephraimduncan/blocks` (blocks.so), `ui-layouts/uilayouts`, and elite Figma agency systems.
> **Directive**: Completely replaces sterile, dated vertical forms with high-converting, creative multi-pane intake architectures that feel crafted by a $1,000,000 design agency.

---

## 1. The Core Philosophy of High-Agency Onboarding

Amateur AI onboarding flows default to a single, centered white column with stacked text fields, generic labels, and a standard button. This creates cognitive friction, feels like a chore, and causes high drop-off.

Elite human-designed onboarding flows:
1. **Provide Instant Gratification**: Every user input immediately reflects in a **Live Visual Artboard / Reactive Canvas**.
2. **Break Steps into Conversational Bites**: One concept per step; natural language framing instead of sterile database labels.
3. **Use Asymmetric Visual Pacing**: Form controls occupy 40%–45% of the viewport; live visual proof occupies 55%–60%.
4. **Smooth Spring Morphing**: Transitioning between steps uses layout animations (`layoutId` in Framer Motion), not jarring page jumps.

---

## 2. Master Creative Archetypes

### Archetype CREATIVE-01: Asymmetric Conversational Split Studio
*Specifically engineered for creative tools, flyer generators, and SaaS intake (e.g. MyndMark):*

```
┌──────────────────────────────────────┬────────────────────────────────────────┐
│  LEFT PANE (45% Width)                │  RIGHT PANE (55% Width)                │
│  The Conversational Driver           │  The Live Reactive Artboard Canvas     │
│                                      │                                        │
│  [Logo / Step Indicator 1 of 4]      │  ┌──────────────────────────────────┐  │
│                                      │  │                                  │  │
│  "What is your business name &        │  │   [Live High-Res Preview Canvas] │  │
│   what makes you unique?"            │  │                                  │  │
│                                      │  │   Updates instantaneously as     │  │
│  ┌─────────────────────────────────┐ │  │   user types (Brand Typography,  │  │
│  │ Name: SwiftPay Logistics       │ │  │   Logo, Palette Simulation)      │  │
│  └─────────────────────────────────┘ │  │                                  │  │
│  ┌─────────────────────────────────┐ │  │   3D Canvas Lighting & Ambient   │  │
│  │ Tagline: Instant Borderless NGN│ │  │   Shader Backdrop                │  │
│  └─────────────────────────────────┘ │  │                                  │  │
│                                      │  └──────────────────────────────────┘  │
│  [Button: Next Step ──>]             │  [Scale Indicator: 100% | Preset: IG]  │
└──────────────────────────────────────┴────────────────────────────────────────┘
```

#### Spatial Architecture:
- **Left Column**: Desktop `w-full lg:w-[45%]`, padding `p-8 lg:p-16`, flex column with vertical centering.
- **Right Column**: Desktop `hidden lg:flex lg:w-[55%]`, background `bg-muted/30` or ambient canvas shader, persistent sticky viewport container.
- **Mobile Collapse (375px)**: The left driver remains primary; the live canvas scales to an interactive thumbnail docked at the top or available via a floating "Preview Artboard" bottom sheet drawer.

---

### Archetype CREATIVE-02: The Morphing Step Card Wizard
*For KYC, identity verification, and multi-step configuration:*

```
┌───────────────────────────────────────────────────────────────────────────────┐
│                                                                               │
│                 Step 2 of 4 ── [●]───[●]───[○]───[○]                          │
│                                                                               │
│        ┌─────────────────────────────────────────────────────────────┐        │
│        │  Select your brand aesthetic archetype                      │        │
│        │  This tunes your typography, color harmony, and motion      │        │
│        │                                                             │        │
│        │  ┌───────────────┐  ┌───────────────┐  ┌───────────────┐   │        │
│        │  │ [✓ Selected]  │  │               │  │               │   │        │
│        │  │ Minimalist    │  │ Neo-Brutalist │  │ Vibrant Bento │   │        │
│        │  │ Swiss 8px     │  │ High-Contrast │  │ Tactile Glow  │   │        │
│        │  └───────────────┘  └───────────────┘  └───────────────┘   │        │
│        │                                                             │        │
│        │  [<- Back]                            [Continue Button ->]  │        │
│        └─────────────────────────────────────────────────────────────┘        │
│                                                                               │
└───────────────────────────────────────────────────────────────────────────────┘
```

#### Key Mechanics:
- Framer Motion `AnimatePresence mode="wait"` with directional slide-fade transitions:
  - Next step: slides in from right (`x: 20, opacity: 0 -> x: 0, opacity: 1`).
  - Previous step: slides in from left (`x: -20, opacity: 0 -> x: 0, opacity: 1`).
- Interactive card selection uses spring scaling: `whileHover={{ scale: 1.02 }}` and `whileTap={{ scale: 0.98 }}`.
- Selected state activates a subtle 2px brand border (`border-primary`) with an animated checkmark icon.

---

### Archetype CREATIVE-03: The Interactive Multimodal Stage
*For uploading assets, extracting palettes, and configuring design systems:*

```
┌───────────────────────────────────────────────────────────────────────────────┐
│                                                                               │
│   ┌───────────────────────────────────┬───────────────────────────────────┐   │
│   │ Brand Assets Dropzone             │ Instant Palette & Token Synthesizer│   │
│   │                                   │                                   │   │
│   │  ┌─────────────────────────────┐  │  Dominant Extracted Tokens:       │   │
│   │  │   [Drag & Drop SVG Logo]    │  │  [#6E2CF4] Electric Violet        │   │
│   │  │   or browse from device     │  │  [#0F172A] Deep Slate Ink         │   │
│   │  └─────────────────────────────┘  │  [#F8FAFC] Studio Surface         │   │
│   │                                   │                                   │   │
│   │  Auto-extracts SVG dimensions,    │  Contrast Check:                  │   │
│   │  monochrome variants, and colors  │  [✓ WCAG 2.1 AAA Passed (12.4:1)] │   │
│   └───────────────────────────────────┴───────────────────────────────────┘   │
│                                                                               │
└───────────────────────────────────────────────────────────────────────────────┘
```

---

## 3. Implementation Code: The Conversational Split Template

```tsx
import React, { useState } from "react";
import { motion, AnimatePresence } from "framer-motion";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";

interface OnboardingData {
  businessName: string;
  tagline: string;
  category: string;
}

export function ConversationalOnboardingStage({
  initialData,
  onComplete,
}: {
  initialData?: Partial<OnboardingData>;
  onComplete: (data: OnboardingData) => void;
}) {
  const [step, setStep] = useState(1);
  const [data, setData] = useState<OnboardingData>({
    businessName: initialData?.businessName || "",
    tagline: initialData?.tagline || "",
    category: initialData?.category || "Creative Tech",
  });

  const nextStep = () => setStep((s) => Math.min(s + 1, 3));
  const prevStep = () => setStep((s) => Math.max(s - 1, 1));

  return (
    <div className="flex min-h-screen w-full flex-col lg:flex-row bg-background text-foreground">
      {/* Left Pane: The Conversational Driver */}
      <div className="flex flex-1 flex-col justify-between p-8 md:p-12 lg:p-16 max-w-2xl mx-auto w-full">
        <div>
          <div className="flex items-center gap-2 mb-8">
            <span className="text-xs font-semibold uppercase tracking-wider text-primary">Step {step} of 3</span>
            <div className="flex gap-1">
              {[1, 2, 3].map((i) => (
                <div
                  key={i}
                  className={`h-1.5 rounded-full transition-all duration-300 ${
                    i <= step ? "w-6 bg-primary" : "w-2 bg-muted"
                  }`}
                />
              ))}
            </div>
          </div>

          <AnimatePresence mode="wait">
            {step === 1 && (
              <motion.div
                key="step-1"
                initial={{ opacity: 0, x: -16 }}
                animate={{ opacity: 1, x: 0 }}
                exit={{ opacity: 0, x: 16 }}
                transition={{ duration: 0.3 }}
                className="space-y-6"
              >
                <h1 className="text-3xl md:text-4xl font-bold tracking-tight">
                  What is your business name?
                </h1>
                <p className="text-muted-foreground text-sm md:text-base leading-relaxed">
                  We will use this to generate your brand artboards, marketing flyers, and typography hierarchy.
                </p>
                <div className="space-y-2">
                  <Label htmlFor="businessName">Brand Name</Label>
                  <Input
                    id="businessName"
                    placeholder="e.g. Apex Studio"
                    value={data.businessName}
                    onChange={(e) => setData({ ...data, businessName: e.target.value })}
                    className="h-12 text-lg"
                  />
                </div>
              </motion.div>
            )}

            {step === 2 && (
              <motion.div
                key="step-2"
                initial={{ opacity: 0, x: -16 }}
                animate={{ opacity: 1, x: 0 }}
                exit={{ opacity: 0, x: 16 }}
                transition={{ duration: 0.3 }}
                className="space-y-6"
              >
                <h1 className="text-3xl md:text-4xl font-bold tracking-tight">
                  Craft your brand signature tagline.
                </h1>
                <p className="text-muted-foreground text-sm md:text-base leading-relaxed">
                  This will anchor your hero flyer headlines and promotional campaigns.
                </p>
                <div className="space-y-2">
                  <Label htmlFor="tagline">Tagline / Mission</Label>
                  <Input
                    id="tagline"
                    placeholder="e.g. Next-Generation Autonomous Systems"
                    value={data.tagline}
                    onChange={(e) => setData({ ...data, tagline: e.target.value })}
                    className="h-12 text-lg"
                  />
                </div>
              </motion.div>
            )}
          </AnimatePresence>
        </div>

        <div className="flex items-center justify-between pt-8 border-t border-border mt-12">
          {step > 1 ? (
            <Button variant="ghost" onClick={prevStep}>
              Back
            </Button>
          ) : <div />}
          
          <Button
            onClick={() => (step === 3 ? onComplete(data) : nextStep())}
            className="px-6 py-2.5 font-medium"
          >
            {step === 3 ? "Launch Studio" : "Continue"}
          </Button>
        </div>
      </div>

      {/* Right Pane: Live Reactive Preview Canvas */}
      <div className="hidden lg:flex flex-1 items-center justify-center p-12 bg-muted/20 border-l border-border relative overflow-hidden">
        <div className="w-full max-w-lg rounded-2xl border border-border bg-card p-8 shadow-xl">
          <span className="text-xs font-semibold uppercase tracking-wider text-muted-foreground block mb-4">
            Live Preview Canvas
          </span>
          <div className="aspect-[4/5] rounded-xl border border-border/80 bg-background p-6 flex flex-col justify-between shadow-inner">
            <div>
              <div className="h-8 w-24 rounded bg-primary/20 mb-6 flex items-center justify-center text-xs font-bold text-primary">
                LOGO
              </div>
              <h2 className="text-2xl font-bold tracking-tight text-foreground">
                {data.businessName || "Your Business Name"}
              </h2>
              <p className="text-muted-foreground text-sm mt-2">
                {data.tagline || "Your brand promise and headline will render here in real-time."}
              </p>
            </div>
            <div className="pt-4 border-t border-border/50 text-xs text-muted-foreground flex justify-between">
              <span>Preset: 1080x1350 IG Portrait</span>
              <span className="text-primary font-medium">Synced</span>
            </div>
          </div>
        </div>
      </div>
    </div>
  );
}
```
