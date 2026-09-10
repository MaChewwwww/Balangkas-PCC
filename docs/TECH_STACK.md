# Technology and dependency baseline

## Target stack

| Area | Selected technology | Preparation state |
| --- | --- | --- |
| Connected web client | Next.js 15.5.24, React 18, TypeScript, Tailwind, selective shadcn/Base UI and Motion | Dependency manifest and lock only |
| API | FastAPI, Pydantic, SQLAlchemy async, Uvicorn | Hash-pinned dependency lock only |
| Relational/vector data | PostgreSQL 16 with pgvector | Container image, no application schema |
| Transient delivery | Redis 7.4 | Container image, no application behavior |
| Object storage | MinIO | Container image, no bucket/bootstrap configuration |
| Authentication | Argon2id, signed session cookie, OTP provider adapter | Contract/dependencies only |
| MLBB extraction | RF-DETR, recognition-only PaddleOCR, local hero-template ranking | Separate CPU input/lock; approved RF-DETR host artifact only; no implementation, runtime download or provider fallback |
| Chain | Solana Devnet, Anchor, Metaplex Core | Node dependency manifest/lock; Devnet/genesis/finalized-evidence contract only; no program source, signer, collection or Token Metadata path |
| Payments | PayMongo test-mode Hosted Checkout v2 adapter/webhook | Contract only; `sk_test_` entry-fee simulation only, no Wallet/disbursement/payout/refund |
| Reverse proxy | Nginx 1.28 | Inactive same-origin application config |
| Deployment | Docker Compose on one Azure VPS | Runbook/config only |

## Dependency management

`frontend/package.json` and `blockchain/package.json` have committed pnpm lockfiles. The frontend uses exact version pins, including `@vladmandic/human` 3.3.6 for the browser-only biometric capture pipeline (detection, one-face gate, landmark alignment, blink gestures and optional liveness/anti-spoof results), the selective Base UI/shadcn toolchain, form/animation/three-dimensional dependencies preserved by the visual contract, and Vitest/testing-library fast-feedback dependencies. The package pin alone does not approve or provision a Human model/browser asset: each asset must have a recorded source, identity, permitted-use review and locally served version match before it is obtained or enabled onsite. It deliberately carries no direct Playwright/Cypress dependency. The frontend pins Next.js 15.5.24, the maintenance-LTS release containing the August 2026 critical-security fixes; React 18.3.1 remains within its supported peer range. A pnpm override also holds every PostCSS resolution at the audited 8.5.28 release, including Next.js's transitive copy. [Next.js August 2026 security release](https://nextjs.org/blog)

The blockchain lock carries exact-version Anchor, Solana Web3, Umi, Metaplex Core and the Devnet metadata uploader only. It deliberately excludes `mpl-token-metadata`, legacy Token Metadata minting, externally supplied scripts/IDL/build output and all key material: official certificates are individually immutable, soulbound Metaplex Core NFT assets, not presentation copies or collection-membership claims. Package preparation does not build a program or create a signer.

The shadcn CLI is pinned for reproducibility but its initialization, generated `components.json`, and generated primitive files are onsite work after explicit authorization. Do not reintroduce the former full set of individual Radix packages; use the selective primitive list in [the component catalogue](screens/COMPONENT_CATALOG.md).

`backend/requirements.in` and `backend/requirements-ocr.in` are human-maintained constraints. `requirements.lock` and `requirements-ocr.lock` are hash-pinned resolution outputs for Linux container builds. The base backend lock includes CPU ONNX Runtime for the approved W600K-R50 embedding artifact; it does not install a detector, liveness service or any model weight. Regenerate with the documented `uv pip compile` command after an intentional dependency change, review the diff, then build the affected dependency-only image. The MLBB extraction lock is resolved for Python 3.11/Linux with uv's CPU Torch backend and pins RF-DETR 1.10.1 plus PaddleOCR 3.7.0; its dependency image uses PyPI plus PyTorch's trusted CPU index, with hashes for every selected wheel, and must never pull CUDA packages. Hash locks do not include model weights or PaddleOCR recognition assets. The only approved extraction checkpoint is the manually provisioned RF-DETR artifact recorded in [MLBB extraction](MLBB_SCOREBOARD_EXTRACTION.md).

Dependency images use Node 22 and Python 3.11 Linux bases. Onsite application implementation may require a compatibility adjustment only after it is documented, lockfiles are regenerated and the dependency image validates. Do not introduce Vercel hosting/runtime configuration; Next.js runs in the self-hosted frontend service.
