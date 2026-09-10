# Career portfolio and player dossiers

## Layout contract

Apply the shared [layout contract](LAYOUT.md). The owned portfolio is an 8/4 desktop workspace (9/3 on the very wide approved layout): gradient athlete-passport masthead, Passport/Analytics/Credentials/History tabs, primary record area on the left, and a sticky right rail for search, credential type filter, performance HUD, and arena CTA. Passport detail pairs personal-information and wallet/readiness cards; credentials use compact responsive card grids; history/search empty states stay in the primary area.

Player and team dossiers are not the same as the owned portfolio: they use an identity masthead, four-cell telemetry ribbon, then a three-column layout with two content columns for match ledger/awards/lineup and one auxiliary column for affiliation, wallet or tactical facts. The public player page stays in the editorial detail shell and its facts column, rather than inheriting portal cards.

Use public/portal/auth typography and responsive rules from [DESIGN](../DESIGN.md). Preserve captions from [CONTROLS](CONTROLS.md); [ROUTES](ROUTES.md) identifies each approved page assembly.

## Fields and controls

IGN, real name, biography, visibility, institution; **Solana Devnet wallet** entry; credential search/type; match search.

## Actions and navigation

Save dossier; face verification; signed wallet linking; filter credentials/matches; open public certificate and contextual team/event dossiers.

## Permission and state behavior

Own profile edits only; public reader sees explicit public projection. The wallet modal presents only Solana Devnet and says connected/signed only after the returned server projection, never after a browser-provider callback. The capture surface uses `@vladmandic/human` to detect a single face, reject zero/multiple faces, align the crop and complete the prompted blink/liveness/anti-spoof gate before upload; that client status is a capture gate, not cryptographic or server-verifiable proof. Keep capture-ready, liveness-required, pending and failed verification in the same surface. A missing/hash-mismatched documented face model, use approval, reviewed Human asset or capture policy is an unavailable state, never a successful fallback. No hardcoded verified status or nonzero fallback metrics.

Every async control has loading/disabled, validation error, network error with retained draft, and actual success states. Missing records show not-found rather than fallback data. Modals trap focus, close with Escape and return focus. Narrow viewports stack rails, retain content order and keep scrolling inside tables/dialogs.

## Data and acceptance

Use the [Career portfolio and player dossiers feature contract](../features/identity-portfolio.md) and its field/error/transaction rules. Translate related UI-AC scenarios from the [baseline catalogue](../acceptance/FRONTEND_BASELINE.md); use persisted fixtures created onsite, never copy source fixture modules. Verify desktop and 375px mobile states before parity sign-off.
