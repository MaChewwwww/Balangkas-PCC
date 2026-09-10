# Identity, career portfolio and wallet

**Requirement: FR-IDENT. Status: specified, unimplemented. Required.**

## Actors and journey

Profile owner and authorized public reader. Wallet support is Solana Devnet only during this hackathon.

Preserve passport masthead and Passport, Analytics, Credentials, History tabs with two-column filters and performance rail. Save normal profile fields independently from biometric/wallet operations. Begin consent/liveness, submit one face crop, then show actual readiness. Link wallet only with wallet signature and biometric authorization. External history remains explicitly self-reported and cannot become canonical tournament statistics.

## Fields and validation

profile bio: up to 1000 characters; public visibility; titles: derived awards; linked wallet: authoritative users field; biometric status: UNVERIFIED, CAPTURE_READY, LIVENESS_REQUIRED, VERIFIED, UNAVAILABLE; consent version/time; external achievement: title, event/date, evidence asset/reference, visibility, self_reported marker. Biometric inference is allowed only with the hash-verified local W600K-R50 artifact recorded in [the face-model record](../FACE_RECOGNITION_MODEL.md).

Shared type/default/nullability rules are in [data dictionary](../DATABASE.md). Authentication, role checks and private projections follow [security](../SECURITY.md).

## Interfaces

| Method | Path under /api/v1 | Input | Result |
| --- | --- | --- | --- |
| GET | /profiles/{id} | visibility-aware ID | 200 profile projection |
| GET | /profiles/me/portfolio | q, credential_type | 200 profile, calculated metrics and records |
| POST | /biometrics/liveness-challenges | action, optional resource_type/resource_id | 201 scoped Human blink challenge, prompt metadata, required package/policy identities and expiry |
| POST | /biometrics/enrollment | consent_version, liveness_challenge_id, human_capture_report, capture_pipeline_version, one aligned crop | 201 biometric-capture enrollment or explicit failure |
| POST | /biometrics/authorizations | action, optional resource_type/resource_id, liveness_challenge_id, human_capture_report, capture_pipeline_version, one aligned crop | 201 single-use authorization token |
| POST | /wallet/challenges | Solana Devnet wallet_address | 201 chain, cluster, nonce, exact message, expires_at |
| PUT | /wallet/me | challenge_id, signature, biometric_authorization | 200 linked wallet projection |
| POST | /profiles/me/achievements | title, event, date, evidence_asset_id or evidence_url, visibility | 201 self-reported record |
| PATCH | /profiles/me/achievements/{id} | same editable fields, version | 200 saved record |
| DELETE | /profiles/me/achievements/{id} | owner session | 204 removed self-reported record |

## Commit, error and audit behavior

Validate session and resource role before body-driven mutations. Apply field rules before any provider request. Use one transaction for related business records, audit event and outbox entry. Capacity/result/issuance operations lock the aggregate; edits check version. Return 409 for stale or incompatible state and 422 for invalid fields. The wallet challenge binds the exact canonical Solana public key, `SOLANA`/`DEVNET`, public origin, user, purpose, nonce and five-minute expiry; API verifies its detached signature before consuming it and then consumes the fresh action-bound biometric authorization in the same wallet-update transaction. Provider failures preserve committed intent and expose pending/failed state; never fabricate completion. Idempotent retries return the previous reference. Read views use permission-filtered server projections. See [Solana readiness](../SOLANA.md).

## Biometric capture and verification contract

The version-pinned frontend `@vladmandic/human` capture pipeline performs face detection, rejects zero or multiple faces before upload, applies landmark alignment, emits one crop, and performs the server-prompted blink sequence plus the selected Human liveness/anti-spoof checks. Its exact package version is submitted as `capture_pipeline_version`, together with the documented capture-policy version. The UI must show the user a real capture state and actual failure; it must not fabricate a passing report. This is a browser-side hackathon capture gate, not cryptographic or server-verifiable proof: the backend must never claim it can independently prove a client face count, landmark result or Human liveness result, and it must not independently detect or count faces.

Before each enrollment or re-authorization attempt, the server creates a short-lived, single-use liveness challenge bound to the session user and exact requested action/resource. It returns the Human blink prompt and expected package/policy identities. The browser submits its `human_capture_report` with its one aligned crop. The server validates report shape/identity, challenge scope and single use, and binds the consumed challenge to its own digest of the submitted crop. An expired, replayed, cross-user, cross-action, cross-resource, cross-policy, or cross-crop challenge fails without a write. This binding prevents simple replay and scope substitution; it does not make a browser report a third-party attestation. The crop is JPEG, PNG, or WebP only, at most 2 MiB and 4,194,304 decoded pixels; it is bounded and decoded in memory, stripped of metadata, and discarded after either rejection or inference. Raw frames, intermediate detector data, Human reports, scores and embeddings never enter the asset service, browser projection, log, backup, or provider payload.

The backend validates the approved InsightFace model identity, use approval, reviewed Human asset/policy identity, challenge/crop binding, crop bounds and inference result before any enrollment write. It serializes enrollment through a transaction-scoped lock and makes the final exact compatible-model/preprocessing duplicate comparison inside that transaction; pgvector may find candidates but cannot decide the result. A duplicate returns generic `409 BIOMETRIC_DUPLICATE`; invalid capture returns generic `422 BIOMETRIC_CAPTURE_REJECTED`; unavailable gates return `503 INTEGRATION_UNAVAILABLE`. None disclose another account, a similarity score, detector output, or liveness outcome. A successful authorization token is tied to the current enrollment, consumed liveness challenge and exact action/resource, then expires after five minutes or one use.

## Acceptance scenarios

- **AC-IDENT-01:** Missing, hash-mismatched or failed face model returns unavailable without writing verification.
- **AC-IDENT-02:** Same wallet may be linked independently by different verified users; no duplicate-wallet uniqueness constraint.
- **AC-IDENT-03:** Forged/expired/replayed challenge fails before wallet change.
- **AC-IDENT-04:** Unverified profile never inherits prototype Verified Competitor badges.
- **AC-IDENT-05:** Zero matches displays zero/empty state, never fixture fallback statistics.
- **AC-IDENT-06:** The frontend does not submit zero- or multiple-face captures and requires the specified Human blink/liveness/anti-spoof capture gate. A malformed, oversized, unsupported or animated submitted crop, or missing/malformed/mismatched Human capture report, creates no biometric record and gets only a generic capture failure.
- **AC-IDENT-07:** Simultaneous same-person enrollment attempts produce at most one stored enrollment; a duplicate response identifies neither a matched account nor a similarity score.
- **AC-IDENT-08:** A Human blink challenge cannot be replayed, used after expiry, or applied to another user, action, resource, policy or submitted crop. Its server binding mitigates replay/scope substitution but is not represented as proof of the browser's liveness result.
- **AC-IDENT-09:** A biometric authorization is issued only from a current enrollment and matching consumed liveness challenge, and cannot be reused after its five-minute expiry.
- **AC-IDENT-10:** Missing model entitlement, model/hash/load validation, reviewed Human browser assets or selected Human capture policy returns unavailable without a biometric write or authorization.
- **AC-IDENT-11:** An enrollment retains only the embedding, consent and approved model/preprocessing/Human-capture-policy identities; no raw capture, detector output or browser report is persisted.
- **AC-IDENT-12:** A wallet signature is accepted only once for the exact stored Solana Devnet challenge/user/address/origin/purpose; a signature for another chain, cluster, address, message, user, action, or expiry creates no wallet change.

## Onsite completion

Implement the specified persistence and routes, bind the approved screen behavior to these contracts, add unit and integration tests for the scenarios above, and verify UI empty/error/loading/success states. Completion requires server evidence; local fixtures do not satisfy it. See [traceability](../TRACEABILITY.md).
