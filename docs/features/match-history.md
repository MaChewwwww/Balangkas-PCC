# Match history and calculated analytics

**Requirement: FR-HISTORY. Status: specified, unimplemented. Required.**

## Actors and journey

Player, authorized team/community member and public-profile reader.

Preserve Matches, Tournament History and Scrimmage History tabs, match feed, expandable team ledgers and right-rail metrics. Every View Match Details action resolves the same canonical dossier with a valid retained navigation origin as [the breadcrumb contract](../screens/BREADCRUMB_CONTEXT.md) defines. Calculate wins/losses and rates from completed series; calculate hero stats from accepted per-game player rows. Exclude pending/void records. A series is one match in headline match totals; games are counted separately.

## Fields and validation

source TOURNAMENT/SCRIMMAGE; series and game IDs; opponent, winner, dates; historical team membership; official statistics; tournament placement; CSV filters and pagination.

Shared type/default/nullability rules are in [data dictionary](../DATABASE.md). Authentication, role checks and private projections follow [security](../SECURITY.md).

## Interfaces

| Method | Path under /api/v1 | Input | Result |
| --- | --- | --- | --- |
| GET | /matches | source, team_id, player_id, tournament_id, date_from, date_to, cursor, limit | 200 permitted match feed |
| GET | /teams/{id}/analytics | date range | 200 calculated metrics |
| GET | /profiles/{id}/analytics | visibility and date range | 200 calculated metrics |
| GET | /teams/{id}/history | cursor, limit | 200 series and placements |
| GET | /teams/{id}/export | date range | 200 flattened CSV |

## Commit, error and audit behavior

Validate session and resource role before body-driven mutations. Apply field rules before any provider request. Use one transaction for related business records, audit event and outbox entry. Capacity/result/issuance operations lock the aggregate; edits check version. Return 409 for stale or incompatible state and 422 for invalid fields. Provider failures preserve committed intent and expose pending/failed state; never fabricate completion. Idempotent retries return the previous reference. Read views use permission-filtered server projections.

## Acceptance scenarios

- **AC-HISTORY-01:** Tournament and scrimmage finalization each contribute exactly one series.
- **AC-HISTORY-02:** Roster departure does not reassign old player statistics.
- **AC-HISTORY-03:** No matches gives zero count and unavailable win-rate denominator.
- **AC-HISTORY-04:** CSV uses stable IDs, ISO timestamps and explicit columns; formula-leading text is escaped.
- **AC-HISTORY-05:** Public analytics honor profile/team visibility and never include raw OCR evidence.

## Onsite completion

Implement the specified persistence and routes, bind the approved screen behavior to these contracts, add unit and integration tests for the scenarios above, and verify UI empty/error/loading/success states. Completion requires server evidence; local fixtures do not satisfy it. See [traceability](../TRACEABILITY.md).
