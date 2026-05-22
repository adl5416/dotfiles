#!/usr/bin/env python3
"""
Iridium PowerPoint generator.

Usage:
    uv run --with python-pptx python3 create_powerpoint.py <content.json> [output.pptx]

content.json format:
{
  "title": "Presentation Title",
  "subtitle": "Optional subtitle",
  "slides": [
    {"type": "section",     "title": "Section Title"},
    {"type": "content",     "title": "Slide Title", "bullets": ["Point 1", "Point 2"]},
    {"type": "two_content", "title": "Slide Title", "left": ["Left 1"], "right": ["Right 1"]},
    {"type": "closing",     "title": "Questions?"}
  ]
}
"""
import json
import sys
from typing import Any
from pptx import Presentation
from pptx.presentation import Presentation as PresentationType
from pptx.slide import SlideLayout, Slide

TEMPLATE_PATH = '/home/alex99/Code/Internal/dotfiles/kiro/.kiro/templates/iridium_powerpoint_template.pptx'


def get_layout(presentation: PresentationType, layout_name: str) -> SlideLayout:
    """Return the slide layout matching the given name."""
    return next(layout for layout in presentation.slide_layouts if layout.name == layout_name)


def set_bullets(placeholder: Any, bullet_points: list[str]) -> None:
    """Clear a placeholder and populate it with the given bullet points."""
    text_frame = placeholder.text_frame
    text_frame.clear()
    for bullet in bullet_points:
        paragraph = text_frame.add_paragraph()
        paragraph.text = bullet
        paragraph.level = 0


def remove_template_slides(presentation: PresentationType) -> None:
    """Remove all existing slides from the presentation."""
    while len(presentation.slides._sldIdLst):
        relationship_id = presentation.slides._sldIdLst[0].rId
        presentation.part.drop_rel(relationship_id)
        del presentation.slides._sldIdLst[0]


def add_cover_slide(presentation: PresentationType, title: str, subtitle: str | None) -> Slide:
    """Add a cover slide with an optional subtitle."""
    slide = presentation.slides.add_slide(get_layout(presentation, 'Custom Layout'))
    if slide.shapes.title:
        slide.shapes.title.text = title
    if subtitle and len(slide.placeholders) > 1:
        slide.placeholders[1].text = subtitle
    return slide


def add_section_slide(presentation: PresentationType, title: str) -> Slide:
    """Add a section header slide."""
    slide = presentation.slides.add_slide(get_layout(presentation, 'Section Header'))
    slide.shapes.title.text = title
    return slide


def add_content_slide(presentation: PresentationType, title: str, bullets: list[str]) -> Slide:
    """Add a title-and-content slide with bullet points."""
    slide = presentation.slides.add_slide(get_layout(presentation, 'Title and Content'))
    slide.shapes.title.text = title
    set_bullets(slide.placeholders[1], bullets)
    return slide


def add_two_content_slide(
    presentation: PresentationType,
    title: str,
    left_bullets: list[str],
    right_bullets: list[str],
) -> Slide:
    """Add a two-column content slide."""
    slide = presentation.slides.add_slide(get_layout(presentation, 'Two Content'))
    slide.shapes.title.text = title
    set_bullets(slide.placeholders[1], left_bullets)
    set_bullets(slide.placeholders[2], right_bullets)
    return slide


def add_closing_slide(presentation: PresentationType, title: str) -> Slide:
    """Add a closing slide."""
    slide = presentation.slides.add_slide(get_layout(presentation, 'Closing  (Option 1)'))
    if slide.shapes.title:
        slide.shapes.title.text = title
    return slide


SLIDE_BUILDERS: dict[str, Any] = {
    'section':     lambda presentation, slide_definition: add_section_slide(presentation, slide_definition['title']),
    'content':     lambda presentation, slide_definition: add_content_slide(presentation, slide_definition['title'], slide_definition.get('bullets', [])),
    'two_content': lambda presentation, slide_definition: add_two_content_slide(presentation, slide_definition['title'], slide_definition.get('left', []), slide_definition.get('right', [])),
    'closing':     lambda presentation, slide_definition: add_closing_slide(presentation, slide_definition.get('title', '')),
}


def build_presentation(content: dict[str, Any], output_path: str) -> None:
    """Build and save a presentation from a content definition dict.

    Args:
        content: Parsed JSON content with title, optional subtitle, and slides list.
        output_path: File path where the .pptx will be saved.
    """
    presentation = Presentation(TEMPLATE_PATH)
    remove_template_slides(presentation)

    presentation.slides.add_slide(get_layout(presentation, 'Legal Disclosures'))
    add_cover_slide(presentation, content['title'], content.get('subtitle'))

    for slide_definition in content.get('slides', []):
        slide_type = slide_definition['type']
        builder = SLIDE_BUILDERS.get(slide_type)
        if builder:
            builder(presentation, slide_definition)
        else:
            print(f"Warning: unknown slide type '{slide_type}', skipping.")

    presentation.save(output_path)
    print(f"Saved: {output_path}")


if __name__ == '__main__':
    if len(sys.argv) < 2:
        print(__doc__)
        sys.exit(1)

    content: dict[str, Any] = json.load(open(sys.argv[1]))
    output_path: str = sys.argv[2] if len(sys.argv) > 2 else 'presentation.pptx'
    build_presentation(content, output_path)
