---
name: git-workflow
description: Git branching strategy and merge request workflow. Use when creating branches, committing, or preparing MRs.
---

## Branching
- Main branch: `main`
- Feature branches: `feature/<short-description>`
- Bug fixes: `fix/<short-description>`
- Hotfixes: `hotfix/<short-description>`

## Commits
- Use conventional commits: `feat:`, `fix:`, `docs:`, `refactor:`, `test:`, `chore:`
- One logical change per commit
- Write in imperative mood: "add feature" not "added feature"

## Merge Requests
- Keep MRs focused — one feature or fix per MR
- Title: concise summary under 70 characters
- Description: what changed, why, how to test
- Self-review diff before requesting review
- Squash commits if history is messy

## CI/CD
- All tests must pass before merge
- Lint and format checks run automatically
- Build must succeed on target branch
