# Iridium Template Guide

Template: `~/.claude/templates/iridium_powerpoint_template.pptx`
Slide size: 13.333" × 7.5" (16:9). Two masters with identical layout sets.

- Master 0 = **light** theme (white background, charcoal text)
- Master 1 = **dark** theme (charcoal `#33383E` background, white text)

## Layouts (both masters)

| # | Layout name | Placeholders (idx: type) | Use for |
|---|-------------|--------------------------|---------|
| 0 | Custom Layout | 0: CENTER_TITLE, 1: SUBTITLE | Title slide (gold globe graphic) |
| 1 | Legal Disclosures | 0: TITLE, 1: OBJECT | Standard legal text (pre-filled in sample) |
| 2 | Section Header | 0: TITLE | Section dividers (dark callout box over globe) |
| 3 | Title and Content | 0: TITLE, 1: OBJECT | Standard content slide |
| 4 | Two Content | 0: TITLE, 1: OBJECT, 2: OBJECT | Side-by-side content |
| 5 | Comparison | 0: TITLE, 2: OBJECT, 3: BODY, 4: OBJECT, 13: BODY | Two columns with headings (BODY = column headers) |
| 6 | Title Only | 0: TITLE | Charts, images, free-form content |
| 7 | Blank Slide | — | Full-bleed custom content |
| 8 | Closing (Option 1) | 0: CENTER_TITLE | Closing with dark callout box |
| 9 | Closing (Option 2) | 0: CENTER_TITLE | Closing with social-media handles |

All content layouts also carry FOOTER (idx 11, "IRIDIUM PROPRIETARY BUSINESS INFORMATION") and SLIDE_NUMBER (idx 12) placeholders inherited from the master. Title and closing layouts have no footer.

## Original template slide map (before prepare_template.py)

| Slides | Content |
|--------|---------|
| 1–3 | Brand guidelines + asset library — marked "REMOVE THIS SLIDE!" |
| 4–17 | Light-theme samples |
| 18–31 | Dark-theme samples |
| 12, 26 | "The following slides can be used as samples…" note — also stripped |

## Working copy after prepare_template.py (13 slides)

Light theme order:

| # | Slide | Layout |
|---|-------|--------|
| 1 | Title | Custom Layout |
| 2 | Legal Disclosures (pre-filled) | Legal Disclosures |
| 3 | Content | Title and Content |
| 4 | Two-column | Two Content |
| 5 | Comparison | Comparison |
| 6 | Title only | Title Only |
| 7 | Blank | Blank Slide |
| 8 | Section divider | Section Header |
| 9 | Sample pie chart | Title Only |
| 10 | Sample bar chart | Title Only |
| 11 | Sample line chart | Title Only |
| 12 | Closing (Option 1) | Closing (Option 1) |
| 13 | Closing (Option 2, social handles) | Closing (Option 2) |

Dark theme order: Section Header moves to slide 3 and the content layouts shift down one (4: Title and Content, 5: Two Content, 6: Comparison, 7: Title Only, 8: Blank). Slides 9–13 match the light order. The script prints the actual list — trust that output.

## Native charts

The chart sample slides hold real PowerPoint charts (pie = XL_CHART_TYPE.PIE, bar = COLUMN_CLUSTERED, line = LINE) already styled in brand colors. Re-target them instead of creating charts:

```python
from pptx import Presentation
from pptx.chart.data import CategoryChartData

presentation = Presentation("deck.pptx")
chart = next(shape for shape in presentation.slides[8].shapes if shape.has_chart).chart

chart_data = CategoryChartData()
chart_data.categories = ["2023", "2024", "2025"]
chart_data.add_series("Throughput (Mbps)", (1.2, 2.8, 4.1))
chart.replace_data(chart_data)
presentation.save("deck.pptx")
```

To duplicate a chart slide, use the pptx skill's unpack/pack workflow and copy the slide XML plus its chart part and relationships.

## Takeaway box

Content and chart samples include a dark rounded box near the bottom: "This is an optional takeaway box to summarize the content in the slide". Either replace the text with the slide's one-line takeaway or delete the shape. Shipping the placeholder text is the most common QA failure — grep for it.

## Footers

Footer text and slide numbers come from the layouts/masters. Don't add manual footer text boxes; don't remove the proprietary-information marking.
