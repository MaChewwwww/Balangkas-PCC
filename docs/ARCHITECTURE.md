# PCC system architecture

## Preparation topology

Only PostgreSQL 16 with pgvector, Redis 7 and MinIO run by default. Development toolchain images install dependencies and then exit. No tables, extensions, buckets, application services or jobs are provisioned automatically beyond the base service images' own initialization.

## Onsite target topology

| Tier | Responsibility | Boundary |
| --- | --- | --- |
| Nginx + certificate renewal | HTTPS termination, request limits, same-origin routing | Public ports 80/443; SSH separately restricted to operators |
| Next.js | Public discovery, authentication screens and portal | Internal port 3000; production standalone Node runtime |
| FastAPI | Session authentication, authorization, contracts, durable commands and bounded-crop biometric embedding/liveness verification | Internal port 8000; /api/v1 and /api/health; it does not detect/count faces; W600K-R50 is a manually provisioned read-only mount, never an image layer |
| Processing worker | Local MLBB draft extraction (RF-DETR layout detection, detector-crop PaddleOCR and template ranking), durable integration/outbox jobs | No published port; one OCR job initially; no external screenshot/provider fallback |
| PostgreSQL/pgvector | Canonical business state, vectors, audit/outbox | No published staging port; fresh onsite migration enables extensions |
| Redis | OTP throttles, short-lived challenges and pub/sub | Not the durable queue or match authority |
| MinIO | Evidence and uploaded media | Private service; authenticated object access through API |

All self-hosted services share one Azure VPS and isolated Compose network. External Brevo, Challonge, PayMongo test-mode Hosted Checkout/webhook and Solana Devnet calls leave through backend/worker adapters. PayMongo has no live, Wallet, recipient, payout, transfer or refund capability this event. Browsers access same-origin application/API and may sign only their own server-snapshotted Solana Devnet messages, entry transfers, or creator escrow funding transactions; private keys never reach PCC. The worker's isolated Devnet operator signer may issue frozen Core certificate assets and release a finalized escrow, while the API never mounts it. Every chain transition requires a finalized Devnet/genesis-matched read, not a browser callback. See [Solana readiness](SOLANA.md).

## Request and processing flow

1. Nginx routes /api/ and /ws/ to FastAPI; other application paths go to Next.js.
2. FastAPI validates the session and resource permission before reading or changing state.
3. A domain transaction writes canonical records, audit evidence and durable outbox events together.
4. The worker claims pending jobs using a lease and row locking, invokes bounded external work, and records outcomes. Redis broadcasts committed events; disconnected clients refetch durable state.
5. OCR emits a draft review queue. Only authorized review acceptance persists official game statistics and schedules bracket advancement.
6. A valid scrimmage result is committed immediately by the first authorized participating leader; subsequent identical submission returns the existing record.

## Module boundaries

Identity owns users, profile, student status, browser liveness/biometric enrollment and wallet linking. Its version-pinned `@vladmandic/human` frontend pipeline detects/rejects face counts, aligns the submitted crop, and performs the blink/liveness/anti-spoof capture gate. The backend validates the exact local embedding-model record, bounded crop and the single-use challenge's session/action/crop binding before embedding, but never repeats browser face detection or counting. It returns unavailable without mutation when a required artifact, approval or Human capture asset is absent or mismatched, and returns a generic capture rejection when the client capture report cannot satisfy the selected policy. Team/community modules own access and affiliation history. Tournament module owns eligibility, registrations, staffing, seeding, bracket configuration and lifecycle. Match module owns series/games/evidence/reviews and calculated analytics. Rewards own allocation and settlement; certificates own recipient/issuance records. Notifications consume committed domain events.

## Concurrency and failure

Use record versions for mutable configuration and row locks for capacity, tournament start, result finalization and allocation release. Duplicate requests use actor+operation+idempotency keys with request digests. No database transaction stays open while waiting for a provider. Provider submission and confirmation are separate states. Ambiguous network failures reconcile the original request before retrying. One server is a failure domain; backups and restore are required, high availability is not claimed.

See [API](API_SPEC.md), [browser/API integration](API_INTEGRATION.md), [backend ownership structure](BACKEND_STRUCTURE.md), [configuration](CONFIGURATION.md), [data](DATABASE.md), [security](SECURITY.md), [operations](DEVOPS.md), and [storage/jobs](STORAGE_JOBS.md).
