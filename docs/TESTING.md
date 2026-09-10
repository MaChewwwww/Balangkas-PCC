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
| Unit / Vitest | Domain transition, validation, data derivation and provider-adapter edge cases per feature acceptance scenarios; use fast Vitest component tests for changed UI behavior where valuable. |
| Migration/seed | Empty database upgrade, required extensions/indexes, idempotent seed and rendered migration SQL. |
| API integration | Session/role checks, idempotency, stale versions, privacy, transactions and pagination. |
| Browser/UI manual report | Developers manually check the applicable UI-AC behavior, route assembly, desktop columns/rail ownership, responsive reductions, field/API/permission states, metric semantics, loading/error/empty states, and keyboard/focus behavior. Use the [manual UI report](screens/MANUAL_UI_REPORT.md) to record route(s), states/actions, widths and result in the handoff/PR. Automated browser E2E and visual-regression suites are deliberately not required during this hackathon. |
| Worker | Intake byte/pixel/side/decode-time rejection and EXIF orientation normalization; RF-DETR checksum/label rejection; `UNSUPPORTED_LAYOUT` review outcome; no-download PaddleOCR startup; detector-to-row association; strict OCR parsing; candidate-only hero ranking; fuzzy/tied roster rejection; OCR unavailable/draft/review; atomic duplicate/stale acceptance; duplicate/out-of-order event and live update reconnect behavior. Manually record the three approved reference-image outcomes; do not hard-code their data. |
| Provider | Mock all provider calls in CI. For PayMongo, use only an authorized `sk_test_` account and document one test checkout success plus one cancellation/failure, invalid-signature, duplicate/out-of-order, wrong-amount/reference, live-mode rejection and allowlist rejection for every method outside `gcash,qrph,maya` at the adapter/API boundary. Use PayMongo's QR Ph simulation/test URL, never a real QR scan. For Solana, mock finalized Devnet RPC reads for wrong genesis, malformed/duplicate/errored/not-finalized signatures, wrong payer/destination/lamports/memo, unsupported transaction version, escrow state/recipient/amount mismatch, Core owner/URI/metadata-image hash/no-collection/update-authority/freeze-authority mismatch, duplicate certificate identity and ambiguous-send reconciliation. Onsite record one Devnet-only manual finalized-read proof for each enabled flow and the metadata/image public-read hashes. No live key, Mainnet money transfer, Wallet/disbursement/payout/refund check or browser E2E is permitted. Retain non-secret test evidence. |
| Deployment | Image digest, HTTPS, health, migration/worker order, backup restore and rollback rehearsal. |

The immediate scrimmage rule requires concurrent acceptance/result tests: one valid participating leader creates one match, same request is idempotent, and different later request gets a conflict. For biometrics, unit/API integration coverage must prove that the frontend Human capture module rejects zero/multiple faces, refuses an incomplete blink/liveness/anti-spoof gate and does not upload before a real capture report; the backend does not repeat detection/counting or pretend it can verify browser landmark output. Test submitted crop byte/type/pixel/animation rejection, model path/SHA-256 absence or mismatch, model load/inference failure, missing InsightFace entitlement, missing/mismatched reviewed Human asset or capture policy, report package/policy mismatch, server-computed crop-digest binding, expired/replayed/cross-scope challenge attempts, one-use authorization expiry, and concurrent duplicate enrollment. Each failure must make biometric work unavailable or return a generic capture/duplicate result without an enrollment/authorization write or privacy leak. Exercise the CPU ONNX session once with a controlled non-user test tensor and record the non-secret result; no raw face fixture is required. Test the staging demo-OTP boundary explicitly: `123456` is rejected unless its configured value is exact, the staging mode is exact, and the explicit enable flag is true; an accepted bypass creates `DEMO_BYPASS`, does not set `email_verified_at`, and loses access when the flag is disabled. A missing or altered OTP-code configuration must leave the bypass unavailable.

No executable test suite is added during preparation. Onsite, add focused unit, API/integration and Vitest checks in proportion to changed behavior. Do not spend hackathon time creating automatic browser E2E or visual-regression suites; satisfy browser/UI coverage through the documented manual developer report, then update [readiness](FOUNDATION_STATUS.md) with actual commands/results.
