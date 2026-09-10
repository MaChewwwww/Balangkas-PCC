# PayMongo test-mode readiness

**Disabled and unimplemented.** PCC uses PayMongo only in its test mode during the hackathon. “Testnet” in event discussion means PayMongo **test mode**: use test API keys and test checkout simulations; no real money moves. There are no inherited credentials, merchant account, wallet, recipient, webhook, entitlement, payout or transfer configuration.

The approved integration shape is **Hosted Checkout v2 for entry-fee simulation only**. The backend creates a Checkout Session and returns its hosted URL; the browser leaves PCC for PayMongo's hosted page and returns to PCC's neutral status view. This preserves the exact fee snapshot and avoids PCC handling card details. PayMongo recommends v2 for new Hosted Checkout integrations. See [Hosted Checkout](https://docs.paymongo.com/docs/payment-channels-hosted-checkout) and [test mode](https://docs.paymongo.com/docs/payment-acceptance-testing).

## Hard scope boundary

The sole enabled PayMongo capability, after onsite authorization, is a test-mode checkout that can demonstrate an entry-fee lifecycle. All of the following remain unavailable and must have no request path, secret, UI success claim or background submission:

- live API keys, live-mode events, real charges, live smoke tests, and any live checkout;
- PayMongo Wallets, automatic payouts, recipient/consumer onboarding, `send_money`, bank/e-wallet disbursement, InstaPay, PESONet, payment splitting and prize E-Wallet settlement;
- refunds, disputes, card vaulting, subscriptions, fee pass-through and collection of bank-account or card details.

`E_WALLET` is PCC's generic PHP entry-fee rail. It is displayed during this event as **PayMongo test checkout — no real funds move**. It must never be labelled “InstaPay”: InstaPay is an outbound domestic transfer rail, not an inbound e-wallet checkout method. Physical cash remains a separately recorded handover; Solana continues to use its own Devnet contract. A PayMongo E-Wallet reward allocation is visible as unavailable for this event, not submitted or paid.

The user-approved test Checkout allowlist is exactly `gcash`, `qrph`, and `maya`; cards and every other method are disabled. The PayMongo-hosted page—not PCC—presents the selected test method. Test QR Ph must use PayMongo's simulation/test URL rather than scanning the generated QR with a real payment application, because a scan can create a real transaction.

## Test checkout contract

1. The server derives the registering captain and registration from the session, confirms that the registration is eligible but not already settled, and snapshots the selected `E_WALLET` fee in integer PHP centavos. The client supplies neither an amount, destination, provider reference, success state nor recipient details.
2. One `payment_attempt` is created with the user command's idempotency key and request digest before provider work. The same logical retry returns that attempt and does not create a second Checkout Session. Its opaque internal reference is the only provider `reference_number`/metadata value; it contains no name, email, team, invite, wallet or other personal data.
3. Only when `PAYMONGO_ENABLED=true`, a secret begins `sk_test_`, the test webhook secret is present, and the exact `gcash,qrph,maya` allowlist is confirmed test-enabled in the account may the backend create a Hosted Checkout v2 session. Test-only behavior is unconditional in PCC; there is no environment switch for a live mode. It sets PHP, quantity one, the exact snapshot centavos, PCC success/cancel return URLs, `pass_on_fees=false`, and no PCC-managed billing/card fields. The first response may contain the short-lived `checkout_url`; PCC does not log it or store it in the durable payment record.
4. Redirect/cancel/success return URLs are navigation only. They never settle a registration. The browser refetches its payment projection, which remains pending until the server has accepted and reconciled signed provider evidence.
5. The test-only webhook endpoint receives the raw bytes before parsing. It verifies `Paymongo-Signature` with HMAC-SHA256 and a timing-safe comparison; it rejects an invalid signature, `livemode=true`, an unhandled event, unknown Checkout Session/reference, mismatched currency/amount, or a payment not in the expected session. It records a sanitized, duplicate-safe provider-event receipt, then queues/reconciles outside the response path. The raw body, checkout URL, billing details, payment method details and full provider response never enter normal logs or projections.
6. Reconciliation obtains/uses the authoritative PayMongo test resource and checks the Checkout Session ID, internal reference, `livemode=false`, payment ID, PHP currency and exact entry-fee amount. Only a verified paid result atomically marks the attempt `PAID`, records safe provider IDs/timestamps, advances the registration when all other requirements pass, writes audit/outbox records and emits the permitted update. A duplicate or out-of-order event cannot pay twice or regress `PAID`.

`PENDING` means a test Checkout Session exists or its result is unresolved; `FAILED`, `EXPIRED` and `CANCELLED` retain their attempt/audit trail and allow a new explicitly requested attempt where policy permits. `UNAVAILABLE` means the test-only configuration or account capability gate failed and creates no provider request. There is no local “simulate paid” route or frontend-only success state.

## Webhook and operational rules

Register exactly one publicly reachable HTTPS **test** endpoint, `/api/v1/webhooks/paymongo/test`, during configured onsite setup; it is not created dynamically per checkout. Subscribe only to Hosted Checkout's `checkout_session.payment.paid` outcome event, respond promptly after durable receipt, and treat duplicates as successful acknowledgements. The test endpoint is separate from any future live endpoint, which is deliberately absent.

Use a fresh PayMongo `Idempotency-Key` derived from the immutable internal payment-attempt ID for each provider write and retain it for reconciliation. Provider IDs are evidence, not authority by themselves: settlement must still match the internal attempt and snapshot. Keep the provider account/dashboard owner, test API-key creation date, permitted test methods, webhook ID/endpoint, key-rotation owner and a completed test result in the operator record outside Git. Never store secrets there or in a release record.

The normal test exercise covers at least one authorized success and one customer-cancel/failure simulation using PayMongo's documented test flow. CI mocks the adapter and signature boundary. There is no live money-movement check, browser E2E suite or actual-funds test during this hackathon.

## Future capabilities are not preapproved

If a later event needs real collection, refunds, payouts or bank/e-wallet distribution, create a new decision and complete the then-current PayMongo account/capability, compliance, privacy, webhook, reconciliation and release requirements first. Reusing a test-mode record, changing only a key prefix, or enabling a wallet is not authorization for that expansion.

## Physical cash

Record authorized operator, representative, timestamp and handover reference. One finalized handover per allocation. Use physical-cash wording rather than provider settlement claims.
