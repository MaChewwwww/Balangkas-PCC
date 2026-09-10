# Community directory and command workspace

## Layout and typography

Directory cards and create modal with image preset/live preview. Four-tab detail workspace for feed/membership/team/competition information as captioned in controls inventory; right-side metrics and search.

Use public/portal/auth typography and responsive rules from [DESIGN](../DESIGN.md). Preserve captions from [CONTROLS](CONTROLS.md); source paths in [ROUTES](ROUTES.md) identify page wrappers.

## Fields and controls

Name, type, institution, visibility, description, tags, cover; post body/image; comments; UP/DOWN reactions.

## Actions and navigation

Create/join/edit/archive; add image post, react, comment, follow member/team/event links with fromCommunity context.

## Permission and state behavior

Private content requires membership. Author/moderator affordances follow server permissions. Archived state is read-only. Empty feed invites authorized first post.

Every async control has loading/disabled, validation error, network error with retained draft, and actual success states. Missing records show not-found rather than fallback data. Modals trap focus, close with Escape and return focus. Narrow viewports stack rails, retain content order and keep scrolling inside tables/dialogs.

## Data and acceptance

Use the [Community directory and command workspace feature contract](../features/communities.md) and its field/error/transaction rules. Translate related UI-AC scenarios from the [baseline catalogue](../acceptance/FRONTEND_BASELINE.md); use persisted fixtures created onsite, never copy source fixture modules. Verify desktop and 375px mobile states before parity sign-off.
