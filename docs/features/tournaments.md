# Tournament creation, registration and operations

**Requirement: FR-TOURN. Status: specified, unimplemented. Required.**

## Actors and journey

Visitor, registering leader, creator and assigned staff.

Preserve feed/grid/table directory, carousel, share confirmation, creation preview and Director Desk. Cross-feature team/player/match routes retain only the server-safe tournament path defined in [the breadcrumb contract](../screens/BREADCRUMB_CONTEXT.md). All tournaments remain publicly discoverable. PRIVATE gates joining only. Creation sets UPCOMING; creator opens registration, configures staffing and seeds; start requires at least two fully registered eligible teams and a bracket consistent with locked entrants. Start locks capacity/format/fees/eligibility/staffing. End requires every required bracket match completed. Completed events expose reward operations; archive removes from active lists but retains direct history.

## Fields and validation

name: 3-255; game MLBB; category; community_id optional; start/end/deadline timestamps; max_teams 2-128; bracket type; best_of and finals_best_of; third_place boolean; grand_final_mode; swiss_rounds 1-16; join_type OPEN/PRIVATE; eligibility ALL_SCHOOLS/SELECTED_HEIS; selected institution IDs; requirements flag/prompt; presentation banner/headline/teaser/article/author fields.

Shared type/default/nullability rules are in [data dictionary](../DATABASE.md). Authentication, role checks and private projections follow [security](../SECURITY.md).

## Interfaces

| Method | Path under /api/v1 | Input | Result |
| --- | --- | --- | --- |
| GET | /tournaments | q, status, category, prize_type, join_type, cursor, limit | 200 public summaries |
| POST | /tournaments | creation fields, prize/entry fields | 201 event |
| GET | /tournaments/{id} | ID | 200 event and permitted operations |
| PATCH | /tournaments/{id} | editable pre-start config or presentation, version | 200 saved event |
| POST | /tournaments/{id}/registrations | team_id, requirements_url, invite_code, biometric_authorization | 201 registration and payment readiness |
| POST | /registrations/{id}/withdraw | participating leader, version | 200 WITHDRAWN |
| POST | /tournaments/{id}/staff | user_id, role_name | 201 assignment |
| DELETE | /tournaments/{id}/staff/{memberId} | creator before start | 204 removed |
| POST | /tournaments/{id}/announcements | title, body | 201 announcement |
| PUT | /tournaments/{id}/reaction | cheers, trophies, fires or null | 200 totals and own reaction |
| POST | /tournaments/{id}/registration-open | version | 200 REGISTRATION_OPEN |
| POST | /tournaments/{id}/start | version | 200 ACTIVE |
| POST | /tournaments/{id}/complete | version | 200 COMPLETED |
| POST | /tournaments/{id}/archive | version | 200 ARCHIVED |
| POST | /tournaments/{id}/ratings | rating 1-5, optional feedback | 201 or updated own rating |

## Commit, error and audit behavior

Validate session and resource role before body-driven mutations. Apply field rules before any provider request. Use one transaction for related business records, audit event and outbox entry. Capacity/result/issuance operations lock the aggregate; edits check version. Return 409 for stale or incompatible state and 422 for invalid fields. Provider failures preserve committed intent and expose pending/failed state; never fabricate completion. Idempotent retries return the previous reference. Read views use permission-filtered server projections.

## Acceptance scenarios

- **AC-TOURN-01:** Capacity is enforced atomically under concurrent registration.
- **AC-TOURN-02:** All active submitted collegiate lineup players have school IDs within the chosen eligibility set.
- **AC-TOURN-03:** Open and invitation-only events remain searchable publicly.
- **AC-TOURN-04:** Tournament start locks sensitive settings and staffing; presentation updates remain available.
- **AC-TOURN-05:** Withdrawal is retained in history and cannot silently refund a payment.
- **AC-TOURN-06:** Create/edit presents registration deadline, eligibility and conditional institution selection, plus requirements and conditional prompt in the existing operations form; missing or stale values cannot be replaced by descriptive text or a client-created lifecycle state.

## Onsite completion

Implement the specified persistence and routes, bind the approved screen behavior to these contracts, add unit and integration tests for the scenarios above, and verify UI empty/error/loading/success states. Completion requires server evidence; local fixtures do not satisfy it. See [traceability](../TRACEABILITY.md).
