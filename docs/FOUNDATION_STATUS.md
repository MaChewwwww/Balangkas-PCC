# PCC readiness status

Updated: 2026-09-10. This table reports this repository only; it does not inherit practice implementation status.

| Area | Status | Present | Deliberately absent |
| --- | --- | --- | --- |
| Product specs | Prepared | Requirements, data/API/feature/screen/acceptance traceability | Application source/models/migrations/tests |
| Frontend reference | Prepared | 41 route, 44 Store-action, 123 UI-test expectation inventory; assets/tokens | React/CSS/component source |
| Data design | Prepared | Fresh data dictionary and migration acceptance | SQL, ORM models, Alembic revisions, seeders |
| Local infrastructure | Prepared and locally health-checked | Isolated Compose Postgres/Redis/MinIO with volumes and health checks | Tables/extensions/buckets/application service |
| Dependency locks | Prepared | Frontend, blockchain and hash-pinned Python/OCR inputs | Application implementation or runtime models |
| Azure operations | Prepared specification | Protected `staging` default branch; single staging VPS target, digest-pinned release, write-quiescing, rollback/backup runbook | Server, domain, secrets, GitHub deployment workflow, remote deployment mutation |
| Biometrics/OCR | Contract only | Privacy/failure/review specifications and reference catalog | Models/weights, live inference, provider call |
| Solana/PayMongo | Contract only | Gates, evidence and failure semantics | PCC signer/program/account/transaction/provider capability |
| Scrimmage finalizer | Excluded by decision | Immediate atomic result contract | Timer, finalizer job, dual-confirmation policy |

## Preparation acceptance

- Every target file is documented by the preparation allowlist.
- 12 feature specifications, 41 frontend routes, 44 Store members and 123 named frontend expectations are traceable.
- No practice application source, models, migrations, code-based fixtures, secrets, deployed artifacts or model weights transfer.
- Default infrastructure has its own Compose name, volumes and loopback ports.
- Default Compose cannot start unfinished application services; inactive images are intentionally unavailable.
- No Vercel configuration or deployment dependency remains.

## Onsite completion gate

Each row becomes implemented only with the specified models/migration/API/UI/tests and actual evidence. Update this file after every work package. A configured key, local mock, static asset or contract table is never sufficient evidence of live integration.
