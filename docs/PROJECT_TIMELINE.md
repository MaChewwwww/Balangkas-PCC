# Onsite work: priority-driven delivery cycles

User-confirmed planning window: September 18, 2026 18:00 through September 20,
2026 18:00, local event time. No application feature is complete beforehand.
This plan sets delivery order and ownership rather than promising that every
work package fits a fixed number of hours. Every required feature remains in
scope; a missed checkpoint is reported with its remaining work.

## Release order

| Order | Objective | Scope and exit condition |
| --- | --- | --- |
| 1 | Release the preparation gate | Confirm preparation checks, approved assets/reference data, environment templates, specifications, ownership, and the explicit onsite activation record. No application implementation is released by this gate. |
| 2 | Establish CI/CD | After onsite authorization, create and exercise the specified pull-request CI, image-build, and manual staging-deploy flow in [CI/CD readiness](CI_CD.md). CI must be usable before feature work is called done; it does not deploy a feature automatically. |
| 3 | Scaffold the complete application shape | Recreate the complete frontend layout, route shells, design tokens, and shared interaction patterns. Create the backend's thin module, transport, and configuration pattern only; do not overbuild feature domain logic that Robert will implement as full-stack slices. |

## Delivery cycles

Work begins after the three release-order gates. Parallel work is intentional,
but an integration never invents a provider success, bypasses server ownership,
or substitutes fixture data for an accepted feature result.

| Cycle | John | Robert | Design | QA / release checkpoint |
| --- | --- | --- | --- | --- |
| 1 | Build the Solana backend and infrastructure foundations, retaining the Devnet-only signer, evidence, and unavailable-state gates. | Deliver the first full-stack slices: Authentication and Community. | Aliah improves the landing page while the first feature slices are assembled. | Charlene tests each completed slice as it lands, using CI plus its focused acceptance/manual UI evidence before the slice is handed off. |
| 2 | Build the MLBB match-extraction backend with its bounded local review flow. | Move to the Teams feature as the next full-stack slice. | Aya fine-tunes the design of Robert's completed Cycle 1 work. | Charlene validates the Team and completed extraction-facing states as they become testable; incomplete provider/model behavior stays visibly unavailable or pending. |
| 3 and onward | Take the next dependency-ordered backend/infrastructure capability. | Take the next dependency-ordered full-stack feature. | Aya refines the prior completed feature cycle; Aliah continues landing-page ownership when that work is active. | Charlene tests every newly completed feature before the next feature is considered ready for integration or staging release. |

Robert's subsequent slices proceed through the remaining required modules in
dependency order, including tournament operations, match/history, scrimmages,
notifications, rewards, certificates, public discovery, and identity/wallet
work. John supplies the corresponding backend or infrastructure capability in
parallel. The exact next slice is chosen only after the previous slice's
contracts, migrations, focused tests, and UI handoff are stable.

## Auth fixture now; tournament simulation later

The present fixture work is intentionally auth-only. The ignored
`.env.accounts` catalog defines 24 local synthetic accounts: 20 players and
four organizers. Its future development-only auth seed is repeat-safe and
creates no profile, team, community, tournament, match, wallet, biometric,
payment, provider, or certificate data. See [configuration](CONFIGURATION.md#local-auth-fixture-catalog) and [authentication](features/authentication-onboarding.md).

The comprehensive idempotent tournament simulator is a final-phase task. It
starts only after the Team, Tournament, and Match capabilities are implemented
and tested, then creates the four-team scenario with stable natural keys and
full rerun/collision coverage. It is not introduced during auth work and must
not become a substitute for live provider or chain evidence.

## Face recognition and completion rules

Face recognition is deliberately last. The team first stabilizes ordinary
authentication, profile, team, tournament, and match testing so biometric
dependencies cannot block the main feature flow. Its final implementation must
still satisfy the recorded browser capture, local model, privacy, exact
duplicate-decision, unavailable-state, and acceptance requirements; it is not
optional or replaced with a success mock.

A completed slice has persistence/migrations where needed, session-bound
authorization, focused unit/API/integration coverage, the required manual UI
report, CI evidence, truthful pending/error states, and updated readiness
documentation. Charlene's verification accompanies each feature completion,
not a single testing pass at the end.
