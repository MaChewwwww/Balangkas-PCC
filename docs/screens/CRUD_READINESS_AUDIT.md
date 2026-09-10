# CRUD screen readiness audit

**Audited 2026-09-11. Status: prepared, unimplemented.** This is a static specification-readiness audit, not a claim that a PCC screen, API, database, payment, provider, or automated browser test exists.

## Coverage

| Check | Result |
| --- | --- |
| Route inventory | 41 documented routes, 41 rows in [ROUTES](ROUTES.md), and 41 preservation IDs in [ROUTE_CONTRACTS](ROUTE_CONTRACTS.md). |
| Interaction baseline | 123 UI expectations remain recorded in [the frontend baseline](../acceptance/FRONTEND_BASELINE.md); they are visual/interaction evidence, not PCC implementation proof. |
| CRUD workspace coverage | Team, community, tournament, scrimmage and match-history workspaces have documented component, layout, field and lifecycle expectations. |

## Verified reconstruction coverage

| Domain | Documented composition | PCC authority retained |
| --- | --- | --- |
| Teams and affiliations | 8/4 directory rail; private-card masking; visual identity/preset preview; name/tag, division/accessibility, conditional HEI, community and description form sequence; 5/12 preview + 7/12 management split; five-lane roster before reserves; active and prior affiliation separation. | Session-derived staff and membership commands, one-time invite disclosure, historical memberships, resource versions, staged assets and actual calculated metrics. |
| Communities | Full masthead and 2/3 + 1/3 command workspace; exact tab order and captions: Community Feed, Members List, Team Rosters, Tournament History; cover/preset preview and conditional HEI form sequence; separate asynchronous feed/member/team/tournament regions. | Canonical institution IDs, member/owner/moderator policy, server aggregate reactions and analytics, soft deletion, archive lifecycle, staged assets and protected private projections. |
| Tournaments | Editorial carousel plus Feed/Grid/Table alternatives; documented 7/12 operations + 5/12 game/host/pubmat/live-preview form; command-center tabs Overview, Teams, Bracket, Matches and Rewards; wide 320px rail; nested tournament team and match dossiers retain context. | Server-derived creator/community eligibility, exact money rails, versioned lifecycle/seed/staff commands, registration snapshots, payment/chain evidence and reviewer-only game finalization. |
| Scrimmages, matches and history | 8/4 board/history workspaces; 5:1:5 scrimmage masthead and 7/5 room; tournament match two-panel detail/evidence rail; retained origin breadcrumbs, ledger/history expansion and right-rail metrics. | Participant-only secrets/chat, immediate atomic first-result finalization, accepted-game-only statistics, private OCR evidence/review and canonical history. |

## Preparation refinements resolved in the contract

| Observation | PCC-ready instruction |
| --- | --- |
| The community's fourth tab is **Tournament History**. | Its exact caption and order are now used in [community screens](communities.md), [route contracts](ROUTE_CONTRACTS.md), [layout](LAYOUT.md), [components](COMPONENT_CATALOG.md) and [visualization semantics](VISUALIZATIONS.md). It remains the competition/tournament-history data projection. |
| Team creation displays 50/4/300 limits, while canonical validation allows 100/10/1000. | The on-site UI preserves the approved visible limits; the server still enforces the documented broader contract. Neither layer is a client-side bypass or a source of invented success. |
| Recruiting control | `is_recruiting` is required in the established division/accessibility form group; an empty lane is explicitly not used as a proxy. |
| Tournament deadline, eligibility and requirements controls | These controls have fixed placement in the existing 7/12 operations column, with conditional institution and prompt fields, not a separate invented settings surface. |
| Cross-feature navigation | [The breadcrumb-context contract](BREADCRUMB_CONTEXT.md) preserves the complete valid path and active sidebar while requiring a relation-proven, permission-filtered server projection; query values cannot disclose labels or grant access. |
| Local presentation state and provider/chain simulation | PCC preserves visual hierarchy only. It uses server projections, staged assets, session authorization, idempotency/version feedback, evidence-backed state and visible pending/failed/unavailable outcomes. |

## Onsite use

For a CRUD route, read [the route contract](ROUTE_CONTRACTS.md), the relevant family file, [the binding matrix](CRUD_MATRIX.md), [layout](LAYOUT.md), [visualization semantics](VISUALIZATIONS.md), the feature/API/data contracts, and then record the completed manual review in [MANUAL_UI_REPORT](MANUAL_UI_REPORT.md). The repository is self-contained for the event. If one unrecorded visual nuance genuinely remains, a developer may explicitly supply the matching screenshot to the working agent as the [onsite blueprint](ON_SITE_BLUEPRINT.md) permits.
