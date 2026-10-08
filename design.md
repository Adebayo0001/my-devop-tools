# Design System Direction — Meridian Health Partners

## Aesthetic Mood
Calming Clinical & High-Trust Contemporary: Reassuring, authoritative medical clarity with warm, high-contrast surfaces designed for zero visual fatigue and complete WCAG 2.1 AA compliance (all body text > 5.5:1 contrast ratio).

## Color Palette
- **Primary Brand / Interactive:** `#0E5E6F` (Deep Marine Teal — Primary CTAs, active states, key anchors; 5.9:1 contrast on white)
- **Primary Neutral / Text:** `#0F172A` (Slate 900 — Headings, high-emphasis body text, form labels; 16.1:1 contrast on white)
- **Secondary Neutral / Muted Text:** `#334155` (Slate 700 — Supporting descriptions, metadata, hours; 7.8:1 contrast on white)
- **Surface / Cards:** `#FFFFFF` (Pure White — Elevated container cards, active form inputs, modal dialogs)
- **Background / Canvas:** `#F8FAFC` (Slate 50 — Page background canvas, providing soft contrast against pure white cards)
- **Border / Divider:** `#CBD5E1` (Slate 300 — Accessible structural card outlines, input borders, table rules; meets 3:1 graphical element standard)
- **Positive Indicator (Accepting Patients):** `#166534` (Forest Green — High-contrast badge text, paired with `#DCFCE7` background fill)
- **Alert / Urgent Care Indicator:** `#9A3412` (Amber Rust — Urgent care status notice text, paired with `#FEF3C7` background fill)

## Typography Pairing
- **Headings & Institutional Anchors:** `Source Serif 4`
  - *Personality:* Authoritative, calming, human-centered editorial serif with open counters and balanced proportions.
  - *Roles:* Display titles, page H1/H2 headings, clinic and provider names.
- **Interface, Body & Form Elements:** `Inter`
  - *Personality:* Ultra-legible, neutral geometric sans-serif with tall x-height and clear character distinction.
  - *Roles:* Body paragraphs, navigation links, button labels, search filters, form inputs, accessibility hints, badge tags.

## Signature Element
**The Clinical Access Badge System:** Distinct, high-contrast capsule badges pairing an explicit SVG status glyph with text (e.g., `✓ Accepting New Patients`, `⚡ Urgent Care Open Now`) with clear programmatic ARIA labels for screen readers.