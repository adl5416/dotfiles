---
name: launch-pad-atrr
description: Use when creating or updating an Iridium Launch Pad SDK Acceptance Test Results Review (ATRR) or Test Rollup Report (TREP) PowerPoint for a new release cycle. Triggered when the user asks to generate the monthly test rollup deck.
---

# Launch Pad ATRR / Test Rollup Report Generator

Produces a new TREP deck by cloning the previous release's PPTX and substituting all version-specific content: version strings, links, dates, checksums, and test domain results.

Also invoke the `document-skills:pptx` skill — this skill handles the *what to change*; the pptx skill handles the *mechanics* (unpack/edit/pack, QA).

## Overview

Two phases:
1. **Auto-discovery** — use Playwright to pull the latest version string, all SharePoint links, and all Jira links from live systems. Requires active browser sessions for SharePoint and Jira.
2. **Manual input** — ask the user only for the four things that can't be fetched: test domain results, exceptions, attendee changes, and the template PPTX path.

---

## Phase 1: Auto-Discovery via Playwright

### 1a. Find the latest release on SharePoint

Navigate to the releases folder. The latest `Launch-Pad-IDKs-*` subfolder is the new version.

```
https://irdm.sharepoint.com/sites/MobileProductEngineering/Shared%20Documents/Forms/AllItems.aspx?id=%2Fsites%2FMobileProductEngineering%2FShared%20Documents%2F5202%20IOT%20SFX%2FIntegrator%20Development%20Kit%2FReleases&viewid=
```

Take a snapshot and read folder names. Identify:
- **VERSION_STRING** — the folder named `Launch-Pad-IDKs-X.Y.Z-YYMMDD-GITHASH8`

Then navigate into that folder to find:
- **ESVD PDF URL** — the `.pdf` file named `{VERSION_STRING}-ESVD - Launch Pad Family...`; get its SharePoint share link (right-click → Copy link, or construct directly from the path pattern in Key Details below)
- **Artifact ZIP URLs** — `9604-SDK-{VERSION_STRING}.zip` and `9704-SDK-{VERSION_STRING}.zip`; get their SharePoint share links
- **MD5 checksums** — check if a checksums or readme file is present in the folder; if not, note they must be provided manually

Derive from VERSION_STRING:
- `9604-SDK-VER` and `9704-SDK-VER` by substituting `Launch-Pad-IDKs` → `9604-SDK` / `9704-SDK`
- Semantic version (e.g. `2.1.0`) from the `X.Y.Z` portion

### 1b. Find the Jira release

Navigate to the IDK project releases page:
```
https://jira.iridium.com/projects/IDK?selectedItem=com.atlassian.jira.jira-projects-plugin:release-page
```

Find the release row matching the version string (or semantic version). Click it to open the release detail page. From the URL extract:
- **Jira Release URL** — `https://jira.iridium.com/projects/IDK/versions/{VERSION_ID}`

On the release detail page, look for:
- **VTT ticket links** — issues listed under "Issues in this version" of type that matches Verification Test Tracker; grab the two `IDK-XXXX` links that appear on slide 4 of the previous deck
- **Test Report PDF attachment URL** — find the test report PDF attachment link (`jira.iridium.com/secure/attachment/.../Launch-Pad-SDK-vX.Y.Z-Test-Report.pdf`)

If the Jira release page doesn't directly show the VTT tickets and test report, navigate to the VTT issue itself (IDK-XXXX) and find the PDF attachment there.

### 1c. Confirm findings with user

After discovery, present a summary table like:

```
VERSION_STRING:    Launch-Pad-IDKs-X.Y.Z-YYMMDD-HASH
9604 SDK:          9604-SDK-X.Y.Z-YYMMDD-HASH
9704 SDK:          9704-SDK-X.Y.Z-YYMMDD-HASH
Semantic version:  X.Y.Z
MD5 9604:          [found / NOT FOUND — need manual input]
MD5 9704:          [found / NOT FOUND — need manual input]
Jira Release URL:  https://jira.iridium.com/projects/IDK/versions/NNNNN
Jira VTT #1:       https://jira.iridium.com/browse/IDK-XXXX
Jira VTT #2:       https://jira.iridium.com/browse/IDK-XXXX
Test Report PDF:   https://jira.iridium.com/secure/attachment/.../...pdf
ESVD SharePoint:   https://irdm.sharepoint.com/...
ZIP SharePoint:    https://irdm.sharepoint.com/...
```

Flag any fields that couldn't be found and ask for them before proceeding.

---

## Phase 2: Manual Input Prompt

After auto-discovery, ask the user only for what couldn't be fetched:

```
--- LAUNCH PAD ATRR — MANUAL INPUTS ---

DECK PATHS
  Template PPTX (previous release, full path):
  Output path for new PPTX:
  New document ID (e.g. IRDM-1023-TREP-014 v1.0):

PRESENTATION DATE (cover slide)
  Presenter name // MON YY (e.g. Alex Lehman // JUN 26):

HARDWARE TESTED (leave blank if unchanged from last release)
  9604 device / transceiver / IMEI / location / test domain:
  9704 device / transceiver / serial / location / test domain:

TRANSCEIVER FIRMWARE TESTED (if changed from last release)
  9604 firmware version:
  9704 firmware versions (one per line, oldest first):

TEST DOMAIN RESULTS
  MPE  — result (PASS / FAIL / SKIPPED):
  MPE  — result date (e.g. 18 JUN 2026, or N/A):
  MPE  — skip reason (if SKIPPED):

  SA   — result (PASS / FAIL / SKIPPED):
  SA   — result date:
  SA   — skip reason (if SKIPPED):

  OOBE — result (PASS / FAIL / SKIPPED):
  OOBE — result date:
  OOBE — skip reason (if SKIPPED):

  C    — result (PASS / FAIL / SKIPPED):
  C    — result date:
  C    — skip reason (if SKIPPED):

EXCEPTIONS DURING TESTING (slide 6 — leave blank if none):

ATTENDEES (leave blank if unchanged)
  Managing Product Owner:
  Technical Product Owner:
  Acceptance Test Manager:
  Optional Attendees:
---
```

## Phase 3: Generation Workflow

File name convention (per IRDM-1023-MDIR-001):
```
IRDM-1023-TREP-NNN v1.0 - Launch Pad SDK vX.Y.Z Test Rollup Report.pptx
```
Increment the `TREP-NNN` number by 1 from the previous release. If the user doesn't provide a template PPTX path, use `~/.claude/templates/launch-pad-atrr-template.pptx` as the baseline (currently v2.0.0 / IRDM-1023-TREP-013). Always generate a new output file — never overwrite the template.

### 1. Copy and unpack

```bash
cp "template.pptx" "output.pptx"
python scripts/office/unpack.py output.pptx unpacked/
```

`scripts/` here refers to the pptx skill's scripts directory:
`~/.claude/plugins/cache/anthropic-agent-skills/document-skills/*/skills/pptx/scripts/`

### 2. Run the bulk substitution script

Create and run this Python script to replace all version strings and dates across every XML and .rels file in one pass. Fill in old/new values from the template PPTX and the input data:

```python
import os

UNPACKED = "unpacked/"

# Order matters: longest/most-specific strings first to avoid partial matches.
REPLACEMENTS = [
    # Full version strings
    ("Launch-Pad-IDKs-OLD_VER", "Launch-Pad-IDKs-NEW_VER"),
    ("9604-SDK-OLD_VER",        "9604-SDK-NEW_VER"),
    ("9704-SDK-OLD_VER",        "9704-SDK-NEW_VER"),
    # Checksums
    ("OLD_MD5_9604",            "NEW_MD5_9604"),
    ("OLD_MD5_9704",            "NEW_MD5_9704"),
    # Dates
    ("OLD_RESULT_DATE",         "NEW_RESULT_DATE"),   # e.g. "21 MAY 2026" → "18 JUN 2026"
    ("OLD_COVER_DATE",          "NEW_COVER_DATE"),     # e.g. "MAY 26"     → "JUN 26"
    # Semantic version in display text  (e.g. "v2.0.0" → "v2.1.0")
    ("vOLD_SEMVER",             "vNEW_SEMVER"),
    # URLs in .rels — Jira release version page
    ("versions/OLD_JIRA_VER_ID", "versions/NEW_JIRA_VER_ID"),
]

for dirpath, _, filenames in os.walk(UNPACKED):
    for filename in filenames:
        if not (filename.endswith(".xml") or filename.endswith(".rels")):
            continue
        path = os.path.join(dirpath, filename)
        with open(path, encoding="utf-8") as f:
            text = f.read()
        updated = text
        for old, new in REPLACEMENTS:
            updated = updated.replace(old, new)
        if updated != text:
            with open(path, "w", encoding="utf-8") as f:
                f.write(updated)
            print(f"  updated: {path}")
print("Done.")
```

### 3. Edit remaining content with the Edit tool

After bulk substitution, these items need targeted XML edits:

**`ppt/slides/_rels/slide4.xml.rels`** — replace all hyperlink `Target` values:
| rId | Points to | Action |
|-----|-----------|--------|
| rId2 | Jira Release version page | New URL |
| rId3 | New ESVD PDF (SharePoint) | New URL |
| rId4 | End-of-paragraph ESVD (same slide, may mirror rId3) | New URL |
| rId5 | Jira VTT ticket #1 | New URL |
| rId6 | Jira VTT ticket #2 | New URL |
| rId7 | Jira Test Report PDF attachment | New URL |

**`ppt/slides/_rels/slide3.xml.rels`** — rId2 is the artifact ZIP on SharePoint; replace with new release folder URL.

**`ppt/slides/slide5.xml`** — test domain results. For each domain (MPE, SA, OOBE, Customer), update:
- `Result Date:` bold run (or set to `N/A` if SKIPPED)
- `Result:` bold run (`PASS`, `FAIL`, or `SKIPPED`)
- `Reason:` bold run (add/remove as needed when SKIPPED)

**`ppt/slides/slide6.xml`** — exceptions. Clear or populate the exception text body.

**`ppt/slides/slide3.xml`** — if hardware or firmware changed: update device/transceiver/location lines and the transceiver firmware version list.

**`ppt/slides/slide1.xml`** — verify cover slide shows correct version string and cover date after bulk substitution.

**`ppt/slides/slide2.xml`** — update attendee names if they changed.

### 4. Clean and pack

```bash
python scripts/clean.py unpacked/
python scripts/office/pack.py unpacked/ "output.pptx" --original "template.pptx"
```

### 5. QA

```bash
python3 -m markitdown output.pptx
```

Check every slide for stale version strings or dates:
```bash
python3 -m markitdown output.pptx | grep -iE "OLD_SEMVER|OLD_VER|OLD_DATE"
```

Then do a visual QA pass per the pptx skill's instructions.

## Slide Change Reference

| # | Title | What changes each release |
|---|-------|--------------------------|
| 1 | Cover (ATRR) | Version string, cover date |
| 2 | Attendance Record | Attendees (if changed); PRO-001 link is static |
| 3 | Test Campaign Context | SDK versions, MD5s, firmware versions, hardware (if changed), scope text, artifact ZIP link |
| 4 | Related and Relevant Links | All Jira + SharePoint URLs and their display text labels |
| 5 | Test Domain Results Summary | Result, result date, skip reason for MPE / SA / OOBE / C |
| 6 | Exceptions During Testing | Exception content (clear if none) |
| 7 | Test Domains Description | Rarely changes |
| 8 | Decision Checklist | Release approval answers (pre-fill Y/N/N/A) |
| 9 | Next Steps | Static |
| 10 | Back cover | Static |

## Key Details

**Version string format:** `Launch-Pad-IDKs-X.Y.Z-YYMMDD-GITHASH8` (e.g. `Launch-Pad-IDKs-2.0.0-260521-6852CDF7`)

**Individual SDK strings:** `9604-SDK-X.Y.Z-YYMMDD-GITHASH8` and `9704-SDK-X.Y.Z-YYMMDD-GITHASH8`

**ESVD SharePoint URL pattern:**
```
https://irdm.sharepoint.com/sites/MobileProductEngineering/Shared%20Documents/
5202%20IOT%20SFX/Integrator%20Development%20Kit/Releases/
{VERSION_STRING}/{VERSION_STRING}-ESVD%20-%20Launch%20Pad%20Family%20of%20
Integrator%20Development%20Kits%20Engineering%20Software%20Version%20Description.pdf
```

**Jira release URL pattern:** `https://jira.iridium.com/projects/IDK/versions/{VERSION_ID}`

**Test Report PDF pattern:** `https://jira.iridium.com/secure/attachment/{ATTACHMENT_ID}/Launch-Pad-SDK-vX.Y.Z-Test-Report.pdf`

**`.rels` files hold the actual URLs; slide XML holds only display text.** Both must be updated when a link changes.

**TREP numbering:** Increment `IRDM-1023-TREP-NNN` by 1 from the previous release's document ID.
