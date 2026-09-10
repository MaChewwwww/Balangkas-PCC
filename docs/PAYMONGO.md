# PayMongo readiness

**Disabled and unimplemented.** No credentials, wallet, entitlement or webhook are inherited. Entry collection and prize payout are separate capabilities. The UI label Instapay does not establish the supported provider resource.

Before enablement, verify account entitlements, recipient onboarding, amount units, test/live behavior, idempotency and webhook signature format against [official documentation](https://developers.paymongo.com/) and the configured account. Record resource/event mapping before adapter implementation. Unsupported capability stays blocked.

## Entry collection

Persist an attempt bound to the registration's exact centavos, initiate the supported collection resource, return the approved user action, verify signed callback and actual resource status, then atomically settle and advance registration if requirements pass. Mismatched or expired payment does not settle. Withdrawal does not automatically refund.

## Prize distribution

Require completed bracket, immutable allocation, verified recipient, enabled wallet capability and authorized operator. Persist intent/idempotency before submission. Submitted is not paid. Only verified settlement evidence permits PAID. Acknowledge duplicates without another side effect. Out-of-order failure cannot undo confirmed settlement; reconcile ambiguity. Persist recipient references, never raw bank/account details.

## Physical cash

Record authorized operator, representative, timestamp and handover reference. One finalized handover per allocation. Use physical-cash wording rather than provider settlement claims.
