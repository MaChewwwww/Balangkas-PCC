# Notifications and activity

**Requirement: FR-NOTIFY. Status: specified, unimplemented. Required.**

## Actors and journey

Authenticated recipient and permitted aggregate reader.

Keep bell flyout and all/unread tabs. Domain transaction creates durable event, worker fans out recipients once. Opening a destination marks that recipient notification read; dismiss hides it without deleting domain audit. Counts persist across reload and sessions. Activity history is separate from user read state.

## Fields and validation

event_id; recipient_user_id; type scrimmage/tournament/credential/team; title/message; destination resource; created_at; read_at; dismissed_at; aggregate audit actor/action/reference.

Shared type/default/nullability rules are in [data dictionary](../DATABASE.md). Authentication, role checks and private projections follow [security](../SECURITY.md).

## Interfaces

| Method | Path under /api/v1 | Input | Result |
| --- | --- | --- | --- |
| GET | /notifications | unread_only, cursor, limit | 200 recipient list and unread count |
| POST | /notifications/read-all | recipient session | 200 updated unread count |
| PATCH | /notifications/{id} | read boolean or dismissed boolean | 200 own notification state |
| GET | /tournaments/{id}/activity | permission, cursor, limit | 200 immutable event summaries |

## Commit, error and audit behavior

Validate session and resource role before body-driven mutations. Apply field rules before any provider request. Use one transaction for related business records, audit event and outbox entry. Capacity/result/issuance operations lock the aggregate; edits check version. Return 409 for stale or incompatible state and 422 for invalid fields. Provider failures preserve committed intent and expose pending/failed state; never fabricate completion. Idempotent retries return the previous reference. Read views use permission-filtered server projections.

## Acceptance scenarios

- **AC-NOTIFY-01:** One event cannot create duplicate notification for the same recipient.
- **AC-NOTIFY-02:** Read/dismiss changes survive refresh and do not alter another user's state.
- **AC-NOTIFY-03:** Inaccessible destination resolves safely and does not leak entity details.
- **AC-NOTIFY-04:** Actual certificate issuance emits notification; draft or mock state does not.
- **AC-NOTIFY-05:** WebSocket interruption loses no persistent notifications.

## Onsite completion

Implement the specified persistence and routes, bind the approved screen behavior to these contracts, add unit and integration tests for the scenarios above, and verify UI empty/error/loading/success states. Completion requires server evidence; local fixtures do not satisfy it. See [traceability](../TRACEABILITY.md).
