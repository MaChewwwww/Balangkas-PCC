# Layout and data-presentation contract

This is the screen-layout source of truth for onsite reconstruction. Read it with the exact [route catalogue](ROUTES.md), [controls inventory](CONTROLS.md), [tokens](TOKENS.md), the relevant family file, and [DESIGN](../DESIGN.md). It records the approved presentation only; it does not authorize copied implementation, mock data, local-only outcomes, or product-policy changes.

## How to use this contract

- Preserve the stated information hierarchy, column order, data density, and responsive transformation. Do not turn a documented workspace into a generic vertical card feed.
- A “rail” is a distinct supporting column, not merely a card placed after the main content. At desktop it owns the documented filters, calculated metrics, status, and/or contextual actions; it moves below the main column only at its stated collapse point.
- Use live, permission-filtered server projections. A missing value stays unknown, pending, unavailable, zero, or empty as appropriate; no sample row or success state may fill a visual gap.
- A row/table may scroll inside its own bounded region on a narrow viewport. Do not hide required data without the documented progressive reduction or a disclosed detail expansion.
- Preserve the public editorial surface and the portal operations surface as separate languages. Exact color, type, and radius values live in [TOKENS](TOKENS.md), not in an improvised component theme.

## Shared portal frame

| Viewport condition | Required frame |
| --- | --- |
| Desktop wider than 1200px | Fixed, scrollable dark left operations sidebar is 272px. The remaining width is the light portal canvas with lifecycle/header, contextual breadcrumb, and padded workspace. |
| 768px through 1200px | Sidebar occupies a 72px icon rail and expands on hover/focus interaction. The main canvas remains beside it; labels must not permanently consume content width. |
| 767px and below | Hide the sidebar, render one main content column, preserve the header/breadcrumb, and reserve bottom space for the fixed mobile navigation. Mobile page/header horizontal padding is 16px. |
| Workspace layouts | Use a real grid: main data area first, rail second in DOM order. At the workspace collapse point, stack main before rail. Do not reorder the rail ahead of the primary record/feed. |

The portal overview has a four-metric ribbon and a `main + 340px` command rail at desktop. That ribbon becomes two metrics at 1024px and one at 580px; the command rail joins the main column at 1024px. Reusable portal entity-card grids use columns of at least 340px and become one column at 580px.

## Repeating portal workspace patterns

| Pattern | Desktop composition | Data-presentation requirements | Narrow transformation |
| --- | --- | --- | --- |
| Directory command workspace | Twelve-column grid: main `8/12` and rail `4/12`, becoming `9/12 + 3/12` on very wide screens where the source does so. | Main holds the result cards, tabbed records, or feed. Rail holds search, filters, sort, compact calculated HUD, and contextual CTA. | One column; retain result feed before the controls rail. |
| Match-room workspace | Twelve-column grid: live/main area `7/12` and participant/action rail `5/12`; the board variant is `8/12 + 4/12`. | Head-to-head identities stay in a dedicated masthead. Pinned/live blocks precede general results. Room-only credentials and chat remain participant-only. | Stack after the masthead; keep action controls with their data surface. |
| Dossier workspace | Three-column grid: content spans two columns and contextual facts/actions occupy one column. | A gradient/dark identity masthead precedes a four-cell telemetry strip. The main column carries ledger/awards/roster; auxiliary card carries affiliations, wallet or tactical summary. | Metric strip is two columns before becoming compact; content and auxiliary panels stack. |
| Tournament command center | Main flexible column plus a fixed 320px rail from 1120px. | Four metric ribbon at 1024px+, operations/analytics/match/reward panels in the main column, filter/telemetry/activity in the rail. | Below 1120px rail becomes a following full-width panel; metric ribbon is two columns below 1024px. |
| Tournament match dossier | Main `1.2fr` and contextual rail `minmax(340px, .8fr)` from the extra-large desktop breakpoint. | Header names both squads and status. Overview lists games as `game number | summary | affordance`; selected-game mode renders two player-stat lineup panels plus evidence and result controls in the rail. | Stack main then rail; player-stat panels become a two-column grid only when there is enough width. |
| Form/modal composition | Label and helper/error text stay adjacent to their field. Preview is a peer column/area, not a replacement for the inputs. | Wide create/edit forms use a 12-column layout for large fields and two-column pairs for related short fields; banner/preset galleries use four choices where space permits. | Inputs stack to one column; the modal body scrolls independently and actions stay reachable. |

## Portal screen evidence matrix

The component names below are documentation labels for the approved assemblies, not implementation dependencies.

| Surface | Component grouping | Required desktop hierarchy |
| --- | --- | --- |
| Overview | Portal overview assembly | Masthead, four KPI cards, then a main command grid with hosted stages/open practice/operations and a 340px activity rail. |
| Teams directory/current teams/history | `TeamsWorkspace`, `MyTeamWorkspace`, `MatchHistoryWorkspace` | 8/4 (9/3 wide) workspace. Main contains result cards or ledger; sticky rail contains filters, telemetry and action card. |
| Communities | `CommunitiesWorkspace` | Community masthead, then a 3-column grid with a 2-column tabbed primary workspace and 1-column supporting side panel. Community Feed, Members List, Team Rosters and Tournament History are distinct tabs; the last is the competition projection. Do not merge their data into one endless feed. |
| Scrimmages | `ScrimmagesWorkspace` | Board: 8/4 results/rail. Matched room: 7/5 live room/action rail, preceded by an 11-column head-to-head masthead (`5 | divider | 5`). |
| Portfolio and public/team dossiers | `PortfolioWorkspace`, `PlayerDataWorkspace`, `TeamDataWorkspace` | Identity masthead, four calculated telemetry values, then 2/3 primary content and 1/3 auxiliary information. Portfolio uses the 8/4 workspace instead. |
| Tournaments | `TournamentsWorkspace`, `TournamentCommandCenter` | Directory has editorial marquee and view switcher; command center has metric ribbon plus flexible main/320px rail. Detail tabs do not mix their panels. |
| Tournament team context | `TournamentTeamContext` | Gradient team masthead with responsive four metrics, followed by paired roster/history cards and later two-column data groups. |
| Tournament match context | `TournamentMatchContext` | Competition masthead, selected tab, summary metrics, main series/game surface, and a distinct evidence/result rail. |

## Public shell and editorial layouts

The public canvas is restrained and editorial: `page-width` is capped at 1280px, while the header uses a 1440px cap. Section title/content columns and strong image/text pairing carry the page; portal-style rounded card stacks do not replace this composition.

| Public surface | Desktop composition | Required data order | Responsive behavior |
| --- | --- | --- | --- |
| Home hero | Two columns, text `1.05fr` then shield/scene `1fr`. | Eyebrow, wordmark/title, tagline, description, CTA group, footnote; scene has poster/WebGL fallback and pause caption. Reconstruct the procedural shield, motion and failure details from [the HeroShield fidelity contract](COMPONENT_CATALOG.md#heroshield-scene-fidelity). | One column at 600px; text stays before scene. |
| Featured tournament | Image `1.1fr`, editorial copy `1fr`. | Artwork/caption, status/title/summary, fact values, CTA. | Keeps two columns through tablet; one column at 600px. |
| Journey | Copy `0.92fr`, steps `1.08fr`; every step is number/icon, title, then explanation. | Never flatten the numbered process into unlabelled cards. | One column at 760px; explanation starts beneath its title. |
| Tournament directory row | `date | identity/status | prize | capacity | arrow`. | Identity includes status/tier/name/date/invitation state. Prize and capacity retain their labels. | Capacity drops below 900px; below 600px prize moves below identity and the row remains a date/identity/arrow grid. |
| Team directory row | `rank | shield mark | identity/school | tier | win-rate bar | match count | arrow`. | Win rate is label + precise value + thin track; counts retain label. | Tier and match count hide below 900px. Below 600px, win rate moves to a second line under identity; rank/mark/identity/arrow remain. |
| Player directory row | `mark | identity/team/verified state | role | win-rate bar | arrow`. | Verification is a state indicator beside identity, never a decorative replacement for server state. | Role drops at 1200px; win rate becomes a second row below identity at 600px. |
| Public detail | Masthead, fact band and tabs precede details. | Details use a `1.3fr + 1fr` main/facts split; brackets retain horizontal round-by-round scrolling. | Detail columns stack at 600px; no fake bracket compression. |
| Certificate view | Certificate/article `1.5fr` plus verification aside `1fr`. | Certificate content, recipient/tournament facts, then status/evidence aside. | Single column below 900px. |
| About and proof sections | Two-column lead, two-column pillars, multi-column founder/proof content. | Maintain editorial text/image relationship and summary ordering. | Leads/pillars become one column at 600px. |

## Public directory controls and tables

The public directory controls are part of the data layout: page introduction first, then a toolbar containing search, filter tabs, and secondary selects/counts, then compact table labels and rows. At 900px the toolbar becomes vertical with a full-width search; at 600px filter controls wrap and nonessential count labels may disappear. A no-results state sits in the results region and offers a reset without changing the page hierarchy.

Use the shared table treatment when a semantic table is appropriate: a bordered, rounded, horizontally scrollable container; left-aligned uppercase header labels; lightly divided rows; and a full-width, centered empty row. Do not make mobile users scroll the page horizontally because of a table.

## Detail and metric presentation

- Scores, K/D/A, gold, exact amount values, identifiers, wallet addresses, and hashes use compact tabular/monospace treatment. Names, labels, summaries, and editorial copy do not.
- A metric always includes a label and its unit/context. A zero result is visibly zero; a value unavailable because no accepted data exists is visibly unavailable, not `0`.
- Card grids are for compact entity summaries. Cards need an identity/banner, privacy or lifecycle badge where applicable, the documented short metric ribbon, and an explicit detail/action affordance.
- Privacy changes the projection, not just the styling. A private team card may show its public/restricted summary, but must replace protected lineup/telemetry with a lock explanation and a join affordance; never include an invite code.
- A chronological feed keeps stable temporal order, actor/record identity, text, attachments, reaction counts, and comment affordances together. Relative dates switch to an absolute date for old entries as defined in the control/acceptance record.

## Responsive and interaction completion gate

Use the source breakpoints rather than a universal breakpoint: public `1200/900/600` with a `760px` journey collapse and `1500px` large-hero adjustment; portal shell `1200/1024/767/580`; tournament command center `1120/1024/850/640/560`. The portal component source also uses the standard responsive tiers for local card/form groupings (`sm`, `md`, `lg`, `xl`, `2xl`); preserve the observed transformation, not the utility class spelling.

Before declaring a screen family visually complete onsite, compare a populated, loading, empty, error, permission-restricted, and narrow state. At desktop verify the stated column count and rail ownership; at the relevant collapse point verify main-before-rail order; at 375px verify no page-level horizontal overflow, contained table/dialog scrolling, reachable actions, visible focus, and correct Escape/focus-return behavior. Existing source UI-AC expectations remain in the [baseline catalogue](../acceptance/FRONTEND_BASELINE.md); this is a required visual review checklist, not a claim that a new UI test suite exists during preparation.

## Audit boundaries and source coverage

This contract defines the approved route wrappers, auth/public/portal/custom assemblies, layout styles, responsive rules, shared data-table/modal/search behavior and interaction inventory. Generic `components/ui` primitives are only a shared control layer; they do not override the page/workspace contracts above. PCC's accepted decisions, feature contracts, privacy rules, server authority, and immediate scrimmage finalization take precedence over any externally supplied material.
