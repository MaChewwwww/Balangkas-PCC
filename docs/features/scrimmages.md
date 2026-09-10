# Scrimmage board and immediate results

**Requirement: FR-SCRIM. Status: specified, unimplemented. Required.**

## Actors and journey

Team captain or manager from participating squad.

Post availability as PENDING (open matchmaking). Challenge requires verified roster of five active players, fair-play agreement and lobby readiness in the existing modal. First accepted opponent locks the room as MATCHED. Persist coordination chat and system notices. One participating captain or manager submits a valid result and atomically creates one finalized match; no second confirmation or timer. Move finalized blocks out of active board and into history.

## Fields and validation

posting_team_id; accepting_team_id; description 1-1000; rank minimum/maximum; scheduled_at; best_of 1/3/5/7; lobby_name and protected lobby_password; status PENDING/MATCHED/FINALIZED/CANCELLED; result winner, series wins, optional MVP and evidence.

Shared type/default/nullability rules are in [data dictionary](../DATABASE.md). Authentication, role checks and private projections follow [security](../SECURITY.md).

## Interfaces

| Method | Path under /api/v1 | Input | Result |
| --- | --- | --- | --- |
| GET | /scrimmages | q, rank, schedule, cursor, limit | 200 active blocks and own pinned blocks |
| POST | /scrimmages | posting_team_id, description, ranks, scheduled_at, best_of, lobby fields | 201 PENDING block |
| GET | /scrimmages/{id} | participant-aware projection | 200 room or public challenge summary |
| PATCH | /scrimmages/{id} | host-editable settings, version | 200 saved block |
| POST | /scrimmages/{id}/accept | team_id, roster/fair_play/lobby acknowledgments | 200 MATCHED |
| POST | /scrimmages/{id}/cancel | host or participating leader, version | 200 CANCELLED |
| GET | /scrimmages/{id}/comments | cursor, limit | 200 persisted messages |
| POST | /scrimmages/{id}/comments | body | 201 message |
| POST | /scrimmages/{id}/result | winner_team_id, team_a_wins, team_b_wins, mvp_user_id optional, evidence_asset_id optional | 200 FINALIZED and match ID |

## Commit, error and audit behavior

Validate session and resource role before body-driven mutations. Apply field rules before any provider request. Use one transaction for related business records, audit event and outbox entry. Capacity/result/issuance operations lock the aggregate; edits check version. Return 409 for stale or incompatible state and 422 for invalid fields. Provider failures preserve committed intent and expose pending/failed state; never fabricate completion. Idempotent retries return the previous reference. Read views use permission-filtered server projections.

## Acceptance scenarios

- **AC-SCRIM-01:** Two concurrent challengers cannot both accept one block.
- **AC-SCRIM-02:** Unrelated user cannot view lobby password or submit result.
- **AC-SCRIM-03:** One valid participating leader submission finalizes immediately and emits one event.
- **AC-SCRIM-04:** Identical replay returns the same match ID; different later payload returns 409 RESULT_ALREADY_FINALIZED.
- **AC-SCRIM-05:** Winner belongs to participating teams and reaches floor(best_of/2)+1 wins; loser stays below that threshold.

## Onsite completion

Implement the specified persistence and routes, bind the approved screen behavior to these contracts, add unit and integration tests for the scenarios above, and verify UI empty/error/loading/success states. Completion requires server evidence; local fixtures do not satisfy it. See [traceability](../TRACEABILITY.md).
