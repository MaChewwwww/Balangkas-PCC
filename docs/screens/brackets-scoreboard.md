# Match dossier and game review

## Layout and typography

Existing game-by-game match dossier with team names, series score, individual game selector, screenshot evidence and player-stat presentation. Bracket match click opens linked detail.

Use public/portal/auth typography and responsive rules from [DESIGN](../DESIGN.md). Preserve captions from [CONTROLS](CONTROLS.md); source paths in [ROUTES](ROUTES.md) identify page wrappers.

## Fields and controls

Per-game screenshot, winner, kills/duration, player identity/hero/KDA/gold, review rationale.

## Actions and navigation

Attach evidence; inspect pending extraction; correct/accept or reject; record manual winner with audit; return to originating history/team/event.

## Permission and state behavior

Only authorized reviewer commits tournament games. Pending OCR never advances series. Partial/unreadable values remain visibly unresolved. Conflicts refresh current version rather than silently overwriting.

Every async control has loading/disabled, validation error, network error with retained draft, and actual success states. Missing records show not-found rather than fallback data. Modals trap focus, close with Escape and return focus. Narrow viewports stack rails, retain content order and keep scrolling inside tables/dialogs.

## Data and acceptance

Use the [Match dossier and game review feature contract](../features/brackets-scoreboard.md) and its field/error/transaction rules. Translate related UI-AC scenarios from the [baseline catalogue](../acceptance/FRONTEND_BASELINE.md); use persisted fixtures created onsite, never copy source fixture modules. Verify desktop and 375px mobile states before parity sign-off.
