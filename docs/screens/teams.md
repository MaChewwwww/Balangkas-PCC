# Teams and current/past affiliations

## Layout and typography

Current Team list separates active/previous squads with career metrics rail. Teams directory has searchable cards and private/public badge. Detail has telemetry, lineup, match ledger and achievements.

Use public/portal/auth typography and responsive rules from [DESIGN](../DESIGN.md). Preserve captions from [CONTROLS](CONTROLS.md); source paths in [ROUTES](ROUTES.md) identify page wrappers.

## Fields and controls

Name/tag, tier, visibility, bio, banner/logo preset/upload, community, coach/manager; invitation code; directory search/filter.

## Actions and navigation

New Team opens modal in place with live preview; join via code; save settings; leave/archive; open same team dossier from roster, community or Current Team.

## Permission and state behavior

Outsider private detail is locked; authenticated directory may show restricted summary. Never reveal invite codes in cards. Preserve origin breadcrumb and active sidebar through nested links.

Every async control has loading/disabled, validation error, network error with retained draft, and actual success states. Missing records show not-found rather than fallback data. Modals trap focus, close with Escape and return focus. Narrow viewports stack rails, retain content order and keep scrolling inside tables/dialogs.

## Data and acceptance

Use the [Teams and current/past affiliations feature contract](../features/teams.md) and its field/error/transaction rules. Translate related UI-AC scenarios from the [baseline catalogue](../acceptance/FRONTEND_BASELINE.md); use persisted fixtures created onsite, never copy source fixture modules. Verify desktop and 375px mobile states before parity sign-off.
