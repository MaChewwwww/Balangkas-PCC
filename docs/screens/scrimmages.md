# Scrimmage board and match room

## Layout and typography

Active matchmaking board without settled records; pinned own/ongoing blocks, H2H/Fresh Opponent cards and performance HUD. Detail uses dedicated head-to-head match room with lobby and chat.

Use public/portal/auth typography and responsive rules from [DESIGN](../DESIGN.md). Preserve captions from [CONTROLS](CONTROLS.md); source paths in [ROUTES](ROUTES.md) identify page wrappers.

## Fields and controls

Schedule, rank range, format, description, lobby name/password; challenge squad and three acknowledgments; chat/preset chips; winner/score/MVP/evidence.

## Actions and navigation

Create/edit request modals, verify/cancel challenge, accept room, coordinate, manage host settings, submit result and move to history immediately.

## Permission and state behavior

Only participants see lobby/chat. One authorized participating leader finalizes; replay returns existing result and later differing result shows conflict. No waiting-for-second-confirmation or delayed finalization UI.

Every async control has loading/disabled, validation error, network error with retained draft, and actual success states. Missing records show not-found rather than fallback data. Modals trap focus, close with Escape and return focus. Narrow viewports stack rails, retain content order and keep scrolling inside tables/dialogs.

## Data and acceptance

Use the [Scrimmage board and match room feature contract](../features/scrimmages.md) and its field/error/transaction rules. Translate related UI-AC scenarios from the [baseline catalogue](../acceptance/FRONTEND_BASELINE.md); use persisted fixtures created onsite, never copy source fixture modules. Verify desktop and 375px mobile states before parity sign-off.
