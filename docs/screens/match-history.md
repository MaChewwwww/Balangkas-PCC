# Match and tournament history

## Layout and typography

Matches/Tournament History/Scrimmage History tabs, two-column search/filter and metrics rail, expandable per-team scrimmage ledger.

Use public/portal/auth typography and responsive rules from [DESIGN](../DESIGN.md). Preserve captions from [CONTROLS](CONTROLS.md); source paths in [ROUTES](ROUTES.md) identify page wrappers.

## Fields and controls

Search, source and relevant team/date filters.

## Actions and navigation

Switch history tabs, expand ledger, View Match Details, follow tournament/placement links, download permitted CSV.

## Permission and state behavior

Counts derive from completed series. Empty results show reset filter action. Same match ID resolves same dossier; keep fromMyTeam/fromTournament/fromCommunity origin.

Every async control has loading/disabled, validation error, network error with retained draft, and actual success states. Missing records show not-found rather than fallback data. Modals trap focus, close with Escape and return focus. Narrow viewports stack rails, retain content order and keep scrolling inside tables/dialogs.

## Data and acceptance

Use the [Match and tournament history feature contract](../features/match-history.md) and its field/error/transaction rules. Translate related UI-AC scenarios from the [baseline catalogue](../acceptance/FRONTEND_BASELINE.md); use persisted fixtures created onsite, never copy source fixture modules. Verify desktop and 375px mobile states before parity sign-off.
