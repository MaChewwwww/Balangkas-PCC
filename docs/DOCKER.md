# Docker and local infrastructure

## Preparation stack

The default Compose file runs only PostgreSQL with pgvector, Redis and MinIO. Its infrastructure images are tag-readable but digest-pinned. It contains no application, migrations, bucket bootstrap, worker or seed commands. PCC-specific port defaults avoid common local-service conflicts: PostgreSQL 55432, Redis 56379, MinIO 59000 and console 59001. All are bound to loopback.

Copy `.env.example` to ignored `.env`, replace the two local random passwords, then run:

```powershell
docker compose config
docker compose up -d --wait
docker compose ps
```

Use `docker compose down` to stop services while retaining volumes. `docker compose down -v` removes the local database, Redis and MinIO volumes; it is destructive and requires explicit confirmation. No shell command in this document initializes PCC application state.

MinIO and database administration ports are intentionally loopback-only. On a remote host, use an SSH tunnel for a deliberate administrative session; never expose these consoles through Nginx.

## Dependency toolchain

`compose.tools.yaml` builds dependency-only images. `frontend-deps` and `blockchain-deps` install lockfile dependencies from digest-pinned Node bases; `backend-deps` and `ocr-deps` install hash-pinned Python dependencies from digest-pinned Python bases. They neither copy application source nor start an application.

```powershell
docker compose -f compose.tools.yaml build frontend-deps blockchain-deps backend-deps
docker compose -f compose.tools.yaml --profile ocr-toolchain build ocr-deps
```

The MLBB extraction toolchain is optional because it is large and requires actual Linux/VPS validation before use. Its Torch wheels are CPU-only; CUDA packages are not part of the locked toolchain. It contains no trained weights or PaddleOCR recognition assets. See [MLBB extraction](MLBB_SCOREBOARD_EXTRACTION.md).

## Inactive onsite application profile

`infra/deployment/compose.application.yaml` adds Nginx, frontend, backend and worker only when explicitly combined with the default/staging Compose file and the `onsite` profile. Its default image names deliberately do not exist, which prevents deployment of unfinished code.

Onsite, after the `staging` release record and `.env.application` preparation, compose application services with the base infrastructure file. `FRONTEND_IMAGE`, `BACKEND_IMAGE` and `WORKER_IMAGE` must each be an already-pulled `repository@sha256:<digest>` reference recorded for that release; commit-SHA tags are not sufficient. For a private `ghcr.io` image, staging maintenance authenticates Docker first with the ignored deployment-only `GITHUB_USERNAME`/`GITHUB_PAT` pair; neither value enters Compose or an application container. The backend and worker need their documented read-only model/secret mounts. The worker is capped to one OCR concurrency, two CPUs and 4 GiB until actual profiling changes those limits. Its ignored `./secrets/solana-operator.json` host file is the only permitted Solana signer location and appears solely as `/run/secrets/solana-operator.json` in the worker; backend and frontend never mount it.

The ignored `models` host directory is mounted read-only into the backend and worker. The backend's biometric adapter may use only the manually provisioned W600K-R50 embedding artifact at `/models/face-recognition/w600k_r50.onnx`; it is not part of a Docker image and does not perform face detection/counting. Before an authorized release, manually provision and SHA-256-verify it according to [the face-model record](FACE_RECOGNITION_MODEL.md). The frontend owns browser detection, count rejection, alignment, blink and liveness/anti-spoof checks through the exact `@vladmandic/human` package pin. Its Human browser assets must be reviewed, locally served and version-matched to that pin; after review they may enter only the recorded frontend image/asset path, never a runtime CDN/model download. The worker's only approved extraction checkpoint is `/models/scoreboard/roboflow_weights.pt`; separately provisioned PaddleOCR recognition assets live under its configured read-only path. Verify all items according to [MLBB extraction](MLBB_SCOREBOARD_EXTRACTION.md), fail closed/unavailable on any failure despite the template's preselected flags, and never add an external screenshot fallback.

The application must provide a server-enforced maintenance state before an onsite migration: it rejects new writes, returns the documented `503 MAINTENANCE`/`Retry-After` response, permits only the health/administrative checks needed for release, and waits for active requests and worker leases to drain. This state is an onsite implementation requirement, not a claim that the preparation Compose profile already supplies it. See [browser/API integration](API_INTEGRATION.md).

The separate TLS bootstrap configuration only serves ACME challenges and a 503 response. It does not expose a frontend or backend. Certificate issuance and renewal are operational steps defined in [DevOps](DEVOPS.md).
