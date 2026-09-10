# Tournament discovery and command center

## Layout contract

Apply the shared [layout contract](LAYOUT.md). The tournament directory begins with an editorial marquee/carousel whose text spans 7/12 and image spans 5/12 at desktop, followed by a toolbar with search and Feed/Grid/Table switcher. Feed cards pair a fixed visual column with article metadata; Grid is three columns on desktop; Table remains a dense, horizontally contained data view. The three modes are alternate views of the same permitted projection, not different records.

Create/manage keeps a large form/operations area and a peer 5/12 pubmat/preview area; related short fields pair at small/medium widths and stack when needed. Tournament detail is the command-center pattern: four metrics, then Overview, Teams, Bracket, Matches, and Rewards as separate panels. From 1120px, the flexible main column has a fixed 320px filter/telemetry/activity rail; the ribbon is four columns at 1024px and two below. Team and match subroutes keep the tournament masthead and hierarchical breadcrumb instead of opening generic team/match pages, following [the cross-feature breadcrumb contract](BREADCRUMB_CONTEXT.md).

Use public/portal/auth typography and responsive rules from [DESIGN](../DESIGN.md). Preserve captions from [CONTROLS](CONTROLS.md); [ROUTES](ROUTES.md) identifies each approved page assembly.

## Fields and controls

Event name/game/host, dates, capacity, category, bracket type, best-of/finals, third place, grand finals, Swiss rounds, join mode/code, fee and prize controls, banner/editorial fields.

### Create and manage form arrangement

Keep the approved desktop 7/12 operations form plus 5/12 visual-identity/live-preview split. In the operations column, preserve the visible source sequence: Tournament Name; Start and End Date pair; Description; Bracket Format and Series Length pair; applicable third-place, grand-finals, or Swiss modifier; Capacity; Circuit Division and Accessibility Type pair; conditional private invite code; Prize rail and exact amount pair; Entry-fee rail and exact amount pair. The visual column contains Game Title, **Hosted by**, 16:9 pubmat upload/preview, and the live Feed/Grid card preview. `Hosted by` selects only the session creator or a community for which the server projects the creator as an eligible owner/manager; it never accepts arbitrary host text or a client-supplied creator ID.

PCC additionally requires controls absent from the source form. Put Registration Deadline directly below the Start/End pair; put Eligibility Mode beside or directly below Circuit Division/Accessibility Type, followed by canonical institution selection only for `SELECTED_HEIS`; put Requirements enabled and its conditional prompt directly after eligibility. These controls remain in the 7/12 operations column, preserve the same field framing and narrow stack order, and are locked with the other server-locked configuration after start. They must not be omitted, hidden behind a generic “advanced” screen, or represented solely by descriptive text.

## Actions and navigation

Search/filter/react/share, create/edit, register/withdraw, assign staff, generate/shuffle bracket, start/end/archive, announcements, review games, allocate prizes and issue certificates.

## Permission and state behavior

Creator controls sensitive settings; format/capacity/fees/eligibility/staff locked after start. End disabled while required matches unfinished. Reward actions locked before completion. Invitation-only remains publicly discoverable.

Every async control has loading/disabled, validation error, network error with retained draft, and actual success states. Missing records show not-found rather than fallback data. Modals trap focus, close with Escape and return focus. Narrow viewports stack rails, retain content order and keep scrolling inside tables/dialogs.

## Data and acceptance

Use the [Tournament discovery and command center feature contract](../features/tournaments.md) and its field/error/transaction rules. Translate related UI-AC scenarios from the [baseline catalogue](../acceptance/FRONTEND_BASELINE.md); use persisted fixtures created onsite, never copy source fixture modules. Verify desktop and 375px mobile states before parity sign-off.
