---
name: iridium-powerpoint
description: "Create PowerPoint presentations using the Iridium corporate template. Use this skill whenever the user asks to create a presentation, make slides, build a deck, or generate a PowerPoint for Iridium-related work. Also use when the user mentions creating slides for meetings, reviews, status updates, or any topic where a .pptx output is needed."
---

# Iridium PowerPoint Creator

Create branded PowerPoint presentations using the Iridium template at `~/.kiro/templates/iridium_powerpoint_template.pptx`.

## Template Slide Layouts

The template provides these layouts (by index):

| Index | Name | Placeholders |
|-------|------|-------------|
| 0 | Custom Layout (Title Slide) | Title (center), Subtitle |
| 1 | Legal Disclosures | Title, Content, Footer, Slide Number |
| 2 | Section Header | Title, Footer, Slide Number |
| 3 | Title and Content | Title, Content, Footer, Slide Number |
| 4 | Two Content | Title, Left Content, Right Content, Footer, Slide Number |
| 5 | Comparison | Title, Left Label, Left Content, Right Label, Right Content, Footer, Slide Number |
| 6 | Title Only | Title, Footer, Slide Number |
| 7 | Blank Slide | Footer, Slide Number |
| 8 | Closing (Option 1) | Title (center) |
| 9 | Closing (Option 2) | Title (center) |

## How to Create Presentations

Use `python-pptx` to build the presentation. The template file must be loaded as the base so all Iridium branding (colors, fonts, logos, backgrounds) are inherited.

```python
from pptx import Presentation
from pptx.util import Inches, Pt, Emu
from pathlib import Path

TEMPLATE_PATH = Path.home() / ".kiro/templates/iridium_powerpoint_template.pptx"

prs = Presentation(str(TEMPLATE_PATH))

# Remove the existing example slides from the template
while len(prs.slides) > 0:
    rId = prs.slides._sldIdLst[0].rId
    prs.part.drop_rel(rId)
    del prs.slides._sldIdLst[0]

# Add a title slide (layout 0)
title_layout = prs.slide_layouts[0]
slide = prs.slides.add_slide(title_layout)
slide.placeholders[0].text = "Presentation Title"
slide.placeholders[1].text = "Subtitle or Author"

# Add a content slide (layout 3)
content_layout = prs.slide_layouts[3]
slide = prs.slides.add_slide(content_layout)
slide.placeholders[0].text = "Slide Title"
slide.placeholders[1].text = "Bullet point content here"

# Add a section header (layout 2)
section_layout = prs.slide_layouts[2]
slide = prs.slides.add_slide(section_layout)
slide.placeholders[0].text = "Section Name"

# Add a closing slide (layout 8)
closing_layout = prs.slide_layouts[8]
slide = prs.slides.add_slide(closing_layout)
slide.placeholders[0].text = "Thank You"

prs.save("output.pptx")
```

## Guidelines

- Always start with layout 0 (title slide) as the first slide
- Use layout 3 (Title and Content) for most content slides
- Use layout 2 (Section Header) to introduce new sections
- Use layout 4 (Two Content) for side-by-side comparisons
- End with layout 8 or 9 (Closing) when appropriate
- For bullet points in content placeholders, add paragraphs to the text frame:

```python
text_frame = slide.placeholders[1].text_frame
text_frame.clear()
paragraph = text_frame.paragraphs[0]
paragraph.text = "First bullet"
for bullet in ["Second bullet", "Third bullet"]:
    new_paragraph = text_frame.add_paragraph()
    new_paragraph.text = bullet
    new_paragraph.level = 0  # Use level 1 for sub-bullets
```

- For tables, add them to a Title Only (layout 6) or Blank (layout 7) slide using `slide.shapes.add_table()`
- Save output to the user's requested path, defaulting to the current working directory
