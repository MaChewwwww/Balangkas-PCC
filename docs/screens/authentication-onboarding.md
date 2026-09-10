# Authentication and onboarding

## Layout contract

Apply the shared [layout contract](LAYOUT.md). Login and registration are a true two-panel composition above 1024px: equal-width dark showcase on the left (brand, value statement, feature pillars, tournament ticker) and a centered, constrained auth-card/form area on the right. The left showcase becomes a compact top introduction at 1024px and below; its pillar grid is removed rather than duplicated above the form.

Auth forms keep the two equal tabs, visible step/progress context, inline field feedback, and related-field rows (password confirmation and short profile data) in two columns until narrow width. Role and game choices are three-across selection grids where room permits. Onboarding is a separate dark stage: sticky branded top bar, one centered white card capped at 840px, gradient progress edge, then step-specific fields. School search, biometric readiness, and wallet readiness belong to their step surfaces; they are not sidebar widgets or proof badges.

Use public/portal/auth typography and responsive rules from [DESIGN](../DESIGN.md). Preserve captions from [CONTROLS](CONTROLS.md); [ROUTES](ROUTES.md) identifies each approved page assembly.

## Fields and controls

Email/password, OTP, real name/IGN, MLBB User ID, four-digit Server / Zone ID, current competitive rank, roles, student toggle, institution search, hero selections and short description. Bind the exact field order, display labels and canonical enum mapping in [the CRUD matrix](CRUD_MATRIX.md); entering these identifiers is profile data, not provider verification.

## Actions and navigation

Register/login, request/resend code, verify, next/back, save profile, liveness and wallet challenge. Keep valid tournament return context.

## Permission and state behavior

Visitor forms; authenticated account owns profile. Invalid or expired verification keeps user in the current step. The biometric step uses frontend `@vladmandic/human` detection/alignment, zero/multiple-face rejection and the prompted blink/liveness/anti-spoof capture gate before upload, then waits for the server enrollment response; neither camera access nor browser capture is high-assurance identity proof. When the current-user projection says `DEMO_BYPASS`, show a non-authoritative demo-access notice and never a verified-identity/credential badge. Camera denial, missing reviewed Human assets/policy or unavailable model/use approval displays retry guidance without a successful biometric badge.

Every async control has loading/disabled, validation error, network error with retained draft, and actual success states. Missing records show not-found rather than fallback data. Modals trap focus, close with Escape and return focus. Narrow viewports stack rails, retain content order and keep scrolling inside tables/dialogs.

## Data and acceptance

Use the [Authentication and onboarding feature contract](../features/authentication-onboarding.md) and its field/error/transaction rules. Translate related UI-AC scenarios from the [baseline catalogue](../acceptance/FRONTEND_BASELINE.md); use persisted fixtures created onsite, never copy source fixture modules. Verify desktop and 375px mobile states before parity sign-off.
