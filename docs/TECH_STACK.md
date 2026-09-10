# Technology and dependency baseline

## Target stack

| Area | Selected technology | Preparation state |
| --- | --- | --- |
| Connected web client | Next.js 14.2.35, React 18, TypeScript, Tailwind/Radix/Motion | Dependency manifest and lock only |
| API | FastAPI, Pydantic, SQLAlchemy async, Uvicorn | Hash-pinned dependency lock only |
| Relational/vector data | PostgreSQL 16 with pgvector | Container image, no application schema |
| Transient delivery | Redis 7.4 | Container image, no application behavior |
| Object storage | MinIO | Container image, no bucket/bootstrap configuration |
| Authentication | Argon2id, signed session cookie, OTP provider adapter | Contract/dependencies only |
| OCR | RF-DETR, PaddleOCR, template matching, optional provider fallback | Separate input/lock; no weights or implementation |
| Chain | Solana Devnet, Anchor, Metaplex Core | Node dependency manifest/lock; no program source or signer |
| Payments | PayMongo adapters/webhook | Contract only |
| Reverse proxy | Nginx 1.28 | Inactive same-origin application config |
| Deployment | Docker Compose on one Azure VPS | Runbook/config only |

## Dependency management

`frontend/package.json` and `blockchain/package.json` have committed pnpm lockfiles. The frontend pins Next.js 14.2.35 because the official security update identifies it as the 14.x patched release. [Next.js security update](https://nextjs.org/blog/security-update-2025-12-11)

`backend/requirements.in` and `backend/requirements-ocr.in` are human-maintained constraints. `requirements.lock` and `requirements-ocr.lock` are hash-pinned resolution outputs for Linux container builds. Regenerate with the documented `uv pip compile` command after an intentional dependency change, review the diff, then build the affected dependency-only image. Hash locks do not include model weights.

Dependency images use Node 22 and Python 3.11 Linux bases. Onsite application implementation may require a compatibility adjustment only after it is documented, lockfiles are regenerated and the dependency image validates. Do not introduce Vercel hosting/runtime configuration; Next.js runs in the self-hosted frontend service.
