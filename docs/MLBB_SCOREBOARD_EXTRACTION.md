# MLBB scoreboard extraction and review

**Status: preparation contract only.** No PCC extraction implementation, worker, database migration or test exists yet. This record preserves the approved local runtime inputs and the exact review boundary for onsite implementation. It does not import external implementation.

## Purpose and authority

The feature converts a private MLBB post-match screenshot into a reviewer-visible **draft**. It never makes an official game result by inference. An authorized tournament reviewer must accept a complete, internally consistent draft in one transaction before player statistics, game winner, series score or bracket advancement change.

The worker uses exactly three local stages:

1. RF-DETR Medium finds known MLBB scoreboard regions and establishes the five-left/five-right row geometry.
2. PaddleOCR recognizes text only inside those detector-located crops. It is not allowed to run a second full-image text-detection pass.
3. A checksum-verified, local hero portrait catalog ranks a small candidate list for each detected hero crop. It is a retrieval aid, never an authoritative classifier.

No screenshot, crop, candidate data, raw OCR text or inferred result may be sent to an external AI/model provider. There is no provider fallback, no silent retry through another service and no runtime model download.

## Approved local artifact and runtime inventory

| Input | PCC location / version | Identity and rule |
| --- | --- | --- |
| RF-DETR MLBB-layout checkpoint | `models/scoreboard/roboflow_weights.pt`; mounted as `/models/scoreboard/roboflow_weights.pt` | User-authorized preparation host input, but not automatically use-approved. SHA-256 `528aab59fb4254e4f2fc2cd6791171e67a29ec1bb2d844344e55f81865e3c8a3`; 138,919,727 bytes. Its safe-read metadata is encoder `dinov2_windowed_small` and resolution 480. Verify checksum and metadata before every machine/VPS use. It is an RF-DETR Medium checkpoint, not a generic RF-DETR base model. |
| RF-DETR layout contract | `mlbb_post_match_v1` | The checkpoint must expose these 14 foreground labels in this exact order: `game_duration`, `game_result`, `game_score`, `game_scoreboard`, `gold`, `hero`, `ign`, `items`, `kda`, `mvp_loss`, `mvp_win`, `noise_overlay`, `player_info`, `player_score`. Its foreground IDs are one-based; ID zero is background. A different checksum, labels, ID mapping or training-resolution metadata is unavailable, not a compatible substitute. |
| RF-DETR runtime | `rfdetr==1.10.1` in `backend/requirements-ocr.lock` | Worker-only, CPU-only dependency image. Detector confidence starts at 0.35; same-label near-duplicates are suppressed at intersection-over-union 0.92. These are starting configuration facts, not a promise of accuracy. |
| PaddleOCR runtime | `paddleocr==3.7.0`, `paddlepaddle==3.3.1` in `backend/requirements-ocr.lock` | Runtime package is prepared, but its actual recognition assets are **not** approved/provisioned in this repository. Before enabling extraction, an operator must manually provision every PaddleOCR asset under `PCC_SCOREBOARD_PADDLE_MODELS_ROOT`, retain its source/version/license/checksum record outside the repository, and prove the runtime cannot download. If this is absent or mismatched, extraction remains unavailable. |
| Hero template catalog | `reference-data/mlbb/heroes/2026-09-09-rone` | 133 catalog entries and 133 portrait files, with per-file hashes in `heroes.json`. `heroes.json` SHA-256 is `03d3746005b5f035327b00d2fec9ee6299add61c7343e5f1141702d4601e6bc3`; `manifest.json` SHA-256 is `a3d2e7f5f871d064feef3041363be1759d647367c4d1f16ff34a5e19b43c01a0`. Load fails closed on catalog/version/hash mismatch. |

The checkpoint and any future manually provisioned PaddleOCR files under `models/scoreboard` are excluded from Git, Docker build context, release images, browser assets and object storage. The checkpoint is manually copied and verified separately on each developer machine and the staging VPS. Only the documented local target path and exact checksum identify the artifact; no alternate filename is an acceptable substitute.

The preparation template preselects `PCC_SCOREBOARD_EXTRACTION_ENABLED=true` as user-approved hackathon scope. The model path, Paddle asset root, catalog version, timeout and one-job concurrency live in `.env.application`; model hashes do not. The hash records in this document are the immutable artifact identities. An actual runtime may enable the feature only when the release record shows successful hash/catalog checks, locally provisioned Paddle assets, CPU-load result and operator approval; otherwise it remains unavailable. The Compose model mount is read-only.

## RF-DETR provenance and use-right status

The approved record identifies this artifact only by its SHA-256, architecture, resolution and labels. Safe-read checkpoint metadata adds `dataset_file=roboflow`, `encoder=dinov2_windowed_small` and `epochs=100`; it does **not** identify a Roboflow workspace, dataset owner, dataset license, exporter or acquisition account. Those facts cannot be reconstructed from the `.pt` file and are therefore recorded as **unverified**, not assumed.

Roboflow's official RF-DETR repository states that the `rfdetr` package and Apache-designated model weights use Apache 2.0. That establishes the upstream software/base-weight policy, not a use right for this separately fine-tuned MLBB-layout checkpoint or its training screenshots. See [the official RF-DETR license statement](https://github.com/roboflow/rf-detr/blob/develop/README.md#license).

At the user's direction, the preparation template preselects `PCC_SCOREBOARD_USAGE_APPROVED=true`. That value is not an approval record: before actual use, an operator still retains outside this repository the artifact's original acquisition source and account/owner; the SHA-256 and acquisition date; the fine-tuning dataset/source and intended hackathon use; the applicable checkpoint/dataset rights; and the approving person. Missing evidence keeps the checkpoint unavailable. The existing 133-hero catalog stays pinned for this hackathon; new heroes, UI versions and skins are not a preparation or onsite-expansion task unless the user explicitly authorizes one.

## Bounded fixed-layout intake

Only `mlbb_post_match_v1` is supported. Before storage or queueing, the API must accept JPEG/PNG/WebP only, enforce 10,485,760 bytes, 16,777,216 decoded pixels and 8192 pixels on either side, decode/orientation-normalize within five seconds, apply EXIF orientation in memory and remove metadata from the processing copy. The original evidence checksum remains the checksum of uploaded bytes; normalized dimensions and orientation outcome are diagnostics.

Invalid, oversized, animated or slow-to-decode media is rejected as upload failure before it becomes evidence. A valid image that fails the fixed-layout attestation—missing/ambiguous required scoreboard geometry, unsupported UI placement or unsupported version—creates an `ocr_runs` record at `NEEDS_REVIEW` with draft `submission_state=UNSUPPORTED_LAYOUT`. It displays no inferred scorecard and offers only clearer evidence, explicit manual result entry, or rejection. It never tries a different layout parser.

## Detector-led draft construction

1. The API authorizes the evidence upload; enforces the fixed byte/pixel/side/decode-time bounds; normalizes EXIF orientation in memory; hashes the original bytes; stores it privately; and snapshots the participating game lineup: stable user IDs, team IDs, canonical IGNs and reviewer-approved aliases.
2. The worker verifies the RF-DETR artifact before loading it, processes the image once, rejects detector boxes below 0.35 confidence and retains its bounded diagnostics. It never assumes a game from filename, image order, team colour or a familiar screenshot.
3. `game_scoreboard` and hero boxes establish left/right visual sides and five row anchors per side. Hero boxes are preferred anchors; only a regular four-row geometry may yield one interpolated anchor. Fewer/more/ambiguous rows remain draft diagnostics rather than invented rows.
4. `ign`, `kda`, `gold`, `player_score`, `items`, `mvp_win` and `mvp_loss` boxes attach to the nearest compatible row only when the assignment is sufficiently plausible. `game_score`, `game_duration` and `game_result` are read only from their detected global boxes.
5. PaddleOCR receives only these crops. Crops are enlarged for recognition; numeric KDA/rating crops may receive bounded grayscale/contrast/threshold retries. The parser accepts only unambiguous K/D/A, integer gold, rating, duration and VICTORY/DEFEAT forms. An unreadable value is `null`, never zero or a guessed value.
6. Each hero crop is tightly bounded around the detected portrait. Local template comparison uses the pinned catalogue's RGB, grayscale, edge and colour features to rank at most five candidates. It must not use items, text, row side, team knowledge or game knowledge to choose a hero.
7. IGN reconciliation normalizes only visible text. Exact canonical IGNs and approved aliases may resolve a roster participant. A fuzzy match is a labelled suggestion only; ties, uncertain text and cross-team ambiguity stay unresolved. Screenshot side maps to a team only when resolved rows consistently identify two distinct participating teams.
8. Persist immutable detector/OCR diagnostics and the draft separately from reviewer corrections. The raw screenshot remains the private `match_evidence` asset; public/list projections never expose it, private object keys or raw OCR payload.

For the initial hackathon implementation, automatic hero acceptance stays disabled. A future opt-in needs a recorded held-out calibration for the exact checkpoint, matcher version and catalog, plus an explicit threshold/margin decision. Reviewed rows cannot be recycled as calibration evidence.

## Review and finalization gate

`ocr_runs.status` is `DRAFT`, `NEEDS_REVIEW`, `ACCEPTED`, `REJECTED` or `FAILED`. Within a draft, `submission_state` may be `READY_FOR_REVIEW`, `NEEDS_CLEARER_SCREENSHOT` or `UNSUPPORTED_LAYOUT`; the latter two remain `NEEDS_REVIEW` at the run level and carry field/row feedback.

A reviewer sees the source evidence, detector-associated row crop, raw/parsed field values, confidence/diagnostic state, candidate hero list and active roster context. The reviewer can confirm or correct a catalog hero, explicitly mark it `UNKNOWN`, correct only visible values with a rationale, request a clearer screenshot, or reject the run. A correction must target a real detected row, choose a hero present in the pinned catalog and choose a participant from the frozen active lineup. It cannot create a hero, roster member, score or hidden field.

Acceptance requires all of the following at the same aggregate version:

- exactly five player rows on each visual side;
- non-null visible IGN, K/D/A, gold and rating for every accepted player row;
- left/right KDA kill sums equal the respective detected game-score totals;
- every attributed participant is `EXACT` or `ALIAS`, with no duplicate active-roster assignment;
- exactly one winning and one losing MVP marker, when the supplied layout exposes them;
- a consistent left/right-to-participating-team mapping and a reviewer-confirmed winner;
- an authorized reviewer, idempotency key and audit rationale.

The acceptance transaction writes the reviewed `ocr_run`, game player-stat rows, game winner/score and series projection together. It creates one outbox event for bracket synchronization after the local transaction commits. A duplicate acceptance returns the existing result; a stale/conflicting review does not overwrite it. Any failed or incomplete draft remains pending or is rejected. Manual result entry is separate, explicitly labelled `MANUAL`, and never poses as OCR success.

## Reviewed reference evidence

The following approved repository images are visual/layout and future controlled-validation references only. They are exact copies of the old non-live fixtures; they are not an uploaded PCC match, seed data, an automatic browser E2E fixture or an official statistic.

| Reference | SHA-256 | Observed constraints |
| --- | --- | --- |
| `assets/public/images/match-evidence/match-101-game-1.jpg` | `e5e85024116f4cca3504a190ed6c6d97ce8af70dd9d496d51cef6c4276881383` | 2048×922 post-match layout with five visual rows per side; visible 20–3, VICTORY and 09:35 header. Quick-chat/system overlays obscure some right-side values. |
| `assets/public/images/match-evidence/match-101-game-2.jpg` | `f0f351a46dc65513b31efe6893cab02448589ac5612c6f8552281774b0ca22b8` | 2048×922 with five visual rows per side, cropped/obscured header area and a hand overlay. Missing global fields must remain missing/review-required, not reconstructed from a fixture expectation. |
| `assets/public/images/match-evidence/match-101-game-3.jpg` | `73b6a9ca9ee3f37a55fff348f6cb053218344bbca235f7cd49946d29016406d2` | 2048×922 with five visual rows per side; visible 23–32, VICTORY and 19:43 header, while a system overlay obstructs central data. |

Use these only to manually inspect layout, crop association, overlay handling and honest unresolved states after onsite implementation. A screenshot with an overlay is not automatically invalid, but unavailable/obscured fields must require review or a clearer re-upload. Do not hard-code scores, player names, heroes, winner or dimensions from these files.

## Hero inventory boundary

The complete extraction catalog is the 133-entry `reference-data/mlbb/heroes/2026-09-09-rone` dataset. `assets/public/images/mlbb/heroes` currently contains only 29 display/reference portraits; it is not the extractor's catalog and does not prove the other 104 heroes are absent from matching. If an onsite screen needs a hero portrait outside that public subset, it must render from an authorized server projection of the pinned catalog or receive a separately approved public-asset expansion with attribution and manifest updates. Do not silently scrape, download or invent portrait assets.

## Onsite enablement checklist

1. Retain the RF-DETR checkpoint provenance/use-right record before actual use, despite the user-directed `PCC_SCOREBOARD_USAGE_APPROVED=true` template value, and verify its path, byte size, checksum, 480-resolution metadata and exact label list.
2. Provision and independently record the exact PaddleOCR recognition assets; demonstrate that the worker starts with networking disabled and makes no runtime asset download. This is an onsite enablement task, not current preparation work.
3. Use the three current reference images for manual overlay/layout reporting. A larger held-out labelled corpus is an onsite calibration task, not a preparation requirement; keep automatic hero acceptance disabled until it exists.
4. Verify the hero catalog version, manifest and every portrait hash; preserve its attribution. Do not expand it for later MLBB heroes, UI variants or skins during this hackathon without explicit authorization.
5. Run focused unit/API/worker checks for bounded intake, EXIF normalization, unsupported-layout review, box mapping, field parsing, fuzzy/tied identity rejection, candidate-only heroes, review authorization/idempotency and atomic acceptance. Do not add automated browser E2E or visual-regression work for this hackathon.
6. Measure memory and latency on the staging VPS with one worker job only. Keep extraction disabled or fail closed on any missing artifact, checksum mismatch, unapproved rights record, timeout or runtime error.

See [match feature contract](features/brackets-scoreboard.md), [data dictionary](DATABASE.md), [storage/jobs](STORAGE_JOBS.md), [configuration](CONFIGURATION.md) and [testing](TESTING.md).
