# Scrimmage board and match room

## Layout contract

Apply the shared [layout contract](LAYOUT.md). The active board is an 8/4 desktop workspace: pinned active/matched blocks appear before general matchmaking cards in the main 8/12 region, while the sticky 4/12 rail contains search/filter, personal win/loss HUD, and Request Scrimmage CTA. A board card keeps squad identity, availability/rank/format/note data, H2H or Fresh Opponent context, and explicit challenge/detail actions; finalized records leave this board for history.

The matched room has a dedicated 11-column head-to-head masthead (`team A 5/11 | score/status divider 1/11 | team B 5/11`) followed by a 7/5 main/action layout. Main is the participant-only room/lobby/chat stream and quick-message chips; the rail holds management, evidence/result controls and related live data. On narrow screens, stack head-to-head content and place the action rail after the room; never expose lobby credentials or chat in a public summary.

Use public/portal/auth typography and responsive rules from [DESIGN](../DESIGN.md). Preserve captions from [CONTROLS](CONTROLS.md); [ROUTES](ROUTES.md) identifies each approved page assembly.

## Fields and controls

Schedule, rank range, format, description, lobby name/password; challenge squad and three acknowledgments; chat/preset chips; winner/score/MVP/evidence.

## Actions and navigation

Create/edit request modals, verify/cancel challenge, accept room, coordinate, manage host settings, submit result and move to history immediately.

## Permission and state behavior

Only participants see lobby/chat. One authorized participating leader finalizes; replay returns existing result and later differing result shows conflict. No waiting-for-second-confirmation or delayed finalization UI.

Every async control has loading/disabled, validation error, network error with retained draft, and actual success states. Missing records show not-found rather than fallback data. Modals trap focus, close with Escape and return focus. Narrow viewports stack rails, retain content order and keep scrolling inside tables/dialogs.

## Data and acceptance

Use the [Scrimmage board and match room feature contract](../features/scrimmages.md) and its field/error/transaction rules. Translate related UI-AC scenarios from the [baseline catalogue](../acceptance/FRONTEND_BASELINE.md); use persisted fixtures created onsite, never copy source fixture modules. Verify desktop and 375px mobile states before parity sign-off.
