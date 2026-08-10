---
name: iridium-jira-tickets
description: "Write JIRA tickets following the Iridium Product Engineering ticket management standards (IRDM-0910-SD-001). Use this skill whenever the user asks to create a JIRA ticket, write a bug report, draft a feature request, write a Definition of Done, compose a TL;DR comment, or needs help structuring any JIRA content for Iridium projects. Also use when the user mentions BCX, SFX, SQM, TD8, TD2, HB, or ANC projects."
---

# Iridium JIRA Ticket Writing Guide

Based on IRDM-0910-SD-001 v1.7 - Product Engineering JIRA Ticket Management.

## Core Philosophy: The 3Cs

All JIRA content must be **Clear**, **Concise**, and **Courteous**. Tickets communicate between people — put as much effort into your ticket as you expect from others.

## Ticket Summary (Title)

The Summary is how a ticket gets noticed everywhere — Kanban cards, status decks, release notes, executive presentations.

Rules:
- Write in **imperative mood** (a call to action): "Update SSDI Table" not "Consider Updating SSDI Table"
- Put key information at the front (survives truncation on board cards, enables fast grok)
- Think "newspaper headline"
- Include enough specifics to avoid ambiguity

Bad: "Wrong Upgrade Tool Version"
Good: "Erroneous Version Number in 960x Upgrade Tool TG17002 GUI"

## Ticket Description

Structure every description with these sections:

```
h3. Executive Summary
One or two sentences of what the ticket is about and why it matters.

h3. Impact Assessment
How big a deal is this? What happens if it occurs in the field? How likely? What is this blocking?

h3. Context
Relevant background, pointers to related tickets, links.

h3. Details
Detailed (but concise) description of the issue or request.
- For bugs: steps to recreate, what led up to the event, all relevant versions
- For investigations: anything known that frames the ask

h3. Definition of Done
* (!) <first action item>
* (!) <second action item>
```

### Who Reads What

| Audience | Needs |
|----------|-------|
| Product Lead | Impact Assessment (value and risk) |
| Technical Lead | Full ticket + Definition of Done |
| Individual Contributor | Details, reproduction steps, what to do |
| Managers/Observers | Exec Summary, Impact, Context, DoD progress |

## Definition of Done (DoD)

A bullet-point checklist in the Description that defines scope, communicates progress, and prevents scope creep.

### Status Icons

| Icon | Meaning |
|------|---------|
| `(!)` | Open — needs to be done |
| `(?)` | Questionable — may or may not need to be done |
| `(x)` | Skipped — did not need to be done (always add sub-bullet explaining why) |
| `(/)` | Done |

### Assignment Markup

- `[UPPERCASE INITIALS]` for a person: `[JD] Update the ICD`
- `[lowercase reference]` for a team/location/company: `[sv_sw] Report on algorithm`
- `[all]` for everyone: `[all] Agree command format`

### DoD Lifecycle

1. Author takes first stab at DoD (minimum: `* (!) <DoD to be created>`)
2. Leads flesh it out while ticket is in backlog
3. Icons updated as tasks are worked
4. Sub-bullets added when Done/Skipped needs explanation
5. Scope is never deleted — use strikethrough or change `(!)` to `(x)` with explanation
6. Ticket is ready for closure when all items are `(/)` or `(x)` — no `(!)` or `(?)` remaining

### DoD Example

```
h3. Definition of Done
* (/) [GC] Discuss user story among stakeholders
* (/) [all] Agree command format and update ICD
** ICD updated to v1.4 per [this attachment]
* (/) Add handling for operationalState command
* (/) Add API for access to TRX operationalState
* (x) [tsc] Update/implement unit tests
** No unit tests needed since none of the internal libraries changed.
```

## TL;DR Comment

A summary comment added when transitioning to READY or REJECT. Should include an appropriate subset of:

- "TL;DR: " prefix
- Recap of the original issue
- Key findings that altered trajectory
- Key decisions and reasoning
- Summary of changes made (code/docs/hardware)
- Explicit "no changes made" statement if applicable
- Summary of new behavior/features
- References to splinter tickets and reasoning
- For rejections: the reason for rejection
- Optional PSRN one-liner if title isn't self-explanatory

## Comment Best Practices

- Update every 2-3 days (keep tickets "green" on board)
- Link to attachments explicitly (don't just say "see attached")
- Use bullet points for readability
- Keep logs/snippets over ~10 lines as attachments, not inline
- Use formatting (emphasis, code markup) for readability
- No salutations or signatures (this isn't email)
- Use @mentions at end of comment when expecting specific feedback
- Once ticket is COMPLETE, no further technical conversation — open a new ticket instead

## Ticket Workflow States

```
TRIAGE → GROOMED BACKLOG → IN PROGRESS ⇄ BLOCKED
                                ↕
                             REVIEW → READY → COMPLETE → VERIFIED
```

- **TRIAGE**: Newly created, awaiting prioritization
- **GROOMED BACKLOG**: Triaged and prioritized, DoD should be fleshed out
- **IN PROGRESS**: Being actively worked (grab from top of backlog, assign to self)
- **BLOCKED**: Waiting on external entity (not internal team)
- **REVIEW**: Independent peer review (not the change author)
- **READY**: Review complete, TL;DR added, discussed in standup then unassigned
- **COMPLETE (Done)**: Release artifact produced
- **COMPLETE (Rejected)**: Rejected with mandatory comment explaining why
- **COMPLETE (Verified)**: Downstream verification complete

## Key Rules

- One issue per ticket — tickets are cheap, confusion is expensive
- Do not pile additional "related" issues onto an existing ticket
- Do not clone tickets (causes more confusion than it saves)
- Use JIRA ticket links to connect related tickets
- Feature branches named: `<jira_ticket>_<description>` (e.g., `TD8-207_bcch_type_ii_ptt`)
- Merge commit messages include ticket ID: `TD8-152: Improve beam selection in PTT`
- A healthy ticket has 5-20 comments (fewer = scope too small, more = scope too big)
