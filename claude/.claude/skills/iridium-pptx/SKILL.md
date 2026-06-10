---
name: iridium-pptx
description: Create Iridium-branded PowerPoint presentations from the official Iridium template. Use whenever the user asks for a presentation, deck, or slides in a work context — project updates, design reviews, test reports, customer-facing material — even if they don't say "Iridium" or "branded" explicitly. This skill wraps the generic pptx skill with Iridium's template, brand colors, and trademark rules.
---

# Iridium PowerPoint

Builds decks from the official Iridium brand template. This skill handles the *branding*; the generic `pptx` skill handles the *mechanics*.

**First, invoke the `pptx` skill** (document-skills:pptx) if not already loaded. Use its editing workflow, QA loop, and conversion scripts. Where its generic design advice (color palettes, font pairings) conflicts with this skill, Iridium branding wins.

## Template

`~/.claude/templates/iridium_powerpoint_template.pptx` — 13.33" × 7.5" (16:9), two masters: **light** (white background) and **dark** (charcoal `#33383E`). Both have identical layouts and a gold wireframe-globe motif.

Never edit the template in place. Prepare a working copy:

```bash
uv run --with python-pptx \
  ~/.claude/skills/iridium-pptx/scripts/prepare_template.py \
  --theme light --output deck.pptx
```

This strips the 3 brand-guideline slides ("REMOVE THIS SLIDE!") and the other theme's samples, leaving 13 sample slides for the chosen theme. It prints a numbered list of what remains. Theme choice: light for everyday/internal decks (default), dark for executive or customer-facing decks when the user wants more polish.

## Workflow

1. Prepare the working copy (above).
2. Plan slides: which samples to fill, which to duplicate, which to delete.
3. Edit content using the pptx skill's workflow (unpack/edit XML/pack, or python-pptx).
4. Delete leftover sample slides:
   ```bash
   uv run --with python-pptx \
     ~/.claude/skills/iridium-pptx/scripts/delete_slides.py deck.pptx 5 7 9
   ```
5. QA per the pptx skill (render to images, inspect). Additionally grep for leftover sample text:
   ```bash
   python -m markitdown deck.pptx | grep -iE "optional takeaway|sample (pie|bar|line)|category [0-9]"
   ```

## Sample slides in the working copy

Same set for both themes (order differs slightly — trust the script's printed list):
title slide, Legal Disclosures, Section Header, Title and Content, Two Content, Comparison, Title Only, Blank, three chart samples (pie / bar / line on Title Only), and two closing options.

Key points:
- **Chart samples contain native PowerPoint charts** already in brand colors. For any data slide, duplicate the matching chart sample and replace its data (`chart.replace_data()` with `CategoryChartData`) rather than building a chart from scratch.
- **Keep Legal Disclosures** in customer-facing decks; drop it for internal ones.
- **Pick one closing slide**, delete the other. Option 2 has social-media handles — customer-facing only.
- Content slides have an **optional dark takeaway box** at the bottom ("This is an optional takeaway box…"). Fill it with the slide's one-line takeaway, or delete the shape. Never ship the placeholder text.
- The footer "IRIDIUM PROPRIETARY BUSINESS INFORMATION" comes from the layouts. Leave it.

Full layout/placeholder map: `references/template-guide.md`.

## Branding

Font: **Arial only** (theme major + minor). Do not introduce other fonts.

| Role | Color |
|------|-------|
| Primary accent (dominant) | Gold `#FCB131` |
| Text / dark background | Charcoal `#33383E` |
| Secondary | Gray `#95A0A9` |
| Data accents (in order) | Teal `#12ABC9`, Green `#7CB01A`, Orange `#FC610D`, Blue `#458CCC` |

Gold carries the visual weight; the other accents are for data series and small highlights. These are the theme's accent1–accent6, so scheme-color references in the template already resolve correctly.

## Trademark rules (Iridium legal cares about these)

- Mark trademarks with superscript ®/™/SM on **first use**: Iridium®, Iridium Certus®, Iridium GO!®, Iridium Extreme®, Short Burst Data®/SBD®.
- **Never write "Certus" alone** — always "Iridium Certus".
- "Iridium NEXT" only for the historic launch campaign — the upgraded system is just "the Iridium constellation/network".
- "BCX"/"SFX" are internal terms — externally use Iridium Certus™ 9810 / Iridium Certus™ 9770.
- No third-party trademarks/products in a way that implies endorsement.

Full rules and approved product names: `references/brand-rules.md`. Read it before writing customer-facing content.
