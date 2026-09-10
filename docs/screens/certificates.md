# Credentials and verification

## Layout and typography

Tournament Rewards issuance modal, placement/member credential views, portfolio credential filters, public lookup and certificate detail.

Use public/portal/auth typography and responsive rules from [DESIGN](../DESIGN.md). Preserve captions from [CONTROLS](CONTROLS.md); source paths in [ROUTES](ROUTES.md) identify page wrappers.

## Fields and controls

Recipient USER/TEAM, recipient ID, award/title/description, metadata; lookup code or mint search.

## Actions and navigation

Create draft, issue, view pending/issued record, revoke with reason, search and follow real Explorer link when available.

## Permission and state behavior

No issuer privilege inferred from opening modal. Walletless USER blocks before signing. Draft unavailable to public; revoked display retains evidence. Empty search cannot submit.

Every async control has loading/disabled, validation error, network error with retained draft, and actual success states. Missing records show not-found rather than fallback data. Modals trap focus, close with Escape and return focus. Narrow viewports stack rails, retain content order and keep scrolling inside tables/dialogs.

## Data and acceptance

Use the [Credentials and verification feature contract](../features/certificates.md) and its field/error/transaction rules. Translate related UI-AC scenarios from the [baseline catalogue](../acceptance/FRONTEND_BASELINE.md); use persisted fixtures created onsite, never copy source fixture modules. Verify desktop and 375px mobile states before parity sign-off.
