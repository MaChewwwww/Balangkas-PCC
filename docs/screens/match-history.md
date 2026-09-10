# Match and tournament history

## Layout contract

Apply the shared [layout contract](LAYOUT.md). History is an 8/4 desktop workspace (9/3 at the widest layout): left main region owns the Matches, Tournament History, and Scrimmage History tabs plus their result/empty surfaces; sticky right rail owns search, filters, three-cell performance summaries, and a contextual arena CTA. The tab change changes the primary ledger, not the layout or rail ownership.

The Matches tab renders compact match cards/rows with opponent/event identity, outcome, date, score/stat summary, and View Match Details. Tournament History groups placement/event summaries with links. Scrimmage History uses expandable team ledgers; its expanded rows preserve label/value pairs and detail links instead of reducing official history to a single result badge. On smaller screens each row’s identity remains before its metrics/actions and the rail follows the history list.

Use public/portal/auth typography and responsive rules from [DESIGN](../DESIGN.md). Preserve captions from [CONTROLS](CONTROLS.md); [ROUTES](ROUTES.md) identifies each approved page assembly.

## Fields and controls

Search, source and relevant team/date filters.

## Actions and navigation

Switch history tabs, expand ledger, View Match Details, follow tournament/placement links, download permitted CSV.

## Permission and state behavior

Counts derive from completed series. Empty results show reset filter action. Same match ID resolves the same dossier; retain a valid Current Team, Tournament, Community or Match History origin only through [the cross-feature breadcrumb contract](BREADCRUMB_CONTEXT.md).

Every async control has loading/disabled, validation error, network error with retained draft, and actual success states. Missing records show not-found rather than fallback data. Modals trap focus, close with Escape and return focus. Narrow viewports stack rails, retain content order and keep scrolling inside tables/dialogs.

## Data and acceptance

Use the [Match and tournament history feature contract](../features/match-history.md) and its field/error/transaction rules. Translate related UI-AC scenarios from the [baseline catalogue](../acceptance/FRONTEND_BASELINE.md); use persisted fixtures created onsite, never copy source fixture modules. Verify desktop and 375px mobile states before parity sign-off.
