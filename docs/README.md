# Balangkas-PCC documentation

This is a code-free preparation baseline. Read [preparation boundary](PREPARATION.md) before making changes.

| Document | Purpose |
| --- | --- |
| [Concept](conceptual/PROJECT_CONCEPT_v1.0.md) | Users, outcomes, product boundary |
| [Architecture](ARCHITECTURE.md) | Azure VPS topology and system boundaries |
| [Data dictionary](DATABASE.md) | Fresh canonical data design without executable schema |
| [API contracts](API_SPEC.md) | Endpoint and protocol contracts |
| [API integration](API_INTEGRATION.md) | Exact browser session, error, retry, asset, maintenance and WebSocket contract |
| [Backend structure](BACKEND_STRUCTURE.md) | Onsite backend ownership boundaries and empty-folder blueprint |
| [Configuration](CONFIGURATION.md) | Non-secret runtime configuration names, scope and fail-closed behavior |
| [Solana Devnet readiness](SOLANA.md) | Devnet-only wallet, entry-fee, escrow, Core certificate, signer and evidence contract |
| [Certificate issuance runbook](runbooks/SOLANA_CERTIFICATE_ISSUANCE.md) | Onsite Devnet-only Core NFT issuance, reconciliation and registry-void procedure |
| [PayMongo test-mode readiness](PAYMONGO.md) | Test-only Hosted Checkout, webhook/reconciliation and no-funds-transfer boundary |
| [Face-recognition model](FACE_RECOGNITION_MODEL.md) | Approved local W600K-R50 artifact identity, manual provisioning and verification boundary |
| [MLBB scoreboard extraction](MLBB_SCOREBOARD_EXTRACTION.md) | Local RF-DETR/PaddleOCR/template extraction inventory and reviewer-only finalization contract |
| [Feature specifications](features/README.md) | Required behavior by module |
| [Screen catalogue](screens/README.md) | Final frontend preservation record |
| [Cross-feature breadcrumb context](screens/BREADCRUMB_CONTEXT.md) | Safe dynamic portal breadcrumb and active-sidebar continuity |
| [CRUD screen readiness audit](screens/CRUD_READINESS_AUDIT.md) | Verified CRUD alignment and onsite reconstruction record |
| [Requirements](FRS_NFRS.md) | Functional/non-functional acceptance |
| [Security](SECURITY.md) | Identity, permission and privacy rules |
| [Storage and jobs](STORAGE_JOBS.md) | Object, worker and real-time behavior |
| [Docker](DOCKER.md) | Local infrastructure and inactive application profiles |
| [DevOps](DEVOPS.md) | Single-VPS rollout, backup and rollback |
| [CI/CD readiness](CI_CD.md) | GitHub Environment, secret/variable, image and manual staging-deploy contract |
| [Testing](TESTING.md) | Preparation and onsite validation |
| [Design](DESIGN.md) | Public/portal visual and interaction preservation |
| [Decision log](DECISIONS.md) | Accepted PCC choices and design safeguards |
| [Traceability](TRACEABILITY.md) | Requirement to screen/data/acceptance/work-package map |
| [Readiness](FOUNDATION_STATUS.md) | What is prepared versus unimplemented |
| [Asset manifest](ASSET_MANIFEST.md) | Approved transfer provenance |

The route, field, API, screen, layout, asset, component and acceptance documentation is self-contained. If an unrecorded nuance needs external material, the operator supplies it directly to the working agent for that task.
