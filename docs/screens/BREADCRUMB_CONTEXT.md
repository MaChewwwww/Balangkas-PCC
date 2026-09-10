# Portal cross-feature breadcrumb context

**Status: preparation contract.** This is the single authority for portal breadcrumb continuity when a user crosses a feature boundary. It preserves the approved interaction without treating a URL as a source of identity, permission, resource existence or labels. It applies only to authenticated `/portal` routes; public-site breadcrumbs follow their route family normally.

## Outcome

A user who opens a related record from a portal workspace keeps the valid path that brought them there. The destination must not collapse to a generic destination-only trail merely because its route belongs to Teams, Players, Tournaments, Matches or Scrimmages. The retained origin also controls the highlighted portal sidebar family. A direct URL, a reload, or a context that cannot be verified uses the destination's ordinary hierarchy instead.

For example, a valid Community → Team → Player → Tournament sequence renders:

`Portal → Communities → Community name → Team name → Player IGN → Tournament name`

The original interface demonstrates this in `PortalShell.tsx`, `PortalLifecycle.tsx`, `TeamsWorkspace.tsx`, `PlayerDataWorkspace.tsx`, `TournamentsWorkspace.tsx`, `TournamentMatchView.tsx` and their recorded expectations `UI-AC-007`, `008`, `010`, `034`–`042`, `074`, `076`, `077` and `089` in [the frontend baseline](../acceptance/FRONTEND_BASELINE.md). These are source-reference identifiers only; no source implementation is transferred or copied.

## Accepted context and normalization

Only the following portal query keys may express a navigation ancestor. Identifier values must be a single well-formed PCC UUID. `from` must occur once and have exactly one listed value. Unknown, duplicate, malformed, empty or conflicting values are ignored; link builders never forward them.

| Incoming context | Canonical outgoing form | Meaning |
| --- | --- | --- |
| `from=my-team` or the source-compatible `fromMyTeam=true` | `from=my-team` | The viewer came through their permitted Current Team affiliation view. |
| `from=match-history` | `from=match-history` | The viewer opened the canonical match dossier from Match History. |
| `fromCommunity={communityId}` | unchanged after validation | A community record is an ancestor. |
| `fromTeam={teamId}` | unchanged after validation | A team or affiliation record is an ancestor. |
| `fromPlayer={profileId}` | unchanged after validation | A player dossier is an ancestor. |
| `fromTournament={tournamentId}` | unchanged after validation | A tournament command context is an ancestor. |

`RouteContext` parses this allowlist once at the route boundary. It keeps an ordered, de-duplicated chain, rejects an ancestor that repeats the current resource, and never reads a label, route, role or visible-state claim from the URL. A generated cross-feature link carries the already-normalized complete chain plus the current source record where that record is a valid ancestor of the next destination. It does not reconstruct a chain by copying arbitrary search parameters.

The canonical display order is the actual valid ancestry, starting with one root (`Current Team`, `Match History`, `Communities`, `Teams`, `Player Data`, or `Tournaments`) and then its records. The current destination is appended visually, not reintroduced as its own `from*` value. A breadcrumb link returns to its own route with only the preceding valid context, so a user can move up the same trail without a loop. Ordinary forward links and browser history remain intact; this contract does not replace Back navigation with a redirect.

## Server-authoritative resolution

Context is a presentation request, never an authorization mechanism. The detail endpoint first resolves the destination from the session and its normal permission policy. It then produces the optional, permission-filtered `navigation_context` projection defined in [the API contract](../API_SPEC.md#shared-protocol). The frontend renders only that returned projection and fixed PCC route templates; it must not issue a separate parent-detail fetch solely because a query supplied an ID.

An asserted ancestor is retained only when it is visible to the session **and** the target's server projection proves the relevant relationship. Examples of permitted relationships are:

| Asserted ancestor | Allowed continuation only when the target projection proves |
| --- | --- |
| Community | a member player, affiliated team, or community-hosted tournament relationship; descendants can retain that chain only through one of those records. |
| Team | a current/historical roster player, a registration/participation tournament, or a related scrimmage/match relationship. |
| Player | that player's roster/affiliation, participation or canonical match relationship. |
| Tournament | a registered team, frozen roster player or match belonging to that tournament. |
| Current Team | the viewer's permitted current/past affiliation or a match reached from that affiliation. |
| Match History | the exact canonical match opened from the viewer-permitted history result. |

The server omits any ancestor that is hidden, absent, unrelated, stale, duplicated or creates a cycle. Once an asserted ancestor fails, any later context segment that depends on it is omitted too. The UI then falls back to the ordinary target-family breadcrumb; it must not show an unverified name, link to a hidden resource, disclose why a resource is unavailable, or retain a misleading partial trail. This deliberately rejects any client-local lookup as authority.

## Presentation and sidebar rules

The shell always starts with `Portal`. When a valid context exists, it renders the preserved root/family label and each server-approved ancestor before the current route title. The oldest retained root selects the sidebar family for the whole cross-feature view:

| Valid root | Breadcrumb family label | Active sidebar item |
| --- | --- | --- |
| `from=my-team` | Current Team | Current Team |
| `from=match-history` | Match History | Match History |
| `fromCommunity` | Communities | Communities |
| `fromTeam` | Teams | Teams & Lineups |
| `fromPlayer` | Player Data | Player Data |
| `fromTournament` | Tournaments | Tournaments |
| no valid context | destination's normal family | destination's normal family |

This is particularly important for Community links: Community → Member/Team/Tournament and every valid direct continuation keep both the community breadcrumb and **Communities** sidebar selection. Likewise, a player reached from a team remains under **Teams & Lineups**, and a tournament match opened from Match History or Current Team keeps that source family instead of switching the user to a generic tournament trail.

## Ownership and verification

`RouteContext` owns allowlist parsing, normalization and link construction. Feature containers pass the normalized request context with their normal read request and render the returned context. `PortalShell` owns the active-sidebar decision and passes only server-safe breadcrumb segments to `BreadcrumbTrail`. No component may persist this context as product state, infer it from local fixtures, or use it to decide an action, data fetch or permission.

During authorized onsite work, cover this with focused route/component or API tests and record the manual route check; do not create browser E2E or visual-regression work for it. The required checks are [AC-NAV-01](../acceptance/README.md#shared-portal-navigation) through `AC-NAV-03` and the source baseline expectations cited above.
