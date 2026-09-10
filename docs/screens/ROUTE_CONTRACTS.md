# Exact route composition contracts

Every listed route has a distinct preservation ID. Reconstruct only these 41 routes; dynamic bracket values are server-resolved identifiers. Read this with [LAYOUT](LAYOUT.md) for dimensions and breakpoints, [CRUD_MATRIX](CRUD_MATRIX.md) for fields/actions, [VISUALIZATIONS](VISUALIZATIONS.md) for metric/table meaning, and [the cross-feature breadcrumb-context contract](BREADCRUMB_CONTEXT.md) for inherited portal paths/sidebar ownership. `Shell >` below means ordered containment, not a mandate for a particular framework structure.

## Public, authentication and onboarding

| ID | Route | Ordered composition | Required data and presentation behavior |
| --- | --- | --- | --- |
| R01 | `/login` | `AuthShell > Login form > OTP state` | Email then password, submission feedback, six-slot OTP verification where needed, and a safe register/back path. Never show a locally assumed signed-in account. |
| R02 | `/register` | `AuthShell > Registration form > OTP state` | Email, password, confirmation and account creation feedback; preserve entered values/errors. Verification remains pending until server evidence. |
| R03 | `/onboarding` | `AuthShell > OnboardingJourney > ordered profile step > biometric/wallet stages > completion` | IGN, school, MLBB User ID, four-digit Zone ID, primary role, rank and 250-character short description appear in that order; build later profile state from canonical data. The biometric stage may show capture-ready after frontend one-face detection/alignment, but only the server may show unavailable/pending/verified state. Wallet panels likewise use actual server state only. |
| R04 | `/` | `PublicShell > PublicHome > hero > featured event > tournament rows > team rows > player rows > credential lookup > editorial sections` | Public discovery projections only. Keep the hero’s split composition, the featured item and the three ordered row families; see V01-V03 for row fields and reductions. |
| R05 | `/about` | `PublicShell > editorial hero > narrative sections > calls to action` | Preserve public editorial cadence and full-width image/text alternation; no portal sidebar or dashboard metrics. |
| R06 | `/tournaments` | `PublicShell > PageIntro > DataToolbar > tournament result list` | Search, status/category/select filters, featured treatment and tournament row order: date, identity/status, prize, capacity, navigation. |
| R07 | `/tournaments/[id]` | `PublicShell > PublicDossier > event hero > overview/story > permitted event details > related rows` | Resolve public event state, event status, date, prize/fee and related public teams/matches. Render unavailable/archived accurately; joining is only a navigation to authenticated eligibility flow. |
| R08 | `/teams` | `PublicShell > PageIntro > FilterTabSet/SearchControl > team result list` | Query canonical public team projection. Desktop row order is rank, mark, identity/school, tier, win rate, matches, navigation. |
| R09 | `/teams/[id]` | `PublicShell > PublicDossier > team identity > metrics/story > roster/history/event regions` | Show public-safe team identity, roster display, calculated metrics and relevant events. Private fields, invites and staff controls stay absent. |
| R10 | `/players` | `PublicShell > PageIntro > FilterTabSet/SearchControl > player result list` | Search by player/team/university projection. Desktop row order is mark, identity/verified wording, role, win rate, navigation; no fake verification badge. |
| R11 | `/players/[id]` | `PublicShell > PublicDossier > player hero > hero mastery > moments > match record` | Privacy-filtered profile, calculated career metrics, accepted-game hero data and public history only. An unknown/hidden player is unavailable, not a sample profile. |
| R12 | `/certificates` | `PublicShell > CertificateLookup > lookup field > explanatory credential sections` | Lookup accepts certificate code or exact Core asset address. Prototype showcase copy stays illustrative; result comes only from lookup API. |
| R13 | `/certificates/[id]` | `PublicShell > CertificateDetail > identity/award grid > verification details > explorer action when evidence exists` | Show `ISSUED` or `VOIDED` public certificate facts/evidence; `PENDING_RECONCILIATION` is neutral/not-valid-yet with no recipient/award facts; draft, unknown or inaccessible identifiers use unavailable state. Network/transaction/Core asset fields need recorded finalized evidence. |

## Portal shell and overview

| ID | Route | Ordered composition | Required data and presentation behavior |
| --- | --- | --- | --- |
| R14 | `/portal` | `PortalShell > OverviewWorkspace > metric ribbon > hosted stages/open scrims > launchpad > recent activity` | Desktop primary workspace plus right rail as LAYOUT specifies. KPIs are calculated, scope-labeled and may be unavailable; actions are permission-gated. |
| R15 | `/portal/[section]` | `PortalShell > RouteContext > one listed workspace` | Compatibility-only dispatcher for documented portal sections. Unknown/unpermitted sections return an appropriate safe not-found/denied state and never manufacture a workspace. |
| R16 | `/portal/portfolio` | `PortalShell > PortfolioWorkspace > player summary > metrics/hero mastery > achievements/credentials > wallet/evidence panes` | Owner projection only. Copy actions use safe display values; wallet/credential status remains pending/failed until authoritative evidence. |
| R17 | `/portal/match-history` | `PortalShell > MatchHistoryWorkspace > toolbar > match table/list > analytics/related tournament regions` | Filters scope canonical history. Rows and totals distinguish completed series, accepted games and unavailable values (V09, V10). |

## Portal teams and players

| ID | Route | Ordered composition | Required data and presentation behavior |
| --- | --- | --- | --- |
| R18 | `/portal/teams` | `PortalShell > TeamDirectory > heading/action > search/filter > team table/cards` | Discoverable team projection plus permitted create action. Directory does not expose invite secrets until a server-authorized create/rotate response. |
| R19 | `/portal/teams/new` | `PortalShell > WorkspaceHeader > team FormLayout > asset preview > submit feedback` | Visual identity/preset preview, then name/tag, tier/accessibility/recruiting, conditional institution, community affiliation and description. Preserve the approved visible 50/4/300 input caps while the server validates its documented broader limits. Create through session principal; show returned one-time invite code only in its secure post-create state. |
| R20 | `/portal/teams/[id]` | `PortalShell > TeamDossier > identity/metric ribbon > roster/history > permitted detail rail` | 8:4 or 9:3 desktop ownership per layout; team data, roster, affiliations and calculated metrics are policy-filtered. |
| R21 | `/portal/teams/[id]/join` | `PortalShell > TeamDossier context > MutationDialog/FormLayout > join feedback` | Show invite-code input for a private team and truthful eligibility/error states. Join action never submits a member/actor ID. |
| R22 | `/portal/teams/[id]/manage` | `PortalShell > WorkspaceHeader > team management FormLayout > staff/invite/archive panels` | Owner/captain policy gates presentation, staff assignments, invite rotation and archive confirmation. Version conflicts retain the form and show current-state guidance. |
| R23 | `/portal/my-team` | `PortalShell > TeamDirectory > active verified roster > past affiliations > search` | Separate active roster and concluded tenure regions; dates and career metrics derive from membership intervals and canonical history. |
| R24 | `/portal/my-team/[id]` | `PortalShell > TeamDossier > affiliation/roster detail > history` | Context is the viewer’s permitted current/past affiliation; it is not a second generic team directory detail. |
| R25 | `/portal/players` | `PortalShell > PlayerDirectory > search/filter > table/cards` | Search/filter policy-safe player summaries. Desktop directory uses the data-presentation pattern, not a generic marketing grid. |
| R26 | `/portal/players/[id]` | `PortalShell > PlayerDossier > 2:3 profile/record grid > four-metric ribbon > hero/history/achievement regions` | Primary dossier column and secondary record rail follow LAYOUT. Data is viewer-permitted and every metric is calculated/labelled as V05-V10 define. |

## Portal communities

| ID | Route | Ordered composition | Required data and presentation behavior |
| --- | --- | --- | --- |
| R27 | `/portal/communities` | `PortalShell > CommunityDirectory > heading/action > discovery list` | Community summaries, search and type/status scope; create action only for eligible actor. |
| R28 | `/portal/communities/new` | `PortalShell > WorkspaceHeader > community FormLayout > visual identity preview > submit feedback` | Name, type, conditional institution, visibility, description, tags and cover asset in the form contract order. Collegiate requires canonical institution; no arbitrary school ID. |
| R29 | `/portal/communities/[id]` | `PortalShell > CommunityCommand > primary 2/3 workspace > secondary 1/3 rail > Community Feed/Members List/Team Rosters/Tournament History tabs` | Preserve the three-column desktop split and source tab order. Tournament History is the competition projection. Posts/comments/reactions, member lists, teams, stages and analytics are separate asynchronous regions. |
| R30 | `/portal/communities/[id]/manage` | `PortalShell > WorkspaceHeader > community management FormLayout > identity/archive panels` | Owner/manager controls only. Save uses a version; archive is confirmed and changes lifecycle rather than deleting history. |

## Portal scrimmages

| ID | Route | Ordered composition | Required data and presentation behavior |
| --- | --- | --- | --- |
| R31 | `/portal/scrimmages` | `PortalShell > ScrimmageBoard > primary 8/12 board > secondary 4/12 filters/own blocks` | Board cards/rows show schedule, rank window, best-of, posting team and lifecycle. The rail stacks at the specified breakpoint rather than being dropped. |
| R32 | `/portal/scrimmages/new` | `PortalShell > WorkspaceHeader > scrimmage FormLayout > lobby/security guidance > submit feedback` | Posting team, description, rank min/max, schedule, best-of and lobby fields. Secrets are encrypted/server-handled and never echoed into public cards. |
| R33 | `/portal/scrimmages/[id]` | `PortalShell > ScrimmageRoom > masthead 5:1:5 > primary match/message column 7/12 > secondary context rail 5/12` | Participant-aware room with persisted messages and action state. Challenge, accept, cancel and result controls are server-policy gated. |
| R34 | `/portal/scrimmages/[id]/manage` | `PortalShell > ScrimmageRoom context > management FormLayout > cancel/edit feedback` | Host-editable settings only while allowed. Avoid any client timer, dual confirmation or fabricated finalization. |

## Portal tournaments, matches and operations

| ID | Route | Ordered composition | Required data and presentation behavior |
| --- | --- | --- | --- |
| R35 | `/portal/tournaments` | `PortalShell > TournamentDirectory > heading/action > search/filter > tournament table/cards` | Public/permitted organizer projections, lifecycle badges, prize/status scope and policy-gated create action. |
| R36 | `/portal/tournaments/new` | `PortalShell > WorkspaceHeader > 7/12 operations FormLayout + 5/12 visual preview > fee/reward fields > bracket settings > submit feedback` | Operations retain source order and add registration deadline, eligibility/conditional institutions, and requirements/prompt in place; visual identity retains MLBB game, eligible host selection, staged pubmat and live preview. Exact fee/prize rails and lifecycle fields bind to their feature/data contracts. |
| R37 | `/portal/tournaments/[id]` | `PortalShell > TournamentCommandCenter > 320px stage rail + 1120px content at wide desktop > overview/registrations/bracket/staff/announcements/rewards panels` | Preserve command-center rail at >=1120 and its stacked fallback. Metrics, progress, bracket and actions follow V07, V08 and V12; no automatic lifecycle transitions. |
| R38 | `/portal/tournaments/[id]/join` | `PortalShell > tournament context > registration FormLayout > payment readiness > pending/failed feedback` | Team selection, optional requirements/invite, eligibility and biometric authorization follow server readiness. PayMongo entry is labelled test checkout/no real funds, opens the returned hosted URL, then refetches status on return; it never treats redirect/query text as paid. A payment attempt is not a registration/payment success. |
| R39 | `/portal/tournaments/[id]/manage` | `PortalShell > TournamentCommandCenter management panels > staged forms > lifecycle/staff/announcement/reward actions` | Only editable pre-start settings are enabled. Lifecycle, seeds, staff, rewards and reconciliation commands expose their version/pending/error state. |
| R40 | `/portal/tournaments/[id]/matches/[matchId]` | `PortalShell > TournamentMatchDossier > series masthead > two team-stat panels > games/evidence/review column` | Scoreboard, game rows, evidence integrity/extraction/review state and manual result controls derive from the server projection. The reviewer draft shows private source evidence, detector-associated values/nulls, local hero candidates and frozen-roster choices as non-official; only accepted records feed the stat panels. Do not create player stats from a series-only scrimmage result. |
| R41 | `/portal/tournaments/[id]/teams/[teamId]` | `PortalShell > TournamentTeamDossier > event-context team header > roster snapshot > event record/placement` | Use registered lineup snapshots and tournament-context history, not mutable current roster as historical truth. |

## Route-state minimums

Every data route has a distinct loading skeleton, empty state, request error with retry where safe, not-found/hidden state, and session/permission state. Every command route additionally has invalid-field, pending, idempotent retry, stale-version conflict and server-confirmed result handling where relevant. A source sample value, browser cache or URL parameter cannot satisfy any of these states. Portal detail routes also use only the server-filtered `navigation_context` described in [the breadcrumb-context contract](BREADCRUMB_CONTEXT.md); a query can preserve a valid trail but cannot create an ancestor, label, visible resource or active permission.
