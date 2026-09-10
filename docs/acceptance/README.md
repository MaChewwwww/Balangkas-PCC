# Acceptance catalogue

These are written scenarios, not executable tests. Implement tests onsite with the feature. The documented interaction inventory preserves intended behavior and explicitly marks demo-only substitutions.

## Shared portal navigation

| ID | Scenario |
| --- | --- |
| AC-NAV-01 | A permitted cross-feature path retains its complete, ordered origin trail and the originating sidebar family: Community → Team → Player → Tournament retains Communities; team/current-team and Match History paths retain their respective roots. A direct destination route uses its ordinary family trail. |
| AC-NAV-02 | Generated cross-feature and breadcrumb links carry only the normalized allowlisted context, preserve the valid chain through a reload, and truncate context when moving up a breadcrumb so no cyclic trail results. |
| AC-NAV-03 | A malformed, duplicate, hidden, unrelated, stale or cyclic origin parameter cannot authorize a read/action, trigger a parent-only fetch, reveal a label/link, or change the permitted destination projection. The server omits it and the UI uses its safe ordinary trail. |

| ID | Scenario |
| --- | --- |
| AC-AUTH-01 | Duplicate normalized email cannot create two accounts. |
| AC-AUTH-02 | Invalid/expired OTP and exhausted attempts do not verify email. `123456` works only when `PCC_HACKATHON_DEMO_OTP_CODE=123456`, exact staging mode, and the explicit demo flag are all present; it creates `DEMO_BYPASS`, never real email/provider/biometric/wallet verification evidence. |
| AC-AUTH-03 | Non-student transition clears institution; student cannot save without a known institution. |
| AC-AUTH-04 | Reload restores server-owned profile, not a hardcoded first player. |
| AC-AUTH-05 | Onboarding preserves a valid join destination but never bypasses eligibility/payment. |
| AC-AUTH-06 | Completed onboarding rejects a missing/malformed MLBB User ID, four-digit Zone ID, rank or primary role; display selections serialize to canonical values without asserting game-account verification. |
| AC-IDENT-01 | Missing, hash-mismatched or failed face model returns unavailable without writing verification. |
| AC-IDENT-02 | Same wallet may be linked independently by different verified users; no duplicate-wallet uniqueness constraint. |
| AC-IDENT-03 | Forged/expired/replayed challenge fails before wallet change. |
| AC-IDENT-04 | Unverified profile never inherits prototype Verified Competitor badges. |
| AC-IDENT-05 | Zero matches displays zero/empty state, never fixture fallback statistics. |
| AC-IDENT-06 | The frontend does not submit zero- or multiple-face captures and requires the selected Human blink/liveness/anti-spoof capture gate. A malformed, oversized, unsupported or animated submitted crop, or missing/malformed/mismatched Human capture report, creates no biometric record and gets only a generic capture failure. |
| AC-IDENT-07 | Simultaneous same-person enrollment attempts produce at most one stored enrollment; a duplicate response identifies neither a matched account nor a similarity score. |
| AC-IDENT-08 | A liveness challenge cannot be replayed, used after expiry, or applied to another user, action, resource or submitted crop. |
| AC-IDENT-09 | A biometric authorization is issued only from a current enrollment and matching consumed liveness challenge, and cannot be reused after its five-minute expiry. |
| AC-IDENT-10 | Missing model entitlement, model/hash/load validation, reviewed Human browser assets or selected Human capture policy returns unavailable without a biometric write or authorization. |
| AC-IDENT-11 | An enrollment retains only the embedding, consent and approved model/preprocessing/Human-capture-policy identities; no raw capture, detector output or browser report is persisted. |
| AC-IDENT-12 | Wallet signature is accepted once only for the exact stored Solana Devnet challenge/user/address/origin/purpose; chain/cluster/address/message/user/action/expiry mismatch creates no wallet change. |
| AC-TEAM-01 | Public visitors do not see private-team details; authenticated directory may show restricted private-team summary only. |
| AC-TEAM-02 | Invite codes never appear in directory payloads. |
| AC-TEAM-03 | Duplicate join is idempotent; departing member retains historical match attribution. |
| AC-TEAM-04 | Last active member departure archives the team; a captain with remaining members transfers leadership first. |
| AC-TEAM-05 | Historical participation prevents hard deletion. |
| AC-TEAM-06 | Team create/edit exposes explicit recruiting state in the preserved division/accessibility form group; an empty roster slot never changes that state, and the route retains its approved visible 50/4/300 limits while the server validates canonical limits. |
| AC-COMM-01 | Collegiate community requires a valid institution; grassroots cannot retain one. |
| AC-COMM-02 | Private membership cannot be granted by client-only code comparison. |
| AC-COMM-03 | A repeated reaction changes no additional counter; opposite reaction replaces it. |
| AC-COMM-04 | Member/team/player/tournament links preserve community navigation origin. |
| AC-COMM-05 | Archived community retains auditable data and blocks new writes. |
| AC-TOURN-01 | Capacity is enforced atomically under concurrent registration. |
| AC-TOURN-02 | All active submitted collegiate lineup players have school IDs within the chosen eligibility set. |
| AC-TOURN-03 | Open and invitation-only events remain searchable publicly. |
| AC-TOURN-04 | Tournament start locks sensitive settings and staffing; presentation updates remain available. |
| AC-TOURN-05 | Withdrawal is retained in history and cannot silently refund a payment. |
| AC-TOURN-06 | Create/edit presents registration deadline, eligibility and conditional institution selection, plus requirements and conditional prompt in the existing operations form; missing or stale values cannot be replaced by descriptive text or a client-created lifecycle state. |
| AC-MATCH-01 | Same evidence/game acceptance cannot advance bracket twice. |
| AC-MATCH-02 | Left/right screenshot positions never assume platform team colors. |
| AC-MATCH-03 | Unknown/unreadable stats remain null rather than zero. |
| AC-MATCH-04 | Incomplete/ambiguous player identities block their official stats until resolved. |
| AC-MATCH-05 | Provider failure preserves accepted local result and exposes pending bracket synchronization. |
| AC-MATCH-06 | Missing, hash-mismatched, wrong-resolution or wrong-label RF-DETR checkpoint, absent recorded checkpoint-use approval, missing local PaddleOCR assets, or a catalog-manifest mismatch leaves extraction unavailable without creating an official game write. |
| AC-MATCH-07 | Over-limit/slow-to-decode evidence is rejected before storage; EXIF orientation is normalized in memory; valid media that cannot attest `mlbb_post_match_v1` remains `UNSUPPORTED_LAYOUT`/review. Detector-missing, overlay-obscured or ambiguously parsed score/row fields remain null or `NEEDS_CLEARER_SCREENSHOT`; no fixture, team colour, filename, row order or arithmetic fills them. |
| AC-MATCH-08 | Template ranking supplies at most its documented local candidates; a candidate, fuzzy IGN suggestion or an unknown hero never becomes an accepted player statistic without reviewer confirmation. |
| AC-MATCH-09 | MLBB extraction never downloads model assets at runtime or sends screenshot/crop/OCR data to an external model provider. |
| AC-MATCH-10 | Reviewer acceptance validates frozen roster, pinned hero catalog, row completeness, score/KDA reconciliation, MVP consistency, version and idempotency, then writes game/series/outbox data atomically; stale or duplicate acceptance cannot advance twice. |
| AC-MATCH-11 | The three approved reference screenshots are manually reported as layout/overlay cases only; their fixture data is never hard-coded, seeded or represented as PCC evidence. |
| AC-SCRIM-01 | Two concurrent challengers cannot both accept one block. |
| AC-SCRIM-02 | Unrelated user cannot view lobby password or submit result. |
| AC-SCRIM-03 | One valid participating leader submission finalizes immediately and emits one event. |
| AC-SCRIM-04 | Identical replay returns the same match ID; different later payload returns 409 RESULT_ALREADY_FINALIZED. |
| AC-SCRIM-05 | Winner belongs to participating teams and reaches floor(best_of/2)+1 wins; loser stays below that threshold. |
| AC-HISTORY-01 | Tournament and scrimmage finalization each contribute exactly one series. |
| AC-HISTORY-02 | Roster departure does not reassign old player statistics. |
| AC-HISTORY-03 | No matches gives zero count and unavailable win-rate denominator. |
| AC-HISTORY-04 | CSV uses stable IDs, ISO timestamps and explicit columns; formula-leading text is escaped. |
| AC-HISTORY-05 | Public analytics honor profile/team visibility and never include raw OCR evidence. |
| AC-PAY-01 | Free entry and no-prize tournament require all corresponding amounts zero. |
| AC-PAY-02 | Fractional minor units are rejected, never rounded. |
| AC-PAY-03 | Unverified fee cannot grant a registered slot; webhook duplicates cannot pay twice. |
| AC-PAY-04 | Changing linked creator wallet does not change existing payment destination snapshots. |
| AC-PAY-05 | Physical handover never claims a PayMongo webhook; provider configuration alone never marks PAID. |
| AC-PAY-06 | A redirect, invalid signature, live-mode event, unknown/mismatched Checkout Session, non-PHP or different-centavo result creates no PAID registration. A valid duplicate/out-of-order test event cannot regress or pay twice. |
| AC-PAY-07 | Only GCash, Maya and QR Ph are allowed in the PayMongo test Checkout; cards and every other method are rejected/not offered. QR Ph uses PayMongo's simulation/test URL, never a real QR scan. Non-test PayMongo keys/events and all Wallet, recipient, payout/disbursement, InstaPay/PESONet, refund and PayMongo E-Wallet prize actions remain unavailable; no UI calls them transferred or paid. |
| AC-PAY-08 | Solana entry becomes paid only from one finalized Devnet transaction matching frozen payer/destination/lamports/memo; a chain escrow has exactly two immutable recipients and one explicit operator release, never a timer. |
| AC-CERT-01 | Walletless individual issuance fails before signer use. |
| AC-CERT-02 | Team issuance never fabricates a user recipient. |
| AC-CERT-03 | Repeated issuance returns the existing attempt/Core asset and cannot issue twice. |
| AC-CERT-04 | Unknown, malformed and draft lookup never substitute a fixture record. |
| AC-CERT-05 | A PCC registry void changes public status to `VOIDED`, retains issuance evidence and a private void note, and never claims an on-chain burn, thaw, transfer or revocation. |
| AC-CERT-06 | Only finalized frozen no-update-authority Metaplex Core asset evidence can issue a certificate; metadata upload, browser claim, Token Metadata mint, wrong owner/URI, transferable asset, update authority, or collection-membership assertion cannot. |
| AC-CERT-07 | A post-submission crash, timeout or missing signature leaves the certificate `PENDING_RECONCILIATION`; reconciliation re-reads only the saved candidate/signature at the finalized commitment and cannot sign a replacement while the outcome is ambiguous. |
| AC-CERT-08 | Public metadata is exactly the server-derived `pcc-certificate-v1` allowlist; an unknown or draft record is unavailable, and a pending lookup discloses no recipient, award, facts or validity. |
| AC-NOTIFY-01 | One event cannot create duplicate notification for the same recipient. |
| AC-NOTIFY-02 | Read/dismiss changes survive refresh and do not alter another user's state. |
| AC-NOTIFY-03 | Inaccessible destination resolves safely and does not leak entity details. |
| AC-NOTIFY-04 | Actual certificate issuance emits notification; draft or mock state does not. |
| AC-NOTIFY-05 | WebSocket interruption loses no persistent notifications. |
| AC-PUBLIC-01 | Private team/player absent from public search and direct public detail. |
| AC-PUBLIC-02 | Unknown IDs show unavailable state, never another record. |
| AC-PUBLIC-03 | Filter reset clears every combined filter without mutating source. |
| AC-PUBLIC-04 | Share/certificate search safely encodes user input. |
| AC-PUBLIC-05 | Reduced motion/unavailable WebGL uses static shield with accessible navigation. |
