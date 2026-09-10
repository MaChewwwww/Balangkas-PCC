# Docker and local infrastructure

## Preparation stack

The default Compose file runs only PostgreSQL with pgvector, Redis and MinIO. It contains no application, migrations, bucket bootstrap, worker or seed commands. PCC-specific port defaults avoid the practice stack: PostgreSQL 55432, Redis 56379, MinIO 59000 and console 59001. All are bound to loopback.

Copy `.env.example` to ignored `.env`, replace the two local random passwords, then run:

```powershell
docker compose config
docker compose up -d --wait
docker compose ps
```

Use `docker compose down` to stop services while retaining volumes. `docker compose down -v` removes the local database, Redis and MinIO volumes; it is destructive and requires explicit confirmation. No shell command in this document initializes PCC application state.

MinIO and database administration ports are intentionally loopback-only. On a remote host, use an SSH tunnel for a deliberate administrative session; never expose these consoles through Nginx.

## Dependency toolchain

`compose.tools.yaml` builds dependency-only images. `frontend-deps` and `blockchain-deps` install lockfile dependencies; `backend-deps` and `ocr-deps` install hash-pinned Python dependencies. They neither copy application source nor start an application.

```powershell
docker compose -f compose.tools.yaml build frontend-deps blockchain-deps backend-deps
docker compose -f compose.tools.yaml --profile ocr-toolchain build ocr-deps
```

The OCR toolchain is optional because it is large and requires actual Linux/VPS validation before use. Model weights are excluded. See [MLBB extraction](MLBB_SCOREBOARD_EXTRACTION.md).

## Inactive onsite application profile

`infra/deployment/compose.application.yaml` adds Nginx, frontend, backend and worker only when explicitly combined with the default/staging Compose file and the `onsite` profile. Its default image names deliberately do not exist, which prevents deployment of unfinished code.

Onsite, after the `staging` release record and `.env.application` preparation, compose application services with the base infrastructure file. `FRONTEND_IMAGE`, `BACKEND_IMAGE` and `WORKER_IMAGE` must each be an already-pulled `repository@sha256:<digest>` reference recorded for that release; commit-SHA tags are not sufficient. `worker` needs provisioned model and secret mounts. The worker is capped to one OCR concurrency, two CPUs and 4 GiB until actual profiling changes those limits.

The application must provide a server-enforced maintenance state before an onsite migration: it rejects new writes, permits only the health/administrative checks needed for release, and waits for active requests and worker leases to drain. This state is an onsite implementation requirement, not a claim that the preparation Compose profile already supplies it.

The separate TLS bootstrap configuration only serves ACME challenges and a 503 response. It does not expose a frontend or backend. Certificate issuance and renewal are operational steps defined in [DevOps](DEVOPS.md).
