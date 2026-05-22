---
name: merge-request
description: "Use this skill when the user wants to draft a merge request — title, description, or definition of done. Trigger when the user mentions \"merge request,\" \"write an MR,\" \"draft an MR,\" \"MR description,\" or asks to format something for a merge request. This skill generates copy-paste-ready MR content."
---

# Merge Request Writing Skill

Generate well-structured merge request content. Output is plain text ready to copy-paste into GitLab/GitHub.

## Output Format

Always produce **two sections**: Title and Description.

### Title

- Concise summary under 70 characters
- Imperative mood: "Add feature" not "Added feature"
- Include what changed, not why

### Description

Structure the description with these labeled sections:

```
*What changed*
Brief summary of the changes.

*Why*
Context and reasoning for the change.

*How to test*
Steps to verify the changes work as expected.

*Related issues*
Link to related tickets (e.g., PROJ-123).

*Checklist*
* (!) Self-reviewed the diff
* (!) Tests pass locally
* (!) No breaking changes
* (?) Updated documentation if needed
```

---

## When the User Provides Context

1. Ask clarifying questions only if the MR scope is too ambiguous.
2. Generate the MR content in the format above.
3. Present it in a single fenced code block so the user can copy-paste it directly.

---

## Additional Guidelines

- **One logical change per MR** — if multiple features, suggest splitting into separate MRs
- **Keep it focused** — avoid scope creep
- **Be specific in testing steps** — make it easy for reviewers to verify
- **Link related work** — reference tickets, issues, or related MRs
