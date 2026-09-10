# Authentication and onboarding

**Requirement: FR-AUTH. Status: specified, unimplemented. Required.**

## Actors and journey

Visitor and account owner.

Register, request OTP, verify email, sign in, complete identity/student profile, then return to an eligible tournament join destination if present. Preserve login/register/auth-backdrop and onboarding steps. A claimed school is profile data, not proof of academic enrollment. Student restriction validates the documented school relationship without inventing a verified-enrollment badge.

## Fields and validation

email: normalized unique address; password: 12-128 characters, hash only; OTP: six digits, expiring; real_name: 1-120; IGN: 1-64; MLBB User ID: digits, 1-64; Server / Zone ID: exactly four digits; competitive_rank: MYTHIC_IMMORTAL, MYTHICAL_GLORY, MYTHIC, LEGEND or EPIC; primary/secondary roles: EXP_LANE, MID_LANE, GOLD_LANE, JUNGLER, ROAMER; is_student: boolean; institution_id: required exactly when student; top heroes: at most three distinct catalog IDs; visibility: public/private; bio: optional, stored up to 1000 characters.

The onboarding presentation uses these exact display labels: **Tank / Roamer** = ROAMER, **Mid Laner** = MID_LANE, **Gold Laner** = GOLD_LANE, **EXP Laner** = EXP_LANE, and **Jungler** = JUNGLER. Rank options display as **Mythic Immortal (100+ Stars)**, **Mythical Glory (50-99 Stars)**, **Mythic (0-49 Stars)**, **Legend**, and **Epic**. The onboarding short-description field intentionally stops at 250 characters in the approved form; profile editing may use the canonical 1000-character capacity. A completed onboarding profile requires the User ID, Zone ID, rank and primary role. These gameplay identifiers are profile data, not a claim that a game-account provider has verified ownership.

Shared type/default/nullability rules are in [data dictionary](../DATABASE.md). Authentication, role checks and private projections follow [security](../SECURITY.md).

## Interfaces

| Method | Path under /api/v1 | Input | Result |
| --- | --- | --- | --- |
| POST | /auth/register | email, password, real_name | 201 account ID, verification_required |
| POST | /auth/request-otp | email | 202 generic delivery acknowledgment |
| POST | /auth/verify-otp | email, code | 200 real email verification or explicitly classified staging demo-bypass state |
| POST | /auth/login | email, password | 200 session cookie, csrf_token, current user with authentication_mode |
| POST | /auth/logout | CSRF header | 204 revoked session |
| POST | /auth/password-reset | email | 202 generic acknowledgment |
| POST | /auth/password-reset/complete | token, new_password | 204 reset and revoke sessions |
| GET | /auth/me | session | 200 user/profile/readiness, csrf_token and authentication_mode |
| GET | /institutions | q, cursor, limit | 200 matched reference entries |
| GET | /heroes | q, role, cursor, limit | 200 pinned catalog entries |
| PUT | /profiles/me | profile fields above | 200 saved profile |

## Commit, error and audit behavior

Validate session and resource role before body-driven mutations. Apply field rules before any provider request. Use one transaction for related business records, audit event and outbox entry. Capacity/result/issuance operations lock the aggregate; edits check version. Return 409 for stale or incompatible state and 422 for invalid fields. Provider failures preserve committed intent and expose pending/failed state; never fabricate completion. Idempotent retries return the previous reference. Read views use permission-filtered server projections.

## Local auth fixtures

The future local auth seed reads the ignored `.env.accounts` catalog described
in [configuration](../CONFIGURATION.md#local-auth-fixture-catalog). It creates
only the 24 synthetic account identities and development-only fixture markers:
20 players and four organizers. It must use stable fixture keys,
validate the complete catalog before one transaction, and make a second run a
no-op for every recognized fixture. It must fail atomically rather than claim
success if a fixture key or reserved email conflicts with a non-fixture user.

The catalog deliberately does not create profiles, teams, communities,
tournaments, matches, providers, wallets, biometrics, payments, certificates,
or real OTP evidence. Each local login reports `SEED_FIXTURE`, remains visibly
labeled as a fixture, and never becomes `EMAIL_VERIFIED` merely because it was
seeded. The expanded four-team tournament simulator belongs to the final
tournament phase after the relevant features are implemented.

## Acceptance scenarios

- **AC-AUTH-01:** Duplicate normalized email cannot create two accounts.
- **AC-AUTH-02:** Invalid/expired OTP and exhausted attempts do not verify email. `123456` is invalid except when `PCC_HACKATHON_DEMO_OTP_CODE=123456`, exact staging mode, and the explicit demo flag are all present; that exception creates `DEMO_BYPASS`, not email/provider/biometric/wallet verification evidence.
- **AC-AUTH-03:** Non-student transition clears institution; student cannot save without a known institution.
- **AC-AUTH-04:** Reload restores server-owned profile, not a hardcoded first player.
- **AC-AUTH-05:** Onboarding preserves a valid join destination but never bypasses eligibility/payment.
- **AC-AUTH-06:** A completed profile cannot omit or misformat MLBB User ID, four-digit Zone ID, rank or primary role; display labels serialize to the canonical role/rank value and do not imply external account verification.
- **AC-AUTH-07:** A development-only run of the account catalog creates exactly its 24 synthetic users once; the next identical run makes no changes, and a foreign/reserved-email collision fails atomically without overwriting an account or creating feature data.

## Onsite completion

Implement the specified persistence and routes, bind the approved screen behavior to these contracts, add unit and integration tests for the scenarios above, and verify UI empty/error/loading/success states. Completion requires server evidence; local fixtures do not satisfy it. See [traceability](../TRACEABILITY.md).
