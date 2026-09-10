# Modular component composition catalogue

**Status: documentation-only design plan.** These are the custom component boundaries to build after explicit onsite development authorization. They describe responsibilities and inputs so the frontend can be modular without importing or reproducing external implementation. Names are target implementation names, not existing source files. The selective primitive policy below implements [ADR-015](../DECISIONS.md).

## Composition and ownership

```text
Route entry
  -> route context + shell
    -> feature container (server projection, command state, permission flags)
      -> domain workspace/dossier
        -> shared data, form and feedback components
```

Route entries read route parameters and select a listed composition. Feature containers translate only permission-filtered API projections into view models and retain idempotency/version/error state. Presentational and primitive components render supplied values and invoke supplied callbacks; they do not choose an actor, fetch a hidden resource, calculate authority, persist a record, or decide a provider result.

## Selective shadcn/ui base layer

At onsite activation, initialize and lock one shadcn/ui configuration before building PCC components. **Base UI is the recommended primitive provider for this new build.** Record the selected shadcn/ui version, primitive provider and package-lock change in the first frontend work package. Do not mix Base UI and Radix implementations within a primitive family; an exception needs a recorded reason and a focused behavior test.

shadcn/ui supplies editable local primitive code and accessibility behavior. It does **not** supply the PCC visual system. Do not bulk-install its whole registry. Add a primitive only when a route/component contract below needs its behavior, then apply PCC tokens and preserve the approved geometry, hierarchy and responsive behavior. A generated primitive belongs in the local base layer; a PCC composition belongs outside it as a custom component.

| Add as the initial base layer | Add only when a documented route needs it | Do not use as a visual shortcut |
| --- | --- | --- |
| Button; Field/Label; Input; Textarea; Select or Combobox; Checkbox; Radio Group; Switch; Input OTP | Calendar/Date Picker for scheduled tournament or scrimmage fields; Popover for a documented anchored control; Avatar only for an actual profile image projection; Resizable only for an approved operator workspace need | Default Card, Sidebar, Data Table, Chart, Carousel, marketing blocks or dashboard templates. PCC owns `PortalShell`, `ResponsiveDataTable`, `MetricRibbon`, charts, cards and all editorial/workspace layouts. |
| Dialog; Alert Dialog; Sheet/Drawer; Dropdown Menu; Tooltip; Tabs; Collapsible; Scroll Area; Table; Skeleton; toast feedback | Command palette, Context Menu, Hover Card, Pagination, Slider, Toggle/Toggle Group only when a route contract calls for that interaction | Default colors, radii, spacing, table columns, empty states, hero sections or generic two-column forms. These must follow [tokens](TOKENS.md), [layout](LAYOUT.md) and route contracts. |

`Dialog`, `Alert Dialog`, `Sheet/Drawer`, `Dropdown Menu`, `Tooltip`, `Tabs`, `Collapsible`, `Scroll Area`, `Table`, `Skeleton` and field primitives are the expected accessibility/focus foundation for the listed PCC components. Wrap or compose them only when that preserves their keyboard, focus-return, Escape and ARIA behavior. `MutationDialog`, `ConfirmAction`, `PortalShell`, `ResponsiveDataTable` and `StatusBadge` remain PCC-owned components with route-specific view models; they are not renamed shadcn defaults.

Before adding any additional shadcn item, the implementer must identify its consuming custom component, the route(s), the interaction it provides, whether an existing base primitive already covers it, and its keyboard/focus acceptance check. This keeps the dependency surface small and prevents generic UI from eroding the approved prototype.

## Foundations

| Component | Responsibility and variants | Required inputs / output boundary |
| --- | --- | --- |
| `PublicShell` | Editorial public navigation, footer, light/dark section surface and mobile navigation. | Page title/context, navigation state, children; no portal/session-private projection. |
| `AuthShell` | Auth backdrop, compact form frame, back link and progress feedback. Supports login, registration and onboarding contexts. | Title, step, children, truthful integration state; no automatic verification success. |
| `PortalShell` | Dark desktop sidebar, collapsed navigation, mobile drawer, header/breadcrumb and notifications trigger. Keeps the valid cross-feature origin's sidebar family active. | Server-filtered navigation permissions, normalized server-safe breadcrumb context, notification count, children; it never infers a context label or permission from the URL. |
| `RouteContext` | Resolves only documented route IDs and the [allowlisted cross-feature breadcrumb context](BREADCRUMB_CONTEXT.md). Normalizes/forwards an existing valid chain and constructs only fixed PCC route links. | Parsed route identifiers, normalized context request and server-returned context projection; never an authorization mechanism, parent lookup or durable browser state. |
| `PageIntro` | Eyebrow, title, summary and primary action hierarchy used by public directories. | Copy, action availability, children. |
| `WorkspaceHeader` | Portal title, context actions and scope/filter summary. | Heading, scoped entity summary, actions already policy-gated. |
| `BreadcrumbTrail` | Contextual portal navigation and back affordance. Retains every valid cross-feature ancestor in order and truncates a clicked link to its preceding context. | Server-safe labels/IDs plus fixed-route URLs; omits inaccessible, unrelated, stale or cyclic ancestry. |
| `AsyncRegion` | Stable loading skeleton, empty state, retriable error, denied/unavailable and loaded content region. | Discriminated state plus retry callback; it never replaces a real zero with a sample. |
| `HeroShield` | Landing-hero dimensional shield scene with a poster-first static mode. It is a presentation-only, client-deferred WebGL enhancement; its exact visual and resilience contract is below. | Active/paused/fallback state only; it never reads product data, submits a command or delays hero copy/navigation. |

## HeroShield scene fidelity

`HeroShield` is the one custom three-dimensional visual in the public landing hero. It is **not** a missing model file: the approved reference constructs the shield procedurally. Rebuild this component onsite from the following observable contract instead of importing reference source or substituting a stock 3D model.

| Aspect | Required reconstruction |
| --- | --- |
| Render boundary | Load the WebGL scene only in a capable browser after the static poster is available; keep the page server-renderable and never hold up the hero copy, CTAs or navigation. Use the pinned `three` and `@react-three/fiber` dependencies. `@react-three/drei` remains available but is not required for this scene. |
| Static mode | Use `assets/public/images/logo.png` as the contained, softly blue-shadowed poster. Static mode is the initial no-WebGL experience and is mandatory for reduced motion, unavailable WebGL2 or a lost WebGL context. The group has the accessible name **“Dimensional Balangkas shield”**; the poster itself is decorative within that labelled group. |
| Shield form | Create one narrow-center shield half with a tapered crest silhouette, angular stepped channels cut through its center, a shallow bevel and visible depth; mirror it across the vertical center seam. Render a slightly enlarged, darker violet depth layer behind the main pair. Put one small pale-blue diamond at the lower center seam. This is a forged crest, not a flat logo plane or a generic medieval shield. |
| Finish and environment | Give the front a high-clearcoat metallic violet-to-blue vertical gradient (violet at the lower portion, blue toward the crest) with cool studio reflections. Use an understated room-like environment, soft ambient fill, a cool directional key, a cyan moving point light and a restrained purple counter-light. Keep the canvas transparent. |
| Atmospheric detail | Place 54 sparse, small, low-opacity cool-blue particles behind/around the shield and a broad elliptical ground halo under it: a thin pale-blue outline with a subtle blue radial glow. Neither may obscure content or become an interactive control. |
| Motion | In normal motion, use a slow 12-second organic loop: yaw moves roughly `-0.4..0.4` radians, pitch roughly `-0.055..0.055`, roll roughly `-0.025..0.025`, and vertical drift roughly `-0.12..0.12` scene units. Pointer influence is deliberately slight (about `0.055` yaw and `0.025` pitch) so the shield feels responsive rather than being a viewer-controlled model. Cap device pixel ratio at 1.5 and prefer low-power rendering. |
| Activity and controls | Animate only while the hero is intersecting the viewport, the document is visible and the user has not paused it. Show the caption **“Forged for fair competition”** and a minimum-44px pause/play control only while animation is active; its accessible names are **“Pause shield animation”** and **“Play shield animation”**. Preserve a manual pause after the scene returns to view. |
| Stage geometry | At desktop the scene occupies its `1fr` side of the `1.05fr/1fr` hero grid and is 530px high; use 600px at 1500px+, 460px at 1200px and below, 420px at 900px and below, and 350px with a 440px maximum width after the 600px one-column collapse. Put `EST. 2026 / PH` at the top-right, the halo 20px above the bottom, and the caption along the bottom edge. |
| Failure behavior | Do not mount WebGL for `prefers-reduced-motion`; react when that preference changes. On WebGL context loss or render failure, permanently replace the scene with the poster for that view. Pause when offscreen or the document is hidden. The pause control disappears in static mode, while the rest of the hero remains navigable and focused normally. |

The `PublicHome` manual report must record the applicable normal-motion, reduced-motion, pause/offscreen and context-loss results; it does not require an automated browser E2E or visual-regression suite.

## Shared data-presentation components

| Component | Responsibility and variants | Required inputs / output boundary |
| --- | --- | --- |
| `MetricRibbon` | Ordered metric cells for dossier/overview headers; 2/3/4-cell responsive arrangements from the route contract. | `MetricValue[]` with label, value/state, explanation and optional destination. |
| `MetricValue` | Renders number, currency, duration, status or unavailable value with a visible label. | Canonical display value and state (`value`, `zero`, `unavailable`, `pending`). |
| `ResponsiveDataTable` | Semantic desktop table with sticky/visible heading row, contained horizontal scroll and mobile reduction defined per column. | Column contract, row view models, row action callbacks, empty/error state. |
| `DataToolbar` | Search, filters, view switcher and result scope above a directory/table. | Controlled query/filter values and callbacks; query state stays in route/container. |
| `FilterTabSet` | Accessible mutually exclusive tabs used by public and workspace lists. | Current value, labelled options, change callback. |
| `FilterSelect` | Single-select filter with explicit placeholder/clear behavior. | Value, option labels/IDs, change callback. |
| `SearchControl` | Labeled text search with clear action and debounce controlled by its container. | Query, input label/placeholder, callbacks. |
| `StatusBadge` | Text-plus-color lifecycle/verification/status display. | Canonical status and accessible wording; color is never the only signal. |
| `EntityCard` | Compact mobile or grid entity preview. | Entity identity, summary metrics, status, permitted navigation/action; not a substitute for desktop table columns. |
| `EmptyState` | Route-specific absence explanation and only an authorized next action. | Title, explanation, optional policy-gated action. |
| `CopyValue` | Copy affordance for safe public values (invite code, lookup code, wallet display). | Value/redacted display, success/failure feedback; never exposes secret material. |

## Forms, uploads and mutation feedback

| Component | Responsibility and variants | Required inputs / output boundary |
| --- | --- | --- |
| `FormLayout` | Approved field order, desktop grouping and mobile stacking. | Ordered named field slots, submit/footer slots. |
| `FormField` | Label, required marker, hint, validation message and control association. | Field ID, label, hint, error, child control. |
| `InstitutionAutocomplete` | Search/select a canonical institution reference. | Query, permitted `/institutions` results, selected ID; no free-text invented institution. |
| `RoleSelect` | Display-role selector that serializes to canonical enum. | Role mapping from CRUD matrix, value, error, change callback. |
| `CompetitiveRankSelect` | Approved rank labels and canonical rank values. | The five enumerated options only, value/error/callback. |
| `MoneyInput` | Decimal entry display bound to an exact minor-unit server command. | Currency/rail, decimal input, validation; never a floating-point canonical amount. |
| `AssetPicker` | Authorized image/file staging and preview. | Purpose, accepted media constraints, staged asset ID/state; no embedded arbitrary data URL persistence. |
| `EvidenceUpload` | Match-evidence upload, checksum/pending/unavailable-extraction feedback and reviewer-safe error state. | Match/game context, staged private asset, extraction state and clearer-screenshot feedback; reference images never count as evidence or source data. |
| `MutationDialog` | Modal shell for create/edit flows, preserving source title/body/footer hierarchy. | Open state, focus trigger, children, close/submit state. |
| `ConfirmAction` | Explicit irreversible/archive/cancel/issue/registry-void confirmation. | Consequence copy, typed confirmation if required, policy-gated command callback. |
| `MutationFeedback` | Inline/surface feedback for validation, pending, conflict, retry and completed-but-not-provider-confirmed state. | Server error/pending/result reference; does not infer success. |

## Domain assemblies

| Component | Route families it composes | Required presentation responsibilities |
| --- | --- | --- |
| `PublicHome` | `/` | `HeroShield` from the fidelity contract above, then featured event, public tournament/team/player rows, credential lookup and educational/editorial sections in listed order. |
| `PublicDirectory` | `/tournaments`, `/teams`, `/players` | page intro, toolbar, listed responsive row/table pattern and entity empty state. |
| `PublicDossier` | `/tournaments/[id]`, `/teams/[id]`, `/players/[id]` | entity hero, metric/story regions and policy-permitted linked records; unavailable rather than fixture detail. |
| `CertificateLookup` / `CertificateDetail` | `/certificates`, `/certificates/[id]` | Lookup input; issued/voided evidence, neutral pending-reconciliation/not-valid-yet, or unavailable state only after server lookup. |
| `OnboardingJourney` | `/onboarding` | ordered profile fields, school/role/rank selections, truthful biometric/wallet integration stages and return-destination preservation. |
| `OverviewWorkspace` | `/portal`, `/portal/[section]` | KPI strip, operations launchpad, hosted events, scrims and recent activity using server projections. |
| `TeamDirectory` / `TeamDossier` | portal team and my-team routes | roster/affiliation segments, staff/recruiting state, invite controls and historical tenure. |
| `PlayerDirectory` / `PlayerDossier` | portal player routes | search/filter, four-metric dossier ribbon, hero mastery, history and credential/portfolio panes. |
| `CommunityDirectory` / `CommunityCommand` | portal community routes | 2:1 workspace, Community Feed/Members List/Team Rosters/Tournament History tabs, detail rail and manager controls. |
| `TournamentDirectory` / `TournamentCommandCenter` | portal tournament routes | organizer directory, tournament overview, 320px stage rail, metrics, registrations, staff, announcements and lifecycle controls. |
| `TournamentMatchDossier` / `TournamentTeamDossier` | nested tournament match/team routes | series scoreboard, two team-stat panels, private evidence/review state with explicit draft/candidate/null labels, and tournament-context roster/record. |
| `ScrimmageBoard` / `ScrimmageRoom` | scrimmage list/new/detail/manage routes | 8:4 board, posting cards, room messages, participant actions and immediate-result feedback. |
| `MatchHistoryWorkspace` | `/portal/match-history` | source/date/opponent/event filters, match rows and calculated analytics with clearly scoped results. |
| `PortfolioWorkspace` | `/portal/portfolio` | self profile, wallets/credentials/achievements, hero mastery and safe copy affordances. |
| `RewardsWorkspace` | tournament management/detail regions | exact fee/prize state, allocation table, payout evidence and pending/failed provider states. |
| `NotificationFlyout` | portal shell | recipient-only list, mark-read/dismiss controls, focus trap/return and unread count reconciliation. |

## Rules that keep the catalogue modular

- Share a primitive only where its semantic contract is identical. A tournament bracket, match score panel, directory row and generic card may share typography/tokens but must keep their different data contracts.
- Keep route-specific desktop ordering in the domain assembly. Do not make one generic `Dashboard` decide whether a community, tournament or scrimmage rail exists.
- Table columns, form fields and metric order are explicit view-model contracts from [ROUTE_CONTRACTS](ROUTE_CONTRACTS.md), [CRUD_MATRIX](CRUD_MATRIX.md) and [VISUALIZATIONS](VISUALIZATIONS.md), not runtime guesses from arbitrary object keys.
- Each query/mutation state is owned once by its feature container; pass narrowly scoped callbacks downward. This prevents duplicate updates, stale modal state and client-side authority drift.
- Components expose accessible names, keyboard interaction, focus return and reduced-motion behavior as part of their contract.

## Onsite verification

For every adopted shadcn primitive, verify the locked version/provider, token override and expected keyboard/focus behavior without changing PCC geometry. Use focused Vitest/component tests where they protect changed behavior. For every domain assembly, record the manually checked server-permission state, desktop/mobile route layout and applicable acceptance scenarios; automated browser E2E/visual-regression runs are deliberately not required during the hackathon. Implement this catalogue only after the preparation gate opens; this document is not frontend source.
