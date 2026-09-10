# Tournament discovery and command center

## Layout and typography

Feed/Grid/Table directory, carousel and image showcase. Create/manage forms with pubmat preview. Detail command center has Overview/Teams/Bracket/Matches/Rewards tabs. Team and match dossiers preserve tournament hierarchy.

Use public/portal/auth typography and responsive rules from [DESIGN](../DESIGN.md). Preserve captions from [CONTROLS](CONTROLS.md); source paths in [ROUTES](ROUTES.md) identify page wrappers.

## Fields and controls

Event name/game/host, dates, capacity, category, bracket type, best-of/finals, third place, grand finals, Swiss rounds, join mode/code, fee and prize controls, banner/editorial fields.

## Actions and navigation

Search/filter/react/share, create/edit, register/withdraw, assign staff, generate/shuffle bracket, start/end/archive, announcements, review games, allocate prizes and issue certificates.

## Permission and state behavior

Creator controls sensitive settings; format/capacity/fees/eligibility/staff locked after start. End disabled while required matches unfinished. Reward actions locked before completion. Invitation-only remains publicly discoverable.

Every async control has loading/disabled, validation error, network error with retained draft, and actual success states. Missing records show not-found rather than fallback data. Modals trap focus, close with Escape and return focus. Narrow viewports stack rails, retain content order and keep scrolling inside tables/dialogs.

## Data and acceptance

Use the [Tournament discovery and command center feature contract](../features/tournaments.md) and its field/error/transaction rules. Translate related UI-AC scenarios from the [baseline catalogue](../acceptance/FRONTEND_BASELINE.md); use persisted fixtures created onsite, never copy source fixture modules. Verify desktop and 375px mobile states before parity sign-off.
