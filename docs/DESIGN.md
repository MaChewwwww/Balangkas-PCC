# Final frontend preservation contract

The approved practice frontend is the visual authority. Recreate it onsite; do not redesign or import its implementation now. [Routes](screens/ROUTES.md), [controls](screens/CONTROLS.md), [tokens](screens/TOKENS.md) and [baseline scenarios](acceptance/FRONTEND_BASELINE.md) form the preservation record.

## Surfaces

| Surface | Required presentation |
| --- | --- |
| Public | Manrope, editorial image-led sections, light canvas with dark feature sections, narrow uppercase eyebrow labels and existing hero compositions. |
| Portal | Plus Jakarta Sans, light work surfaces, blue/violet accents, dark operations sidebar, contextual breadcrumbs and right-rail metrics/filter layouts. |
| Brand | Local Balangkas font for existing wordmark/display uses, existing logos and approved artwork. |
| Numeric details | Tabular monospace for scores, statistics, IDs, wallets and hashes only. |
| Authentication | Existing animated branded backdrop and compact form hierarchy; preserve onboarding progression and feedback. |

Portal sidebar is 272px expanded and 72px collapsed, with light canvas #f6f8fc, white surface and dark #070e1b sidebar. Public base canvas is #f6f7f9, ink #111827 and accent #285cff. Exact extracted tokens are in the token table; older generalized palette prose must not override them.

## Responsive and motion acceptance

Preserve source public breakpoints at 1200/900/600 pixels, with special 760 and 1500 cases; portal uses 1200/1024/767/580 cases. Rebuild behavior rather than assuming a single universal breakpoint. At narrow widths, stack rails and content, preserve readable tables with contained horizontal scrolling, and expose accessible navigation. Dialogs fit viewport and allow scrolling. No fixed-width element forces page overflow at 375px.

Shield animation must support manual pause, offscreen/document-hidden pause, reduced-motion preference changes and WebGL context-loss fallback to logo poster. Preserve carousel pause, hover and dot controls. Keyboard focus is visible; Escape closes dialogs/flyouts and returns focus to trigger. Avoid blocking all content until animation loads.

## Interaction preservation

Keep final labels, tab groupings, filter placement, view switchers, previews, share-copy confirmation and navigation context. Source sample statistics and success copy are not permanent values. API-backed empty/loading/error/pending states fit the same layout. Show zero/unavailable metrics honestly. All mutations retain user input on validation/network error and disable repeat submit while pending; a retry uses the same operation key.

A surface is complete only when its route, permissions, relevant modal/action states and mobile behavior match the source specification. Styling tokens are documentation only until onsite coding. Screenshot-based visual comparison is an onsite acceptance activity; no fresh browser screenshot audit has been claimed for this preparation.
