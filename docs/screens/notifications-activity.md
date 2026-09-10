# Overview, bell and activity

## Layout contract

Apply the shared [layout contract](LAYOUT.md). Portal Overview opens with masthead/action area, four KPI cards, and a main-plus-340px command grid for hosted stages, open practice, operations launchpad, and recent activity. The metric ribbon becomes two columns at 1024px and one at 580px; the command rail stacks after the primary modules at 1024px.

The notification bell is an anchored header flyout, not a new route-sized feed. It has a labelled header with unread count and mark-all action, All/Unread tabs, vertically grouped notification rows, per-row read/dismiss controls, and an explicit empty state. Activity remains a chronological panel in the owning tournament/community/overview context. A narrow view may resize the flyout but keeps trigger, tab, row metadata, and controls reachable.

Use public/portal/auth typography and responsive rules from [DESIGN](../DESIGN.md). Preserve captions from [CONTROLS](CONTROLS.md); [ROUTES](ROUTES.md) identifies each approved page assembly.

## Fields and controls

Unread filter and notification destination.

## Actions and navigation

Open/close via pointer/Escape, mark single/all read, dismiss, navigate to destination.

## Permission and state behavior

Only own notifications; read/dismiss survives refresh. Domain activity is not deleted by dismissal. Empty unread state and loading/error fit flyout.

Every async control has loading/disabled, validation error, network error with retained draft, and actual success states. Missing records show not-found rather than fallback data. Modals trap focus, close with Escape and return focus. Narrow viewports stack rails, retain content order and keep scrolling inside tables/dialogs.

## Data and acceptance

Use the [Overview, bell and activity feature contract](../features/notifications-activity.md) and its field/error/transaction rules. Translate related UI-AC scenarios from the [baseline catalogue](../acceptance/FRONTEND_BASELINE.md); use persisted fixtures created onsite, never copy source fixture modules. Verify desktop and 375px mobile states before parity sign-off.
