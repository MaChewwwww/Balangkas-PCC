# Canonical PCC data dictionary

**Specification only. No model or SQL file exists.** Fresh onsite migrations implement this design, not the practice revision history. The [practice field audit](reference/PRACTICE_MODEL_FIELDS.md) preserves the comparison evidence.

## Shared conventions

Every entity has a server-generated UUID id and UTC created_at. Mutable entities also have updated_at and monotonically increasing version. Unless marked optional, fields are required. Text lengths use feature limits; unspecified short labels max 120, long descriptions max 1000. Parent links are foreign keys. Archive/soft-delete historically significant entities; never cascade-delete matches, credentials or payment audits when a user/team leaves. UUIDs and timestamps serialize as strings. Minor-unit money is integer in storage; SOL wire values are digit strings. No source fixture ID is a seeded production identity.

## AUTH / IDENT

| Entity | Fields and types beyond shared fields | Uniqueness, relations and lifecycle |
| --- | --- | --- |
| users | email text255; password_hash text; real_name text120; role PLAYER/ORGANIZER; email_verified_at optional time; linked_wallet_address optional text64; wallet_verified_at optional time | normalized email unique; wallet deliberately not unique; session determines actor |
| sessions | user_id; token_id text; expires_at time; revoked_at optional time; csrf_hash text | token_id unique; revoke on logout/reset |
| otp_challenges | user_id; code_hash text; expires_at; consumed_at optional; attempts integer | one active challenge per purpose/account; latest resend invalidates old |
| password_reset_tokens | user_id; token_hash; expires_at; consumed_at optional | unique token hash, single use |
| wallet_challenges | user_id; proposed_address; nonce_hash; message_digest; expires_at; consumed_at optional | binds exact user/address/action; independent of biometric token |
| institutions | canonical_name text255; source_version text | normalized name unique; immutable reference IDs |
| player_profiles | user_id; ign text64; mlbb_account_id optional text64; primary_role enum; secondary_role optional enum; is_student boolean; institution_id optional; visibility PUBLIC/PRIVATE; bio optional text1000 | one profile per user; student iff institution present; wallet read from users only |
| profile_hero_showcase | profile_id; hero_id; position integer1..3 | unique profile+position and profile+hero; stats calculated from accepted games |
| player_ign_aliases | profile_id; alias text64; normalized_alias text64; approved_by; approved_at | unique profile+normalized alias; no automatic guessed aliases |
| biometrics | user_id; embedding vector512; consent_version; consent_at; model_version; verified_at | one enrollment per user; cosine index; serialized enrollment deduplication; no raw photograph |
| biometric_authorizations | user_id; action; resource_id; token_hash; expires_at; consumed_at optional | one-use and five-minute expiry |
| external_achievements | user_id; title; event_name; occurred_on date; evidence_asset_id optional; evidence_url optional HTTPS; visibility; source SELF_REPORTED; deleted_at optional | at least one evidence reference; never contributes canonical match totals |

## TEAM / COMM

| Entity | Fields and types | Invariants |
| --- | --- | --- |
| teams | name text100; tag text10; tier GRASSROOT/COLLEGIATE; visibility PUBLIC/PRIVATE; captain_id; coach_id optional; manager_id optional; community_id optional; bio optional; logo_asset_id optional; banner_asset_id optional; is_recruiting boolean; lifecycle ACTIVE/ARCHIVED; archived_at optional | normalized name/tag unique; captain is active member; no single-active-team-per-user restriction |
| team_invites | team_id; code_hash; created_by; rotated_at optional | active hash unique; do not return stored secret |
| team_memberships | team_id; user_id; role CAPTAIN/COACH/MANAGER/MEMBER; joined_at; left_at optional | unique active team+user; permit historical rejoin records |
| communities | name text100; type COLLEGIATE/GRASSROOT; institution_id optional; visibility; owner_id; description; tags list of short text; cover_asset_id optional; lifecycle; archived_at optional | institution required only collegiate; normalized name unique |
| community_invites | community_id; code_hash; created_by; rotated_at optional | same secret handling as teams |
| community_memberships | community_id; user_id; role OWNER/MANAGER/MEMBER; joined_at; left_at optional | unique active community+user |
| community_posts | community_id; author_id; body text5000; image_asset_id optional; deleted_at optional | member writes, author/moderator soft deletion |
| post_reactions | post_id; user_id; reaction UP/DOWN | unique post+user; delete means no reaction |
| post_comments | post_id; author_id; body text1000; edited_at optional; deleted_at optional | membership checks on writes |

## TOURN

| Entity | Fields and types | Invariants |
| --- | --- | --- |
| tournament_series | title text255; description optional | recurring event grouping, independent of match series |
| tournaments | series_id optional; creator_id; community_id optional; name text255; game MLBB; category; eligibility_mode optional; status UPCOMING/REGISTRATION_OPEN/ACTIVE/COMPLETED/ARCHIVED/CANCELLED; starts_at; ends_at; registration_deadline; max_teams integer2..128; join_type OPEN/PRIVATE; requirements_enabled boolean; requirements_prompt optional | ends >= starts; registration_deadline <= starts; creator non-null; all events publicly discoverable |
| tournament_bracket_settings | tournament_id; format SINGLE_ELIMINATION/DOUBLE_ELIMINATION/ROUND_ROBIN/SWISS; best_of integer1/3/5/7; finals_best_of integer1/3/5/7; third_place boolean; grand_final_mode STANDARD/SINGLE_MATCH; swiss_rounds optional integer1..16 | one per tournament; extra options apply only appropriate format; locked at start |
| tournament_editorial | tournament_id; banner_asset_id optional; headline; teaser; article_body text; author_name; author_role; author_avatar_asset_id optional; host_label | one per tournament; content treated as plain text/approved formatting, never arbitrary executable HTML |
| tournament_eligible_institutions | tournament_id; institution_id | unique pair; selected list nonempty for SELECTED_HEIS |
| tournament_invites | tournament_id; code_hash; created_by; rotated_at optional | PRIVATE registration requires active code |
| tournament_staff | tournament_id; user_id; role_name; can_review_matches boolean | unique tournament+user; creator alone assigns; locked after start |
| registrations | tournament_id; team_id; requirements_url optional; status PENDING_REQUIREMENTS/PENDING_PAYMENT/REGISTERED/WITHDRAWN; registered_at optional; withdrawn_at optional; entry_fee_mode; entry_fee_centavos integer; entry_fee_lamports bigint; destination_wallet optional | unique tournament+team; immutable fee snapshot; withdrawn may re-register pre-start via same row with audit and existing payment evidence |
| registration_lineup | registration_id; user_id; membership_id; role; ign_snapshot; institution_id_snapshot optional | roster snapshot used for eligibility/history, not live membership names |
| tournament_seeds | tournament_id; registration_id; seed_number integer | unique tournament+seed and tournament+registration; immutable after start |
| tournament_milestones | tournament_id; title; scheduled_at; status UPCOMING/ACTIVE/COMPLETED; position integer | ordered presentation; no implicit business lifecycle transition |
| tournament_announcements | tournament_id; author_id; title; body text5000 | authorized staff/creator writes |
| tournament_reactions | tournament_id; user_id; kind CHEERS/TROPHIES/FIRES | one current reaction per user/event; aggregate counts derived |
| tournament_ratings | tournament_id; user_id; rating integer1..5; feedback optional | unique event+user; registered participant after completion |
| bracket_sync | tournament_id; challonge_id optional; remote_url optional; status PENDING/SYNCED/FAILED; last_synced_version; last_error optional | unique remote ID; failed sync never fabricates advancement |

## MATCH / SCRIM / HISTORY

| Entity | Fields and types | Invariants |
| --- | --- | --- |
| scrimmages | posting_team_id; accepting_team_id optional; created_by; description; rank_min/max optional integers; scheduled_at; best_of; lobby_name; lobby_password_ciphertext optional; status PENDING/MATCHED/FINALIZED/CANCELLED; accepted_by/at optional; finalized_at optional | distinct teams; rank min >=0 and max>=min; one accepting team |
| scrimmage_messages | scrimmage_id; author_user_id optional for system; body text1000; kind USER/SYSTEM; deleted_at optional | only participants see room messages; system actor cannot be supplied by client |
| matches | source TOURNAMENT/SCRIMMAGE; tournament_id optional; scrimmage_id optional; team_a_id; team_b_id; round optional; bracket_match_id optional; scheduled_at optional; best_of; wins_a/wins_b integers; winner_id optional; status PENDING/IN_PROGRESS/COMPLETED/VOID; finalized_by optional; finalized_at optional; result_digest optional | exactly one source relation; scrimmage_id unique; winning team belongs to match; one series result |
| match_lineups | match_id; team_id; user_id; role; ign_snapshot; membership_id optional | preserves participating historical lineup even after departure |
| match_games | match_id; game_number integer; winner_id optional; status PENDING/PENDING_REVIEW/RECORDED/VOID; left_team_id/right_team_id optional; left_kills/right_kills optional integers; duration_seconds optional; recorded_by/at optional | unique match+game number; accepted games determine tournament series score |
| match_evidence | game_id optional; match_id; asset_id; SHA-256 text64; source UPLOAD/IMPORT; integrity VERIFIED; captured_at optional | asset checksum before association; one evidence association per object/game |
| ocr_runs | evidence_id; status DRAFT/NEEDS_REVIEW/ACCEPTED/REJECTED/FAILED; pipeline_version; model_version; catalog_version; raw_payload JSON; draft_payload JSON; review_payload optional JSON; reviewer_id/reviewed_at optional; rationale optional | immutable raw payload; corrections separate; official writes only on acceptance |
| game_player_stats | game_id; ocr_run_id optional; team_id; user_id optional; screen_side LEFT/RIGHT; row_number integer1..5; raw_squad_tag optional; raw_ign; identity_state EXACT/ALIAS/FUZZY/UNRESOLVED/UNREADABLE; identity_confidence/basis optional; hero_id optional; hero_state MATCHED/UNKNOWN; hero_confidence/evidence optional; kills/deaths/assists/gold optional integers; overall_score optional decimal; is_mvp boolean; mvp_type optional WIN/LOSS | unique game+side+row; nullable unreadable values; unresolved player rows cannot become attributed official stats |
| hero_catalog_versions | version text; source_revision; manifest_sha256; attribution | immutable version |
| heroes | catalog_version; external_id text; canonical_name; role optional; portrait reference | unique version+external ID |
| tournament_placements | tournament_id; team_id; placement integer; derived_from_bracket_version | computed at valid completion; unique placement except explicitly tied ranks |

A scrimmage finalization may have a series score without fabricated per-game statistics. Create the canonical match and optional submitted evidence atomically; do not invent individual game winners to match a score. Headline totals count completed series; per-hero totals count accepted games only. No secondary career counter is authoritative.

## PAY / CERT

| Entity | Fields and types | Invariants |
| --- | --- | --- |
| tournament_reward_settings | tournament_id; prize_type NONE/CASH/E_WALLET/BLOCKCHAIN; prize_centavos bigint; prize_lamports bigint | positive amount only selected rail; NONE both zero |
| payment_attempts | registration_id; rail E_WALLET/SOLANA; status PENDING/PAID/FAILED; amount_centavos/lamports; destination_snapshot; provider_reference optional; chain_signature optional; verified_at optional; request_digest | unique provider reference/signature; exact amount and destination verification |
| payout_recipients | user_id; provider_recipient_reference; status UNVERIFIED/PENDING/VERIFIED/REJECTED | no raw bank/account details |
| reward_allocations | tournament_id; placement; team_id; representative_user_id; rail CASH/E_WALLET/BLOCKCHAIN; amount_centavos/lamports; destination_reference; status ALLOCATED/READY/SUBMITTED/PAID/FAILED; finalized_at optional | immutable wallets/amounts after finalize; active placement unique |
| payout_runs | tournament_id; allocation_version; requested_by; status PENDING/RUNNING/COMPLETED/FAILED; idempotency_key | run owns provider attempts and reconciliations |
| payout_transfers | run_id; allocation_id; provider_reference optional; chain_signature optional; status; submitted_at optional; settled_at optional; failure_reason optional | unique allocation+successful transfer; retain failed attempts |
| provider_events | provider; event_id; signature_verified boolean; received_at; processed_at optional; sanitized payload | unique provider+event; only verified events may settle |
| cash_handovers | allocation_id; operator_id; handed_over_at; reference; acknowledgment note | one finalized handover; CASH only |
| escrow_records | tournament_id; program_id; PDA; network DEVNET; deposit_signature optional; allocation_digest optional; release_signature optional; state AWAITING_DEPOSIT/FUNDED/REWARDS_FINALIZED/RELEASED | program and amounts validated, no pseudo-PDA evidence |
| certificates | lookup_code text64; tournament_id; recipient_type USER/TEAM; user_id optional; team_id optional; management_member_id optional; award_type; title; description; recipient_context JSON; attributes JSON; status DRAFT/ISSUED/REVOKED; destination_snapshot; mint_address optional; tx_hash optional; metadata_uri optional; issued_at/revoked_at optional; revoke_reason optional | unique lookup/mint; USER requires user, TEAM requires team; draft issued_at null; real success before ISSUED |
| certificate_attempts | certificate_id; status PENDING/SUBMITTED/CONFIRMED/FAILED; request_digest; transaction_signature optional; submitted_at/confirmed_at optional; failure_reason optional | one active attempt; reconcile ambiguous submission before signing again |

## NOTIFY / shared infrastructure

| Entity | Fields and types | Invariants |
| --- | --- | --- |
| assets | owner_id; purpose; bucket; object_key; content_type; byte_size; width/height; SHA-256; visibility; lifecycle STAGED/ATTACHED/DELETED | object key unique; owning resource permission applies |
| audit_events | aggregate_type/id; actor_id optional for system; action; occurred_at; before_version/after_version; non-sensitive detail JSON | append-only |
| outbox_events | event_id; aggregate_id; event_type; payload reference; delivered_at optional | event ID unique, committed with domain transaction |
| jobs | kind; aggregate_id; idempotency_key; status; attempts; available_at; lease_expires_at optional; last_error optional | one active job per logical operation |
| notifications | recipient_user_id; event_id; type; title; message; destination_type/id; read_at optional; dismissed_at optional | unique recipient+event; no cross-recipient mutations |
| idempotency_records | user_id; operation; key; request_digest; response_reference; expires_at | unique scope+key; financial/issuance uniqueness remains permanent after record expiry |

## Read-model mapping from frontend

| Frontend shape/label | Server authority |
| --- | --- |
| university/hei | institution ID plus resolved canonical name |
| owner_id/currentUserId | session principal and resource creator/captain |
| members list of IGNs | membership/user IDs plus display projection |
| dates and format strings | structured date and bracket settings formatted for display |
| team_history/tenure | dated membership intervals and canonical result joins |
| winrate/matches/top_heroes | calculated projections, no fixture fallback |
| screenshot_data_url | authorized asset reference/content endpoint |
| prize_pool display text | exact reward settings formatted by currency |
| entry_fee_value | validated decimal UI input -> exact minor units |
| local FINALIZED | canonical scrimmage FINALIZED and completed match |
| notification time string | created_at formatted relative to viewer clock |
| blockchain preview object | persisted issuance/settlement evidence only |

## Fresh migration acceptance

Onsite migration must create all specified relationships, uniqueness and check constraints; enable pgvector and required indexes; seed approved reference data repeat-safely; upgrade an empty database; and render migration SQL for review. Test rollback only for explicitly reversible schema operations on disposable databases. No stamping or import of practice database history.
