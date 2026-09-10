# Data presentation and visualization semantics

This document defines the meaning, ordering and honest absence state of every visual data pattern. It prevents graphs, scorecards, cards and tables from being rebuilt with invented values. Layout and breakpoints are in [LAYOUT](LAYOUT.md); fields and commands are in [CRUD_MATRIX](CRUD_MATRIX.md).

## Universal value rules

| Value kind | Display rule | Never do this |
| --- | --- | --- |
| Count | Integer with a label and scope (`completed series`, `active roster`, `registered teams`). | Use fixture count, `0` for a failed query, or a count without its scope. |
| Rate | Percent rounded only for display; show numerator/denominator in accessible detail when meaningful. | Divide by zero, present a rate from pending/review games, or call a rate `0%` when unavailable. |
| Score | Team A score – Team B score, tied to a named completed series/game and status. | Infer individual games from a scrimmage series result. |
| Money | Currency formatted from exact minor units; SOL from exact decimal string. | Calculate canonical money in floating point or make a pending payment look settled. |
| Date/time | Asia/Manila event presentation from UTC value; date range has clear timezone scope. | Render a browser-local value as the event’s official time. |
| Lifecycle / verification | Text label plus color/icon, source record and timestamp/detail where permitted. | Color alone, a sample green badge, or a provider/biometric/credential success without evidence. |
| Missing value | `—` with context, or a labelled unavailable/pending/error region. | Substitute zero, `N/A` without explanation, or copied sample data. |

## Metric definitions

| ID | Display label / locations | Canonical calculation and population | Zero, unavailable and pending behavior |
| --- | --- | --- | --- |
| V01 | Matches / record / public team-player rows | Count canonical `matches` with `status=COMPLETED` in the projection’s entity/scope. | `0` when completed query succeeds with none; `—` when hidden/not calculated; skeleton/error before result. |
| V02 | Wins / losses / win rate | Wins/losses from completed series in the same scope. Win rate = completed wins / (completed wins + completed losses) × 100. | `0%` only with denominator > 0 and zero wins; `—` when denominator is zero or scope unavailable. |
| V03 | Roster / members | Active `team_memberships` or `community_memberships` in the currently shown entity/scope. | `0` only for a successful permitted list; private/masked membership is not `0`. |
| V04 | Hero mastery / KDA / hero totals | Accepted `game_player_stats` for exactly attributed player rows and accepted games. KDA = (kills + assists) / max(1, deaths), with its game scope stated. | `—` if there are no accepted attributable games; unresolved/unknown rows do not enter total. |
| V05 | Profile/portfolio metric ribbon | The ordered set of V01-V04 and credential/achievement count only where its server projection supplies it. | Preserve four-cell order; unavailable cells remain cells, not removed/reflowed into fabricated values. |
| V06 | Team performance ribbon/dossier | Completed-series record, calculated win rate, active roster, and relevant scheduled/placement projection. | State scope such as season/date filter; archive/history can have a different scope. |
| V07 | Tournament registration/capacity | Registered team count / `max_teams`; count statuses exactly as product read model defines, normally `REGISTERED`, not payment attempts. | `0/max` after successful empty projection; `—` if capacity unreadable. |
| V08 | Tournament progress / stage status | Completed valid bracket matches / total generated bracket matches, plus bracket sync/lifecycle state. | No progress bar advancement for queued/failed sync or manually guessed bracket shape. |
| V09 | Match-series score | `matches.wins_a` and `matches.wins_b`, winner and `COMPLETED` state. | Do not surface pending/void as final score; do not synthesize game scorecards. |
| V10 | Game score/player panel | Recorded game fields and accepted review values; participant stats only when identity state permits attribution. Draft view separately labels detector/OCR values, nulls, hero candidates and review-required state. | Do not convert OCR draft, fuzzy/unresolved identity, template candidate, unreadable value or source screenshot into an official stat. |
| V11 | Community analytics | The server’s date-range calculated metric projection (members, posts, engagement or other exposed measures). | Draw a trend chart from the browser feed or fill absent time buckets with invented zeroes. |
| V12 | Reward/payment/certificate state | Exact allocation/payment/issuance records and provider/chain/cash evidence. | Treat a submitted, pending or local preview reference as paid, minted or handed over. |
| V13 | Notification/activity counts | Recipient-only unread state and immutable permitted event summaries. | Mutate count based on a global client event or hide failure as a read event. |

## Desktop rows, tables and responsive reduction

The desktop data structures below are part of the visual baseline. At narrower widths, reduce the named secondary fields in the named order; retain identity, status and the primary decision field. A `ResponsiveDataTable` keeps its overflow inside the table region, never at the page level.

| Pattern | Desktop left-to-right field order | Reduction / state behavior |
| --- | --- | --- |
| Public tournament row | Event date; tournament identity and lifecycle; prize; registered/capacity; navigation affordance. | Under 900px hide capacity; under 600px place prize beneath identity. Date, title/status and navigation persist. |
| Public team row | Rank; team mark; name and school; tier; V02 win rate; V01 matches; navigation affordance. | Under 900px hide tier then matches; under 600px move win rate below identity. Use `—` for unavailable rate/rank, not sample values. |
| Public player row | Player mark; name and verification wording; primary role; V02 win rate; navigation affordance. | Under 1200px hide role; under 600px move rate below identity. A badge only communicates actual projection state. |
| Portal directory table | Entity identity first, context/status, primary metrics, permitted row action last. The exact route-specific columns derive from its domain projection. | Do not replace a dense desktop table with a card grid. On narrow screens use designated compact card/row projection or contained table scroll. |
| Roster/affiliation table | Member identity; roster/staff role; joined/left or active status; derived record/context. | Active and historic groups remain separate. Historical roster snapshot uses stored lineup/interval values. |
| Match history table | Series identity; source/event; opponent; result V09; date; permitted detail action. | Filters scope all rows and metrics. `VOID`, pending/review and completed statuses render distinctly. |
| Registration/operations table | Team identity; readiness/lifecycle; payment state where permitted; seed/lineup/status; scoped action. | Capacity and payment state use V07/V12; sensitive provider details are not table content. |
| Reward/certificate table | Recipient/placement; rail/amount; lifecycle/evidence reference; authorized action. | Exact money stays tabular/monospaced where appropriate; no raw provider/bank secrets. |

## Named visual assemblies

| Assembly | Required visual content and source of truth |
| --- | --- |
| Public home discovery bands | Featured event plus public tournament/team/player rows above. Public summary query controls all values; static images establish editorial composition only. |
| Profile and team dossiers | Hero/identity panel, ordered metric ribbon, record/roster/history regions. Use V01-V06; the right rail remains a real secondary information region on desktop. |
| Community command workspace | 2/3 primary work area and 1/3 rail with Community Feed, Members List, Team Rosters and Tournament History tabs. Feed/social data, member counts, participating teams and stage data are separate projections/async states. |
| Tournament command center | 320px stage rail at wide desktop, four-cell metric row at the documented width, overview plus registration/bracket/staff/announcement/reward panels. Use V07, V08 and V12. |
| Tournament match dossier | Series masthead, competing teams, two symmetric team-stat panels, game list and evidence/review region. Use V09/V10; preserve unknown/unresolved/pending fields. |
| Scrimmage board and room | 8/4 list/filter split; room masthead and 7/5 primary/rail split. Cards show posting context and status; room result is V09 only after atomic server finalization. |
| Portfolio | Player metric ribbon, accepted-game hero mastery, achievements and credential/wallet evidence sections. Self-reported and provider-backed items are visibly distinct. |
| Certificate lookup/detail | Input/explanation before a lookup; certificate facts, recipient, award, issue/registry-void and evidence only from a returned public projection. Public pending reconciliation is neutral/not-valid-yet and exposes no recipient or award facts. |
| Overview/notifications | KPI strip and short activity feed must use V01-V03/V13 with scope. Bell flyout is recipient-only and keyboard-operable. |

## Charts and progress indicators

The approved interface is primarily metric, row and table based. Do not introduce a dashboard chart merely because an endpoint returns numbers. A chart is permitted only when the server exposes an ordered date-series or category-series projection with labels, units and zero/missing semantics. Its accessible table/list equivalent is required.

| Candidate | May be rendered only when | Required fallback |
| --- | --- | --- |
| Community trend | Analytics returns dated buckets and documented metric/unit. | Labeled metric list or no-data state; not locally derived feed history. |
| Tournament capacity/progress | V07/V08 values and total are present. | Numeric `registered / capacity` or `completed / total`; no indeterminate progress posed as completion. |
| Win-rate comparison | Same scope, completed-series totals and denominators exist for each entity. | Per-entity V02 values with denominators/unavailable marks. |
| Hero mastery ranking | Ordered accepted-game aggregate arrives with entity/period scope. | Ordered list with rank/count; not portraits sorted by fixture popularity. |

## Async, privacy and accessibility rules

Loading uses a layout-preserving skeleton rather than a made-up metric. Empty means a successful permitted query returned no records; hidden/not found means the viewer lacks a visible resource; error means the request failed; pending means an accepted command or provider job is unfinished. Each needs unique text and appropriate retry/action.

All visualizations provide text labels, status wording and table/list alternatives where a graphical encoding exists. Scores, IDs, wallets, hashes and numeric tables use the documented tabular treatment. Do not expose a private roster, wallet, provider reference, raw biometric material or OCR raw payload merely to fill a panel.
