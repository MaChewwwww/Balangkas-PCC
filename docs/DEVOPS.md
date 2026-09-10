# Single Azure VPS operations

## Target

One Azure VPS runs Nginx, the connected Next.js client, FastAPI, worker, PostgreSQL/pgvector, Redis and MinIO in Compose. Only Nginx exposes 80/443. SSH is restricted to operators; database, Redis and MinIO stay private. This is a single failure domain, not high availability.

The VPS hostname, sizing and network identity remain unset. Do not reuse practice host credentials, deploy directories, GitHub secrets, TLS files or Devnet identities. Provision them only in an authorized deployment task.

## Hackathon staging release

The Azure VPS is the sole hackathon **staging** environment. `staging` is the integration and deployment branch; this project has no `main` promotion or separate production environment. A release begins only from an approved PR merged into `staging` and an authorized release window.

1. Build and test the merged `staging` commit. Publish frontend, backend and worker images, then record the source commit and each image's repository digest in a release record.
2. Prepare the ignored deployment environment with image references in `repository@sha256:<digest>` form. A commit-SHA tag may aid discovery, but it is not a deployable identity. Verify every resolved reference matches the release record and retain the prior known-good digest set.
3. Back up PostgreSQL and MinIO metadata/object storage. Verify the backup can restore into a separate disposable location.
4. Acquire the deployment lock at `/tmp/balangkas-pcc-deploy.lock`. Put the application into a write-quiesced maintenance state, reject new mutations, and wait for in-flight requests and worker leases to finish. The lock coordinates operators; maintenance mode protects data from user traffic.
5. Pull only the recorded digest-pinned images. Run fresh migrations while writes remain quiesced, then run repeat-safe reference seeding once schema is at head. Abort on any failure; do not start a new worker against a partial schema.
6. Recreate frontend/backend, confirm their health and migration compatibility, then recreate the worker after its dependent schema/configuration check passes. Nginx is reloaded last, after upstream health endpoints pass.
7. Verify HTTPS, `/api/health`, public route, authenticated route, database migration head, worker logs and the running image digests. Reopen writes only after these checks pass; record the outcome against the release record.

Do not perform application code edits or Git commits on the server. CI/CD automation may execute this sequence only after the application exists and an authorized deploy workflow is created. The preparation repository has no active deployment workflow.

## Backup and recovery

Nightly logical PostgreSQL dump plus daily volume snapshot, and MinIO object/metadata backup, are required once state exists. Retain at least seven daily restore points during the event. Encrypt off-host backups and record success/failure without secret paths. Restore rehearsals target isolated volumes and a separate database name.

For an application failure, quiesce writes and recreate the service with the previous known-good digest set under the deployment lock. Image rollback does not roll back schema. Forward-compatible migrations are mandatory; if recovery requires database restore, keep writes stopped, restore the matching backup in isolation, verify integrity, then authorize the staging cutover. Never truncate or drop event data as a shortcut.

## Capacity, logs and certificates

Reserve memory before enabling OCR; API and database health have priority. Worker concurrency starts at one. Rotate container logs, monitor disk growth for Postgres, MinIO and images, and prune only unused images after confirming rollback needs. Certbot uses the bootstrap challenge location; certificate renewal runs before expiry and Nginx reload follows successful renewal.

## Branching

Use `feature/*`, `fix/*`, `docs/*`, `test/*` or `chore/*` branches and approved PRs to `staging`; never push directly to `staging`. `staging` is the repository's only integration/release branch for the hackathon, and no `main` branch or promotion workflow is used. Commit messages follow `type(scope): imperative summary`.
