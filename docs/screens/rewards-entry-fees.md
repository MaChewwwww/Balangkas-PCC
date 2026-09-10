# Rewards and fee checkout

## Layout contract

Apply the shared [layout contract](LAYOUT.md). Rewards lives inside the tournament command center rather than a free-standing finance dashboard. Its tab retains the tournament metric ribbon and 320px contextual rail at wide desktop. Allocation lists and issuance/payout actions stay in the primary Rewards panel; rail controls filter or summarize the same selected tournament and must not silently change the scope.

The allocation workspace splits its detailed recipients/evidence panel from its settlement/summary panel at extra-large width, then stacks. Recipient, placement, rail, exact amount, state, and evidence reference stay visibly associated in every row. Certificate and reward dialogs are centered, scrolling modal surfaces with two-column related fields where space permits; entry-fee choices remain in tournament creation/join, visibly separate from reward rail choices.

Use public/portal/auth typography and responsive rules from [DESIGN](../DESIGN.md). Preserve captions from [CONTROLS](CONTROLS.md); [ROUTES](ROUTES.md) identifies each approved page assembly.

## Fields and controls

Prize type/amount, entry rail/value, placement/team/representative allocation, operator confirmation. During this event the only PayMongo entry choice reads **PayMongo test checkout — no real funds move**. Its hosted page may offer only GCash, Maya and QR Ph; PCC does not collect a card, bank account, e-wallet account or recipient details. The QR Ph test flow uses PayMongo's simulation/test URL, never a scanned QR. A Solana entry clearly states **Solana Devnet**, exact SOL/lamport display and the server-provided creator destination; a blockchain reward only accepts CHAMPION and RUNNER_UP with distinct linked-wallet snapshots.

## Actions and navigation

Start a PayMongo test checkout, return and refresh its pending/paid/failed/expired status, sign/verify a server-snapshotted Solana Devnet entry transfer, save/finalize allocations, create/verify a creator-signed Devnet escrow funding intent, request one operator release after finalization, or record physical handover. A PayMongo E-Wallet reward action remains visibly unavailable; do not render an InstaPay, PayMongo Wallet, transfer, refund or recipient-onboarding action.

## Permission and state behavior

UI renders no bank-account/card collection. Incomplete test-only provider or Solana Devnet setup disables its action with the server readiness reason. A hosted-checkout redirect or return screen is not paid; only the refetched server projection can show `PAID`. A wallet-provider success, submitted Solana signature, or escrow funding click is also not paid/funded; pending finality stays visibly pending until the server projection changes. PayMongo E-Wallet prize rows show `Unavailable for hackathon test mode — no funds transfer`; blockchain release has no automatic/timer action; immutable finalized allocations cannot be edited.

Every async control has loading/disabled, validation error, network error with retained draft, and actual success states. Missing records show not-found rather than fallback data. Modals trap focus, close with Escape and return focus. Narrow viewports stack rails, retain content order and keep scrolling inside tables/dialogs.

## Data and acceptance

Use the [Rewards and fee checkout feature contract](../features/rewards-entry-fees.md) and its field/error/transaction rules. Translate related UI-AC scenarios from the [baseline catalogue](../acceptance/FRONTEND_BASELINE.md); use persisted fixtures created onsite, never copy source fixture modules. Verify desktop and 375px mobile states before parity sign-off.
