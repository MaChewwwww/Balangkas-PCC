# Brackets, game evidence and organizer review

**Requirement: FR-MATCH. Status: specified, unimplemented. Required.**

## Actors and journey

Tournament creator, authorized match reviewer and permitted spectator.

Generate bracket using locked entry list; shuffle seeds before start only. Review match dossier one game at a time. Preserve a valid tournament, Current Team or Match History path to that dossier as [the breadcrumb contract](../screens/BREADCRUMB_CONTEXT.md) defines. Upload screenshot to private storage, snapshot the participating lineup, enqueue local RF-DETR/PaddleOCR/template extraction, and show uncertain fields beside their evidence. The detector owns field geometry, PaddleOCR recognizes detector crops only, and hero templates provide a candidate list only. Reviewer confirms/corrects visible values with rationale and accepts game. Only accepted winner contributes series wins. Completed series schedules idempotent Challonge advancement. Manual result entry remains available with explicit source and audit, not an invented OCR success. No screenshot/provider fallback is permitted.

## Fields and validation

match series: source, participating team IDs, round, best_of, wins and status; game: number, winner, left/right mapping, kill totals, duration; evidence: private asset ID/checksum/orientation-normalized dimensions; extraction: fixed layout profile, RF-DETR checkpoint identity, PaddleOCR/runtime identity, catalog version, immutable diagnostics, raw draft and review state; player stats: frozen-roster user, raw IGN/tag, identity state/basis, hero candidates, selected catalog hero or UNKNOWN, K/D/A, gold, rating and MVP type.

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
| POST | /ocr-runs/{id}/review | ACCEPT/REJECT, only detected-row corrections, rationale, version, idempotency key | 200 atomically committed game or rejected draft; incomplete draft remains review-required |
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
- **AC-MATCH-06:** Missing/mismatched local model or catalog/runtime inputs, or absent recorded checkpoint-use approval, leave extraction unavailable without an official write.
- **AC-MATCH-07:** Oversized/slow-to-decode media is rejected before storage; EXIF orientation is normalized in memory; a valid but unsupported layout becomes `UNSUPPORTED_LAYOUT`/review. Obscured, ambiguous or absent detector/OCR fields stay null or require a clearer screenshot; no contextual guessing occurs.
- **AC-MATCH-08:** Hero-template ranks and fuzzy IGN matches are review aids only, never automatic official attribution.
- **AC-MATCH-09:** The local extraction path has no runtime download or external screenshot/model-provider egress.
- **AC-MATCH-10:** Complete authorized review accepts atomically and idempotently; stale/duplicate review cannot advance a series twice.
- **AC-MATCH-11:** Approved reference screenshots verify layout/overlay handling manually and never become hard-coded PCC data.

## Onsite completion

Implement the specified persistence and routes, bind the approved screen behavior to these contracts, add unit and integration tests for the scenarios above, and verify UI empty/error/loading/success states. Completion requires server evidence; local fixtures do not satisfy it. See [traceability](../TRACEABILITY.md).
