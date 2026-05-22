---
name: partner-doc
description: "Use this skill when creating partner documentation including Application Notes (ANs) and Integration Control Documents (ICDs). Trigger when the user mentions 'partner doc', 'Application Note', 'AN', 'ICD', or asks to create partner-facing technical documentation."
---

# Partner Documentation Skill

Create partner-facing technical documentation using Iridium templates.

## Repository

Base path: `/home/alex99/Code/Iridium/Documentation/Partner/partner`

## Application Notes (ANs)

Short technical guides for specific features or integrations.

**Guide:** `/home/alex99/Code/Iridium/Documentation/Partner/partner/docs/misc/AN-Template/AN-Template-Guide.adoc`

**Base Template:** `/home/alex99/Code/Iridium/Documentation/Partner/partner/docs/misc/AN-Template/AN-Template-Base.adoc`

Format: AsciiDoc (.adoc)

Naming: `AN-XXXX-[Title].adoc`

## Integration Control Documents (ICDs)

Comprehensive technical specifications for partner integrations.

**Guide:** `/home/alex99/Code/Iridium/Documentation/Partner/partner/docs/misc/Long-Template/Long-Template-Guide.adoc`

**Base Template:** `/home/alex99/Code/Iridium/Documentation/Partner/partner/docs/misc/Long-Template/Long-Template-Base.adoc`

Format: AsciiDoc (.adoc)

## Workflow

1. Determine document type: AN (short) or ICD (comprehensive)
2. Read the appropriate guide (.adoc-Guide file)
3. Copy the base template (.adoc-Base file)
4. Follow guide structure and formatting
5. Save in appropriate location within `/home/alex99/Code/Iridium/Documentation/Partner/partner`
6. Use AsciiDoc format for all documents
