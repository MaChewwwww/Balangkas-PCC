---
name: staging-maintenance
description: Perform authorized state-changing maintenance on the Balangkas-PCC staging VPS, including Compose service management, digest-pinned image rollout or rollback, configuration updates, migrations, and safe Docker cleanup. Use only for an explicitly identified configured staging target; do not use for source changes or preparation-phase deployment.
---

# PCC staging maintenance

Change the hackathon staging VPS deliberately and verify the result. This skill is for runtime operations after the application and an authorized target exist. It is not an authorization to provision, deploy, or contact a server during PREPARATION.

## Operation classes

| Requested operation | Required evidence before work | Minimum proof afterward |
| --- | --- | --- |
| Service restart/recreate | Confirmed host, service, and reason | Service health and recent logs |
| Image rollout/rollback | Authorized release record with exact image digests; `GITHUB_USERNAME` and `GITHUB_PAT` only when a private `ghcr.io` image must be pulled | Running digests match the record |
| Runtime configuration change | Named setting and affected services; never its secret value | Affected service health and behavior |
| Migration/seed | Verified backup, write quiescing, migration/seed command from onsite code | Schema head, seed result, worker health |
| Docker cleanup | Retained known-good digest set and target host | Disk result and retained rollback images |
| Root-level host administration | Explicit authorization plus administrator identity | Command-specific host verification |

## Before changing state

1. Read `docs/DEVOPS.md`, `docs/DOCKER.md`, `docs/FOUNDATION_STATUS.md`, and `.env.deployment.example`. For schema, worker, storage, or provider work, also read the pertinent PCC documentation.
2. Confirm the user has authorized the specific staging operation and target. Never infer a hostname, deploy directory, SSH user, key, image reference, previous release, or database state from unrelated external material.
3. Read an ignored `.env.deployment` only if it exists. Parse simple `KEY=value` entries without sourcing the file; do not print, stage, commit, or create it. Routine values are `STAGING_SSH_HOST`, `STAGING_SSH_USER`, `STAGING_SSH_PORT`, `STAGING_SSH_KEY_PATH`, and `STAGING_DEPLOY_DIRECTORY`. `STAGING_SSH_KEY_PATH` must resolve on the control machine to the configured private PEM key file; never read, print, copy, or embed its bytes. `GITHUB_USERNAME` is non-secret. Require `GITHUB_PAT` only when the authorized release includes a private `ghcr.io` image; it must be a GitHub classic `read:packages` token for that account and is read only at the point of registry authentication. `STAGING_ADMIN_SSH_USER` and `STAGING_ADMIN_SSH_KEY_PATH` are only for an explicitly authorized root-level task.
4. State the intended change and verification before executing it. Use the smallest command that achieves the authorized outcome.

Stop rather than guessing if the release record, target host, deployment directory, image digest, required private-registry credential, backup procedure, or applicable application command is missing.

## Connection and discovery

Use the routine deployment identity for service work. Use the configured SSH port, key, and keepalives for long operations:

```bash
ssh -o ServerAliveInterval=60 -o ServerAliveCountMax=3 \
  -p <staging-ssh-port> -i <staging-ssh-key> \
  <staging-user>@<staging-host> "<command>"
```

Before a state change, capture a lightweight server baseline without printing secrets:

```bash
cd <configured-deploy-directory>
docker compose -f compose.staging.yaml -f infra/deployment/compose.application.yaml --profile onsite config --quiet
docker compose -f compose.staging.yaml -f infra/deployment/compose.application.yaml --profile onsite ps
docker compose -f compose.staging.yaml -f infra/deployment/compose.application.yaml --profile onsite ps --format '{{.Service}}|{{.Image}}|{{.State}}'
```

Do not substitute an externally supplied server path, service, image, host, or domain. If the release record uses a different checked-in Compose invocation, use that exact invocation consistently for the whole operation.

## Server boundary

Never edit application source, templates, Dockerfiles, Compose files, or repository configuration on the VPS. Do not create commits, switch branches, pull source, or make ad-hoc patches there. Those changes require an approved PR to `staging`; the server receives only approved, digest-pinned runtime artifacts and authorized runtime configuration.

Routine maintenance uses the configured staging SSH identity. Use the configured port and SSH key, with keepalives for long-running operations. Do not read, echo, pipe, or use password/PAT values from an environment file except for the narrowly permitted private-GHCR authentication flow below.

For a private `ghcr.io` image only, authenticate the VPS Docker client before pulling its recorded digest. Pass `GITHUB_PAT` only through `docker login ghcr.io --username <GITHUB_USERNAME> --password-stdin` over the already authenticated SSH connection, with shell tracing disabled. Never put it in a command argument, remote environment file, Compose variable, image build, release record, log, or response; unset the local in-memory value immediately afterward. Public GHCR images and non-GHCR registries do not use this credential.

Root-level work—such as package, mount, account, firewall, or system-service changes—needs separate explicit authorization and both configured administrator identity values. First verify the administrator identity and non-interactive privilege capability; stop if it is unavailable rather than attempting password-based `sudo`.

## Serialized service operations

The deployment lock is `/tmp/balangkas-pcc-deploy.lock`. Acquire it for any operation that pulls, recreates, starts, stops, or restarts application services, so maintenance cannot race a release.

```bash
flock /tmp/balangkas-pcc-deploy.lock bash -lc '
  cd <configured-deploy-directory>
  docker compose -f compose.staging.yaml -f infra/deployment/compose.application.yaml --profile onsite \
    up -d --no-deps --force-recreate <service>
'
```

Use the actual configured Compose invocation if the authorized release record specifies a different configuration location. Do not substitute paths, services, image tags, or domains from unrelated external material.

## Service and image playbooks

For an explicitly named service restart or recreate, hold the lock and affect no other service:

```bash
flock /tmp/balangkas-pcc-deploy.lock bash -lc '
  cd <configured-deploy-directory>
  docker compose -f compose.staging.yaml -f infra/deployment/compose.application.yaml --profile onsite \
    up -d --no-deps --force-recreate <service>
'
```

For an authorized image rollout, first pull only the release-recorded digest references, then recreate the intended service under the lock. Never deploy a mutable tag. For a rollback, use the entire prior known-good digest set required by the affected services, keep writes quiesced when data compatibility is in question, and remember that an image rollback does not undo a schema migration.

For a runtime configuration change, display the setting name and affected services but redact the setting value. Apply the approved change through the configured runtime environment, then recreate only the services that consume it. Never edit code, Compose configuration, or repository files on the VPS.

## Allowed maintenance

- Restart, recreate, stop, or start explicitly named Compose services.
- Pull and deploy only the image digests recorded for an authorized staging release.
- Roll a service back to the prior known-good **digest set** under the deployment lock. A tag is only a lookup aid, not a deploy identity.
- Update an authorized runtime `.env` value. Before applying it, show the affected setting name and services without exposing its value; recreate only the affected services.
- Run an already-implemented migration or repeat-safe reference seeding command after the required backup and write quiescing steps.
- Prune Docker images or build cache only after confirming the retained known-good digest set remains available for rollback.

For a schema-affecting operation: back up PostgreSQL and MinIO first, enable the server-enforced write-quiesced maintenance state, wait for active requests and worker leases to drain, migrate, then verify schema head before recreating workers. Do not use legacy database stamps, seeds, service names, or migration commands from another repository. A fresh PCC database must follow its onsite migration contract.

The backup record must identify the successful PostgreSQL and MinIO backup artifacts and the isolated restore check. If either backup or the restore evidence is absent, stop before migration. Run only the migration and seed commands supplied by the onsite application repository; during PREPARATION these commands do not exist and must not be invented.

For cleanup, inspect image and disk usage first. Prune only after verifying the current and prior known-good digest sets remain retained. Do not use volume-pruning commands as ordinary cleanup.

## Destructive operations

Ask the user to confirm before `docker compose down`, any volume deletion, `docker system prune --volumes`, database drop/truncate, storage reinitialization, or a database restore/cutover. Identify the exact confirmed staging host and target volume/database first. Never use destructive cleanup as a shortcut for a failed migration or release.

## Verification and recovery

After every change, verify the relevant evidence rather than assuming success:

1. Compose service state and health.
2. The running service image digest against the authorized release record.
3. HTTPS, `/api/health`, a public route, and an authenticated route when the changed service affects them.
4. Migration head and worker logs after schema or worker work.
5. The maintenance-state exit and restored write access after a successful release.

Typical service evidence is:

```bash
cd <configured-deploy-directory>
docker compose -f compose.staging.yaml -f infra/deployment/compose.application.yaml --profile onsite ps
docker compose -f compose.staging.yaml -f infra/deployment/compose.application.yaml --profile onsite ps --format '{{.Service}}|{{.Image}}|{{.State}}'
docker compose -f compose.staging.yaml -f infra/deployment/compose.application.yaml --profile onsite logs --tail=100 <service>
curl --fail --silent --show-error <public-origin>/api/health
```

For proxy work, also verify a public route and an authenticated route. For migrations, confirm the application-reported migration head before workers resume. For storage work, verify authorized object access without exposing object contents or credentials.

If the application fails, keep writes quiesced and recreate the affected service with the prior known-good digest set. Image rollback does not reverse schema. If recovery requires a database restore, restore the matching backup in isolation, verify integrity, and stop for explicit cutover authorization.

Report the command category used, the target service(s), the verified image digest(s), the evidence obtained, and any remaining limitation. Never report a remote action as complete without its verification result.
