# Communities and social activity

**Requirement: FR-COMM. Status: specified, unimplemented. Required.**

## Actors and journey

Player, community member, owner and manager.

Create through the existing modal and live cover preview. Public community permits join; private requires invitation. Preserve four-tab detail composition, member/team links and community-origin breadcrumbs according to [the breadcrumb contract](../screens/BREADCRUMB_CONTEXT.md). Member posts may attach approved image; reaction toggles one per user; author can edit/remove own post/comment and owner/manager can moderate. Archive blocks new activity while retaining history and authorized read access.

## Fields and validation

name: 3-100 unique; type: COLLEGIATE/GRASSROOT; institution_id only collegiate; visibility; tags: up to 10 short tags; description: 1000; cover_asset_id; lifecycle ACTIVE/ARCHIVED; posts: body up to 5000, optional image; comment: 1-1000; reaction: UP/DOWN per user.

Shared type/default/nullability rules are in [data dictionary](../DATABASE.md). Authentication, role checks and private projections follow [security](../SECURITY.md).

## Interfaces

| Method | Path under /api/v1 | Input | Result |
| --- | --- | --- | --- |
| GET | /communities | q, type, cursor, limit | 200 summaries |
| POST | /communities | name, type, institution_id, visibility, description, tags, cover_asset_id | 201 community, owner membership and one-time code |
| GET | /communities/{id} | visibility policy | 200 permitted detail |
| PATCH | /communities/{id} | presentation, version | 200 saved detail |
| POST | /communities/{id}/join | invite_code when private | 200 membership |
| POST | /communities/{id}/archive | owner, version | 200 archived |
| GET | /communities/{id}/posts | cursor, limit | 200 member-visible posts |
| POST | /communities/{id}/posts | body, image_asset_id | 201 post |
| PATCH | /posts/{id} | body, image_asset_id, version | 200 saved post |
| DELETE | /posts/{id} | author/moderator | 204 soft deletion |
| PUT | /posts/{id}/reaction | UP, DOWN or null | 200 counts and own reaction |
| POST | /posts/{id}/comments | body | 201 comment |
| PATCH | /comments/{id} | body, version | 200 edited comment |
| DELETE | /comments/{id} | author/moderator | 204 soft deletion |
| GET | /communities/{id}/analytics | time range | 200 member-visible calculated metrics |
| GET | /communities/{id}/export | time range | 200 CSV |

## Commit, error and audit behavior

Validate session and resource role before body-driven mutations. Apply field rules before any provider request. Use one transaction for related business records, audit event and outbox entry. Capacity/result/issuance operations lock the aggregate; edits check version. Return 409 for stale or incompatible state and 422 for invalid fields. Provider failures preserve committed intent and expose pending/failed state; never fabricate completion. Idempotent retries return the previous reference. Read views use permission-filtered server projections.

## Acceptance scenarios

- **AC-COMM-01:** Collegiate community requires a valid institution; grassroots cannot retain one.
- **AC-COMM-02:** Private membership cannot be granted by client-only code comparison.
- **AC-COMM-03:** A repeated reaction changes no additional counter; opposite reaction replaces it.
- **AC-COMM-04:** Member/team/player/tournament links preserve a valid community navigation origin under [the cross-feature breadcrumb contract](../screens/BREADCRUMB_CONTEXT.md); URL context itself neither supplies labels nor grants access.
- **AC-COMM-05:** Archived community retains auditable data and blocks new writes.

## Onsite completion

Implement the specified persistence and routes, bind the approved screen behavior to these contracts, add unit and integration tests for the scenarios above, and verify UI empty/error/loading/success states. Completion requires server evidence; local fixtures do not satisfy it. See [traceability](../TRACEABILITY.md).
