# Storage, jobs and real-time delivery

## Objects

| Purpose | Input | Limit | Access and retention |
| --- | --- | --- | --- |
| Brand/static references | Approved repository asset | Versioned | Public |
| Team/community/tournament image | JPEG/PNG/WebP | 10 MiB, max 8192 pixels per side | Public only when owning record permits |
| Scoreboard evidence | JPEG/PNG/WebP | 10 MiB, max 8192 pixels per side | Participants/reviewers; retained with match audit |
| External achievement evidence | Image or HTTPS reference | Same image bounds | Profile owner; public only by explicit visibility |
| Biometric crop | Decodable single-face image | 2 MiB | Memory-only inference, discard afterward |

API receives multipart file, validates media signature and dimensions, computes SHA-256, writes an unpredictable object key, then records asset metadata. Reject SVG uploads; transferred passive brand SVG is trusted reference content only. Failed database commit leaves a cleanup candidate, never a visible orphan. Store object keys rather than expiring URLs or data URLs. API serves authorized object bytes at /api/v1/assets/{id}/content; cache only approved public assets. Bucket bootstrap is an onsite operator task.

## Durable jobs

Persist job kind, aggregate ID, payload reference, idempotency key, status, attempts, available_at, lease expiry and last error. States: PENDING, RUNNING, SUCCEEDED, FAILED. Worker lease is 120 seconds with heartbeat for long OCR; expired lease returns to pending. Retry transient failures after 5, 30 and 120 seconds; permanent validation failures stop. A provider timeout with possible side effect enters reconciliation, not blind resubmission. Initial OCR concurrency is one; separate resource budget from API.

Kinds: OCR extraction, bracket synchronization, notification delivery, provider reconciliation and certificate submission/reconciliation. There is no timed scrimmage finalizer. Never let a periodic job change a submitted scrimmage winner.

## WebSocket contract

Endpoint /ws/events; same-origin session authentication. Server derives permitted user/team/community/tournament channels. Client may request entity subscriptions but cannot self-authorize them. Event envelope fields: event_id, type, aggregate_id, version, occurred_at and minimal payload. Event types: match.recorded, bracket.updated, scrimmage.matched, scrimmage.finalized, comment.created, notification.created, reward.updated, certificate.updated.

Emit only after commit. Client de-duplicates event_id and refetches when version skips or after reconnect. Reconnect delays 1, 2, 5, then 15 seconds capped. Persist comments and notifications before delivery. Redis outage delays live updates without losing committed data; UI allows refresh and shows reconnecting state.
