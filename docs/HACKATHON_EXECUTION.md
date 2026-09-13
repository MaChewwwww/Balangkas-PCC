# 48-hour execution board

Planning baseline: 2026-09-14. Event: September 18 18:00 to September 20 18:00,
2026, Asia/Manila. PREPARATION remains active. This board is planning and
acceptance guidance, not authorization to implement or deploy before onsite.
All twelve requirements remain mandatory. Targets below are initial time
budgets, not evidence that the full scope fits; Charlene updates actuals and
remaining estimates at each checkpoint.

## Ownership and handoffs

Robert owns full-stack CRUD slices, including feature persistence, routes,
approved UI and focused tests. John owns shared backend foundations,
integrations, worker and DevOps, and coordinates migration order. Each author
writes the migration for their change; John checks ordering before integration.
Aliah owns design parity and the landing page. The timeline's former name
"Aya" is treated as an unresolved assignment and allocated to Aliah for this
plan, without assuming they are the same person. Charlene owns acceptance,
checkpoint tracking, demo and pitch.

Before touching a shared contract or migration, record the owner and affected
files in the work-package handoff. Use the existing preparation branch and PRs
to staging; coordinate small commits and shared-file edits. This plan does not
authorize additional branches. John coordinates merges/releases; Robert is
the code-review backup, with operator access verified before any release duty
is transferred. Aliah can execute manual UI checks from Charlene's checklist.

## Milestone definitions and biometric retrofit

ADR-029 authorizes two passes. CRUD-ready means real persistence, validation,
session/role checks, forms and ordinary actions have focused passing checks.
Robert can develop those behaviors without first implementing face requirements.
Domain-level development tests can exercise that incomplete flow independently
of the biometric gate. Track it as unfinished integration, never successful
biometric verification or a completed feature. Existing provider, money,
idempotency and session-ownership rules still apply.

Integration-complete means the final contracts and all required dependencies
pass. Staging must keep unfinished gated operations unavailable rather than
expose a permissive development path. No new biometric bypass flag, API field,
database verification state or fake authorization token is specified here.

| Retrofit item | Owner | Required completion evidence |
| --- | --- | --- |
| Capture/enrollment and one-use authorization | John backend; Robert browser | Approved assets/model/policy; real capture; no raw retention; enrollment and duplicate/replay rejection tests |
| Wallet linking | Robert with John Solana adapter | Signature and action-bound biometric authorization consumed atomically; missing/expired/wrong-scope authorization rejected |
| Tournament registration | Robert | Biometric authorization integrated with registration checks; missing/replayed/cross-tournament authorization rejected without registration mutation |
| Downstream chain and certificates | John with Robert UI | Use final authoritative linked-wallet evidence; no provisional CRUD record becomes payment or issuance evidence |
| Development-path cleanup | Robert; Charlene verifies | Review affected routes/tests and staging configuration; no permissive face bypass or fabricated verification remains |
| Final acceptance | Charlene | AC-IDENT-01..12, affected tournament/payment/certificate cases and manual UI report rerun; readiness updated |

## Delivery budgets and checkpoints

Hour numbers are elapsed event time. Budget includes integration and focused
checks; developers must plan rest within the window rather than assume 48
productive hours each. If a target is missed, Charlene records the blocker,
remaining estimate, responsible person and next checkpoint. Move work within
the plan explicitly; never relabel an unavailable required feature complete.

| Window | Robert | John | Checkpoint evidence |
| --- | --- | --- | --- |
| H0–4 (4h) | Shared shell, auth slice and feature structure | CI/CD, base DB/API/worker shape and first release | Explicit activation; first small deployed slice if release prerequisites pass; pipeline result |
| H4–12 (8h) | Authentication/community, profiles and team CRUD | Solana foundations and provider/asset readiness checks | CRUD records survive reload; session/role checks; unresolved integration list |
| H12–24 (12h) | Tournament and match/review CRUD; scrimmages/history | Local extraction backend; integration adapters | Connected CRUD walkthrough; manual entry labelled manual; extraction reports real result or unavailable |
| H24–32 (8h) | Remaining identity, rewards, certificates, notifications and public CRUD surfaces | Required chain/payment/worker capabilities | Every FR has an explicit CRUD/integration status; final-pass owners and estimates |
| H32–38 (6h) | Connect face requirements to affected CRUD flows | Biometric runtime and remaining integration fixes | Retrofit checklist passes, or affected required feature remains incomplete |
| H38–42 (4h) | Cross-feature fixes and manual UI checks | Integration, migration, recovery and resource checks | Full required acceptance review; release evidence and remaining gaps |
| H42–48 (6h) | Essential fixes and walkthrough support | Release stability and essential fixes | Rehearsal, recorded working demo, submitted artifacts and honest completion report |

Aliah checks approved visual parity as each slice lands; Charlene tests each
handoff throughout. H24–32 is especially capacity-sensitive: at H12 and H24,
compare remaining estimates with available hours and reassign explicitly.
The final six hours are reserved for demonstration and stabilization; changes
then need a concrete defect or outstanding required acceptance item.

## Dependency and evidence register

Preparation deadline means by September 17 18:00 where permitted. Provisioning
of any model beyond the two existing exceptions remains subject to the
preparation boundary. Evidence records contain no secrets; credentials stay in
approved ignored/operator storage. No external account or VPS changes are made
merely by updating this board.

| Dependency | Current evidence / gap | Owner | Deadline and next evidence |
| --- | --- | --- | --- |
| Dependency images, including OCR | Locks/Dockerfiles exist; OCR build was omitted from the main test list | John; Robert checks own machine | Preparation: record successful build and lock checks on relevant machines; OCR image separately |
| Local Docker services | Earlier health checks documented; engine unavailable during September 14 audit | John | Preparation: running-engine Compose health check; record machine/date/result |
| CI/CD and staging access | Environment/target documented configured; workflow unimplemented | John | Preparation: review operator access/runbook; H4: actual merged-commit/image/deploy evidence after authorization |
| Human browser capture | Package pinned; reviewed assets and capture policy outstanding | John; Robert browser consumer | Preparation: source/use review and exact asset/policy checklist; onsite provision before H32 retrofit |
| W600K-R50 | Local/VPS provisioning documented; runtime and applicable use evidence still required | John | Preparation: check existing operator evidence; H32–38: controlled load, capture and rejection evidence |
| RF-DETR | Approved hash/layout; acquisition/dataset/use record unverified | John | Preparation: resolve original-source evidence; onsite keep unavailable until complete |
| PaddleOCR recognition assets | Runtime packages prepared; recognition assets not provisioned/approved | John | Preparation: identify exact permissible assets; onsite approved local provisioning before extraction enablement |
| OCR on 2-vCPU/8-GiB VPS | No measured inference capacity evidence in readiness | John | H24: one-job latency/peak memory under shared service load; bounded failures, no runtime download; no unmeasured SLA |
| Brevo and Challonge | Config contracts exist; this audit has no account/capability proof | John | Preparation: record account owner/access and remaining setup; onsite adapter success/failure evidence before dependent acceptance |
| PayMongo test checkout | Contract only; test account/method/webhook evidence absent in readiness | John | Preparation: identify account custodian and setup needs; onsite authorized test success/cancel and signed reconciliation |
| Solana wallet/escrow/Core | Contract only; signer/program/finality/metadata evidence outstanding | John | Preparation: custodian/provider/toolchain checklist; onsite fresh Devnet evidence per enabled capability by H38 |
| Demo and event requirements | Schedule accepted; judging rubric/submission details not supplied in reviewed plan | Charlene | Preparation: obtain organizer rules, pitch limit and submission checklist; H42: rehearsed script and working backup recording |

The asset and provider contracts remain authoritative: [face](FACE_RECOGNITION_MODEL.md),
[OCR](MLBB_SCOREBOARD_EXTRACTION.md), [Solana](SOLANA.md),
[PayMongo](PAYMONGO.md), [configuration](CONFIGURATION.md), and
[testing](TESTING.md). A larger labelled OCR corpus remains an onsite task;
automatic hero acceptance stays disabled as specified.

## Demo plan

Charlene owns this initial five-minute script and adjusts duration to the actual
organizer limit. Prepare the script now; create application data only onsite.

| Time | Presenter/action | Evidence shown |
| --- | --- | --- |
| 0:00–0:40 | Charlene explains the collegiate competition problem and PCC's intended users | Clear problem and value statement using the approved concept |
| 0:40–1:40 | Robert shows player/team and organizer tournament operations | Real CRUD persistence, role-specific actions, registration state |
| 1:40–2:50 | Robert submits an approved scoreboard image and reviews the result | Actual extraction draft and corrections; accepted result updates match/history; manual entry explicitly labelled if used |
| 2:50–4:10 | John demonstrates available identity, test payment and Devnet credential flow | Real capture where enabled; test-mode label; finalized chain/public lookup evidence for completed operations |
| 4:10–5:00 | Charlene explains outcomes and remaining limitations | Traceable completion list; no unavailable integration described as working |

Use distinct player/captain/organizer accounts and the four-team scenario only
after its documented simulator prerequisites pass. Development-only auth
fixtures never become staging sessions. For staging, create accounts through
the permitted auth flow and preserve any DEMO_BYPASS label. Prepare the exact
route sequence, approved screenshot, expected results and reset instructions
from implemented behavior; never hard-code screenshot output.

At H42, rehearse from a fresh browser session, verify projector/network/camera
and wallet interactions, and record a successful real run with its date/commit.
Use that clearly labelled recording if connectivity fails. Retain truthful
pending/unavailable states and disclose any missing required capability. Keep
credentials, raw biometric frames and private evidence out of recordings.
