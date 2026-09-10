---
name: github-pr
description: Prepare a reviewable Balangkas-PCC pull request targeting staging after Git and a remote are explicitly configured.
---

# Balangkas-PCC pull request workflow

Use only when the user asks to commit or open a PR and Git/remote access is configured. Read `docs/DEVOPS.md`, `docs/TESTING.md`, `docs/PREPARATION.md`, and the relevant feature specifications.

Inspect Git status, branch, remotes and existing PR state first. Preserve unrelated user changes. Create or reuse an allowed typed branch, never commit `.env`, secrets, generated artifacts or model weights, and use a conventional commit message. Target `staging`; do not merge without explicit user authorization.

During PREPARATION, validate documentation links, Compose configuration, dependency locks and the no-code boundary. After onsite implementation, add applicable unit/API/UI/migration checks. Include actual results and any external integration limitations in the PR body. Do not create a GitHub remote, alter branch protection or deploy as part of this skill.
