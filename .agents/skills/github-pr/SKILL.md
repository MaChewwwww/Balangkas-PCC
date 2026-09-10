---
name: github-pr
description: Commit existing Balangkas-PCC work and prepare a reviewable pull request to staging without creating branches. Use when the user asks to commit or open a PR after Git and the remote are configured.
---

# Balangkas-PCC pull request workflow

Use this skill only when the user asks to commit or open a pull request. Read `docs/DEVOPS.md`, `docs/TESTING.md`, `docs/PREPARATION.md`, and the relevant feature specifications before acting.

## Requested outcome and authority

| User request | Authorized work | Do not do automatically |
| --- | --- | --- |
| Commit | Validate, stage the intended files, and create one conventional commit | Push, open a PR, merge, or change a branch |
| Prepare/open a PR | Commit the intended work if needed, push the existing branch, and open or reuse its PR to `staging` | Merge, deploy, or alter branch protection |
| Merge | Verify the named PR and merge only when the user expressly authorizes it | Delete/switch branches or deploy unless separately requested |

## Pre-flight

Start with a read-only inventory:

```bash
git status --short
git branch --show-current
git remote -v
git log --oneline -5
git diff --check
```

Preserve unrelated user changes. The repository works from the existing `chore/pcc-preparation-infrastructure` branch: do not create, rename, delete, or switch branches unless the active user explicitly directs it. If the current branch is `staging`, stop and ask for direction rather than committing directly to the protected branch.

When a PR or merge is requested, also confirm GitHub access and look for the branch's entire PR history before mutating remote state:

```bash
gh auth status
gh pr list --head <current-branch> --state all --json number,state,url,mergedAt,title
```

An existing open PR is reused. An already merged PR is reported and never recreated. A closed, unmerged PR requires user direction before opening a replacement.

## Validation gates

Select checks by phase and changed surface; do not claim a check was run when it was not.

During PREPARATION, run applicable no-code checks before a commit:

```powershell
docker compose config
docker compose -f compose.staging.yaml config
docker compose -f compose.tools.yaml config
git diff --check
```

Also inspect changed files for the preparation boundary, Markdown links, lock/dependency consistency, manifests, and affected specifications. Do not run framework initializers, migrations, seeders, or application tests while the repository remains in PREPARATION.

After onsite authorization, run the named unit/API/UI scenarios for the change. Schema work additionally requires rendered migration SQL, an empty-database upgrade, repeat-safe seed verification, and the relevant browser/worker checks. Provider calls stay mocked unless a separately authorized live-account task names the target. Stop and report any failure before committing.

## Commit

Review the intended change before staging:

```bash
git diff --name-only
git diff -- <intended-files>
git add <intended-files>
git diff --cached --check
git diff --cached --name-status
```

Never stage `.env` files, credentials, generated artifacts, model weights, or unrelated user work. Use `type(scope): imperative summary`, with one of `feat`, `fix`, `docs`, `test`, `refactor`, or `chore`. Quote commit messages safely so shell-sensitive characters are preserved:

```bash
git commit -m 'docs(ops): clarify staging maintenance workflow'
git status --short
git log -1 --oneline
```

If the user asks only for a commit, do not push or open a PR. Report the commit SHA and validation results.

## Pull request

For a requested PR, push only the existing current branch:

```bash
git push --set-upstream origin <current-branch>
```

Then inspect its PR history across open, merged, and closed states before creating anything:

- If a PR is already open, report and reuse it; do not create a duplicate.
- If it is already merged, report that result and do not recreate, reset, or delete local work.
- If it is closed without merging, stop for user direction.
- Otherwise, create one reviewable PR from the current branch to `staging`.

The PR body must state the actual summary, validation results, documentation changes, and any external-integration limitation. Do not claim live deployment, provider success, or an unrun check. Verify a newly opened PR with `gh pr view <number-or-url> --json url,state,baseRefName,headRefName`.

Do not merge unless the user explicitly authorizes it. On an authorized merge, confirm the remote `MERGED` state and merge time with `gh pr view <number-or-url> --json state,mergedAt,url`. Do not delete or switch the local branch as cleanup; the standing repository rule retains the existing branch.

Do not create a GitHub remote, alter branch protection, deploy, or make server changes as part of this skill.
