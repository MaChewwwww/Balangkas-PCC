# Landing and public discovery

## Layout contract

Apply the shared [layout contract](LAYOUT.md). Public discovery is editorial, not portal-card based: the home hero is `1.05fr copy + 1fr shield scene`; featured tournament is `1.1fr image + 1fr copy`; and the journey has copy beside a numbered three-part step list. Text stays before artwork when those layouts collapse. Shield motion has the documented poster/focus/pause fallbacks.

Directory pages use page introduction, search/filter toolbar, compact table labels, and semantically ordered rows. Tournament rows are date, identity/status, prize, capacity, arrow; team rows are rank, shield, identity/school, tier, win rate, matches, arrow; player rows are mark, identity/verification, role, win rate, arrow. Preserve the progressive column reduction and metric reflow in the shared contract rather than replacing rows with opaque cards. Public detail pages use masthead/facts/tabs followed by a 1.3fr primary detail column and 1fr facts column; certificate detail uses its separate 1.5fr/1fr layout.

Use public/portal/auth typography and responsive rules from [DESIGN](../DESIGN.md). Preserve captions from [CONTROLS](CONTROLS.md); [ROUTES](ROUTES.md) identifies each approved page assembly.

## Fields and controls

Search and combined filters; certificate query; accessible mobile menu.

## Actions and navigation

Browse, filter/reset, open record, inspect bracket, share, join through authentication, navigate with keyboard and pause animations.

## Permission and state behavior

Only public teams/profiles. Unknown ID does not substitute fixture. Invitation-only event remains listed. Reduced-motion/WebGL failure uses poster; focus returns after menu close.

Every async control has loading/disabled, validation error, network error with retained draft, and actual success states. Missing records show not-found rather than fallback data. Modals trap focus, close with Escape and return focus. Narrow viewports stack rails, retain content order and keep scrolling inside tables/dialogs.

## Data and acceptance

Use the [Landing and public discovery feature contract](../features/public-discovery.md) and its field/error/transaction rules. Translate related UI-AC scenarios from the [baseline catalogue](../acceptance/FRONTEND_BASELINE.md); use persisted fixtures created onsite, never copy source fixture modules. Verify desktop and 375px mobile states before parity sign-off.
