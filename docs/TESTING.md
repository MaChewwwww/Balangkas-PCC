# Validation strategy

## Preparation checks

Run these now because they do not require application source:

```powershell
docker compose config
docker compose -f compose.staging.yaml config
docker compose -f compose.tools.yaml config
docker compose up -d --wait
docker compose -f compose.tools.yaml build frontend-deps blockchain-deps backend-deps
```

Validate Markdown links, YAML parseability, dependency lock consistency, asset manifest checksums, source-manifest completeness, absence of prohibited application artifacts, and required feature/route/action coverage. A healthy infrastructure service does not prove a future API, migration or provider works.

## Onsite test layers

| Layer | Required evidence |
| --- | --- |
| Unit | Domain transition, validation, data derivation and provider-adapter edge cases per feature acceptance scenarios. |
| Migration/seed | Empty database upgrade, required extensions/indexes, idempotent seed and rendered migration SQL. |
| API integration | Session/role checks, idempotency, stale versions, privacy, transactions and pagination. |
| Browser/UI | Every UI-AC from [frontend baseline](acceptance/FRONTEND_BASELINE.md), loading/error/empty state, desktop/mobile parity and keyboard interactions. |
| Worker | Retry/lease, OCR unavailable/draft/review, duplicate/out-of-order event and live update reconnect behavior. |
| Provider | Mock all provider calls in CI; run live Devnet/PayMongo checks only with authorized configured accounts and retain real evidence. |
| Deployment | Image digest, HTTPS, health, migration/worker order, backup restore and rollback rehearsal. |

The immediate scrimmage rule requires concurrent acceptance/result tests: one valid participating leader creates one match, same request is idempotent, and different later request gets a conflict. Test face model absence/inference failure explicitly; it must never verify an identity.

No executable test suite is added during preparation. Convert every AC and UI-AC row into named tests onsite, then update [readiness](FOUNDATION_STATUS.md) with actual commands/results.
