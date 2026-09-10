# Brackets, game evidence and organizer review

**Requirement: FR-MATCH. Status: specified, unimplemented. Required.**

## Actors and journey

Tournament creator, authorized match reviewer and permitted spectator.

Generate bracket using locked entry list; shuffle seeds before start only. Review match dossier one game at a time. Upload screenshot to private storage, enqueue extraction, show uncertain fields and evidence. Reviewer confirms/corrects values with rationale and accepts game. Only accepted winner contributes series wins. Completed series schedules idempotent Challonge advancement. Manual result entry remains available with explicit source and audit, not an invented OCR success.

## Fields and validation

match series: source, participating team IDs, round, best_of, wins and status; game: number, winner, left/right mapping, kill totals, duration; evidence: object key, checksum, dimensions; extraction: pipeline/catalog version, raw draft, review state; player stats: roster user, raw IGN/tag, hero candidates, K/D/A, gold, MVP type.

Shared type/default/nullability rules are in [data dictionary](../DATABASE.md). Authentication, role checks and private projections follow [security](../SECURITY.md).

## Interfaces

| Method | Path under /api/v1 | Input | Result |
| --- | --- | --- | --- |
| GET | /tournaments/{id}/bracket | ID | 200 bracket and sync state |
| POST | /tournaments/{id}/bracket | creator, version | 202 bracket job |
| POST | /tournaments/{id}/seeds/shuffle | creator before start, version | 200 stored seed order |
| GET | /matches/{id} | permission context | 200 series, games, evidence and read model |
| POST | /matches/{id}/games/{gameId}/evidence | asset_id | 201 evidence, 202 extraction job reference |
| GET | /ocr-runs/{id} | review permission | 200 draft and candidate evidence |
| POST | /ocr-runs/{id}/review | ACCEPT/REJECT, corrected field table, rationale, version | 200 committed game or rejected draft |
| POST | /matches/{id}/games/{gameId}/result | winner_team_id, permitted score fields, source MANUAL, version | 200 recorded game |
| POST | /tournaments/{id}/bracket/reconcile | creator | 202 reconciliation |

## Commit, error and audit behavior

Validate session and resource role before body-driven mutations. Apply field rules before any provider request. Use one transaction for related business records, audit event and outbox entry. Capacity/result/issuance operations lock the aggregate; edits check version. Return 409 for stale or incompatible state and 422 for invalid fields. Provider failures preserve committed intent and expose pending/failed state; never fabricate completion. Idempotent retries return the previous reference. Read views use permission-filtered server projections.

## Acceptance scenarios

- **AC-MATCH-01:** Same evidence/game acceptance cannot advance bracket twice.
- **AC-MATCH-02:** Left/right screenshot positions never assume platform team colors.
- **AC-MATCH-03:** Unknown/unreadable stats remain null rather than zero.
- **AC-MATCH-04:** Incomplete/ambiguous player identities block their official stats until resolved.
- **AC-MATCH-05:** Provider failure preserves accepted local result and exposes pending bracket synchronization.

## Onsite completion

Implement the specified persistence and routes, bind the approved screen behavior to these contracts, add unit and integration tests for the scenarios above, and verify UI empty/error/loading/success states. Completion requires server evidence; local fixtures do not satisfy it. See [traceability](../TRACEABILITY.md).
