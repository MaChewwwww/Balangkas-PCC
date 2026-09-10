# Onsite UI reconstruction blueprint

**Status: preparation documentation only.** This is the self-contained hand-off for rebuilding the approved interface at the hackathon. It deliberately contains no copied external implementation, component code, fixture values or dependency on a separately checked-out repository. All approved assets are already accounted for locally in [the asset manifest](../ASSET_MANIFEST.md).

If a written contract cannot settle a visual nuance during development, a developer may supply the relevant prototype screenshot to the working agent for that one decision. Treat it as an ad hoc comparison aid, reconcile it with the PCC contracts, and do not create or maintain a screenshot/visual-reference atlas.

## Read order

1. Read [PREPARATION](../PREPARATION.md), [DECISIONS](../DECISIONS.md), [architecture](../ARCHITECTURE.md), [requirements](../FRS_NFRS.md), and this file. Do not start application code until an explicit onsite authorization records that the preparation gate is open.
2. For the selected route, read [the exact route contract](ROUTE_CONTRACTS.md), [the cross-feature breadcrumb-context contract](BREADCRUMB_CONTEXT.md), its screen family in [the catalogue](README.md), [layout](LAYOUT.md), [controls](CONTROLS.md), and [tokens](TOKENS.md).
3. Bind fields and commands only from [the CRUD matrix](CRUD_MATRIX.md), the relevant feature contract, [data dictionary](../DATABASE.md), and [API contract](../API_SPEC.md).
4. Build every metric, table and status with [visualization semantics](VISUALIZATIONS.md); do not turn unavailable or unverified data into sample numbers or success states.
5. Compose the screen from [the component catalogue](COMPONENT_CATALOG.md) within [the frontend ownership structure](../FRONTEND_STRUCTURE.md), then use [asset readiness](ASSET_READINESS.md) and [the acceptance baseline](../acceptance/FRONTEND_BASELINE.md) for verification.

This order resolves conflicts in the normal authority order: accepted PCC decisions and feature/data/API contracts determine truth and authorization; the audited reference determines presentation where it does not conflict. The reference’s mock identity, wallet, biometric, escrow and credential outcomes are never product behavior.

## Package boundaries

| Package | Answers | Must not answer |
| --- | --- | --- |
| [ROUTE_CONTRACTS](ROUTE_CONTRACTS.md) | Which ordered regions, desktop layout, responsive reduction and route context are required? | Which client can mutate a resource or what a metric means. |
| [BREADCRUMB_CONTEXT](BREADCRUMB_CONTEXT.md) | Which valid ancestor path remains across feature boundaries, when its sidebar root stays active, and how unsafe context falls back. | Resource authorization, a parent-data fetch or a URL-provided label. |
| [CRUD_MATRIX](CRUD_MATRIX.md) | Which visible field maps to which canonical field, command, permission and error state? | CSS or unverified local-data behavior. |
| [VISUALIZATIONS](VISUALIZATIONS.md) | Which values are derived, their numerator/denominator, ordering, formats and empty states? | A fabricated fallback or a new chart design. |
| [COMPONENT_CATALOG](COMPONENT_CATALOG.md) | Which small reusable components compose the presentation and where their boundaries are? | Server policy, identity inference or hidden side effects. |
| [ASSET_READINESS](ASSET_READINESS.md) | Which locally committed approved assets can be used and their status? | Permission to treat illustrative evidence as user evidence. |

## Implementation sequence once authorized

1. Establish the public, authentication and portal shells; implement tokens, typography, breakpoints, focus behavior and reduced-motion fallbacks before feature pages.
2. Initialize the version-pinned, selective shadcn/ui Base UI primitive layer from [the component catalogue](COMPONENT_CATALOG.md), then build the shared PCC presentational primitives and `AsyncRegion` state contract. Do not install the full registry or put resource fetching, acting-user IDs, business rules or provider calls inside those primitives.
3. Implement each feature vertically: migration/seed, server policy, API projection and command, route composition, then acceptance tests. Use the feature order in [traceability](../TRACEABILITY.md).
4. Rebuild the 41 routes, including empty, loading, denied, validation, pending and error states. The compatibility route `/portal/[section]` maps only to the listed portal sections.
5. Compare at 375, 600, 768, 1024 and 1440 pixels. Validate table overflow is contained, rails move rather than disappear, dialogs return focus, and the viewer sees only server-permitted data.

## Non-negotiable reconstruction rules

- Reproduce the described ordering and layout; do not replace information-dense desktop workspaces with generic card grids or generic two-column forms.
- Keep the public and portal surface systems distinct. Desktop portal layouts often have a primary workspace plus a dedicated secondary rail; the rail’s ownership is recorded in [LAYOUT](LAYOUT.md).
- A route component owns route parameters and composition only. A feature container owns query/mutation coordination. Presentational components receive a typed view model and callbacks, not an unrestricted store.
- Preserve a valid normalized cross-feature breadcrumb trail and its source sidebar family. The URL requests presentation context only; use the server-filtered context projection, never a URL label/ID, to display or authorize an ancestor.
- Use shadcn/ui selectively for the documented accessible base primitives. PCC custom components own the portal/sidebar, tables, metrics, cards, charts and all visual styling; default shadcn blocks cannot replace the approved design.
- Session identity is server-owned. Never accept an acting user, owner, captain, reviewer, issuer, biometric result, wallet state, payment outcome or scrimmage finalization from a URL, form field, local storage or client fixture.
- Every mutation uses the API’s version and idempotency rules. Preserve form values on a validation/network failure and visibly retain pending/failed states.
- Use local approved assets by target path. Do not copy an external file at the event, hotlink arbitrary artwork, or display a reference match screenshot as real PCC evidence.
- A metric has an explicit data source and an unavailable state. `0`, `—`, a skeleton and an error panel have different meanings.

## Completion record per route

Before marking an implementation route complete, record the following in the onsite work package or review:

- route and source-preservation ID from [ROUTE_CONTRACTS](ROUTE_CONTRACTS.md);
- feature/data/API contracts and query/command projection used;
- desktop and mobile layout comparison at the required widths;
- all loaded, empty, error, denied, pending and successful states that apply;
- field validation, session/role protection, stale-version and idempotency evidence for every enabled mutation;
- metric provenance and a negative check that no fixture/sample/provider success is rendered as current PCC data;
- keyboard, focus-return and reduced-motion evidence in the developer's [manual UI report](MANUAL_UI_REPORT.md) (route/state/action/width/result); no automated browser E2E or visual-regression suite is required for the hackathon.

This record is evidence of implementation only after application work is authorized. This document does not itself unlock application coding.
