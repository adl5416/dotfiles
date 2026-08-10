---
name: launch-pad-atrr
description: Use when creating or updating an Iridium Launch Pad SDK Acceptance Test Results Review (ATRR) or Test Rollup Report (TREP) PowerPoint for a new release cycle. Triggered when the user asks to generate the monthly test rollup deck.
---

# Launch Pad ATRR / Test Rollup Report Generator

Produces a new TREP deck by cloning the previous release's PPTX and substituting all version-specific content: version strings, links, dates, checksums, and test domain results.

Also invoke the `document-skills:pptx` skill — this skill handles the *what to change*; the pptx skill handles the *mechanics* (unpack/edit/pack, QA).

## Overview

Two phases:
1. **Auto-discovery** — use the `agent-browser` skill (per global tool preference — not raw Playwright/browser MCP tools) to pull the latest version string, all SharePoint links, and all Jira links from live systems. Requires active browser sessions for SharePoint and Jira.
2. **Manual input** — ask the user only for the four things that can't be fetched: test domain results, exceptions, attendee changes, and the template PPTX path.

### Browser session reliability

SharePoint/Jira SSO login needs a human. If the host has a real display (check `echo $DISPLAY`; `xdpyinfo >/dev/null 2>&1` to confirm it's reachable), launch `agent-browser` with `--headed` and that `DISPLAY` value so a normal Chrome window opens for the user to log into directly — this is more reliable than the agent-browser observability dashboard (port 4848), whose remote mouse/keyboard forwarding has had real bugs (click-target offset, certain keys like `.` not registering). Fall back to the dashboard only if there's no usable local display. Wait on `agent-browser wait --url "**<target-domain>**"` (generous timeout, e.g. 300000ms) rather than polling after handing off for login.

---

## Phase 1: Auto-Discovery via Browser Automation

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
- **MD5 checksums** — each zip has a matching `{filename}.zip.md5.txt` file in the same folder; click it to open the preview and `read` the page, or `find text` + `get value` on the textbox in the "Link created" dialog — the checksum is right there, no download needed

**Getting SharePoint share links:** select a row (click its "Select row" cell, not the checkbox directly — the checkbox is often covered by other elements), then click **Copy link** from the toolbar that appears. This sometimes opens a "Link created" dialog with the URL in a readable textbox (`get value @ref`), and sometimes just shows a "Link copied" toast with no readable element — in that case read the OS clipboard instead (`xclip -selection clipboard -o` if on a real X display; requires `--headed` mode, see above). **Gotcha:** selecting a second row without deselecting the first leaves both selected ("2 selected"), which removes "Copy link" from the toolbar entirely (only single-select shows it) — press `Escape` to clear selection between files.

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
- **VTT ticket link(s)** — issues of type Verification Test Tracker. **Don't assume there are always two** (previous decks sometimes had one per HDK, i.e. two — but a cycle can just as easily ship a single combined VTT covering both 9604 and 9704). Search `project = <ID> AND issuetype = "Verification Test Tracker"` or look for a "TEST: Launch Pad IDKs vX.Y.Z Verification Test Tracker"-style summary; confirm the actual count with the user if it's not obvious from the release's issue list.
- **Test report attachment(s)** — attached to the VTT issue(s), under "Attachments". **Format and count vary by cycle**: some cycles attach a single combined PDF (`Launch-Pad-SDK-vX.Y.Z-Test-Report.pdf`), others attach the raw pytest-html reports directly, one per HDK (e.g. `9704_test_report.html`, `9604_test_results.html`). Check what's actually attached rather than assuming the PDF pattern in Key Details below — that pattern is a common case, not a guarantee. If there are two reports, slide 4 needs a second hyperlink + relationship added (see Phase 3 step 3).

Jira attachment URLs (`jira.iridium.com/secure/attachment/...`) force a download and can't be `open`ed/read directly in-browser (`net::ERR_ABORTED`). If you need to inspect a report's contents, click it to trigger the download, then check the browser's default Downloads folder (e.g. `~/Downloads/`) for the saved file.

If the Jira release page doesn't directly show the VTT ticket(s) and test report(s), navigate to the VTT issue itself (IDK-XXXX) and find the attachments there — or ask the user for the ticket/attachment links directly, which is often faster than searching.

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
Jira VTT:          https://jira.iridium.com/browse/IDK-XXXX  [confirm: one combined, or one per HDK?]
Test Report(s):    https://jira.iridium.com/secure/attachment/.../...  [confirm: PDF or HTML? one or two files?]
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
Increment the `TREP-NNN` number by 1 from the previous release. If the user doesn't provide a template PPTX path, use `~/.claude/templates/launch-pad-atrr-template.pptx` as the baseline — **but check its actual version first** (see docProps/core.xml `dc:title`, or just look at slide 1). This cached copy goes stale between sessions (it was 8 releases old — v2.0.0 — the last time this was checked, well behind the then-current v2.0.8) since nothing updates it automatically. If it's more than 1 release behind, tell the user and ask if they have the real previous deck; if forced to proceed with a stale template anyway, **flag the "Hardware Tested" / "Transceiver Firmware Tested" / MD5 sections on slide 3 as high-risk** even when the user says hardware/firmware are "unchanged" — "unchanged from last release" was true relative to a release many cycles back, not the actual last one, and this produced visibly wrong firmware/hardware data in practice. After generating a new deck, consider copying the finished output back over the cached template path so the next run starts from something closer to current.

Always generate a new output file — never overwrite the template.

### 1. Copy and unpack

```bash
cp "template.pptx" "output.pptx"
python scripts/office/unpack.py output.pptx unpacked/
```

`scripts/` here refers to the pptx skill's scripts directory:
`~/.claude/plugins/cache/anthropic-agent-skills/document-skills/*/skills/pptx/scripts/`

### 2. Run the bulk substitution script

**Watch for non-breaking spaces (`\xa0`, U+00A0).** The template frequently uses `\xa0` instead of a regular space right before values (`\xa0N/A`, `\xa0SKIPPED`, `\xa0PASS`). These render identically to a normal space in `cat`/`Read` output, so a plain-ASCII-space replacement string will silently fail to match. Verify with `python3 -c "print(repr(open(path,encoding='utf-8').read()[idx-5:idx+5]))"` around the target text before writing a replacement, or just do these specific substitutions directly in Python (`text.replace("\xa0N/A", ...)`) rather than via a shell/Edit-tool string that can't represent the character reliably.

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
| rId4 | End-of-paragraph ESVD (same slide, may mirror rId3) | New URL — **verify it actually matches rId3's target**; found pointing to a stale, unrelated older release in practice, not actually mirroring rId3 |
| rId5 | Jira VTT ticket | New URL |
| rId6 | Second VTT ticket, if the template has one | New URL, or point at the same single VTT URL as rId5 if this cycle only has one (don't leave it stale) |
| rId7 | Test report attachment #1 (9704) | New URL |

Don't assume rId7 is the only test-report slot. If there are **two test reports** this cycle (see Phase 1b), add a new relationship (next free rId, e.g. `rId8`) for the second report, and in `slide4.xml` split the "Test Report" paragraph's single hyperlinked run into two runs — one per report, each with its own `hlinkClick r:id`. Don't just overwrite rId7's target and drop the second report.

**Before wiring up new targets, dump every rId's current target-and-anchor-text pairing** (a small script pairing each `hlinkClick r:id="rIdN"` with the `<a:t>` text inside its enclosing `<a:p>`) so you know which visible text each rId actually drives — don't rely on the table above matching the template you're given, since rIds get renumbered/reordered across edits and orphaned ones accumulate.

**`ppt/slides/_rels/slide3.xml.rels`** — rId2 is the 9604 artifact ZIP on SharePoint; add a separate rId (e.g. `rId3`) for the 9704 ZIP rather than reusing rId2 for both — found both SDK-name runs sharing one `hlinkClick` (both pointing at the 9604 zip) in the template, which is wrong even though it doesn't visibly break anything until someone clicks the 9704 link.

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

**Text-based QA does not catch color/visibility bugs** — a slide can extract perfectly correct text via markitdown while being visually blank. Also render every slide to an image and actually look at it:
```bash
soffice --headless --convert-to pdf --outdir . output.pptx
pdftoppm -png -r 100 output.pdf slide
```
Then view a few of the resulting `slide-N.png` files (cover, a text-heavy slide, the results-summary slide) — this is what actually caught a LibreOffice-round-trip bug that made most body text invisible (see Known Issues below) when the text-only QA pass had shown nothing wrong.

Then do a visual QA pass per the pptx skill's instructions.

## Known Issues

**LibreOffice re-save makes all body text invisible.** If this deck (or the user) is later opened and saved with LibreOffice Impress, LibreOffice's PPTX export bakes an explicit `<a:schemeClr val="dk1"/>` fill onto every text run that previously inherited its color from the placeholder/master. In the Iridium template, `dk1` (`theme1.xml` `<a:clrScheme>`) equals `#33393e` — the exact navy used for the slide background — so every heading and bullet becomes the same color as the background and disappears. Hyperlinked runs stay visible because links use the separate `hlink` theme color (`#fcb131`, orange), which is why a broken deck shows working links but blank everything else. This is a strong, distinctive symptom: if the user reports "the text vanished after I had it open," check `docProps/app.xml` for `<Application>LibreOffice...` before looking anywhere else.

Fix: unpack the affected file and do `schemeClr val="dk1"` → `schemeClr val="lt1"` across `ppt/slides/*.xml` (verify first that every `dk1` hit in the file is inside an `rPr`/`endParaRPr`/`defRPr`/`solidFill` context, not a legitimate background fill, before doing the blanket replace — `grep -c` each slide, then spot-check contexts). This preserves the user's actual content edits; only the color token changes. Re-render to PNG to confirm before handing the file back.

**`pack.py`'s validator can false-positive on `_rels/.rels` after LibreOffice touches the file** — it may report `customXml/item*.xml` references as broken even though they're the same structure LibreOffice itself wrote and the file opens fine. If you hit this while repacking a file that's already been through LibreOffice, use `--validate false` and do your own sanity check instead (open with `python-pptx`, and/or render to PDF/PNG per the QA step above) rather than trying to restructure `customXml` relationships you didn't create and don't need to touch.

**Warn the user about LibreOffice** when handing off a finished deck if you know (or suspect, e.g. this is a Linux box) they'll edit it there: either recommend they use real PowerPoint for any further edits, or let them know to come back for the `dk1`→`lt1` fix if text goes missing after their next save.

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

**Test report attachment pattern:** `https://jira.iridium.com/secure/attachment/{ATTACHMENT_ID}/{filename}` — `{filename}` varies by cycle (a combined `Launch-Pad-SDK-vX.Y.Z-Test-Report.pdf`, or separate per-HDK pytest-html files like `9704_test_report.html` / `9604_test_results.html`); don't assume the PDF naming, check what's actually attached.

**`.rels` files hold the actual URLs; slide XML holds only display text.** Both must be updated when a link changes.

**TREP numbering:** Increment `IRDM-1023-TREP-NNN` by 1 from the previous release's document ID.
