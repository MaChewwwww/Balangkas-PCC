# Certificate issuance and public lookup

**Requirement: FR-CERT. Status: specified, unimplemented. Required.**

## Actors and journey

Authorized tournament issuer, individual/team recipient and public verifier.

Preserve Rewards certificate modal, placement/member views and portfolio credential filters. Draft selection validates tournament and recipient context. Individual issuance requires that person's linked wallet. Team issuance uses explicit team identity and final system custody with immutable team metadata. Submit once, reconcile transaction, then mark issued. Public lookup accepts lookup code or exact mint and shows revoked records as revoked. Drafts never look publicly issued.

## Fields and validation

lookup_code unique; tournament_id; award_type; title/description; USER/TEAM recipient; user_id or team_id; management_member_id optional; metadata attributes; issuance DRAFT/ISSUED/REVOKED; mint, transaction, metadata URI and timestamps.

Shared type/default/nullability rules are in [data dictionary](../DATABASE.md). Authentication, role checks and private projections follow [security](../SECURITY.md).

## Interfaces

| Method | Path under /api/v1 | Input | Result |
| --- | --- | --- | --- |
| POST | /tournaments/{id}/certificates | recipient_type, recipient ID, award, title, description, metadata | 201 DRAFT |
| POST | /certificates/{id}/issue | issuer, version | 202 issuance job |
| POST | /certificates/{id}/revoke | reason, issuer, version | 200 REVOKED |
| GET | /certificates/{lookup} | lookup code or mint | 200 issued/revoked public projection |
| GET | /certificates | recipient/tournament filters, cursor, limit | 200 permitted list |

## Commit, error and audit behavior

Validate session and resource role before body-driven mutations. Apply field rules before any provider request. Use one transaction for related business records, audit event and outbox entry. Capacity/result/issuance operations lock the aggregate; edits check version. Return 409 for stale or incompatible state and 422 for invalid fields. Provider failures preserve committed intent and expose pending/failed state; never fabricate completion. Idempotent retries return the previous reference. Read views use permission-filtered server projections.

## Acceptance scenarios

- **AC-CERT-01:** Walletless individual issuance fails before signer use.
- **AC-CERT-02:** Team issuance never fabricates a user recipient.
- **AC-CERT-03:** Repeated issuance returns the existing attempt/mint and cannot mint twice.
- **AC-CERT-04:** Unknown, malformed and draft lookup never substitute a fixture record.
- **AC-CERT-05:** Revocation changes public status and retains issuance evidence; do not imply on-chain revocation unless implemented and verified.

## Onsite completion

Implement the specified persistence and routes, bind the approved screen behavior to these contracts, add unit and integration tests for the scenarios above, and verify UI empty/error/loading/success states. Completion requires server evidence; local fixtures do not satisfy it. See [traceability](../TRACEABILITY.md).
