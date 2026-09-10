# API contracts

**Status: specification only.** All application endpoints are onsite work. Paths below use /api/v1 unless stated otherwise. No generated schemas are included.

## Shared protocol

| Concern | Contract |
| --- | --- |
| Identity | Session cookie and CSRF per [security](SECURITY.md); never trust submitted acting-user IDs. |
| Success | Entity response with id, version and operation-specific fields; lists include items and next_cursor. |
| Errors | code, message, field_errors and request_id; no internal stack or secrets. |
| HTTP | 401 missing session; 403 forbidden visible action; 404 absent/hidden; 409 state/idempotency conflict; 422 invalid fields; 429 retryable throttle; 503 unavailable integration. |
| Pagination | Opaque cursor, limit default 20/max 100, stable created_at plus ID ordering; reject malformed cursor. |
| Dates | ISO-8601 UTC timestamps, inclusive from/exclusive to; UI renders Asia/Manila event time. |
| Money | Nonnegative integer minor units; SOL amounts carried as base-10 strings on JSON wire to avoid JS precision loss. Display decimal strings are not canonical amounts. |
| Mutations | Idempotency-Key required for create, results, review, payments and issuance. Scope user+operation; same key/different body 409. Save request digest and resulting reference. |
| Versions | Mutable aggregate PATCH/commands require version; stale version returns 409 with current version. |
| Downloads | CSV authorized same as source data; UTF-8, explicit columns, formula-leading text escaped. |
| Uploads | Multipart POST /assets with purpose and file -> 201 asset ID; GET /assets/{id}/content authorizes owning context. |
| WebSockets | /ws/events outside /api/v1; see [delivery contract](STORAGE_JOBS.md). |

All read models are projections of [DATABASE](DATABASE.md). Field descriptions in feature documents specify inputs; unlisted server/audit fields are not client-editable. Full resource responses include the matching data-dictionary fields filtered by permissions; secrets, hashes and raw face data are always omitted.

## FR-AUTH: Authentication and onboarding

See [field and behavior contract](features/authentication-onboarding.md).

| Method | Path | Input | Result |
| --- | --- | --- | --- |
| POST | /auth/register | email, password, real_name | 201 account ID, verification_required |
| POST | /auth/request-otp | email | 202 generic delivery acknowledgment |
| POST | /auth/verify-otp | email, code | 200 email verification state |
| POST | /auth/login | email, password | 200 session cookie, csrf_token, current user |
| POST | /auth/logout | CSRF header | 204 revoked session |
| POST | /auth/password-reset | email | 202 generic acknowledgment |
| POST | /auth/password-reset/complete | token, new_password | 204 reset and revoke sessions |
| GET | /auth/me | session | 200 user/profile/readiness |
| GET | /institutions | q, cursor, limit | 200 matched reference entries |
| GET | /heroes | q, role, cursor, limit | 200 pinned catalog entries |
| PUT | /profiles/me | profile fields above | 200 saved profile |

## FR-IDENT: Identity, career portfolio and wallet

See [field and behavior contract](features/identity-portfolio.md).

| Method | Path | Input | Result |
| --- | --- | --- | --- |
| GET | /profiles/{id} | visibility-aware ID | 200 profile projection |
| GET | /profiles/me/portfolio | q, credential_type | 200 profile, calculated metrics and records |
| POST | /biometrics/enrollment | consent_version, cropped file, liveness evidence | 201 verified enrollment or explicit failure |
| POST | /biometrics/authorizations | action, resource_id, cropped file, liveness evidence | 201 single-use authorization token |
| POST | /wallet/challenges | wallet_address | 201 nonce, message, expires_at |
| PUT | /wallet/me | challenge_id, signature, biometric_authorization | 200 linked wallet projection |
| POST | /profiles/me/achievements | title, event, date, evidence_asset_id or evidence_url, visibility | 201 self-reported record |
| PATCH | /profiles/me/achievements/{id} | same editable fields, version | 200 saved record |
| DELETE | /profiles/me/achievements/{id} | owner session | 204 removed self-reported record |

## FR-TEAM: Teams, rosters and affiliations

See [field and behavior contract](features/teams.md).

| Method | Path | Input | Result |
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

## FR-COMM: Communities and social activity

See [field and behavior contract](features/communities.md).

| Method | Path | Input | Result |
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

## FR-TOURN: Tournament creation, registration and operations

See [field and behavior contract](features/tournaments.md).

| Method | Path | Input | Result |
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

## FR-MATCH: Brackets, game evidence and organizer review

See [field and behavior contract](features/brackets-scoreboard.md).

| Method | Path | Input | Result |
| --- | --- | --- | --- |
| GET | /tournaments/{id}/bracket | ID | 200 bracket and sync state |
| POST | /tournaments/{id}/bracket | creator, version | 202 bracket job |
| POST | /tournaments/{id}/seeds/shuffle | creator before start, version | 200 stored seed order |
| GET | /matches/{id} | permission context | 200 series, games, evidence and read model |
| POST | /matches/{id}/games/{gameId}/evidence | asset_id | 201 evidence, 202 extraction job reference |
| GET | /ocr-runs/{id} | review permission | 200 draft and candidate evidence |
| POST | /ocr-runs/{id}/review | ACCEPT/REJECT, corrected field table, rationale, version | 200 committed game or rejected draft |
| POST | /matches/{id}/games/{gameId}/result | winner_team_id, permitted score fields, source MANUAL, version | 200 recorded game |
| POST | /tournaments/{id}/bracket/reconcile | creator | 202 reconciliation |

## FR-SCRIM: Scrimmage board and immediate results

See [field and behavior contract](features/scrimmages.md).

| Method | Path | Input | Result |
| --- | --- | --- | --- |
| GET | /scrimmages | q, rank, schedule, cursor, limit | 200 active blocks and own pinned blocks |
| POST | /scrimmages | posting_team_id, description, ranks, scheduled_at, best_of, lobby fields | 201 PENDING block |
| GET | /scrimmages/{id} | participant-aware projection | 200 room or public challenge summary |
| PATCH | /scrimmages/{id} | host-editable settings, version | 200 saved block |
| POST | /scrimmages/{id}/accept | team_id, roster/fair_play/lobby acknowledgments | 200 MATCHED |
| POST | /scrimmages/{id}/cancel | host or participating leader, version | 200 CANCELLED |
| GET | /scrimmages/{id}/comments | cursor, limit | 200 persisted messages |
| POST | /scrimmages/{id}/comments | body | 201 message |
| POST | /scrimmages/{id}/result | winner_team_id, team_a_wins, team_b_wins, mvp_user_id optional, evidence_asset_id optional | 200 FINALIZED and match ID |

## FR-HISTORY: Match history and calculated analytics

See [field and behavior contract](features/match-history.md).

| Method | Path | Input | Result |
| --- | --- | --- | --- |
| GET | /matches | source, team_id, player_id, tournament_id, date_from, date_to, cursor, limit | 200 permitted match feed |
| GET | /teams/{id}/analytics | date range | 200 calculated metrics |
| GET | /profiles/{id}/analytics | visibility and date range | 200 calculated metrics |
| GET | /teams/{id}/history | cursor, limit | 200 series and placements |
| GET | /teams/{id}/export | date range | 200 flattened CSV |

## FR-PAY: Entry fees and prize settlement

See [field and behavior contract](features/rewards-entry-fees.md).

| Method | Path | Input | Result |
| --- | --- | --- | --- |
| POST | /registrations/{id}/payment | selected configured rail | 202 payment attempt/reference |
| POST | /registrations/{id}/solana-verification | transaction_signature | 200 settled or 202 confirmation pending |
| GET | /registrations/{id}/payment | owner permission | 200 payment state |
| GET | /tournaments/{id}/rewards | role-aware | 200 allocations and evidence |
| PUT | /tournaments/{id}/rewards | placement allocations, exact amounts, representative IDs, version | 200 draft allocation |
| POST | /tournaments/{id}/rewards/finalize | operator, version | 200 immutable allocation |
| POST | /tournaments/{id}/payouts | finalized allocation ID | 202 payout run |
| POST | /allocations/{id}/handover | handover_reference, handed_over_at | 200 CASH handover evidence |
| POST | /webhooks/paymongo | raw signed provider event | 200 accepted duplicate-safe receipt |

## FR-CERT: Certificate issuance and public lookup

See [field and behavior contract](features/certificates.md).

| Method | Path | Input | Result |
| --- | --- | --- | --- |
| POST | /tournaments/{id}/certificates | recipient_type, recipient ID, award, title, description, metadata | 201 DRAFT |
| POST | /certificates/{id}/issue | issuer, version | 202 issuance job |
| POST | /certificates/{id}/revoke | reason, issuer, version | 200 REVOKED |
| GET | /certificates/{lookup} | lookup code or mint | 200 issued/revoked public projection |
| GET | /certificates | recipient/tournament filters, cursor, limit | 200 permitted list |

## FR-NOTIFY: Notifications and activity

See [field and behavior contract](features/notifications-activity.md).

| Method | Path | Input | Result |
| --- | --- | --- | --- |
| GET | /notifications | unread_only, cursor, limit | 200 recipient list and unread count |
| POST | /notifications/read-all | recipient session | 200 updated unread count |
| PATCH | /notifications/{id} | read boolean or dismissed boolean | 200 own notification state |
| GET | /tournaments/{id}/activity | permission, cursor, limit | 200 immutable event summaries |

## FR-PUBLIC: Public discovery and information

See [field and behavior contract](features/public-discovery.md).

| Method | Path | Input | Result |
| --- | --- | --- | --- |
| GET | /public/tournaments | q, status, category, join_type, prize_type, cursor, limit | 200 discoverable events |
| GET | /public/teams | q, tier, cursor, limit | 200 public teams only |
| GET | /public/players | q, role, cursor, limit | 200 public profiles only |
