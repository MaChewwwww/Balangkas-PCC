# PCC system architecture

## Preparation topology

Only PostgreSQL 16 with pgvector, Redis 7 and MinIO run by default. Development toolchain images install dependencies and then exit. No tables, extensions, buckets, application services or jobs are provisioned automatically beyond the base service images' own initialization.

## Onsite target topology

| Tier | Responsibility | Boundary |
| --- | --- | --- |
| Nginx + certificate renewal | HTTPS termination, request limits, same-origin routing | Public ports 80/443; SSH separately restricted to operators |
| Next.js | Public discovery, authentication screens and portal | Internal port 3000; production standalone Node runtime |
| FastAPI | Session authentication, authorization, contracts, durable commands | Internal port 8000; /api/v1 and /api/health |
| Processing worker | OCR extraction and durable integration/outbox jobs | No published port; OCR concurrency 1 initially |
| PostgreSQL/pgvector | Canonical business state, vectors, audit/outbox | No published staging port; fresh onsite migration enables extensions |
| Redis | OTP throttles, short-lived challenges and pub/sub | Not the durable queue or match authority |
| MinIO | Evidence and uploaded media | Private service; authenticated object access through API |

All self-hosted services share one Azure VPS and isolated Compose network. External Brevo, Challonge, PayMongo and Solana Devnet calls leave through backend/worker adapters. Browsers access same-origin application/API and may sign Solana messages or transactions with the user's wallet; private keys never reach the backend.

## Request and processing flow

1. Nginx routes /api/ and /ws/ to FastAPI; other application paths go to Next.js.
2. FastAPI validates the session and resource permission before reading or changing state.
3. A domain transaction writes canonical records, audit evidence and durable outbox events together.
4. The worker claims pending jobs using a lease and row locking, invokes bounded external work, and records outcomes. Redis broadcasts committed events; disconnected clients refetch durable state.
5. OCR emits a draft review queue. Only authorized review acceptance persists official game statistics and schedules bracket advancement.
6. A valid scrimmage result is committed immediately by the first authorized participating leader; subsequent identical submission returns the existing record.

## Module boundaries

Identity owns users, profile, student status, liveness/biometric enrollment and wallet linking. Team/community modules own access and affiliation history. Tournament module owns eligibility, registrations, staffing, seeding, bracket configuration and lifecycle. Match module owns series/games/evidence/reviews and calculated analytics. Rewards own allocation and settlement; certificates own recipient/issuance records. Notifications consume committed domain events.

## Concurrency and failure

Use record versions for mutable configuration and row locks for capacity, tournament start, result finalization and allocation release. Duplicate requests use actor+operation+idempotency keys with request digests. No database transaction stays open while waiting for a provider. Provider submission and confirmation are separate states. Ambiguous network failures reconcile the original request before retrying. One server is a failure domain; backups and restore are required, high availability is not claimed.

See [API](API_SPEC.md), [data](DATABASE.md), [security](SECURITY.md), [operations](DEVOPS.md), and [storage/jobs](STORAGE_JOBS.md).
