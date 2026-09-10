# PCC readiness status

Updated: 2026-09-11. This table reports this repository only; it does not inherit external implementation status.

| Area | Status | Present | Deliberately absent |
| --- | --- | --- | --- |
| Product specs | Prepared | Requirements, data/API/feature/screen/acceptance traceability and the bounded local face-model record | Application source, model definitions, migrations and tests |
| Frontend baseline | Prepared | 41 route compositions, 44 documented interaction actions and 123 UI expectation inventories; checksum-verified CRUD audit of all 41 routes and 10 CRUD workspaces; layout/CRUD/visualization/component blueprint including the procedural HeroShield scene, server-safe dynamic cross-feature breadcrumb context and frontend ownership structure; selective version-pinned shadcn/ui Base UI policy; 51 verified visual assets including local UI fonts, 136 pinned reference-data files and manual-UI-report fast-feedback policy | React/CSS/component source or installed shadcn/ui primitives; automated browser E2E/visual-regression suite |
| Data design | Prepared | Fresh data dictionary and migration acceptance | SQL, ORM models, Alembic revisions, seeders |
| Backend blueprint | Prepared | Domain/transport/integration/worker ownership, exact browser/API protocol, staging configuration contract and empty target directories | FastAPI source, routers, schemas, domain services, migrations, tests or generated clients |
| Local infrastructure | Prepared and locally health-checked | Isolated Compose Postgres/Redis/MinIO with volumes and health checks | Tables/extensions/buckets/application service |
| Dependency locks | Prepared | Frontend, blockchain and hash-pinned Python/OCR inputs, digest-pinned Node/Python dependency-image bases, including `@vladmandic/human` 3.3.6, CPU ONNX Runtime, RF-DETR 1.10.1 and PaddleOCR 3.7.0 | Application implementation; reviewed Human browser assets/capture policy, PaddleOCR recognition assets and all runtime models except the separately ignored W600K-R50 and RF-DETR artifacts |
| Azure operations | Prepared specification | Protected `staging` default branch; single staging VPS target, digest-pinned release, write-quiescing, rollback/backup runbook, and GitHub Environment/credential/manual-deploy contract | Server, domain, Environment secrets/variables, GitHub deployment workflow, remote deployment mutation |
| Biometrics/MLBB extraction | Local artifacts and contracts prepared; implementation deferred | Privacy/failure/review specifications, fixed MLBB screenshot intake and unsupported-layout review outcome, exact `@vladmandic/human` capture-package pin and browser-blink capture boundary, 133-hero checksum-pinned catalog, ignored W600K-R50 and RF-DETR artifacts at verified local paths, and manually audited evidence-layout references | Biometric/OCR source, live inference, reviewed Human browser assets and calibrated capture policy, RF-DETR checkpoint provenance/use approval, PaddleOCR recognition assets, expanded labelled calibration corpus, provider call or any unapproved model weight |
| Solana/PayMongo | Contract only | Devnet/genesis/finalized-evidence gates; browser-versus-worker signer boundary; fresh two-recipient escrow design; exact-version, individually immutable soulbound Metaplex Core NFT certificates with server-owned public metadata, reconciliation and registry voiding; PayMongo test-only Hosted Checkout v2, raw-signature/reconciliation and no-funds-transfer boundary | PCC signer/program/account/transaction/provider capability; any old Solana deployment/collection/key; PayMongo account, `sk_test_` keys, test webhook, adapter, payout/Wallet/disbursement/recipient/refund capability and every live-money path |
| Scrimmage finalizer | Excluded by decision | Immediate atomic result contract | Timer, finalizer job, dual-confirmation policy |

## Preparation acceptance

- Every target file is documented by the preparation allowlist.
- 12 feature specifications, 41 frontend routes, 44 documented interaction actions and 123 named frontend expectations are traceable; the checksum-verified [CRUD audit](screens/CRUD_READINESS_AUDIT.md) records every route and CRUD workspace. The onsite UI blueprint covers route composition, server-safe cross-feature breadcrumb continuity, field/API binding, visualization semantics, a selective shadcn/ui base layer, component boundaries, local fonts, manual UI-report evidence and asset use without an external repository dependency.
- No external application source, model definitions, migrations, code-based fixtures, secrets or deployed artifacts transfer. The only model-weight exceptions are the ignored, manually verified W600K-R50 artifact documented in [FACE_RECOGNITION_MODEL.md](FACE_RECOGNITION_MODEL.md) and RF-DETR artifact documented in [MLBB_SCOREBOARD_EXTRACTION.md](MLBB_SCOREBOARD_EXTRACTION.md).
- Default infrastructure has its own Compose name, volumes and loopback ports.
- Default Compose cannot start unfinished application services; inactive images are intentionally unavailable.
- No Vercel configuration or deployment dependency remains.

## Onsite completion gate

Each row becomes implemented only with the specified models/migration/API/UI/tests and actual evidence. Update this file after every work package. A configured key, local mock, static asset or contract table is never sufficient evidence of live integration.
