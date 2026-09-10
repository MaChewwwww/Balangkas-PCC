# Landing and public discovery

## Layout and typography

Final editorial landing/about, tournament article/featured sections, directories and detail pages. Preserve images, spacing, Manrope hierarchy and shield scene specification.

Use public/portal/auth typography and responsive rules from [DESIGN](../DESIGN.md). Preserve captions from [CONTROLS](CONTROLS.md); source paths in [ROUTES](ROUTES.md) identify page wrappers.

## Fields and controls

Search and combined filters; certificate query; accessible mobile menu.

## Actions and navigation

Browse, filter/reset, open record, inspect bracket, share, join through authentication, navigate with keyboard and pause animations.

## Permission and state behavior

Only public teams/profiles. Unknown ID does not substitute fixture. Invitation-only event remains listed. Reduced-motion/WebGL failure uses poster; focus returns after menu close.

Every async control has loading/disabled, validation error, network error with retained draft, and actual success states. Missing records show not-found rather than fallback data. Modals trap focus, close with Escape and return focus. Narrow viewports stack rails, retain content order and keep scrolling inside tables/dialogs.

## Data and acceptance

Use the [Landing and public discovery feature contract](../features/public-discovery.md) and its field/error/transaction rules. Translate related UI-AC scenarios from the [baseline catalogue](../acceptance/FRONTEND_BASELINE.md); use persisted fixtures created onsite, never copy source fixture modules. Verify desktop and 375px mobile states before parity sign-off.
