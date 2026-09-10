# 70: Git and pull requests

Use the existing `chore/pcc-preparation-infrastructure` branch for repository work. Do not create, rename or delete branches unless the active user explicitly reverses this instruction. Reviewable PRs target `staging`; never push directly to `staging`. The hackathon VPS is the staging environment, and no `main` branch or promotion workflow is used. Commit format is `type(scope): imperative summary`.

Run phase-appropriate checks before PR: documentation/infrastructure validation during preparation; application tests/migration rendering once onsite code exists. Do not stage `.env`, secrets, generated outputs or model weights. See [DevOps](../../docs/DEVOPS.md).
