---
name: jira-ticket
description: "Use this skill when the user wants to draft JIRA ticket content — summaries, descriptions, or definitions of done. Trigger when the user mentions \"JIRA ticket,\" \"write a ticket,\" \"draft a ticket,\" \"ticket summary,\" \"definition of done,\" or asks to format something for JIRA. This skill generates copy-paste-ready ticket content; it does not interface with JIRA directly."
---

# JIRA Ticket Writing Skill

Generate well-structured JIRA ticket content following Iridium Product Engineering best practices (IRDM-0910-SD-001). Output is plain text ready to copy-paste into JIRA.

## Core Principles (The 3Cs)

- **Clear** — precision of language prevents confusion
- **Concise** — make it easy on the reader to understand you
- **Courteous** — success requires teamwork

## When the User Provides Context

1. Ask clarifying questions only if the blurb is too ambiguous to determine the ticket type (bug, feature, investigation) or scope.
2. Generate the ticket content in the format below.
3. Present it in a single fenced code block so the user can copy-paste it directly.

---

## Output Format

Always produce **two sections**: Summary and Description.

### Summary (Title)

- Think "newspaper headline" — key information first
- Use **imperative mood** ("Update firmware" not "Firmware should be updated")
- Include the specific system/component/product affected
- Keep it scannable — retains meaning when truncated on Kanban cards
- Bad: "Wrong Upgrade Tool Version"
- Good: "Erroneous Version Number in 960x Upgrade Tool TG17002 GUI"

### Description

Structure the description with these labeled sections:

```
*Executive Summary*
One or two sentences: what this ticket is about and why it matters.

*Impact Assessment*
Labeled sub-fields quantifying the risk/impact. Use whichever labels fit the situation:
Production Status: ...
Supply Risk: ...
Cost Impact: ...
Business Risk: ...
Customer Impact: ...
Schedule Impact: ...

*Context*
Key-value pairs and background. Use labeled fields for specifics:
Component: ...
Arena PN: ...
Product: ...
Additional narrative context as needed.
Links to related tickets (use JIRA linking syntax: PROJ-123).

*Details* (optional — include only when Context doesn't fully frame the ask)
A detailed but concise description of the issue or request.
- For bugs: what led up to the event, steps to recreate, all relevant versions
- For features/investigations: anything known that frames the ask
- Avoid speculation and hyperbole

*Definition of Done*
* (!) [INITIALS] Action item in imperative mood
* (!) [INITIALS] Another action item
* (?) [team] Optional/questionable item
```

---

## Definition of Done Rules

The DoD is the most critical part of the ticket. Follow these rules exactly:

### Status Icons

| Icon | Meaning |
|------|---------|
| `(!)` | Open — needs to be done |
| `(?)` | Questionable — may or may not need to be done |
| `(x)` | Skipped — did not need to be done (add sub-bullet explaining why) |
| `(/)` | Done |

### Assignment Markup

| Format | Meaning |
|--------|---------|
| `[JD]` | Assigned to a person (uppercase initials) |
| `[sv_sw]` | Assigned to a team (lowercase) |
| `[tsc]` | Assigned to a location/company (lowercase) |
| `[all]` | Everyone |

### Writing DoD Items

- Every bullet must be in **imperative mood** (a call to action)
- Good: "Update the ICD to reflect new command format"
- Bad: "ICD might need updating"
- Each bullet should be independently completable
- If you don't know specific assignees, omit the brackets — the user will add them

---

## Examples

### Example 1: Software Bug Ticket

When the user says: "We found that the 9770 beacon timing is off by 200ms when the unit is in cold start. It's causing missed pages for customers in polar regions."

Produce:

```
SUMMARY:
Correct 9770 Beacon Timing 200ms Offset During Cold Start

DESCRIPTION:
*Executive Summary*
The 9770 transceiver exhibits a 200ms beacon timing offset during cold start conditions, causing missed pages for subscribers in polar regions.

*Impact Assessment*
Customer-facing issue affecting page delivery reliability in polar coverage zones. Likelihood of occurrence is high for any cold-start scenario (power cycle, firmware update). This is a product support concern.

*Context*
- Observed in field reports from polar-region subscribers
- Affects 9770 (SFX) product line
- Related to cold-start initialization sequence

*Details*
During cold start, the beacon timing drifts 200ms from nominal. This offset persists until the unit completes full acquisition. Subscribers in polar regions (where satellite pass times are shorter) experience missed pages because the timing window is too narrow to absorb the offset.

Steps to reproduce:
1. Power cycle 9770 unit
2. Monitor beacon timing against reference
3. Observe 200ms offset during cold-start phase

*Definition of Done*
* (!) Root-cause the 200ms offset in cold-start beacon timing
* (!) Implement correction to beacon timing initialization
* (!) Verify fix does not regress warm-start timing
* (?) Update unit test coverage for beacon timing edge cases
* (!) Peer review and merge to trunk
```

### Example 2: Supply Chain / Investigation Ticket

When the user says: "Skyworks has repeatedly delayed delivery of the SKY12212-478LF RF switch (Arena PN 150-00094) used in the 9770. We are imminently running out of stock, production is line-down, and Supply Chain anticipates the part may go EOL within the year. This ticket investigates potential alternates to restore supply continuity."

Produce:

```
SUMMARY:
Investigate Alternate RF Switch for 9770 SKY12212-478LF (150-00094) Supply Continuity

DESCRIPTION:
*Executive Summary*
Skyworks has repeatedly delayed delivery of the SKY12212-478LF RF switch (Arena PN 150-00094) used in the 9770. We are imminently running out of stock, production is line-down, and Supply Chain anticipates the part may go EOL within the year. This ticket investigates potential alternates to restore supply continuity.

*Impact Assessment*
Production Status: 9770 manufacturing is currently line down until at least June pending component availability.
Supply Risk: Multiple push-outs from Skyworks, significant risk of further delays, and anticipated EOL this year.
Cost Impact: Unit price has increased from $4.179 to $27.19, creating substantial cost pressure.
Business Risk: We are at risk of extended production downtime and delivery delays.

*Context*
Component: Skyworks SKY12212-478LF
Arena PN: 150-00094
Product: 9770
Supply Chain notes early signs of EOL.
Initial engineering review indicates a fully FFF alternate is unlikely; form/fit/function deviations may be needed and will require validation.

*Definition of Done*
* (/) [irdm] Upload 9770 Arena BOM
* (!) [cc] Compile list of candidate alternates.
* (!) [cc] Summarize viable alternates (if any) with specs, pros/cons, and required validation scope.
* (!) [cc] Provide recommendations.
* (!) [AS] Review findings with stakeholders and decide on steps forward.
* (!) [AS] Create follow-on ticket for implementation (design change, layout update, validation) if an alternate is recommended.
```

Note: This example omits the *Details* section because the Context is self-explanatory. The DoD mixes `(/)` (already done) with `(!)` (still open) since the ticket is in progress.

---

## Additional Guidelines

- **One issue per ticket.** If the user's blurb contains multiple issues, suggest splitting into separate tickets.
- **No priority tags.** Backlog position determines priority, not High/Med/Low labels.
- **Imperative mood everywhere** — summary and DoD bullets are calls to action.
- **Prefix conventions** — if the user mentions product support, prefix summary with `[PS]`. For merge tickets, use `[MERGE]`.
- **Keep it DRY** — don't repeat the summary content verbatim in the executive summary; expand on it.
- **Audience-aware context** — if the ticket is being posted in a project dedicated to a specific vendor/team, don't redundantly name that vendor in the Executive Summary or Context. Keep vendor references in the DoD assignment brackets where they serve a functional purpose.
- **Sub-bullets for grouped work** — when a single DoD item covers multiple discrete replacements or sub-tasks, use JIRA sub-bullets (`** (!) ...`) to enumerate each one. This keeps the top-level DoD scannable while preserving traceability to individual items.
- **Linked investigations vs. implementation** — when an investigation is tracked in a separate ticket, call out that the *investigation* lives elsewhere but keep the *implementation action* (e.g., "Replace X per linked ticket recommendation") in this ticket's DoD. The linked ticket finds the answer; this ticket acts on it.
- **Open-ended scope** — when BoM analysis or similar discovery work may surface additional items, use a `(?) TBD` bullet in the DoD to signal that the list may grow. This sets expectations without blocking ticket creation.
