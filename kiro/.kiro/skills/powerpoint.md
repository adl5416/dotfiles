---
name: iridium-powerpoint
description: "Use this skill when the user wants to create an Iridium-branded PowerPoint presentation. Trigger when the user mentions 'PowerPoint', 'presentation', 'slides', or 'deck'. Generate a content.json and run the generator script to produce a .pptx file."
---

# Iridium PowerPoint Skill

Generate Iridium-branded `.pptx` files using the generator script and official template.

## Templates

Path: `~/.kiro/templates/iridium_powerpoint_template.pptx`
Path: `~/Code/Iridium/Documentation/Partner/partner/docs/misc/R&D/templates/Iridium_Presentation_Template.pptx`

## Generator Script

Path: `~/.kiro/scripts/create_powerpoint.py`

Run with:
```bash
uv run --with python-pptx python3 ~/.kiro/scripts/create_powerpoint.py content.json output.pptx
```

## content.json Format

```json
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
```

## Available Slide Types

| Type | Layout Used | Use for |
|------|-------------|---------|
| `section` | Section Header | Section dividers |
| `content` | Title and Content | Standard bullet-point slides |
| `two_content` | Two Content | Side-by-side content |
| `closing` | Closing (Option 1) | Final slide |

## Slide Structure

Every presentation must follow this order:
1. Legal Disclosures — added automatically
2. Cover slide — from `title` and `subtitle` fields
3. Content slides — from `slides` array
4. Closing slide — last entry in `slides`

## Branding Rules

- Trademarks: always `Iridium®`, `Iridium Certus®` with superscript on first use
- Never use "Certus" alone — always "Iridium Certus®"
- Never use the retired "Iridium Everywhere" logo
- "IRIDIUM PROPRIETARY BUSINESS INFORMATION" footer is included automatically via the template
