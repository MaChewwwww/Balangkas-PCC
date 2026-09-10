# Public discovery and information

**Requirement: FR-PUBLIC. Status: specified, unimplemented. Required.**

## Actors and journey

Unauthenticated visitor and returning player.

Preserve landing, about, tournament directory/article/bracket view, team directory/detail, player directory/detail and certificate directory/lookup. Shared records reflect authorized portal edits. Trim case-insensitive search, combine filters and restore all results on reset. Tournament invitation requirement remains visible; join CTA carries tournament context through authentication only while joinable. Keyboard navigation and motion fallback retain current behavior.

## Fields and validation

search q; tournament status/category/join/prize filters; team tier; player role; profile/team visibility; public certificate query; about/team information.

Shared type/default/nullability rules are in [data dictionary](../DATABASE.md). Authentication, role checks and private projections follow [security](../SECURITY.md).

## Interfaces

| Method | Path under /api/v1 | Input | Result |
| --- | --- | --- | --- |
| GET | /public/tournaments | q, status, category, join_type, prize_type, cursor, limit | 200 discoverable events |
| GET | /public/teams | q, tier, cursor, limit | 200 public teams only |
| GET | /public/players | q, role, cursor, limit | 200 public profiles only |

## Commit, error and audit behavior

Validate session and resource role before body-driven mutations. Apply field rules before any provider request. Use one transaction for related business records, audit event and outbox entry. Capacity/result/issuance operations lock the aggregate; edits check version. Return 409 for stale or incompatible state and 422 for invalid fields. Provider failures preserve committed intent and expose pending/failed state; never fabricate completion. Idempotent retries return the previous reference. Read views use permission-filtered server projections.

## Acceptance scenarios

- **AC-PUBLIC-01:** Private team/player absent from public search and direct public detail.
- **AC-PUBLIC-02:** Unknown IDs show unavailable state, never another record.
- **AC-PUBLIC-03:** Filter reset clears every combined filter without mutating source.
- **AC-PUBLIC-04:** Share/certificate search safely encodes user input.
- **AC-PUBLIC-05:** Reduced motion/unavailable WebGL uses static shield with accessible navigation.

## Onsite completion

Implement the specified persistence and routes, bind the approved screen behavior to these contracts, add unit and integration tests for the scenarios above, and verify UI empty/error/loading/success states. Completion requires server evidence; local fixtures do not satisfy it. See [traceability](../TRACEABILITY.md).
