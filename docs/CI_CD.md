# CI/CD readiness contract

**Status: preparation definition and staging environment configured.** The GitHub `staging` Environment, branch restriction to `staging`, connection secrets (`STAGING_SSH_PRIVATE_KEY`, `STAGING_SSH_KNOWN_HOSTS`, `STAGING_GHCR_PULL_TOKEN`), and variables (`STAGING_SSH_HOST`, `STAGING_SSH_USER`, `STAGING_SSH_PORT`, `STAGING_DEPLOY_DIRECTORY`, `STAGING_PUBLIC_ORIGIN`, `GHCR_USERNAME`) are configured for `MaChewwwww/Balangkas-PCC`. Actions workflows, image builds, and releases remain held at the preparation gate until explicit onsite authorization to develop and deploy.

The Azure VPS is the single hackathon **staging** target. `staging` is the sole integration and release branch: there is no `main` promotion or production environment. After onsite activation, merging an approved PR into `staging` automatically starts checks, image publishing and deployment to the VPS; no separate deploy click is required.

## Delivery model

| Stage | Trigger and scope | Required result | Must not do |
| --- | --- | --- | --- |
| CI | Pull request targeting `staging` | Run the focused unit, integration and Vitest checks available after onsite activation; use `.env.accounts.example` only for disposable auth-fixture tests; mock external providers | Access staging credentials, publish an image, load a developer's ignored account catalog, alter the VPS, or run browser E2E/visual-regression suites |
| Build and publish | A push to `staging` resulting from an approved PR merge, after checks pass on that exact commit | Build the frontend, backend and worker images; publish them to the selected registry; record the source commit and immutable digest for each image | Deploy by tag, use a personal token for routine GHCR publishing, or deploy before all required checks and image publications succeed |
| Staging deploy | Automatically after the same merged `staging` commit passes required checks and all three images are published | Verify the recorded commit/digest set, run the [staging release sequence](DEVOPS.md#hackathon-staging-release), and record the outcome | Accept arbitrary image references, deploy a pull request, bypass the deployment lock, or change application source on the VPS |

The approved PR merge is the rollout trigger. The release workflow uses a push to `staging`, with deployment dependent on successful checks and image publishing in that run. Opening or updating a PR, closing it without merging, or a failed check/build never deploys. `workflow_dispatch` is not required for normal delivery. Direct, authorized SSH maintenance remains valid for urgent work, but follows the same digest, backup, write-quiescing, lock, verification and release-record rules through the [staging-maintenance skill](../.agents/skills/staging-maintenance/SKILL.md).

## GitHub Environment

Create one GitHub Environment named `staging` during onsite setup. Restrict deployment branches to the exact `staging` branch. Do not create `development`, `production`, or `main` environments for this hackathon.

For speed, the default is no required reviewer and no wait timer. Approval and merge of the PR are the human release decision; normal delivery has no additional manual approval step. If the team later enables a protection rule, the job must use the `staging` Environment so its secrets remain unavailable until that rule passes. GitHub Environments and their secrets for a private repository require a plan that supports them; confirm this before relying on the pipeline. [GitHub's Environment documentation](https://docs.github.com/en/actions/how-tos/deploy/configure-and-manage-deployments/manage-environments) defines the availability and branch/protection behavior.

Set the Environment URL only after the real HTTPS public origin exists. It is a navigation aid, not an authority or substitute for the workflow health check.

## Environment secrets

Put deployment credentials in the `staging` Environment, never in a repository file, image, application container, job summary, or non-secret variable. GitHub only makes Environment secrets available to jobs that reference that Environment; secrets must be injected explicitly into a workflow. [GitHub's secret guidance](https://docs.github.com/en/actions/concepts/security/secrets) also recommends the least privilege required.

| Secret | Needed | Value and boundary |
| --- | --- | --- |
| `STAGING_SSH_PRIVATE_KEY` | Required for a CI/CD deployment | The fresh, restricted deployment-account private-key PEM bytes. It is an Actions secret, unlike local `STAGING_SSH_KEY_PATH`, which is only a path to a local PEM file. The workflow writes it only to a short-lived mode-restricted runner file and removes it on exit. |
| `STAGING_SSH_KNOWN_HOSTS` | Required for a CI/CD deployment | The pinned `known_hosts` record for the exact staging SSH host. The workflow must use this record for host verification; it must not disable host-key checking or accept a host key interactively. |
| `STAGING_GHCR_PULL_TOKEN` | Only when the deployed GHCR images are private | A GitHub classic PAT limited to `read:packages`, held by the account named in `GHCR_USERNAME`. It is supplied only to the VPS-side Docker login through standard input and is never a Compose, application, image-build, release-record, command-line or log value. Omit it for public GHCR images or a different registry. |

Do not attempt to create an Actions secret named `GITHUB_PAT`: GitHub secret names may not start with `GITHUB_`. The reserved built-in `GITHUB_TOKEN` is supplied by GitHub to a workflow; it is not a secret the team creates. For GHCR publishing, the build job grants that token only `contents: read` and `packages: write`, which is GitHub's documented model for publishing images associated with the workflow repository. [GitHub's publishing guide](https://docs.github.com/en/actions/tutorials/publish-packages/publish-docker-images) and [Container Registry guidance](https://docs.github.com/en/packages/working-with-a-github-packages-registry/working-with-the-container-registry) describe this model.

The local manual-maintenance counterpart remains the ignored `.env.deployment` pair `GITHUB_USERNAME` and `GITHUB_PAT`. It is intentionally not the GitHub Actions secret naming scheme. For private GHCR pulls, both use the same minimum `read:packages` capability; GitHub documents digest pulls and this scope in its [Container Registry guidance](https://docs.github.com/en/packages/working-with-a-github-packages-registry/working-with-the-container-registry).

## Environment variables

Environment variables are non-secret deployment coordinates. They can appear unmasked in workflow output, so never place a credential, token, key, connection string, internal object identifier, or runtime configuration secret in them. [GitHub's variables guidance](https://docs.github.com/en/actions/concepts/workflows-and-actions/variables) makes this distinction explicit.

| Variable | Needed | Value |
| --- | --- | --- |
| `STAGING_SSH_HOST` | Required for a CI/CD deployment | Exact VPS hostname or IP address. |
| `STAGING_SSH_USER` | Required for a CI/CD deployment | Restricted deployment-account login name. |
| `STAGING_SSH_PORT` | Required for a CI/CD deployment | SSH port; use `22` only when the provisioned host uses it. |
| `STAGING_DEPLOY_DIRECTORY` | Required for a CI/CD deployment | Absolute directory on the VPS containing the approved Compose deployment files and ignored runtime environment files. |
| `STAGING_PUBLIC_ORIGIN` | Required for final HTTPS health verification | Exact `https` public origin, with no path or wildcard. It must agree with the VPS application's `PCC_PUBLIC_ORIGIN` but does not replace it. |
| `GHCR_USERNAME` | Only for private GHCR pulls | GitHub account that owns the package-read capability used by `STAGING_GHCR_PULL_TOKEN`. |

Do not define static `FRONTEND_IMAGE`, `BACKEND_IMAGE` or `WORKER_IMAGE` variables in GitHub. A build produces those values per release, and the deploy job accepts only the recorded `repository@sha256:<digest>` set for the selected successful `staging` release. Tags are discovery aids, never deployment identity.

## What remains on the VPS

GitHub Actions receives only the deployment connection material above. The VPS keeps its ignored `.env.application`, runtime model files, Solana operator key, provider credentials, database/Redis/MinIO configuration and application secrets. In particular, do **not** copy any of the following into GitHub Actions secrets or variables:

- `DATABASE_URL`, MinIO credentials, `PCC_SESSION_SIGNING_KEY`, Brevo, Challonge or PayMongo credentials/webhook secret;
- biometric, RF-DETR or PaddleOCR artifacts and their records;
- the Solana operator signer, program material or wallet secrets; and
- the local `GITHUB_PAT`/`GITHUB_USERNAME` maintenance values except through the conditional, separately named GHCR pull secret above.

The workflow may select a digest-pinned release and invoke the release procedure, but it must not manufacture or rewrite the VPS runtime configuration. See [Configuration](CONFIGURATION.md), [Docker deployment](DOCKER.md), and [DevOps](DEVOPS.md).

## Onsite workflow requirements

When application development is explicitly activated, create the workflow files with these constraints:

1. Pin every third-party GitHub Action to a full commit SHA and give each job the smallest explicit permission set.
2. Keep CI, image publishing and deploy jobs separate. Only the deploy job references the `staging` Environment or SSH/GHCR-pull secrets.
3. Build images from the exact merged `staging` commit. Record the commit plus all three resolved registry digests before its dependent deploy job can start.
4. Automatically run the deploy job after successful merged-commit checks and publication of all three images in the same release workflow; reject any ref other than `staging`. Consume only that run's recorded commit/digest set, never free-form image inputs. Serialize staging deployments without cancelling an in-progress deployment. Under the VPS lock, reject a stale release that would replace a newer deployed commit; a queued release superseded by a newer staging head may be skipped. Rollbacks remain explicit operator recovery actions.
5. Before connecting, install the pinned SSH known-hosts record and the temporary restricted PEM file. Do not print, transform, upload as an artifact, or persist either secret. For a private GHCR pull, relay the token only to `docker login --password-stdin` on the authenticated VPS session.
6. On the VPS, acquire `/tmp/balangkas-pcc-deploy.lock`, back up and validate restore, quiesce writes, run migrations before the worker, roll out only the selected digest set, and complete the [DevOps verification sequence](DEVOPS.md#hackathon-staging-release). Preserve the prior known-good digest set for rollback.
7. Publish a non-secret release outcome: source commit, image digests, migration result, health/HTTPS result, rollback target, triggering actor, workflow run and time. Never include environment values, key paths, tokens, provider responses, or user data.

Focused unit, API/integration and Vitest checks are appropriate once code exists. For auth changes, CI copies the tracked `.env.accounts.example` only into a disposable test environment and proves the catalog's repeat-safe behavior; ignored local account files and staging never enter CI. Browser E2E and visual-regression automation remain out of scope; use the developer [manual UI report](screens/MANUAL_UI_REPORT.md) for UI verification.

## Onsite setup checklist

1. Confirm explicit onsite development/deployment authorization and record activation as required by [the preparation boundary](PREPARATION.md).
2. Confirm that the repository's GitHub plan supports private-repository Environments. Create and branch-restrict `staging` before creating a deploy workflow.
3. Provision a fresh, restricted VPS deployment account and SSH key; obtain and verify the VPS host key out of band. Add the required Environment secrets and non-secret variables above without echoing their values.
4. Create the build and deploy workflows only after the application and image definitions exist. Test CI on a pull request first; then build one `staging` release, record its exact digests, and verify that its dependent deployment starts automatically without a manual dispatch.
5. Verify HTTPS, `/api/health`, a public route, an authenticated route, migrations, worker state and running image digests. Record the manual UI report and release outcome. Rehearse the documented digest rollback and backup restore before relying on the pipeline.

## Current preparation boundary

The GitHub `staging` Environment, branch restriction to `staging`, and CI/CD secrets and variables are now provisioned. Actions workflow files and automated releases remain intentionally excluded during preparation. Creating workflows, building images, and performing releases are separate, explicitly authorized onsite tasks.
