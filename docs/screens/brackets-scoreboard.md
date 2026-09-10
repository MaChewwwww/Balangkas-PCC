# Match dossier and game review

## Layout contract

Apply the shared [layout contract](LAYOUT.md). The tournament match dossier opens with a dark tournament-context masthead naming both teams, status, series score, and tabs. Overview shows a responsive four-metric strip, a primary game list where each row is `game number | game summary | open affordance`, and a distinct contextual panel. Selecting a game changes the primary surface to two lineup/stat panels (one per team) with player identity/hero and compact K/D/A, gold, and rating columns.

At extra-large desktop, the game surface is `1.2fr + minmax(340px, .8fr)`: player/stat review stays on the left and evidence upload plus result/review controls stay in the right rail. At smaller widths it stacks without moving evidence before the selected-game record. Bracket rounds remain horizontally scrollable rather than being crushed into an unreadable mobile grid.

Use public/portal/auth typography and responsive rules from [DESIGN](../DESIGN.md). Preserve captions from [CONTROLS](CONTROLS.md); [ROUTES](ROUTES.md) identifies each approved page assembly.

## Fields and controls

Per-game screenshot, winner, kills/duration, player identity/hero/KDA/gold, review rationale.

## Actions and navigation

Attach evidence; inspect pending extraction; correct/accept or reject; record manual winner with audit; return to originating history/team/event through [the cross-feature breadcrumb contract](BREADCRUMB_CONTEXT.md).

## Permission and state behavior

Only an authorized reviewer commits tournament games. Pending OCR never advances series. The reviewer panel presents the private source evidence, detector-associated row fields, unresolved/null state, hero candidate rank and frozen-roster context; it must never render a suggested hero/identity as confirmed. Partial/unreadable or overlay-obscured values remain visibly unresolved or request a clearer screenshot. A valid image with unsupported MLBB geometry displays `Unsupported layout — manual result or clearer evidence required`, never a partial guessed scorecard. Conflicts refresh current version rather than silently overwriting.

Every async control has loading/disabled, validation error, network error with retained draft, and actual success states. Missing records show not-found rather than fallback data. Modals trap focus, close with Escape and return focus. Narrow viewports stack rails, retain content order and keep scrolling inside tables/dialogs.

## Data and acceptance

Use the [Match dossier and game review feature contract](../features/brackets-scoreboard.md) and its field/error/transaction rules. Translate related UI-AC scenarios from the [baseline catalogue](../acceptance/FRONTEND_BASELINE.md); use persisted fixtures created onsite, never copy source fixture modules. Verify desktop and 375px mobile states before parity sign-off.
