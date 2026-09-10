# Career portfolio and player dossiers

## Layout and typography

Passport gradient masthead; Passport/Analytics/Credentials/History tabs; two-column workspace with right-side search, credential-type filters, HUD and arena CTA. Public player pages use editorial shell.

Use public/portal/auth typography and responsive rules from [DESIGN](../DESIGN.md). Preserve captions from [CONTROLS](CONTROLS.md); source paths in [ROUTES](ROUTES.md) identify page wrappers.

## Fields and controls

IGN, real name, biography, visibility, institution; wallet entry; credential search/type; match search.

## Actions and navigation

Save dossier; face verification; signed wallet linking; filter credentials/matches; open public certificate and contextual team/event dossiers.

## Permission and state behavior

Own profile edits only; public reader sees explicit public projection. Keep pending/failed verification in same surface. No hardcoded verified status or nonzero fallback metrics.

Every async control has loading/disabled, validation error, network error with retained draft, and actual success states. Missing records show not-found rather than fallback data. Modals trap focus, close with Escape and return focus. Narrow viewports stack rails, retain content order and keep scrolling inside tables/dialogs.

## Data and acceptance

Use the [Career portfolio and player dossiers feature contract](../features/identity-portfolio.md) and its field/error/transaction rules. Translate related UI-AC scenarios from the [baseline catalogue](../acceptance/FRONTEND_BASELINE.md); use persisted fixtures created onsite, never copy source fixture modules. Verify desktop and 375px mobile states before parity sign-off.
