# Overview, bell and activity

## Layout and typography

Portal overview summaries use committed data. Bell trigger with unread badge opens flyout and all/unread tabs; event activity stays inside owning context.

Use public/portal/auth typography and responsive rules from [DESIGN](../DESIGN.md). Preserve captions from [CONTROLS](CONTROLS.md); source paths in [ROUTES](ROUTES.md) identify page wrappers.

## Fields and controls

Unread filter and notification destination.

## Actions and navigation

Open/close via pointer/Escape, mark single/all read, dismiss, navigate to destination.

## Permission and state behavior

Only own notifications; read/dismiss survives refresh. Domain activity is not deleted by dismissal. Empty unread state and loading/error fit flyout.

Every async control has loading/disabled, validation error, network error with retained draft, and actual success states. Missing records show not-found rather than fallback data. Modals trap focus, close with Escape and return focus. Narrow viewports stack rails, retain content order and keep scrolling inside tables/dialogs.

## Data and acceptance

Use the [Overview, bell and activity feature contract](../features/notifications-activity.md) and its field/error/transaction rules. Translate related UI-AC scenarios from the [baseline catalogue](../acceptance/FRONTEND_BASELINE.md); use persisted fixtures created onsite, never copy source fixture modules. Verify desktop and 375px mobile states before parity sign-off.
