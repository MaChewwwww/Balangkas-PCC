# Onsite frontend structure

**Status: preparation documentation and empty-directory skeleton only.** `frontend/` intentionally contains no application source before the onsite development gate opens. This is the target ownership map for the one connected Next.js application; it is not permission to generate or copy its files now.

## Target tree

```text
frontend/
  public/                         # populated onsite from the approved assets package
  src/
    app/                          # Next.js App Router entry and route layouts only
      (public)/                   # /, /about, public directories and public detail routes
      (auth)/                     # /login and /register
      onboarding/                 # /onboarding
      portal/                     # authenticated routes and nested portal route leaves
    components/
      base/                       # selected generated shadcn/Base UI primitives only
      shared/                     # PCC-shared presentational/accessibility components
      public/                     # public-shell components shared across public routes
      auth/                       # auth-shell and reusable auth/onboarding presentation
      portal/                     # portal shell, navigation and cross-domain workspace presentation
    features/                     # one module for each documented product domain
      authentication/
      identity/
      teams/
      communities/
      tournaments/
      matches/
      scrimmages/
      match-history/
      rewards/
      certificates/
      notifications/
      public-discovery/
    lib/                          # narrow HTTP/session, formatting, accessibility and motion helpers
    styles/                       # PCC token/global/style-layer files, not copied external CSS
    test/                         # shared Vitest/testing-library support only
```

The empty `public`, `app`, `components`, `features`, `lib`, `styles` and `test` directories exist now only to make this plan visible. No route page, component, configuration, test, fixture or generated file exists until explicit onsite authorization.

## Route and shell ownership

`src/app` is deliberately thin. It chooses the proper route shell, parses route/query context and delegates to a feature container; it does not contain feature data shaping, mutations or generic dashboard logic.

| Area | Owns | Must not own |
| --- | --- | --- |
| `(public)` route group | Public layout/shell, home, about, public discovery/detail and certificate route leaves. | A second client, mock discovery data, or private portal projections. |
| `(auth)` and `onboarding` | Auth frame and the documented login/registration/onboarding route leaves. | OTP, biometric, wallet or session success invented in the browser. |
| `portal` | `PortalShell`, authenticated route layout, [breadcrumb context](screens/BREADCRUMB_CONTEXT.md), mobile navigation and every portal path in [ROUTES](screens/ROUTES.md). | A submitted actor ID, permission decision, hidden-resource fetch or URL-supplied breadcrumb label. |
| Route leaf | One route composition from [ROUTE_CONTRACTS](screens/ROUTE_CONTRACTS.md); thin route-specific query/parameter parsing and one normalized navigation-context request. | A duplicate component implementation when an owned feature assembly already exists, or a context-only parent-resource fetch. |

Do not add `src/app/api` routes for product APIs: FastAPI is the sole `/api/v1` contract and is routed same-origin by Nginx. Do not recreate the old frontend's local mock store, source fixture module, random IDs, browser-side authorization, or provider-success simulation.

## Component and feature boundaries

| Location | Ownership rule |
| --- | --- |
| `components/base` | Only the selected, version-pinned shadcn/Base UI primitives in [the component catalogue](screens/COMPONENT_CATALOG.md). Generated primitive files are editable accessibility foundations, not PCC feature components. Do not bulk-install the registry. |
| `components/shared` | `AsyncRegion`, `MetricRibbon`, `ResponsiveDataTable`, form field framing, feedback, status, search/filter and other components whose semantic contract is identical across more than one feature. It owns no resource-specific API calls. |
| `components/public`, `components/auth`, `components/portal` | Shell-level and route-family presentation shared by that surface: for example `PublicShell`, `HeroShield`, `AuthShell`, `PortalShell`, navigation and notification flyout. They receive already-authorized projections and callbacks. |
| `features/<domain>` | Domain route containers, API-to-view-model mapping, domain assemblies and command state for exactly one requirement family. `features/identity` owns the version-pinned browser `@vladmandic/human` capture pipeline: detection, exactly-one-face gate, landmark alignment, bounded crop creation, server-prompted blink sequence and configured Human liveness/anti-spoof checks. It must present the browser result as a capture gate, never as cryptographic/server proof; only the API response may advance the identity flow. A feature may import base/shared/surface components, but not reach into another feature's internals. Cross-domain values arrive through a documented API projection or a narrow shared type. |
| `lib` | Stateless or infrastructure helpers only: same-origin HTTP/CSRF handling, response/error normalization, formatting, accessibility and motion utilities. It cannot hold canonical business state, a fake current user, cached provider success, or domain-specific policy. |

Feature names map one-to-one to the requirement families in [traceability](TRACEABILITY.md). A domain assembly must use the route, CRUD, visualization and component contracts; it may not infer table columns or form fields from arbitrary object keys.

## API, state and asset boundary

The FastAPI contract in [API_SPEC](API_SPEC.md) is the only product network boundary. Feature containers pass the session cookie/CSRF and idempotency/version values required by that contract, normalize its permitted projection and preserve a draft only for the current interaction. For a portal cross-feature route, they additionally pass only the allowlisted normalized context and render only the returned server-safe `navigation_context` projection defined in [the breadcrumb contract](screens/BREADCRUMB_CONTEXT.md). Server data remains server-authoritative: it is refetched/reconciled after commands and never becomes a durable browser-only substitute.

The approved files under `assets/public` remain the preparation-phase asset package. After activation, populate `frontend/public` byte-preservingly from those approved target assets, retain font/portrait attribution, and verify every hash against [ASSET_MANIFEST](ASSET_MANIFEST.md). Do not hotlink, import or copy files from external material. `HeroShield` is recreated from its [procedural scene contract](screens/COMPONENT_CATALOG.md#heroshield-scene-fidelity), not from a missing model file.

## Styles, tests and review evidence

Create the PCC global/token/style layer under `src/styles` after activation from [DESIGN](DESIGN.md), [tokens](screens/TOKENS.md) and [layout](screens/LAYOUT.md). Do not bring over external CSS or let default shadcn styles replace the documented public/portal composition.

Put reusable Vitest/testing-library setup support in `src/test`; put a focused test beside the changed unit or feature when that most clearly protects behavior. Do not create an automatic Playwright/Cypress browser-E2E or visual-regression tree for this hackathon. Record real route/state/width/keyboard/motion checks in [the manual UI report](screens/MANUAL_UI_REPORT.md).

## Onsite creation order

1. Record the explicit activation in `DECISIONS.md`, then establish the root App Router entry, the three route shells, local asset materialization and global tokens.
2. Initialize the selective shadcn/Base UI layer in `components/base`; build shared PCC primitives before page-specific assemblies.
3. Create the route leaves listed in [ROUTES](screens/ROUTES.md), one feature module at a time, binding each to the authoritative API and data contracts. Before enabling the identity capture UI, approve and pin its separate detector/landmark browser assets; the W600K-R50 server-model exception does not cover them.
4. Add focused unit/API/integration/Vitest coverage alongside changed behavior and complete a manual UI report for the finished work package.

No source skeleton beyond the listed empty directories should be created as preparation. This keeps activation fast without falsely claiming a working frontend.
