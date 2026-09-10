# Acceptance catalogue

These are written scenarios, not executable tests. Implement tests onsite with the feature. The practice test inventory is evidence of intended interaction and explicitly marks demo-only substitutions.

| ID | Scenario |
| --- | --- |
| AC-AUTH-01 | Duplicate normalized email cannot create two accounts. |
| AC-AUTH-02 | Invalid/expired OTP and exhausted attempts do not verify email. |
| AC-AUTH-03 | Non-student transition clears institution; student cannot save without a known institution. |
| AC-AUTH-04 | Reload restores server-owned profile, not a hardcoded first player. |
| AC-AUTH-05 | Onboarding preserves a valid join destination but never bypasses eligibility/payment. |
| AC-IDENT-01 | Missing face model returns unavailable without writing verification. |
| AC-IDENT-02 | Same wallet may be linked independently by different verified users; no duplicate-wallet uniqueness constraint. |
| AC-IDENT-03 | Forged/expired/replayed challenge fails before wallet change. |
| AC-IDENT-04 | Unverified profile never inherits prototype Verified Competitor badges. |
| AC-IDENT-05 | Zero matches displays zero/empty state, never fixture fallback statistics. |
| AC-TEAM-01 | Public visitors do not see private-team details; authenticated directory may show restricted private-team summary only. |
| AC-TEAM-02 | Invite codes never appear in directory payloads. |
| AC-TEAM-03 | Duplicate join is idempotent; departing member retains historical match attribution. |
| AC-TEAM-04 | Last active member departure archives the team; a captain with remaining members transfers leadership first. |
| AC-TEAM-05 | Historical participation prevents hard deletion. |
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
| AC-MATCH-01 | Same evidence/game acceptance cannot advance bracket twice. |
| AC-MATCH-02 | Left/right screenshot positions never assume platform team colors. |
| AC-MATCH-03 | Unknown/unreadable stats remain null rather than zero. |
| AC-MATCH-04 | Incomplete/ambiguous player identities block their official stats until resolved. |
| AC-MATCH-05 | Provider failure preserves accepted local result and exposes pending bracket synchronization. |
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
| AC-CERT-01 | Walletless individual issuance fails before signer use. |
| AC-CERT-02 | Team issuance never fabricates a user recipient. |
| AC-CERT-03 | Repeated issuance returns the existing attempt/mint and cannot mint twice. |
| AC-CERT-04 | Unknown, malformed and draft lookup never substitute a fixture record. |
| AC-CERT-05 | Revocation changes public status and retains issuance evidence; do not imply on-chain revocation unless implemented and verified. |
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
