# Authentication and onboarding

**Requirement: FR-AUTH. Status: specified, unimplemented. Required.**

## Actors and journey

Visitor and account owner.

Register, request OTP, verify email, sign in, complete identity/student profile, then return to an eligible tournament join destination if present. Preserve login/register/auth-backdrop and onboarding steps. A claimed school is profile data, not proof of academic enrollment. Student restriction validates the documented school relationship without inventing a verified-enrollment badge.

## Fields and validation

email: normalized unique address; password: 12-128 characters, hash only; OTP: six digits, expiring; real_name: 1-120; IGN: 1-64; MLBB account ID: string; primary/secondary roles: EXP_LANE, MID_LANE, GOLD_LANE, JUNGLER, ROAMER; is_student: boolean; institution_id: required exactly when student; top heroes: at most three distinct catalog IDs; visibility: public/private.

Shared type/default/nullability rules are in [data dictionary](../DATABASE.md). Authentication, role checks and private projections follow [security](../SECURITY.md).

## Interfaces

| Method | Path under /api/v1 | Input | Result |
| --- | --- | --- | --- |
| POST | /auth/register | email, password, real_name | 201 account ID, verification_required |
| POST | /auth/request-otp | email | 202 generic delivery acknowledgment |
| POST | /auth/verify-otp | email, code | 200 email verification state |
| POST | /auth/login | email, password | 200 session cookie, csrf_token, current user |
| POST | /auth/logout | CSRF header | 204 revoked session |
| POST | /auth/password-reset | email | 202 generic acknowledgment |
| POST | /auth/password-reset/complete | token, new_password | 204 reset and revoke sessions |
| GET | /auth/me | session | 200 user/profile/readiness |
| GET | /institutions | q, cursor, limit | 200 matched reference entries |
| GET | /heroes | q, role, cursor, limit | 200 pinned catalog entries |
| PUT | /profiles/me | profile fields above | 200 saved profile |

## Commit, error and audit behavior

Validate session and resource role before body-driven mutations. Apply field rules before any provider request. Use one transaction for related business records, audit event and outbox entry. Capacity/result/issuance operations lock the aggregate; edits check version. Return 409 for stale or incompatible state and 422 for invalid fields. Provider failures preserve committed intent and expose pending/failed state; never fabricate completion. Idempotent retries return the previous reference. Read views use permission-filtered server projections.

## Acceptance scenarios

- **AC-AUTH-01:** Duplicate normalized email cannot create two accounts.
- **AC-AUTH-02:** Invalid/expired OTP and exhausted attempts do not verify email.
- **AC-AUTH-03:** Non-student transition clears institution; student cannot save without a known institution.
- **AC-AUTH-04:** Reload restores server-owned profile, not a hardcoded first player.
- **AC-AUTH-05:** Onboarding preserves a valid join destination but never bypasses eligibility/payment.

## Onsite completion

Implement the specified persistence and routes, bind the approved screen behavior to these contracts, add unit and integration tests for the scenarios above, and verify UI empty/error/loading/success states. Completion requires server evidence; local fixtures do not satisfy it. See [traceability](../TRACEABILITY.md).
