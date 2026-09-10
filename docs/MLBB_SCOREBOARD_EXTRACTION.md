# MLBB extraction and review specification

**Unimplemented in PCC.** Practice experiments inform this design; their source and trained weights are excluded.

## Pipeline

1. Authorize evidence upload, validate image, checksum and save private object metadata.
2. Snapshot the participating game lineup with stable user IDs, canonical IGNs and approved aliases.
3. Run local RF-DETR Medium detection, PaddleOCR text extraction and deterministic template comparison against the pinned hero catalog.
4. Preserve overlapping/mirrored-row diagnostics. Extract squad tag separately from player-only IGN; never derive identity from team color.
5. Normalize Unicode, case and whitespace. Match exact IGN, approved alias, then one unambiguous high-confidence roster-only fuzzy candidate. Retain confidence and basis; ties stay unresolved.
6. Rank hero candidates from portrait evidence and retain crops, scores and catalog/pipeline versions. Items, IGN and KDA do not identify heroes.
7. If explicitly enabled, make one batched external fallback for unresolved fields; no per-row calls or silent retries.
8. Display review queue. Corrections preserve original evidence. Authorized acceptance writes official rows and game outcome atomically, then derives series progress.

## Evidence rules

Rows store side/position, raw tag/IGN, identity state, hero state, K/D/A/gold/score and optional MVP kind WIN/LOSS. Unreadable is null, never zero. UNKNOWN hero is valid diagnostic output. Player attribution must resolve before official attributed statistics. Left/right team mapping requires consistent distinct-team row matches. Duplicate roster assignment is invalid.

States: DRAFT, NEEDS_REVIEW, ACCEPTED, REJECTED, FAILED. Automatic hero acceptance is disabled by default; enable only after held-out calibration and an explicit threshold/margin decision. Reviewed catalog crops cannot double as calibration samples. Human acceptance remains mandatory for official outcomes.

## Runtime and acceptance

Separate OCR dependency lock/image, initial CPU concurrency one. Do not download weights on API startup. Provision weights onsite with provenance and SHA-256, then measure actual VPS memory/latency. Missing weights return unavailable extraction; manual entry remains explicitly manual.

Cover mirrored rows, unreadable digits, invalid image, wrong roster, ambiguous hero, missing crop/model, provider timeout, duplicate upload, simultaneous reviewers, repeated acceptance and failed bracket sync. See [match feature](features/brackets-scoreboard.md) and [data](DATABASE.md).
