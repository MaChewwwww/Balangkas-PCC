# Identity, authorization and privacy contracts

| Concern | Required behavior |
| --- | --- |
| Session | Short-lived signed session JWT in Secure HttpOnly SameSite=Lax cookie, 24-hour expiry; session row enables logout/revocation. No bearer token in localStorage. |
| CSRF | Require same-origin Origin and session-bound CSRF token on cookie-authenticated mutations. WebSocket upgrade verifies session and Origin. |
| Password | Argon2id hash; minimum 12 characters, maximum 128; never log credentials. Password reset token single-use, 15-minute expiry, hashed at rest. |
| OTP | Six digits, 10-minute expiry, 5 attempts; 60-second resend interval, 5 sends per hour per account/IP. Generic request response avoids account enumeration. |
| Demo OTP | Disabled by default; only explicitly flagged local demo mode permits a configured bypass. Never enables biometric or wallet verification. |
| Resource ownership | Use session user ID. Client owner/creator/user fields cannot grant permissions. Per-resource role checks on every write. |
| Biometric input | Consent + client liveness precede one cropped HTTPS frame; never raw streams. Server validates decodable single-face input and does not trust a client boolean as proof. |
| Enrollment | Normalize 512-d embedding; similarity >= 0.65 is duplicate conflict. Missing model, inference failure or invalid frame cannot mark verified. Serialize duplicate-check and enrollment writes to prevent simultaneous duplicate enrollment. |
| Wallet link/change | Single-use signed wallet challenge + 1:1 biometric similarity >= 0.70; five-minute expiry. Atomic update of users.linked_wallet_address with audit. Wallet sharing across users is permitted. |
| Tournament entry | Leader supplies five-minute single-use biometric authorization bound to user, action and tournament. No client-generated proof. |
| Face retention | Delete raw face bytes after inference; persist embedding and consent/version audit only. Do not expose embeddings or verification internals publicly. |
| Object privacy | Authorize evidence/lobby access before response; no public object listing. Remove metadata from user image uploads. |
| Codes | Store team/community/tournament invite hashes only; reveal fresh code once to authorized creator, then rotate if lost. Directory never exposes codes. |
| Logs | Correlation IDs and non-sensitive event references; no tokens, face bytes, lobby passwords, invite codes or payment-account details. |

## Role matrix

| Resource/action | Visitor | Member/player | Leader/manager | Creator/operator |
| --- | --- | --- | --- | --- |
| Public directory | Visible records only | Same public policy | Same public policy | Same public policy |
| Own profile/wallet | No | Own only | Own only | Cannot bypass recipient proof |
| Team private details | No | Active member | Captain/coach/manager | Team captain controls delegation |
| Team settings/archive | No | No | Captain or delegated manager | Historical records retained |
| Community posts | No | Active community member | Owner/manager moderate | Owner manages access/archive |
| Tournament settings/staff | No | No | Assigned staff read/operate allowed match views | Creator only; staffing locked after start |
| Official tournament result | No | Read permitted projection | Explicit tournament match-review permission | Creator permitted |
| Scrimmage result | No | No | Participating team captain or manager | No unrelated global-user bypass |
| Payout release | No | No | No | Authorized operator after readiness and immutable allocation |
| Certificates | Issued public record only | Own credential view | No implicit signer access | Authorized tournament issuer |

Private player details are available to self and authorized competition operations only; public profile navigation never substitutes a different player when an ID is missing. Return 404 for hidden records, 403 for an authenticated visible resource's forbidden action.
