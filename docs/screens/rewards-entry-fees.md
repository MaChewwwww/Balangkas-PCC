# Rewards and fee checkout

## Layout and typography

Tournament Rewards tab and existing allocation views; fee controls remain separate in create/join surfaces.

Use public/portal/auth typography and responsive rules from [DESIGN](../DESIGN.md). Preserve captions from [CONTROLS](CONTROLS.md); source paths in [ROUTES](ROUTES.md) identify page wrappers.

## Fields and controls

Prize type/amount, entry rail/value, placement/team/representative allocation, operator confirmation.

## Actions and navigation

Prepare fee, sign/verify Solana transfer, review payment status; save/finalize allocations, request payout or record physical handover.

## Permission and state behavior

UI renders no bank-account collection. Incomplete provider setup disables submission with readiness reason. Pending confirmation is not paid. Immutable finalized allocation cannot be edited.

Every async control has loading/disabled, validation error, network error with retained draft, and actual success states. Missing records show not-found rather than fallback data. Modals trap focus, close with Escape and return focus. Narrow viewports stack rails, retain content order and keep scrolling inside tables/dialogs.

## Data and acceptance

Use the [Rewards and fee checkout feature contract](../features/rewards-entry-fees.md) and its field/error/transaction rules. Translate related UI-AC scenarios from the [baseline catalogue](../acceptance/FRONTEND_BASELINE.md); use persisted fixtures created onsite, never copy source fixture modules. Verify desktop and 375px mobile states before parity sign-off.
