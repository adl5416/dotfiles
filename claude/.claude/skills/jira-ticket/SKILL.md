---
name: jira-ticket
description: Use when writing, drafting, or reviewing a Jira ticket — bug reports, investigations, feature requests, supply chain issues, or any work item. Triggered by requests like "write me a Jira ticket", "draft a ticket for", "create a Jira for", or when producing a SUMMARY + DESCRIPTION block.
---

# Jira Ticket Writing

## Overview

Tickets are a method to **communicate between people** — efficiently, effectively, and respectfully. Every field you write will be read by product leads, tech leads, individual contributors, managers, and engineers doing archaeology years later. Write accordingly.

**The 3Cs:** Clear · Concise · Courteous

---

## Output Format

Always produce two labeled blocks:

```
SUMMARY:
<title>

DESCRIPTION:
<sections>
```

---

## Summary (Title) Field

Think **newspaper headline**: specific, front-loaded, imperative mood.

| Rule | Bad | Good |
|------|-----|------|
| Be specific | "Wrong Upgrade Tool Version" | "Erroneous Version Number in 960x Upgrade Tool TG17002 GUI" |
| Front-load key terms | "Issue with beacon timing on cold start in 9770" | "Correct 9770 Beacon Timing 200ms Offset During Cold Start" |
| Imperative mood | "Consider updating SSDI Table" | "Update SSDI Table" |
| Include part numbers / product names when relevant | "Fix RF switch issue" | "Investigate Alternate RF Switch for 9770 SKY12212-478LF (150-00094) Supply Continuity" |

**Imperative mood matters for closed tickets:** "Update SSDI Table" when DONE means we did it. "Consider Updating SSDI Table" when DONE is ambiguous — did we consider and decline? The title must be unambiguous at any status.

---

## Description Sections

Include the sections that are relevant. Omit sections that add no value (e.g. skip *Details* if *Context* is already self-explanatory for an investigation ticket).

### *Executive Summary*
1–2 sentences: **what** the ticket is about and **why it matters**. Audience: everyone. Lead with the product/component affected and the observable symptom or goal.

### *Impact Assessment*
1–2 sentences: **how big a deal is this?** Cover: field impact, likelihood of occurrence, what this is blocking, production/supply risk, cost impact. Audience: product lead prioritizing the backlog.

### *Context*
Background the reader needs: affected product lines, related tickets (spawned from / blocking), field reports, supply chain notes, prior investigations. Keep it factual — no speculation.

### *Details*
A concise but complete description of the issue or request.
- **Bugs:** steps to reproduce, expected vs. actual behavior, all relevant versions/hardware revisions.
- **Investigations/scoping:** what is known, what frames the ask, what is out of scope.
- **Supply chain:** component PN, Arena PN, pricing history, supplier status, current stock level.

Omit this section if *Context* already provides everything an engineer needs to start.

### *Definition of Done*
A live bullet checklist. Every ticket must have one. Write each item in **imperative mood** (a call to action).

---

## Definition of Done (DoD) Format

```
*Definition of Done*
* (!) <open item — not yet done>
* (/) <completed item>
* (?) <optional item — do if feasible>
* (x) <skipped item>
** Reason: <explanation for the skip — always required on (x)>
** Sub-bullet for additional detail or decisions under any item
```

**Status markers:**

| Marker | Meaning |
|--------|---------|
| `(!)` | Open — must be completed before close |
| `(/)` | Done |
| `(?)` | Optional — do if it makes sense |
| `(x)` | Skipped — always add a `**` sub-bullet explaining why |

**Assignment prefixes** (put before the action text):

| Prefix | Assigned to |
|--------|-------------|
| `[GC]` | Person — uppercase initials |
| `[sv_sw]` | Team, org, or location — lowercase |
| `[all]` | Everyone on the ticket |

A ticket is ready to close only when every item is `(/)` or `(x)`. No `(!)` or `(?)` items may remain open.

**Minimum DoD at ticket creation:**
```
*Definition of Done*
* (!) <DoD to be created>
```
Flesh it out before or as the ticket enters IN PROGRESS.

---

## Special Ticket Prefixes

Prepend to the Summary when applicable:

| Prefix | When to use |
|--------|-------------|
| `[PS]` | Product Support — customer-facing issue reported from the field |
| `[MERGE]` | Merge of a change from one product codebase to another |

---

## Dos and Don'ts

**Do:**
- One issue per ticket. Tickets and ticket links are cheap; confusion is not.
- Use ticket links liberally — if you find a related ticket while searching, link them.
- Write DoD items in imperative mood.
- Update the DoD as scope evolves; never delete items, only `(x)` them with explanation.

**Don't:**
- Use High/Med/Low priority tags — backlog order is the priority signal.
- Clone tickets (creates reset burden and lost tickets).
- Pile related issues into an open ticket — file a new one.
- Speculate or use hyperbole in *Details*.
- Leave `(x)` items without an explanatory sub-bullet.

---

## Examples

### Bug / Hardware Defect

User says: *"The 9770 beacon timing is off by 200ms during cold start. It's causing missed pages in polar regions."*

```
SUMMARY:
Correct 9770 Beacon Timing 200ms Offset During Cold Start

DESCRIPTION:
*Executive Summary*
The 9770 transceiver exhibits a 200ms beacon timing offset during cold start conditions, causing missed pages for subscribers in polar regions.

*Impact Assessment*
Customer-facing issue affecting page delivery reliability in polar coverage zones. Likelihood is high for any cold-start scenario (power cycle, firmware update). This is a product support concern.

*Context*
- Observed in field reports from polar-region subscribers
- Affects 9770 (SFX) product line
- Related to cold-start initialization sequence

*Details*
During cold start, beacon timing drifts 200ms from nominal. The offset persists until the unit completes full acquisition. Subscribers in polar regions (where satellite pass windows are shorter) experience missed pages because the timing window cannot absorb the offset.

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

### Supply Chain / Investigation

User says: *"Skyworks keeps delaying the SKY12212-478LF RF switch (Arena PN 150-00094) used in the 9770. We're almost out of stock, line is down, and Supply Chain thinks it may go EOL. Investigate alternates."*

```
SUMMARY:
Investigate Alternate RF Switch for 9770 SKY12212-478LF (150-00094) Supply Continuity

DESCRIPTION:
*Executive Summary*
Skyworks has repeatedly delayed delivery of the SKY12212-478LF RF switch (Arena PN 150-00094) used in the 9770. Stock is nearly depleted, production is line-down, and Supply Chain anticipates EOL within the year. This ticket investigates potential alternates to restore supply continuity.

*Impact Assessment*
Production is currently line down until at least June pending component availability. Multiple push-outs from Skyworks with significant risk of further delays. Unit price has increased from $4.179 to $27.19. A fully form/fit/function alternate is unlikely; deviations will require validation.

*Context*
- Component: Skyworks SKY12212-478LF
- Arena PN: 150-00094
- Product: 9770
- Supply Chain notes early signs of EOL

*Definition of Done*
* (/) [irdm] Upload 9770 Arena BOM
* (!) [cc] Compile list of candidate alternates
* (!) [cc] Summarize viable alternates with specs, pros/cons, and required validation scope
* (!) [cc] Provide recommendations
* (!) [AS] Review findings with stakeholders and decide on path forward
* (!) [AS] Create follow-on ticket for implementation if an alternate is recommended
```
