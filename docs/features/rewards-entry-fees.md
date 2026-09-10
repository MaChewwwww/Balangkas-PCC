# Entry fees and prize settlement

**Requirement: FR-PAY. Status: specified, unimplemented. Required.**

## Actors and journey

Registering captain, tournament creator, representative and payout operator.

Keep Free Entry, E-Wallet (Instapay) and Solana labels separate from Cash (Physical), E-Wallet (PayMongo) and blockchain prizes. Registration waits for exact verified fee. Solana entry destination snapshots creator wallet. Completed tournament allows allocation review and one-time finalization. Physical cash records handover; provider cash waits for signed settlement webhook; chain payout waits for verified Devnet transaction. No automatic release solely because bracket completes.

## Fields and validation

prize_type NONE/CASH/E_WALLET/BLOCKCHAIN; entry_fee_mode NONE/E_WALLET/SOLANA; amount minor units; immutable destination snapshot; placement/representative; allocation state; payout run/transfer IDs; provider reference/event; handover evidence.

Shared type/default/nullability rules are in [data dictionary](../DATABASE.md). Authentication, role checks and private projections follow [security](../SECURITY.md).

## Interfaces

| Method | Path under /api/v1 | Input | Result |
| --- | --- | --- | --- |
| POST | /registrations/{id}/payment | selected configured rail | 202 payment attempt/reference |
| POST | /registrations/{id}/solana-verification | transaction_signature | 200 settled or 202 confirmation pending |
| GET | /registrations/{id}/payment | owner permission | 200 payment state |
| GET | /tournaments/{id}/rewards | role-aware | 200 allocations and evidence |
| PUT | /tournaments/{id}/rewards | placement allocations, exact amounts, representative IDs, version | 200 draft allocation |
| POST | /tournaments/{id}/rewards/finalize | operator, version | 200 immutable allocation |
| POST | /tournaments/{id}/payouts | finalized allocation ID | 202 payout run |
| POST | /allocations/{id}/handover | handover_reference, handed_over_at | 200 CASH handover evidence |
| POST | /webhooks/paymongo | raw signed provider event | 200 accepted duplicate-safe receipt |

## Commit, error and audit behavior

Validate session and resource role before body-driven mutations. Apply field rules before any provider request. Use one transaction for related business records, audit event and outbox entry. Capacity/result/issuance operations lock the aggregate; edits check version. Return 409 for stale or incompatible state and 422 for invalid fields. Provider failures preserve committed intent and expose pending/failed state; never fabricate completion. Idempotent retries return the previous reference. Read views use permission-filtered server projections.

## Acceptance scenarios

- **AC-PAY-01:** Free entry and no-prize tournament require all corresponding amounts zero.
- **AC-PAY-02:** Fractional minor units are rejected, never rounded.
- **AC-PAY-03:** Unverified fee cannot grant a registered slot; webhook duplicates cannot pay twice.
- **AC-PAY-04:** Changing linked creator wallet does not change existing payment destination snapshots.
- **AC-PAY-05:** Physical handover never claims a PayMongo webhook; provider configuration alone never marks PAID.

## Onsite completion

Implement the specified persistence and routes, bind the approved screen behavior to these contracts, add unit and integration tests for the scenarios above, and verify UI empty/error/loading/success states. Completion requires server evidence; local fixtures do not satisfy it. See [traceability](../TRACEABILITY.md).
