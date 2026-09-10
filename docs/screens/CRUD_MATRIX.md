# Screen CRUD and field-binding matrix

This matrix prevents an onsite implementation from guessing which input, value, actor or lifecycle belongs to a screen. It is a screen binding layer over [feature contracts](../features/README.md), [the data dictionary](../DATABASE.md), and [the API contract](../API_SPEC.md). Those documents remain authoritative when a field is not repeated here.

## Shared command rules

- The session determines the actor. No visible form supplies an owner, captain, reviewer, issuer, recipient authority, provider outcome or `currentUserId`.
- Create, results, review, payment and issuance commands send `Idempotency-Key`; mutable resources send their last server `version`. A repeated key with the same request returns the prior result; stale versions and incompatible state return a visible conflict.
- Read lists use opaque cursors and explicit filters. The client does not merge fixture data into an empty server list.
- Fields use canonical IDs for relationships (institution, hero, asset, community, team, registration), with their server-resolved display text. Never submit display labels as authorities.
- `Archive`, `withdraw`, `cancel`, `dismiss`, `revoke` and `delete` have different lifecycle meanings. Show the named command, its consequence and a confirmation when the record is historically material.
- All forms preserve user entries after validation, transport or conflict errors. Pending disables duplicate submission but leaves an auditable pending/failed state where external work is involved.

## Profile, access and identity

| Screen/action | Field order and canonical binding | Command / authorization / truthful state |
| --- | --- | --- |
| Register | Email, password, confirmation. `real_name` is collected by the registration contract even though the visual form may stage it with account setup. | `POST /auth/register`; anonymous. Account creation is not email verification. Normalize email server-side; password is never returned. |
| Verify OTP / sign in | Email, six-digit code; or email and password. | `POST /auth/request-otp`, `/auth/verify-otp`, `/auth/login`; anonymous. Invalid/expired/exhausted OTP remains an error, never a visual completion. |
| Onboarding profile | IGN -> institution/school -> MLBB User ID -> four-digit Zone ID -> primary role -> competitive rank -> short description (250-character screen limit); optional secondary role, top heroes and visibility as product flow requires. Store `ign`, `institution_id`, `mlbb_user_id`, `mlbb_zone_id`, `competitive_rank`, canonical role enums and `bio`. | `PUT /profiles/me`; session owner. Required completion fields are IGN, User ID, Zone ID, rank, primary role and institution only when `is_student`. See the exact display-to-enum mapping below. |
| Profile edit | Canonical profile fields, including up to three distinct hero IDs and the full optional 1000-character stored bio capacity. | `PUT /profiles/me`; session owner. UI must not claim MLBB account verification from the entered IDs. |
| Biometric enrollment/authorization | Request a scoped Human blink challenge, then consent version, challenge ID, `human_capture_report`, exact `@vladmandic/human` capture-pipeline version and its one aligned crop; action/resource only for authorization. | `POST /biometrics/liveness-challenges`, then `/biometrics/enrollment` or `/biometrics/authorizations`; session owner. The frontend detects faces, rejects zero/multiple faces, aligns the crop and runs the blink/liveness/anti-spoof capture gate; backend does not repeat detection/counting or represent the browser report as server-verifiable proof. Show actual capture-ready, unavailable, failed, pending or successful server outcome. A missing/mismatched documented model, approval, reviewed Human asset or capture policy is unavailable; no raw photograph/embedding is rendered or stored client-side. |
| Wallet link | Proposed **Solana Devnet** address, returned exact chain/cluster-bound challenge ID/message and signature, one-use biometric authorization. | `POST /wallet/challenges`, then `PUT /wallet/me`; session owner. A connected-looking wallet is not linked until the exact signed challenge and biometric authorization are accepted by the server. |
| Achievement | Title, event name, occurred date, one evidence asset ID or HTTPS URL, visibility. | `POST/PATCH/DELETE /profiles/me/achievements`; session owner. It remains self-reported and never increases canonical match totals. |

### Onboarding display mapping

| Approved label | Canonical value / validation |
| --- | --- |
| Tank / Roamer | `ROAMER` |
| Mid Laner | `MID_LANE` |
| Gold Laner | `GOLD_LANE` |
| EXP Laner | `EXP_LANE` |
| Jungler | `JUNGLER` |
| Mythic Immortal (100+ Stars) | `MYTHIC_IMMORTAL` |
| Mythical Glory (50-99 Stars) | `MYTHICAL_GLORY` |
| Mythic (0-49 Stars) | `MYTHIC` |
| Legend | `LEGEND` |
| Epic | `EPIC` |

## Teams, roster and affiliations

| Screen/action | Field order and canonical binding | Command / authorization / truthful state |
| --- | --- | --- |
| Create team | Visual identity/preset preview, then name (source UI max 50; server 3–100) + tag (source UI 2–4; server 2–10), tier + visibility, explicit recruiting status, conditional institution, optional community, description (source UI max 300; server max 1000). Bind to `teams` fields and authorized staged asset IDs. | `POST /teams`; session principal becomes authorized captain/member per server policy. Returned invite code is one-time response data; do not redisplay it from an unprotected list. An empty roster lane never substitutes for the required `is_recruiting` input. |
| Edit team | Presentation fields, recruiting, assets and community affiliation; resource `version`. | `PATCH /teams/{id}`; permitted staff. Server controls lifecycle/staff authority; preserve error and current version on conflict. |
| Join / leave | Invite code only when private; no member ID. | `POST /teams/{id}/join` or `/leave`; session principal. A result is an active/closed membership record, not a client roster splice. |
| Assign staff | Canonical selected captain, coach and manager user IDs from permitted active membership list; version. | `PUT /teams/{id}/staff`; authorized captain/server policy. Never allow an arbitrary user lookup to become staff. |
| Rotate invite / archive | No secret input for rotation; version for archive and explicit confirmation. | `POST /teams/{id}/invite-code/rotate`, `/archive`; captain/policy. Archive retains historic memberships, matches and certificates. |
| My team / affiliations | Read-only filtering: search, active/history. | `GET /teams/me/affiliations`; session principal. Show active and concluded tenure separately with dated intervals. |

## Communities and social activity

| Screen/action | Field order and canonical binding | Command / authorization / truthful state |
| --- | --- | --- |
| Create community | Name, type, institution conditional on `COLLEGIATE`, visibility, description, comma-separated tags normalized to list, cover asset. | `POST /communities`; session owner becomes owner membership. Institution is required only for collegiate; a grassroots hub does not invent one. |
| Edit / archive community | Editable presentation, tags/cover/description and `version`; archive confirmation. | `PATCH /communities/{id}`, `POST /communities/{id}/archive`; owner/manager or owner respectively. Archive is lifecycle state, not a hard delete. |
| Join community | Invite code only for private community. | `POST /communities/{id}/join`; session principal. |
| Publish/edit/remove post | Body (up to 5000), optional staged image asset, `version` for edit. | `POST /communities/{id}/posts`, `PATCH/DELETE /posts/{id}`; member author or moderator. Delete is soft deletion. |
| React / comment | Reaction `UP`, `DOWN` or `null`; comment body up to 1000 and version when editing. | `PUT /posts/{id}/reaction`, `POST/PATCH/DELETE` comment endpoints; member and author/moderator policy. Aggregate counts come from server. |
| Analytics/export | Time range only. | `GET /communities/{id}/analytics` or `/export`; member policy. Charts/metrics use V11 server calculation, never local feed counter guesses. |

## Tournaments, registration and operations

| Screen/action | Field order and canonical binding | Command / authorization / truthful state |
| --- | --- | --- |
| Create tournament | In the 7/12 operations form: name, start/end dates, registration deadline, description, bracket format/best-of and applicable modifiers, capacity, category + open/private join choice, eligibility and conditional institution IDs, requirements and conditional prompt, conditional private code, exact prize and entry-fee rails. In the 5/12 visual form: MLBB game, server-permitted personal/community host choice, staged pubmat and editorial preview. | `POST /tournaments`; session creator. Dates/capacity/format combinations validate server-side; host/community eligibility is server-derived; price display converts to exact minor units or SOL digit string. |
| Edit tournament | Only server-allowed pre-start config/presentation fields plus `version`. | `PATCH /tournaments/{id}`; creator/policy. Locked fields stay visibly unavailable after start. |
| Register / withdraw | Team ID from eligible teams, optional requirements URL, private invite code, biometric authorization when policy requires; version on withdrawal. | `POST /tournaments/{id}/registrations`, `POST /registrations/{id}/withdraw`; authorized participating leader. Server snapshots lineup and returns readiness; it does not mean payment settled. |
| Staff / announcement / reaction / rating | Staff user ID and role name; announcement title/body; reaction enum or null; rating 1-5 and optional feedback. | Listed FR-TOURN endpoints; creator/staff/participant policy. Staff removal is pre-start only; reaction and rating are current-user state. |
| Lifecycle | No free-form status field; resource `version`. | Registration-open, start, complete, archive commands. State transition controls present only when server projection says available. |
| Bracket / seed / reconcile | Resource version for creation/shuffle; no bracket result editing. | `POST /tournaments/{id}/bracket`, `/seeds/shuffle`, `/bracket/reconcile`; creator policy. A queued/sync-failed bracket does not show invented advancement. |

## Matches, evidence and results

| Screen/action | Field order and canonical binding | Command / authorization / truthful state |
| --- | --- | --- |
| Upload game evidence | Staged asset ID for the selected tournament match/game. | `POST /matches/{id}/games/{gameId}/evidence`; permitted source. Response is evidence plus extraction job; display integrity/extraction status, not extracted sample stats. |
| Review OCR draft | `ACCEPT`/`REJECT`, detected-row corrections only, rationale, version and idempotency key. A correction selects a frozen-roster participant and pinned-catalog hero or `UNKNOWN`; it cannot invent data. | `POST /ocr-runs/{id}/review`; reviewer permission. Source evidence and local diagnostics remain immutable; only complete accepted review atomically commits official game data. |
| Manual game result | Winner team ID, permitted score fields, source `MANUAL`, version. | `POST /matches/{id}/games/{gameId}/result`; permitted reviewer/staff. Valid recorded games determine series score. |
| Match display | No client mutation from the read view except its explicitly permitted actions. | `GET /matches/{id}`. Team panels, games and player rows follow V09/V10; unresolved/unreadable player fields remain visible as such, not guessed. |

## Scrimmages and immediate finalization

| Screen/action | Field order and canonical binding | Command / authorization / truthful state |
| --- | --- | --- |
| Create/edit block | Posting team ID selected from actor’s permitted teams, description, rank min/max, schedule, best-of, lobby name/password and `version` for edits. | `POST/PATCH /scrimmages`; session principal and host policy. Lobby secret is encrypted; no browser-side public display. |
| Accept/cancel challenge | Accepting team ID selected from permitted teams plus roster/fair-play/lobby acknowledgments; version for cancel. | `POST /scrimmages/{id}/accept` or `/cancel`; participating leader/host policy. A matched/cancelled state comes from server. |
| Room messages | Body up to 1000. | `GET/POST /scrimmages/{id}/comments`; participant only. System messages have no client-supplied actor. |
| Propose result | Winner team ID, team A/B series wins, optional MVP user ID, optional evidence asset ID. | `POST /scrimmages/{id}/result`; one authorized participating leader. First valid request atomically finalizes one canonical match and is idempotent; a conflicting later result is 409. No timer, dual confirmation or fabricated game rows. |

## Fees, rewards, credentials and notifications

| Screen/action | Field order and canonical binding | Command / authorization / truthful state |
| --- | --- | --- |
| Pay entry fee | Server-selected configured rail; PayMongo has no user-supplied amount/method/account data and shows **test checkout — no real funds**; Solana first obtains a short-lived server-frozen Devnet payer/destination/lamports/memo intent, then submits only its resulting signature. | `POST /registrations/{id}/payment` or `/solana-payment-intent`, then `/solana-verification`; participant permission. PayMongo opens only the server-returned hosted URL, then refetches a webhook/reconciliation-backed state; Solana becomes paid only after exact successful finalized Devnet evidence. Pending/failed/refused is visibly distinct from `PAID`; redirect/wallet callback/signature submission never settles. |
| Draft/finalize rewards | Placement allocation rows: placement, team, representative user, rail, exact amount and destination reference; `version`. | `PUT /tournaments/{id}/rewards`, then `/rewards/finalize`; operator policy. Finalization freezes allocation values; UI cannot silently alter them. |
| Fund/release blockchain escrow | Creator funding intent/version then transaction signature; finalized two-recipient CHAMPION/RUNNER_UP allocation. | `POST /tournaments/{id}/escrow/funding-intent`, then `/escrow/verification`; release through permitted `POST /tournaments/{id}/payouts`. Creator browser signs funding; worker-only operator signs exactly one release. Pending finality is not funded/paid; no timer/automatic release. |
| Payout / cash handover | Finalized allocation ID; handover reference and date for cash. | `POST /tournaments/{id}/payouts`, `/allocations/{id}/handover`; operator. External processing is pending until provider/chain/acknowledgement evidence. PayMongo E-Wallet payout shows the documented test-mode unavailable state; it has no transfer, recipient or refund control. |
| Draft/issue/void certificate | Recipient type and permitted recipient ID, award/type, title and description; version for issue/void, controlled void reason category/private note. | Certificate endpoints; issuer policy. The server derives `pcc-certificate-v1` metadata—no free-form JSON/URI/image input. `DRAFT`, `PENDING_RECONCILIATION`, `ISSUED` and `VOIDED` have separate visual states. Never display a Core asset address/transaction as successful without finalized owner/URI/hash/`PermanentFreezeDelegate(frozen: true, authority: None)`/no-collection/no-update-authority evidence. |
| Notifications | Read-all action, or own notification `read`/`dismissed` boolean. | Notification endpoints; recipient session only. Dismiss is viewer state, not deletion of the audit event. |

## Read-only public actions

Public directory filters are `q`, the documented category/status/tier/role/join/prize filters, cursor and limit. Certificate lookup is a read action. Any public CTA that leads to registration, editing, staff, wallet, evidence or payment first enters the relevant authenticated route and server policy; a public URL never grants the command.

## Required form-state presentation

Every matrix row that writes data must render all applicable states: initial, client/server validation, submitting, idempotent replay, conflict/current-version refresh, unauthorized/forbidden, provider/job pending, failed/retryable, and server-confirmed result. Use [the route contract](ROUTE_CONTRACTS.md) for placement, then preserve the source visual hierarchy without copying its mocked success behavior.
