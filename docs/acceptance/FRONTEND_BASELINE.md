# Frontend acceptance baseline

123 named interaction expectations are recorded here. These descriptions are acceptance references, not proof that PCC is implemented. Expectations mentioning local/simulated behavior require server-backed equivalence, not copying a simulation.

| ID | Expected interaction | PCC translation |
| --- | --- | --- |
| UI-AC-001 | renders page header, telemetry HUD, and 3 distinct tabs | Preserve expected user-visible behavior with live authorization and persistence. |
| UI-AC-002 | renders match feed with tournament and scrimmage matches in Matches tab | Preserve expected user-visible behavior with live authorization and persistence. |
| UI-AC-003 | switches to Tournament History tab and renders placements with navigation links | Preserve expected user-visible behavior with live authorization and persistence. |
| UI-AC-004 | switches to Scrimmage History tab and expands per-team scrimmage ledger | Preserve expected user-visible behavior with live authorization and persistence. |
| UI-AC-005 | renders Match History inside PortalShell with active sidebar navigation highlight | Preserve expected user-visible behavior with live authorization and persistence. |
| UI-AC-006 | renders double column layout with search, filters, and linked View Match Details actions | Preserve expected user-visible behavior with live authorization and persistence. |
| UI-AC-007 | renders breadcrumb 'Portal -> Current Team -> Team Name' when viewing team details from Current Team | Preserve expected user-visible behavior with live authorization and persistence. |
| UI-AC-008 | renders breadcrumb 'Portal -> Current Team -> Team Name' when navigating with ?from=my-team | Preserve expected user-visible behavior with live authorization and persistence. |
| UI-AC-009 | delegates to TeamsWorkspace in mode='detail' | Preserve expected user-visible behavior with live authorization and persistence. |
| UI-AC-010 | keeps the Current Team origin on match dossier links | Preserve expected user-visible behavior with live authorization and persistence. |
| UI-AC-011 | renders Current Team inside PortalShell with active navigation highlight | Preserve expected user-visible behavior with live authorization and persistence. |
| UI-AC-012 | renders two-column List View with active squads, previous teams, and right-rail metrics HUD | Preserve expected user-visible behavior with live authorization and persistence. |
| UI-AC-013 | filters teams by search query in List View | Preserve expected user-visible behavior with live authorization and persistence. |
| UI-AC-014 | opens Join Team modal from List View and handles team joining | Preserve expected user-visible behavior with live authorization and persistence. |
| UI-AC-015 | opens New Team modal in-place without navigating when clicking New Team | Preserve expected user-visible behavior with live authorization and persistence. |
| UI-AC-016 | renders title, description, and action button cleanly to maximize space | Preserve expected user-visible behavior with live authorization and persistence. |
| UI-AC-017 | renders search bar on the left and chip tabs on the right with interactive controls | Preserve expected user-visible behavior with live authorization and persistence. |
| UI-AC-018 | renders cards with staggered animation delays and updates on filter | Preserve expected user-visible behavior with live authorization and persistence. |
| UI-AC-019 | displays the specific community name in the breadcrumb navigation | Preserve expected user-visible behavior with live authorization and persistence. |
| UI-AC-020 | opens popover, lists options with descriptions, and selects value | Preserve expected user-visible behavior with live authorization and persistence. |
| UI-AC-021 | opens modal, displays live preview, allows selecting presets, and creates community | Preserve expected user-visible behavior with live authorization and persistence. |
| UI-AC-022 | opens popover, searches by acronym and full name, and selects an institution | Preserve expected user-visible behavior with live authorization and persistence. |
| UI-AC-023 | clears selected school when clear button is clicked | Preserve expected user-visible behavior with live authorization and persistence. |
| UI-AC-024 | renders 4 tabs, switches between them, and creates a post with image attachment | Preserve expected user-visible behavior with live authorization and persistence. |
| UI-AC-025 | returns 'Just now' for timestamps less than 60 seconds ago | Preserve expected user-visible behavior with live authorization and persistence. |
| UI-AC-026 | returns minutes ago for timestamps under 60 minutes | Preserve expected user-visible behavior with live authorization and persistence. |
| UI-AC-027 | returns hours ago for timestamps under 24 hours | Preserve expected user-visible behavior with live authorization and persistence. |
| UI-AC-028 | returns days ago for timestamps under 7 days | Preserve expected user-visible behavior with live authorization and persistence. |
| UI-AC-029 | switches to absolute datetime when 7 days or older | Preserve expected user-visible behavior with live authorization and persistence. |
| UI-AC-030 | renders relative timestamps on existing posts and comments | Preserve expected user-visible behavior with live authorization and persistence. |
| UI-AC-031 | renders Player Detail page with breadcrumb 'Portal -> Player Data -> IGN' | Preserve expected user-visible behavior with live authorization and persistence. |
| UI-AC-032 | renders overhauled Team Detail page with telemetry strip, active lineup, match ledger, and achievements | Preserve expected user-visible behavior with live authorization and persistence. |
| UI-AC-033 | links the match ledger to the tournament match dossier | Preserve expected user-visible behavior with live authorization and persistence. |
| UI-AC-034 | renders hierarchical breadcrumb: Portal -> Communities -> Community Name -> Record Title | Preserve expected user-visible behavior with live authorization and persistence. |
| UI-AC-035 | renders hierarchical breadcrumb when navigating from team: Portal -> Teams -> Team Name -> Tournament Name | Preserve expected user-visible behavior with live authorization and persistence. |
| UI-AC-036 | includes ?fromCommunity query param in Members List and Team Rosters links | Preserve expected user-visible behavior with live authorization and persistence. |
| UI-AC-037 | renders multi-segment breadcrumb: Portal -> Communities -> Community Name -> IGN -> Tournament Name | Preserve expected user-visible behavior with live authorization and persistence. |
| UI-AC-038 | PlayerDataWorkspace preserves fromCommunity in tournament and team links | Preserve expected user-visible behavior with live authorization and persistence. |
| UI-AC-039 | retains 'Communities' as the active sidebar item when navigation originated from community | Preserve expected user-visible behavior with live authorization and persistence. |
| UI-AC-040 | retains 'Communities' as active sidebar item when viewing a team page with community parent | Preserve expected user-visible behavior with live authorization and persistence. |
| UI-AC-041 | highlights Teams & Lineups for a player profile opened from a team roster | Preserve expected user-visible behavior with live authorization and persistence. |
| UI-AC-042 | activates target area normally when navigation did not originate from community | Preserve expected user-visible behavior with live authorization and persistence. |
| UI-AC-043 | displays Public or Private badges on all team cards and NEVER exposes invite codes in the directory list | Preserve expected user-visible behavior with live authorization and persistence. |
| UI-AC-044 | masks private team telemetry for outsiders and shows 'Join via Invite Code' | Preserve expected user-visible behavior with live authorization and persistence. |
| UI-AC-045 | unlocks and joins private team when valid invite code is submitted in join modal | Preserve expected user-visible behavior with live authorization and persistence. |
| UI-AC-046 | renders restricted lock screen when visiting a private squad URL without authorization | Preserve expected user-visible behavior with live authorization and persistence. |
| UI-AC-047 | opens overhauled Team Creation modal with banner presets and live card preview | Preserve expected user-visible behavior with live authorization and persistence. |
| UI-AC-048 | renders 2-column command center layout with right-rail search, division filter, and telemetry HUD | Preserve expected user-visible behavior with live authorization and persistence. |
| UI-AC-049 | renders unread notification badge on bell trigger | Preserve expected user-visible behavior with live authorization and persistence. |
| UI-AC-050 | opens flyout and allows marking all notifications as read | Preserve expected user-visible behavior with live authorization and persistence. |
| UI-AC-051 | filters unread notifications and supports dismiss | Preserve expected user-visible behavior with live authorization and persistence. |
| UI-AC-052 | creates a local team and exposes squad management controls | Preserve interaction; replace local/simulated outcome with authorized persisted result. |
| UI-AC-053 | renders the athlete passport masthead with identity badges including the simulation label | Preserve interaction; replace local/simulated outcome with authorized persisted result. |
| UI-AC-054 | renders all 4 tabs and switches between them | Preserve expected user-visible behavior with live authorization and persistence. |
| UI-AC-055 | renders the credentials tab count as a badge pill and not as inline parentheses | Preserve expected user-visible behavior with live authorization and persistence. |
| UI-AC-056 | labels the biometric and Solana wallet surfaces as simulations | Preserve interaction; replace local/simulated outcome with authorized persisted result. |
| UI-AC-057 | renders double column layout with search, credential filters, performance HUD, and arena CTA on the right rail | Preserve expected user-visible behavior with live authorization and persistence. |
| UI-AC-058 | filters credentials by credential type and restores the full list on All | Preserve expected user-visible behavior with live authorization and persistence. |
| UI-AC-059 | filters credentials and match records by search query and shows the no-results empty states | Preserve expected user-visible behavior with live authorization and persistence. |
| UI-AC-060 | renders Career Portfolio inside PortalShell with active sidebar navigation highlight | Preserve expected user-visible behavior with live authorization and persistence. |
| UI-AC-061 | renders Scrimmage Board directory without tabs or settled scrimmages, showing active matchmaking requests | Preserve expected user-visible behavior with live authorization and persistence. |
| UI-AC-062 | requests a new scrimmage via modal | Preserve expected user-visible behavior with live authorization and persistence. |
| UI-AC-063 | opens verification modal when challenging a squad and transitions scrimmage to MATCHED upon confirmation | Preserve expected user-visible behavior with live authorization and persistence. |
| UI-AC-064 | cancels challenge verification modal without changing scrimmage status | Preserve expected user-visible behavior with live authorization and persistence. |
| UI-AC-065 | renders dedicated Match Room detail view with head-to-head teams and custom lobby credentials | Preserve expected user-visible behavior with live authorization and persistence. |
| UI-AC-066 | exchanges live coordination chat messages and allows using quick preset chips in Match Room | Preserve expected user-visible behavior with live authorization and persistence. |
| UI-AC-067 | submits official match result via modal, simulates OCR parse, and deterministically finalizes the scrimmage | Preserve interaction; replace local/simulated outcome with authorized persisted result. |
| UI-AC-068 | opens Manage Settings modal from Match Room toolbar and allows the host to update scrimmage settings | Preserve expected user-visible behavior with live authorization and persistence. |
| UI-AC-069 | renders right-rail user scrimmage performance HUD with matches, winrate, victory, and defeat | Preserve expected user-visible behavior with live authorization and persistence. |
| UI-AC-070 | renders overhauled data cards with View Team Details buttons, H2H winrate, and Fresh Opponent chips | Preserve expected user-visible behavior with live authorization and persistence. |
| UI-AC-071 | renders Pinned Active Scrimmages at the top when ongoing or user scrimmages exist, and hides it when none match | Preserve expected user-visible behavior with live authorization and persistence. |
| UI-AC-072 | opens Edit Scrimmage Request modal from Scrimmage Board directory when 'Edit Request' is clicked | Preserve expected user-visible behavior with live authorization and persistence. |
| UI-AC-073 | shows tournament-specific team roster details and profile links | Preserve expected user-visible behavior with live authorization and persistence. |
| UI-AC-074 | renders tournament team detail breadcrumbs: Portal -> Tournaments -> Tournament Name -> Team Name | Preserve expected user-visible behavior with live authorization and persistence. |
| UI-AC-075 | records results and optional evidence at the individual-game level on a match page | Preserve expected user-visible behavior with live authorization and persistence. |
| UI-AC-076 | reuses the tournament match dossier with a match-history breadcrumb | Preserve expected user-visible behavior with live authorization and persistence. |
| UI-AC-077 | retains the current-team breadcrumb when a team ledger opens the dossier | Preserve expected user-visible behavior with live authorization and persistence. |
| UI-AC-078 | parses exact minor-unit amounts without silently rounding | Preserve expected user-visible behavior with live authorization and persistence. |
| UI-AC-079 | only exposes Solana entry fees when the creator has a linked wallet | Preserve the gate with a server-projected Solana Devnet destination and finalized-evidence state; no local wallet callback can settle it. |
| UI-AC-080 | keeps cash/E-Wallet prize PHP and PayMongo test-checkout entry-fee labels distinct; never calls the entry fee InstaPay | Preserve expected user-visible behavior with live authorization and persistence. |
| UI-AC-081 | renders Directory mode with carousel, image showcase, and view switchers | Preserve expected user-visible behavior with live authorization and persistence. |
| UI-AC-082 | switches views between Feed, Grid, and Table | Preserve expected user-visible behavior with live authorization and persistence. |
| UI-AC-083 | filters tournaments by search term | Preserve expected user-visible behavior with live authorization and persistence. |
| UI-AC-084 | allows reacting to an article with cheer/fire/trophy | Preserve expected user-visible behavior with live authorization and persistence. |
| UI-AC-085 | copies tournament link and shows visual confirmation when clicking share button | Preserve expected user-visible behavior with live authorization and persistence. |
| UI-AC-086 | renders Detail mode with the tournament command center and switches between all 5 tabs | Preserve expected user-visible behavior with live authorization and persistence. |
| UI-AC-087 | opens the certificate issuance modal and records a credential | Preserve the modal with server-authorized Core NFT draft/pending-reconciliation/issued/voided states; never turn a local mint/callback into issuance. |
| UI-AC-088 | keeps team reward actions locked until completion and moves members to certificates | Preserve expected user-visible behavior with live authorization and persistence. |
| UI-AC-089 | renders match page breadcrumb with format 'Portal -> Tournaments -> Tournament Name -> Match ID' | Preserve expected user-visible behavior with live authorization and persistence. |
| UI-AC-090 | shows the creator name when a tournament has no affiliated community | Preserve expected user-visible behavior with live authorization and persistence. |
| UI-AC-091 | shows a private invite code, creator settings, and an icon-only share control in the hero | Preserve expected user-visible behavior with live authorization and persistence. |
| UI-AC-092 | locks the same edit fields after a tournament has started | Preserve expected user-visible behavior with live authorization and persistence. |
| UI-AC-093 | shows creator lifecycle controls and allows staffing before start | Preserve expected user-visible behavior with live authorization and persistence. |
| UI-AC-094 | starts a seeded tournament and locks staffing after confirmation | Preserve interaction; replace local/simulated outcome with authorized persisted result. |
| UI-AC-095 | keeps end guarded when an active tournament still has unfinished matches | Preserve expected user-visible behavior with live authorization and persistence. |
| UI-AC-096 | shows match links from the bracket tab | Preserve expected user-visible behavior with live authorization and persistence. |
| UI-AC-097 | renders Create mode and submits a new tournament with esports settings and pubmat upload | Preserve expected user-visible behavior with live authorization and persistence. |
| UI-AC-098 | opens Join via Invite Code modal, verifies passcode, and registers squad | Preserve expected user-visible behavior with live authorization and persistence. |
| UI-AC-099 | renders Join mode and registers squad | Preserve expected user-visible behavior with live authorization and persistence. |
| UI-AC-100 | renders Manage mode (Director Desk) and supports stage advancement | Preserve expected user-visible behavior with live authorization and persistence. |
| UI-AC-101 | supports carousel auto-scroll controls, pause toggle, hover events, and dot selection | Preserve expected user-visible behavior with live authorization and persistence. |
| UI-AC-102 | uses the poster without mounting 3D for reduced motion or unavailable WebGL | Preserve expected user-visible behavior with live authorization and persistence. |
| UI-AC-103 | pauses offscreen and preserves manual pause when the scene returns | Preserve expected user-visible behavior with live authorization and persistence. |
| UI-AC-104 | falls back after context loss and responds to motion preference changes | Preserve expected user-visible behavior with live authorization and persistence. |
| UI-AC-105 | reflects a portal-store visibility change in the public directory | Preserve expected user-visible behavior with live authorization and persistence. |
| UI-AC-106 | encodes a submitted certificate query and prevents empty submission | Preserve expected user-visible behavior with live authorization and persistence. |
| UI-AC-107 | shows an empty result then restores the directory when filters reset | Preserve expected user-visible behavior with live authorization and persistence. |
| UI-AC-108 | opens a bracket match and closes it with Escape | Preserve expected user-visible behavior with live authorization and persistence. |
| UI-AC-109 | opens accessible navigation, closes with Escape and returns focus | Preserve expected user-visible behavior with live authorization and persistence. |
| UI-AC-110 | starts versioned, normalized, and isolated from fixture mutation | Preserve interaction; replace local/simulated outcome with authorized persisted result. |
| UI-AC-111 | keeps archived records out while retaining discoverable private teams | Preserve expected user-visible behavior with live authorization and persistence. |
| UI-AC-112 | contains local reward and scrimmage surfaces without external service state | Preserve interaction; replace local/simulated outcome with authorized persisted result. |
| UI-AC-113 | keeps prize pools in PHP while keeping entry fees in exact centavos | Preserve expected user-visible behavior with live authorization and persistence. |
| UI-AC-114 | seeds the 4 collegiate and grassroots communities with correct assets | Preserve interaction; replace local/simulated outcome with authorized persisted result. |
| UI-AC-115 | does not reveal private teams or players through search or direct lookup | Preserve expected user-visible behavior with live authorization and persistence. |
| UI-AC-116 | does not substitute a different record for missing IDs | Preserve expected user-visible behavior with live authorization and persistence. |
| UI-AC-117 | combines case-insensitive trimmed search with team tier and player role | Preserve expected user-visible behavior with live authorization and persistence. |
| UI-AC-118 | sorts by recorded win rate without mutating the source | Preserve expected user-visible behavior with live authorization and persistence. |
| UI-AC-119 | keeps invitation-only tournaments discoverable and combines every filter | Preserve expected user-visible behavior with live authorization and persistence. |
| UI-AC-120 | resolves IDs and exact mint addresses to the same credential | Preserve lookup behavior using certificate code and exact Metaplex Core asset address; the prototype mint term is not the PCC data model. |
| UI-AC-121 | handles arbitrary input without object-prototype or missing-record fallbacks | Preserve expected user-visible behavior with live authorization and persistence. |
| UI-AC-122 | preserves tournament context only for joinable events | Preserve expected user-visible behavior with live authorization and persistence. |
| UI-AC-123 | links only explicit, available public profiles | Preserve expected user-visible behavior with live authorization and persistence. |
