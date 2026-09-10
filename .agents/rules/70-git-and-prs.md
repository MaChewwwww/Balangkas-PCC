# 70: Git and pull requests

After Git initialization, use `feature/*`, `fix/*`, `docs/*`, `test/*` or `chore/*` branches and reviewable PRs to `staging`. Never push directly to `staging`. The hackathon VPS is the staging environment; no `main` branch or promotion workflow is used. Commit format is `type(scope): imperative summary`.

Run phase-appropriate checks before PR: documentation/infrastructure validation during preparation; application tests/migration rendering once onsite code exists. Do not stage `.env`, secrets, generated outputs or model weights. See [DevOps](../../docs/DEVOPS.md).
