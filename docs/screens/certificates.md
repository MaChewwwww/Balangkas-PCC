# Credentials and verification

## Layout contract

Apply the shared [layout contract](LAYOUT.md). Credential issuance begins in the tournament Rewards panel and opens a focused modal with recipient selection and related two-column fields when width permits. Placement/member credential cards keep recipient identity, tournament/award context, issuance state, and the single action appropriate to that state; they do not present a wallet/address as successful evidence by itself.

Public verification uses the editorial lookup surface. A certificate detail page is a `1.5fr + 1fr` desktop composition: the certificate/article panel is primary and verification/status/evidence is a dedicated aside. That aside stacks below the certificate at 900px. Portfolio credential filters remain in the owned-portfolio main/rail composition, not in the public certificate layout.

Use public/portal/auth typography and responsive rules from [DESIGN](../DESIGN.md). Preserve captions from [CONTROLS](CONTROLS.md); [ROUTES](ROUTES.md) identifies each approved page assembly.

## Fields and controls

Recipient USER/TEAM, recipient ID, award/title/description, metadata; lookup code or Core asset address search.

## Actions and navigation

Create draft, issue, view pending/issued record, void in the PCC registry with controlled reason category/private note, search and follow real Devnet Explorer link when the server returns a finalized Core asset address.

## Permission and state behavior

No issuer privilege inferred from opening modal. Walletless USER blocks before worker signing. The UI calls the identity field **Core asset address**, never mint address; it may identify the credential standard as a Metaplex Core NFT. Draft is unavailable to public. `PENDING_RECONCILIATION` shows the neutral, not-valid-yet status without recipient/award facts; `ISSUED` requires server-reported finalized Core NFT evidence; and `VOIDED` retains that evidence without claiming an on-chain change. The modal never accepts free-form metadata JSON, recipient wallets, metadata/image URIs or a schema version. Empty search cannot submit.

Every async control has loading/disabled, validation error, network error with retained draft, and actual success states. Missing records show not-found rather than fallback data. Modals trap focus, close with Escape and return focus. Narrow viewports stack rails, retain content order and keep scrolling inside tables/dialogs.

## Data and acceptance

Use the [Credentials and verification feature contract](../features/certificates.md) and its field/error/transaction rules. Translate related UI-AC scenarios from the [baseline catalogue](../acceptance/FRONTEND_BASELINE.md); use persisted fixtures created onsite, never copy source fixture modules. Verify desktop and 375px mobile states before parity sign-off.
