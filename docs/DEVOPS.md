# Single Azure VPS operations

## Target

One Azure VPS runs Nginx, the connected Next.js client, FastAPI, worker, PostgreSQL/pgvector, Redis and MinIO in Compose. Only Nginx exposes 80/443. SSH is restricted to operators; database, Redis and MinIO stay private. This is a single failure domain, not high availability.

The VPS hostname, sizing and network identity remain unset. Do not reuse practice host credentials, deploy directories, GitHub secrets, TLS files or Devnet identities. Provision them only in an authorized deployment task.

## Onsite release sequence

1. Build/test the feature branch and merge an approved PR into `staging`.
2. Build immutable frontend/backend/worker images tagged with the commit SHA; record image digests.
3. Back up PostgreSQL and MinIO metadata/object storage. Verify backup can restore into a separate disposable location.
4. Acquire the deployment lock at `/tmp/balangkas-pcc-deploy.lock` and verify working tree/image identities.
5. Pull only the intended immutable images. Run fresh migrations before starting workers; run repeat-safe reference seeding once schema is at head.
6. Recreate frontend/backend, then worker after its dependent schema/configuration check passes. Nginx last, after its upstream health endpoints pass.
7. Verify HTTPS, `/api/health`, public route, authenticated route, database migration head, worker logs and actual image digests.

Do not perform application code edits or Git commits on the server. CI/CD automation may execute this sequence only after the application exists and an authorized deploy workflow is created. The preparation repository has no active deployment workflow.

## Backup and recovery

Nightly logical PostgreSQL dump plus daily volume snapshot, and MinIO object/metadata backup, are required once state exists. Retain at least seven daily restore points during the event. Encrypt off-host backups and record success/failure without secret paths. Restore rehearsals target isolated volumes and a separate database name.

For an application failure, recreate the service with the previous known-good immutable image under the deployment lock. Image rollback does not roll back schema. Forward-compatible migrations are mandatory; if recovery requires database restore, stop writes, restore the matching backup in isolation, verify integrity, then authorize the cutover. Never truncate or drop production data as a shortcut.

## Capacity, logs and certificates

Reserve memory before enabling OCR; API and database health have priority. Worker concurrency starts at one. Rotate container logs, monitor disk growth for Postgres, MinIO and images, and prune only unused images after confirming rollback needs. Certbot uses the bootstrap challenge location; certificate renewal runs before expiry and Nginx reload follows successful renewal.

## Branching

Use `feature/*`, `fix/*`, `docs/*`, `test/*` or `chore/*` branches and PRs to `staging`; no direct `main` or `staging` pushes. Promote staging to main by a separately approved PR. Commit messages follow `type(scope): imperative summary`.
