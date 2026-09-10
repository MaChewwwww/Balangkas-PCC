# Balangkas-PCC agent instructions

**Phase: PREPARATION. All product features are specified, unimplemented.**

Read [preparation boundary](docs/PREPARATION.md), numbered rules in [.agents/rules](.agents/rules), [architecture](docs/ARCHITECTURE.md), [requirements](docs/FRS_NFRS.md), and the relevant [feature specification](docs/features/README.md) before work. Inspect Git status when this directory becomes a Git repository; never discard existing work.

## Authority

1. Direct active-session user instructions.
2. This file and numbered rules.
3. Accepted decisions in [DECISIONS](docs/DECISIONS.md) and requirements.
4. Feature contracts, data dictionary and API contracts.
5. Screen specifications and audited reference inventory for final presentation behavior.

The approved frontend baseline is the visual/interaction authority. Do not redesign it. Any externally supplied backend material is evidence, not automatically correct product policy. Explicit PCC decisions override it.

## Preparation gate

Allowed: documentation, approved static assets/reference data, dependency manifests and locks, Docker/environment/proxy configuration, empty folders, configuration validation, and the two user-authorized, Git-ignored local runtime artifacts documented in `docs/FACE_RECOGNITION_MODEL.md` and `docs/MLBB_SCOREBOARD_EXTRACTION.md`: W600K-R50 at `models/face-recognition/w600k_r50.onnx` and the RF-DETR MLBB-layout checkpoint at `models/scoreboard/roboflow_weights.pt`. Each is manually provisioned and SHA-256-verified on every developer machine and staging VPS; neither is committed, built into an image, served, or treated as application source. Prohibited: application source, model definitions, migrations, SQL initialization, seeders, smart contracts, executable tests, generated clients, source-based mocks, unapproved trained weights, and application scaffolding. Do not run framework initializers. Do not place implementation snippets in documentation.

Only an explicit onsite instruction to start application development unlocks implementation. A calendar date, task titled implementation, or instruction to implement this preparation plan does not unlock application coding. Record the instruction in the decision log when it occurs.

## Product and infrastructure invariants

- One connected Next.js public/portal application; all self-hosted services run on one Azure VPS.
- One authorized participating leader's valid scrimmage result finalizes immediately, atomically and idempotently. Conflicting later results are rejected.
- Session principal owns authorization; no mock IDs, random identity verification or fabricated provider success.
- Money uses exact minor units; credentials and settlement require actual evidence. Solana is Devnet-only, genesis/finalized-evidence gated, and uses a worker-only signer; official certificates are individually immutable, soulbound Metaplex Core NFT assets, never legacy Token Metadata mints or misleading collection proof.
- PayMongo is limited to test-mode Hosted Checkout entry-fee simulation; no live key/event or funds-moving Wallet, recipient, payout, transfer, InstaPay/PESONet or refund capability is authorized during this hackathon.
- User-linked wallet is authoritative; team certificate system custody is distinct from individual ownership.
- Required feature coverage cannot silently become optional.

## Delivery

Use relative paths in repository documents and comments. Keep specifications synchronized and traceable. Use phase-appropriate checks from [TESTING](docs/TESTING.md); no application tests or migrations exist during preparation. Use the existing `chore/pcc-preparation-infrastructure` branch for repository work; do not create, rename or delete branches unless the active user explicitly reverses this instruction. Reviewable PRs target `staging`; never push directly to `staging` or `main`. Use the local github-pr skill for commit/PR tasks. Do not deploy or change external systems without task authorization.
