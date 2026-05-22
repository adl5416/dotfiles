---
name: atrr-deck
description: "Use this skill when updating ATRR (Acceptance Test Rollup Report) PowerPoint decks for new SDK versions. Trigger when the user mentions 'ATRR deck', 'test rollup report', or asks to update a PowerPoint for a new SDK release."
---

# ATRR Deck Skill

Update ATRR PowerPoint decks when creating new versions.

## Standard Updates

When creating an ATRR deck for a new SDK version:

1. **Build Hash** — Replace the old build hash (format: `DDMMYY-XXXXXXXX`) with the new one from the release folder name
   - Example: `260421-7E4D9D19` → `260521-6852CDF7`
   - Found in: Slide 1 (cover), Slide 3, Slide 4

2. **Date** — Update the test date on Slide 1 to the test completion date
   - Format: `MAY 26` (or appropriate month/day)
   - Also update all dates in the test domains results summary section

3. **Test Domains Status** — Mark domains that were skipped
   - Only tested domains get actual dates
   - Skipped domains: Result Date = `N/A`, Status = `SKIPPED`
   - Common pattern: First 2 domains tested, last 2 skipped

4. **Version Numbers** — Replace old version (e.g., `1.2.4`) with new version (e.g., `2.0.0`)

## Workflow

1. Source file: Previous ATRR deck for prior version
2. Replace version numbers (old → new)
3. Extract build hash from release folder: `/home/alex99/Downloads/Launch-Pad-IDKs-X.X.X-DDMMYY-XXXXXXXX/`
4. Replace all instances of old build hash with new one
5. Update test date to completion date
6. Mark skipped domains as `SKIPPED` with `N/A` dates
7. Save with new version in filename

## File Naming

Format: `IRDM-1023-TREP-013 v1.0 - 9704 Launch Pad SDK vX.X.X Test Rollup Report.pptx`

Example: `IRDM-1023-TREP-013 v1.0 - 9704 Launch Pad SDK v2.0.0 Test Rollup Report.pptx`
