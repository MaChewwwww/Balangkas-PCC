# Certificate issuance and public lookup

**Requirement: FR-CERT. Status: specified, unimplemented. Required.**

## Actors and journey

Authorized tournament issuer, individual/team recipient and public verifier. Official on-chain credentials are Solana Devnet Metaplex Core NFT assets, never legacy Token Metadata mints or presentation copies.

Preserve Rewards certificate modal, placement/member views and portfolio credential filters. Draft selection validates tournament and recipient context. Individual issuance requires that person's linked-wallet snapshot. Team issuance uses explicit team identity and final system custody with immutable team metadata. The server derives the exact reviewed `pcc-certificate-v1` public metadata from an allowlist; upload it once, submit once, reconcile both Core asset and immutable soulbound state at finalized commitment, then mark issued. Public lookup accepts lookup code or exact Core asset address and shows `ISSUED`, neutral `PENDING_RECONCILIATION`, or registry `VOIDED` state. Drafts never look publicly issued.

## Fields and validation

lookup_code unique; tournament_id; server-calculated certificate-identity digest; award_type; title/description; USER/TEAM recipient; user_id or team_id; management_member_id optional; server-derived `pcc-certificate-v1` metadata attributes; issuance `DRAFT`/`PENDING_RECONCILIATION`/`ISSUED`/`VOIDED`; `METAPLEX_CORE` Devnet asset address, create/immutability transactions, public metadata/image URI/SHA-256, provider receipt and timestamps. A Core asset address is not called a mint. Public metadata uses only the fixed allowlist in [Solana readiness](../SOLANA.md); it never accepts arbitrary JSON or restricted data.

Shared type/default/nullability rules are in [data dictionary](../DATABASE.md). Authentication, role checks and private projections follow [security](../SECURITY.md).

## Interfaces

| Method | Path under /api/v1 | Input | Result |
| --- | --- | --- | --- |
| POST | /tournaments/{id}/certificates | recipient_type, recipient ID, award, title, description | 201 DRAFT |
| POST | /certificates/{id}/issue | issuer, version | 202 issuance job |
| POST | /certificates/{id}/void | reason category, private note, issuer, version | 200 VOIDED registry record |
| GET | /certificates/{lookup} | lookup code or Core asset address | 200 issued/pending-reconciliation/voided public projection |
| GET | /certificates | recipient/tournament filters, cursor, limit | 200 permitted list |

## Commit, error and audit behavior

Validate session and resource role before body-driven mutations. Apply field rules before any provider request. Use one transaction for related business records, audit event and outbox entry. Capacity/result/issuance operations lock the aggregate; edits check version. Return 409 for stale or incompatible state and 422 for invalid fields. The worker alone reads the isolated Devnet signer. It records server-derived metadata/image URI/SHA-256 and provider receipt before creating a Core asset, then verifies at finalized commitment the expected standard, candidate/destination snapshot, URI/hash, permanent-freeze plugin `frozen: true` with authority `None`, no collection, no update authority, and create/immutability signatures before it makes the `ISSUED` transition. Provider failures preserve committed intent; an ambiguous creation stays `PENDING_RECONCILIATION` and reconciles its original candidate without signing a replacement. Idempotent retries return the previous reference. Void is a PCC-registry-only status with a controlled reason category/private note; it has no on-chain side effect. Read views use permission-filtered server projections. See [Solana readiness](../SOLANA.md).

## Acceptance scenarios

- **AC-CERT-01:** Walletless individual issuance fails before signer use.
- **AC-CERT-02:** Team issuance never fabricates a user recipient.
- **AC-CERT-03:** Repeated issuance returns the existing attempt/Core asset and cannot issue twice; a duplicate active/issued certificate identity is rejected.
- **AC-CERT-04:** Unknown, malformed and draft lookup never substitute a fixture record.
- **AC-CERT-05:** Void changes public registry status to `VOIDED`, retains issuance evidence and private void note, and never implies an on-chain burn, thaw, transfer or revocation.
- **AC-CERT-06:** A certificate cannot become issued from a metadata upload, a browser claim, a Token Metadata mint, a non-finalized transaction, wrong Core owner/URI/hash, transferable asset, named freeze delegate, update authority, or collection-membership assertion. A real issued credential records one finalized Core NFT asset address with `PermanentFreezeDelegate(frozen: true, authority: None)` and public metadata hash.
- **AC-CERT-07:** A post-submission crash, timeout or missing signature produces `PENDING_RECONCILIATION`; it re-reads only the saved candidate/signature at finalized commitment and cannot sign a replacement while outcome is ambiguous.
- **AC-CERT-08:** Public metadata is exactly the server-derived `pcc-certificate-v1` allowlist and excludes restricted data. An unknown/draft record remains unavailable; a pending lookup contains no recipient/award facts and is not valid evidence.

## Onsite completion

Implement the specified persistence and routes, bind the approved screen behavior to these contracts, add unit and integration tests for the scenarios above, and verify UI empty/error/loading/success states. Completion requires server evidence; local fixtures do not satisfy it. See [traceability](../TRACEABILITY.md).
