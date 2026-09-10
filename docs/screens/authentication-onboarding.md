# Authentication and onboarding

## Layout and typography

Branded auth backdrop; focused login/register forms; onboarding step layout with school selector and face/wallet surfaces.

Use public/portal/auth typography and responsive rules from [DESIGN](../DESIGN.md). Preserve captions from [CONTROLS](CONTROLS.md); source paths in [ROUTES](ROUTES.md) identify page wrappers.

## Fields and controls

Email/password, OTP, real name/IGN, MLBB account ID, roles, student toggle, institution search, hero selections.

## Actions and navigation

Register/login, request/resend code, verify, next/back, save profile, liveness and wallet challenge. Keep valid tournament return context.

## Permission and state behavior

Visitor forms; authenticated account owns profile. Invalid or expired verification keeps user in the current step. Camera denial/model unavailable displays retry guidance without a verified badge.

Every async control has loading/disabled, validation error, network error with retained draft, and actual success states. Missing records show not-found rather than fallback data. Modals trap focus, close with Escape and return focus. Narrow viewports stack rails, retain content order and keep scrolling inside tables/dialogs.

## Data and acceptance

Use the [Authentication and onboarding feature contract](../features/authentication-onboarding.md) and its field/error/transaction rules. Translate related UI-AC scenarios from the [baseline catalogue](../acceptance/FRONTEND_BASELINE.md); use persisted fixtures created onsite, never copy source fixture modules. Verify desktop and 375px mobile states before parity sign-off.
