# Entry fees and prize settlement

**Requirement: FR-PAY. Status: specified, unimplemented. Required.**

## Actors and journey

Registering captain, tournament creator, representative and payout operator.

Keep Free Entry, **PayMongo test checkout — no real funds move**, and Solana labels separate from Cash (Physical), E-Wallet and blockchain prizes. `E_WALLET` is a generic PHP rail; it is never labelled “InstaPay,” which is an outbound transfer rail. The PayMongo hosted page permits only its configured test methods: GCash, Maya and QR Ph; PCC never collects payment credentials, and QR Ph uses PayMongo's simulation/test URL rather than a real scan. Registration waits for an exact, server-verified fee. A Solana entry snapshots the registering leader's linked payer wallet, creator destination wallet, exact lamports, canonical registration memo, Devnet cluster and genesis; only a matching successful finalized Devnet transaction can register the team. A blockchain prize is a new Devnet escrow with exactly two distinct finalized wallet recipients, `CHAMPION` and `RUNNER_UP`; it is never an entry-fee destination and releases only after explicit operator action. Completed tournament allows allocation review and one-time finalization. Physical cash records handover; chain payout waits for verified Devnet transaction. PayMongo prize settlement, Wallet/disbursement, recipient onboarding, refunds and transfers are unavailable in this hackathon. No automatic release solely because bracket completes.

## Fields and validation

prize_type NONE/CASH/E_WALLET/BLOCKCHAIN; entry_fee_mode NONE/E_WALLET/SOLANA; amount minor units; immutable destination snapshot; placement/representative; allocation state; payout run/transfer IDs; provider reference/event; handover evidence.

Shared type/default/nullability rules are in [data dictionary](../DATABASE.md). Authentication, role checks and private projections follow [security](../SECURITY.md).

## Interfaces

| Method | Path under /api/v1 | Input | Result |
| --- | --- | --- | --- |
| POST | /registrations/{id}/payment | configured `PAYMONGO_TEST_CHECKOUT` rail | 202 test attempt and one-time hosted checkout URL, or explicit unavailable |
| POST | /registrations/{id}/solana-payment-intent | participant, version | 201 short-lived browser-signable Devnet entry transaction/instructions with frozen payer, destination, exact lamports and memo, or explicit unavailable |
| POST | /registrations/{id}/solana-verification | transaction_signature | 200 paid after exact finalized Devnet verification, 202 confirmation pending, or explicit mismatch without registration |
| GET | /registrations/{id}/payment | owner permission | 200 payment state |
| GET | /tournaments/{id}/rewards | role-aware | 200 allocations and evidence |
| PUT | /tournaments/{id}/rewards | placement allocations, exact amounts, representative IDs, version | 200 draft allocation |
| POST | /tournaments/{id}/rewards/finalize | operator, version | 200 immutable allocation |
| POST | /tournaments/{id}/payouts | finalized allocation ID | 202 permitted non-PayMongo payout run; E-Wallet is unavailable in this event |
| POST | /allocations/{id}/handover | handover_reference, handed_over_at | 200 CASH handover evidence |
| POST | /tournaments/{id}/escrow/funding-intent | creator, version | 201 short-lived browser-signable Devnet funding transaction and expected PDA, or explicit unavailable |
| POST | /tournaments/{id}/escrow/verification | funding transaction_signature | 200 funded after exact finalized Devnet/PDA verification or 202 confirmation pending |
| POST | /webhooks/paymongo/test | raw signed test provider event | 200 accepted duplicate-safe receipt |

## Commit, error and audit behavior

Validate session and resource role before body-driven mutations. Apply field rules before any provider request. Use one transaction for related business records, audit event and outbox entry. Capacity/result/issuance operations lock the aggregate; edits check version. Return 409 for stale or incompatible state and 422 for invalid fields. For PayMongo, a test-mode Hosted Checkout v2 session is created only after the test-key/configuration gate and is bound to the exact integer-centavo snapshot with a provider idempotency key. Redirect return parameters, a browser success page and a client claim never settle a registration. The raw webhook signature is verified before parsing; only a `livemode=false` `checkout_session.payment.paid` event for the expected Checkout Session/payment, exact PHP amount and internal reference can be reconciled into one atomic `PAID` transition. For Solana, the verifier reads only the configured Devnet RPC at finalized commitment and matches the frozen payer, destination, lamports, memo, signature uniqueness and cluster/genesis. An escrow is a distinct operator-requested workflow: a creator signs funding in the browser, while an isolated worker signs exactly one final release after immutable two-recipient allocation evidence. Provider failures preserve committed intent and expose pending/failed state; never fabricate completion. Idempotent retries return the previous reference. Read views use permission-filtered server projections. See [PayMongo test-mode readiness](../PAYMONGO.md) and [Solana readiness](../SOLANA.md).

## Acceptance scenarios

- **AC-PAY-01:** Free entry and no-prize tournament require all corresponding amounts zero.
- **AC-PAY-02:** Fractional minor units are rejected, never rounded.
- **AC-PAY-03:** Unverified fee cannot grant a registered slot; webhook duplicates cannot pay twice.
- **AC-PAY-04:** Changing linked creator wallet does not change existing payment destination snapshots.
- **AC-PAY-05:** Physical handover never claims a PayMongo webhook; provider configuration alone never marks PAID.
- **AC-PAY-06:** A redirect, invalid signature, live-mode event, unknown/mismatched Checkout Session, non-PHP or different-centavo result creates no `PAID` registration. A valid duplicate/out-of-order test event cannot regress or pay twice.
- **AC-PAY-07:** Only GCash, Maya and QR Ph are allowed in the PayMongo test Checkout; cards and every other method are rejected/not offered. QR Ph uses PayMongo's simulation/test URL, never a real QR scan. Non-test PayMongo keys/events and all Wallet, recipient, payout/disbursement, InstaPay/PESONet, refund and PayMongo E-Wallet prize actions remain unavailable; no UI calls them transferred or paid.
- **AC-PAY-08:** A Solana entry becomes paid only after one successful finalized Devnet transaction matches the frozen payer, destination, exact lamports and memo; duplicate/wrong/errored/not-finalized/cross-cluster signatures create no registration. A blockchain escrow release is one explicit operator action after a two-recipient immutable allocation, never a timer or completion side effect.

## Onsite completion

Implement the specified persistence and routes, bind the approved screen behavior to these contracts, add focused unit/API tests for the scenarios above, and verify UI empty/error/loading/success states manually. Test only with authorized `sk_test_` keys and PayMongo test simulations; no browser E2E suite or funds-moving test is required. Completion requires server evidence; local fixtures do not satisfy it. See [traceability](../TRACEABILITY.md).
