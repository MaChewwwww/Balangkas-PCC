# Community directory and command workspace

## Layout contract

Apply the shared [layout contract](LAYOUT.md). Community discovery uses responsive entity cards and a create modal with cover presets and live preview. A community record starts with a full masthead, then becomes a three-column desktop command workspace: the selected tab gets two columns of primary width and the supporting metrics/search/action area owns the remaining column. It stacks primary content before the supporting area on narrow screens.

Keep the four tab surfaces distinct, in approved order: **Community Feed**, **Members List**, **Team Rosters**, then **Tournament History**. The final tab is the community's competition/tournament-history projection; retain its approved caption instead of relabelling it simply “Competition”. Feed has composer, chronological posts, image/reaction/comment data; Members has member summaries and search; Teams has squad summaries and search; Tournament History has tournament/stage summaries and search. The summary rail contains compact count/telemetry blocks rather than duplicating every feed field. Community-origin links retain their breadcrumb/active-navigation context only through [the cross-feature breadcrumb contract](BREADCRUMB_CONTEXT.md).

Use public/portal/auth typography and responsive rules from [DESIGN](../DESIGN.md). Preserve captions from [CONTROLS](CONTROLS.md); [ROUTES](ROUTES.md) identifies each approved page assembly.

## Fields and controls

Name, type, institution, visibility, description, tags, cover; post body/image; comments; UP/DOWN reactions.

### Form arrangement

The source create and manage form begins with visual identity: live 16:9 banner preview, upload and four preset choices. It then presents Community Name (100-character limit), Community Type and Access & Privacy as a desktop pair, conditional canonical HEI autocomplete for `COLLEGIATE`, Description (1000-character limit), and comma-separated Discovery Tags. Preserve that order, the live badge/tag preview and the two-column-to-stack transformation. A `GRASSROOT` selection clears and hides the institution rather than leaving a stale school value.

Assets enter PCC only through the staged-asset flow. The source's browser data-URL preview is visual evidence only; it is not a persistence format. A private invite code appears only in the authorized join flow or the secure server response, never in the directory or community masthead.

## Actions and navigation

Create/join/edit/archive; add image post, react, comment, follow member/team/event links with the normalized community context defined in [the cross-feature breadcrumb contract](BREADCRUMB_CONTEXT.md).

## Permission and state behavior

Private content requires membership. Author/moderator affordances follow server permissions. Archived state is read-only. Empty feed invites authorized first post.

Every async control has loading/disabled, validation error, network error with retained draft, and actual success states. Missing records show not-found rather than fallback data. Modals trap focus, close with Escape and return focus. Narrow viewports stack rails, retain content order and keep scrolling inside tables/dialogs.

## Data and acceptance

Use the [Community directory and command workspace feature contract](../features/communities.md) and its field/error/transaction rules. Translate related UI-AC scenarios from the [baseline catalogue](../acceptance/FRONTEND_BASELINE.md); use persisted fixtures created onsite, never copy source fixture modules. Verify desktop and 375px mobile states before parity sign-off.
