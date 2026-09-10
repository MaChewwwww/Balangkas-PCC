# Teams, rosters and affiliations

**Requirement: FR-TEAM. Status: specified, unimplemented. Required.**

## Actors and journey

Player, team captain, coach and delegated manager.

Directory search/filter and two-column roster workspace lead to team detail or invite modal. Preserve Current Team active/past lists and context-specific dossiers, including the server-safe cross-feature path defined in [the breadcrumb contract](../screens/BREADCRUMB_CONTEXT.md). Captain creates team and own membership together; captain or delegated manager edits permitted presentation fields. Only captain changes captain/manager assignment. Membership history survives departures. More than one team affiliation is permitted; active selection is a user preference, not a single-team database constraint. Team attachment requires active captain membership in the selected community.

## Fields and validation

name: 3-100 unique; tag: 2-10 unique; tier: GRASSROOT/COLLEGIATE; is_public; bio: 1000; logo/banner asset IDs; captain_id; coach_id and manager_id nullable; community_id nullable; recruiting boolean; membership joined_at/left_at and role.

Shared type/default/nullability rules are in [data dictionary](../DATABASE.md). Authentication, role checks and private projections follow [security](../SECURITY.md).

## Interfaces

| Method | Path under /api/v1 | Input | Result |
| --- | --- | --- | --- |
| GET | /teams | q, tier, visibility, cursor, limit | 200 discoverable summaries |
| POST | /teams | name, tag, tier, is_public, presentation, community_id | 201 team and one-time invite code |
| GET | /teams/{id} | session visibility | 200 permitted team detail |
| PATCH | /teams/{id} | presentation, recruiting, version | 200 updated team |
| POST | /teams/{id}/join | invite_code when private | 200 active membership |
| POST | /teams/{id}/leave | session | 200 closed membership |
| PUT | /teams/{id}/staff | captain_id, coach_id, manager_id, version | 200 assignments |
| POST | /teams/{id}/archive | version | 200 archived team |
| POST | /teams/{id}/invite-code/rotate | captain session | 200 one-time code |
| GET | /teams/me/affiliations | q, active/history | 200 dated affiliations and calculated metrics |

## Commit, error and audit behavior

Validate session and resource role before body-driven mutations. Apply field rules before any provider request. Use one transaction for related business records, audit event and outbox entry. Capacity/result/issuance operations lock the aggregate; edits check version. Return 409 for stale or incompatible state and 422 for invalid fields. Provider failures preserve committed intent and expose pending/failed state; never fabricate completion. Idempotent retries return the previous reference. Read views use permission-filtered server projections.

## Acceptance scenarios

- **AC-TEAM-01:** Public visitors do not see private-team details; authenticated directory may show restricted private-team summary only.
- **AC-TEAM-02:** Invite codes never appear in directory payloads.
- **AC-TEAM-03:** Duplicate join is idempotent; departing member retains historical match attribution.
- **AC-TEAM-04:** Last active member departure archives the team; a captain with remaining members transfers leadership first.
- **AC-TEAM-05:** Historical participation prevents hard deletion.
- **AC-TEAM-06:** Team create/edit exposes explicit recruiting state in the preserved division/accessibility form group; an empty roster slot never changes that state, and the route retains its source-visible 50/4/300 limits while the server validates canonical limits.

## Onsite completion

Implement the specified persistence and routes, bind the approved screen behavior to these contracts, add unit and integration tests for the scenarios above, and verify UI empty/error/loading/success states. Completion requires server evidence; local fixtures do not satisfy it. See [traceability](../TRACEABILITY.md).
