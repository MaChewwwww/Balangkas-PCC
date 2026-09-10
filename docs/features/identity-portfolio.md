# Identity, career portfolio and wallet

**Requirement: FR-IDENT. Status: specified, unimplemented. Required.**

## Actors and journey

Profile owner and authorized public reader.

Preserve passport masthead and Passport, Analytics, Credentials, History tabs with two-column filters and performance rail. Save normal profile fields independently from biometric/wallet operations. Begin consent/liveness, submit one face crop, then show actual readiness. Link wallet only with wallet signature and biometric authorization. External history remains explicitly self-reported and cannot become canonical tournament statistics.

## Fields and validation

profile bio: up to 1000 characters; public visibility; titles: derived awards; linked wallet: authoritative users field; biometric status: UNVERIFIED, VERIFIED, UNAVAILABLE; consent version/time; external achievement: title, event/date, evidence asset/reference, visibility, self_reported marker.

Shared type/default/nullability rules are in [data dictionary](../DATABASE.md). Authentication, role checks and private projections follow [security](../SECURITY.md).

## Interfaces

| Method | Path under /api/v1 | Input | Result |
| --- | --- | --- | --- |
| GET | /profiles/{id} | visibility-aware ID | 200 profile projection |
| GET | /profiles/me/portfolio | q, credential_type | 200 profile, calculated metrics and records |
| POST | /biometrics/enrollment | consent_version, cropped file, liveness evidence | 201 verified enrollment or explicit failure |
| POST | /biometrics/authorizations | action, resource_id, cropped file, liveness evidence | 201 single-use authorization token |
| POST | /wallet/challenges | wallet_address | 201 nonce, message, expires_at |
| PUT | /wallet/me | challenge_id, signature, biometric_authorization | 200 linked wallet projection |
| POST | /profiles/me/achievements | title, event, date, evidence_asset_id or evidence_url, visibility | 201 self-reported record |
| PATCH | /profiles/me/achievements/{id} | same editable fields, version | 200 saved record |
| DELETE | /profiles/me/achievements/{id} | owner session | 204 removed self-reported record |

## Commit, error and audit behavior

Validate session and resource role before body-driven mutations. Apply field rules before any provider request. Use one transaction for related business records, audit event and outbox entry. Capacity/result/issuance operations lock the aggregate; edits check version. Return 409 for stale or incompatible state and 422 for invalid fields. Provider failures preserve committed intent and expose pending/failed state; never fabricate completion. Idempotent retries return the previous reference. Read views use permission-filtered server projections.

## Acceptance scenarios

- **AC-IDENT-01:** Missing face model returns unavailable without writing verification.
- **AC-IDENT-02:** Same wallet may be linked independently by different verified users; no duplicate-wallet uniqueness constraint.
- **AC-IDENT-03:** Forged/expired/replayed challenge fails before wallet change.
- **AC-IDENT-04:** Unverified profile never inherits prototype Verified Competitor badges.
- **AC-IDENT-05:** Zero matches displays zero/empty state, never fixture fallback statistics.

## Onsite completion

Implement the specified persistence and routes, bind the approved screen behavior to these contracts, add unit and integration tests for the scenarios above, and verify UI empty/error/loading/success states. Completion requires server evidence; local fixtures do not satisfy it. See [traceability](../TRACEABILITY.md).
