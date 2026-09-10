# Teams and current/past affiliations

## Layout contract

Apply the shared [layout contract](LAYOUT.md). The teams directory and Current Team list are an 8/4 desktop workspace (9/3 on the widest layout): roster cards or active/previous affiliation lists occupy the main column; a sticky right rail owns search, division, visibility, sort, personal telemetry, and create/explore actions. Directory cards are one column at small width, two columns at medium width, and three only on very wide screens. Each public card presents banner, tier/visibility badges, crest/name/community, a three-cell win-rate/matches/lineup ribbon, then captain/detail action. Private cards replace protected telemetry with a lock explanation and invite join action; they never disclose the code.

Team detail uses the dossier pattern: masthead, four telemetry values, two-thirds main ledger/awards/lineup and one-third contextual/tactical area. Team settings deliberately use a 5/12 visual/preview side and 7/12 detail form side; lineup is five tactical-lane cards before reserves/substitutes. Current/past affiliations remain separate result groups, not a merged career feed.

Use public/portal/auth typography and responsive rules from [DESIGN](../DESIGN.md). Preserve captions from [CONTROLS](CONTROLS.md); [ROUTES](ROUTES.md) identifies each approved page assembly.

## Fields and controls

Name/tag, tier, visibility, bio, banner/logo preset/upload, community, coach/manager; invitation code; directory search/filter.

### Form arrangement and visible limits

Preserve the source form order instead of turning team creation or management into a generic settings page. The create modal presents visual identity (upload or one of the four approved presets, with its live preview) before the fields: **Team Name + Tag** as the desktop pair, **Circuit Division + Accessibility Type** as the next pair, conditional Higher Education Institution for a collegiate team, optional Affiliated Community Hub, then Team Description. The management screen keeps its 5/12 visual preview and 7/12 form split with that same form ordering; roster management remains a separate five-lane lineup and reserves surface.

The approved UI visibly caps name at 50 characters, tag at 4 characters (labelled 2–4), and description at 300 characters. These are route-level input limits required for visual parity. The canonical API/data validation remains the broader 3–100, 2–10, and 1000-character contract in [the feature specification](../features/teams.md); do not create a second route, hidden field, or client-side success path to bypass either layer.

`is_recruiting` is a required PCC field but had no source control. Add one explicit **Recruiting status** control beside the division/accessibility group (or immediately below it when the pair has no room). It binds only that boolean; an empty tactical-lane card is not a recruiting state. This is the sole PCC-required addition to the source team form and must use the established select/toggle treatment, responsive stacking, validation, draft retention and server-confirmed state.

## Actions and navigation

New Team opens modal in place with live preview; join via code; save settings; leave/archive; open same team dossier from roster, community or Current Team.

## Permission and state behavior

Outsider private detail is locked; authenticated directory may show restricted summary. Never reveal invite codes in cards. Preserve origin breadcrumb and active sidebar through nested links only as [the cross-feature breadcrumb contract](BREADCRUMB_CONTEXT.md) permits.

Every async control has loading/disabled, validation error, network error with retained draft, and actual success states. Missing records show not-found rather than fallback data. Modals trap focus, close with Escape and return focus. Narrow viewports stack rails, retain content order and keep scrolling inside tables/dialogs.

## Data and acceptance

Use the [Teams and current/past affiliations feature contract](../features/teams.md) and its field/error/transaction rules. Translate related UI-AC scenarios from the [baseline catalogue](../acceptance/FRONTEND_BASELINE.md); use persisted fixtures created onsite, never copy source fixture modules. Verify desktop and 375px mobile states before parity sign-off.
