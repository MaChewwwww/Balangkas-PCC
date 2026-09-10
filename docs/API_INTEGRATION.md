# Browser and API integration contract

**Status: preparation contract only.** This is the exact boundary between the one Next.js application and the FastAPI service after onsite activation. It supplements [API contracts](API_SPEC.md); endpoint-specific inputs and feature behavior remain authoritative there.

## Origin, session and request model

The browser calls relative `/api/v1` paths on the one public HTTPS origin. It does not call a separate API host, route business requests through Next.js API routes, keep server state in `localStorage`, or invent a development actor ID. Nginx routes `/api/` to FastAPI; Next.js owns screens and browser presentation only.

Login, a successful real OTP verification and `GET /auth/me` return a current-user projection plus a CSRF token. The server sets a `pcc_session` cookie with `Secure`, `HttpOnly`, `SameSite=Lax` and `Path=/`; its expiry matches the server session. The feature container keeps the CSRF token only in memory and refreshes it from the current-user/session response after reload or login. JavaScript must never read, construct or persist the session cookie.

Every cookie-authenticated state-changing request sends the current `X-CSRF-Token` header and is subject to exact `Origin` validation. Public registration and OTP request endpoints still enforce their own throttles. A missing/expired session yields `401 AUTH_REQUIRED`; a bad CSRF token yields `403 CSRF_REJECTED`; a non-approved origin yields `403 ORIGIN_REJECTED`.

## Response, retry and projection conventions

| Concern | Browser contract |
| --- | --- |
| Entity success | A resource projection contains `id`, `version` when mutable, and only permission-safe fields documented by the applicable feature/API contract. |
| Collection success | `{ "items": [...], "next_cursor": string or null }`; preserve the opaque cursor unchanged for the next request. |
| Portal navigation context | A detail route forwards only the normalized allowlisted origin values in [the breadcrumb-context contract](screens/BREADCRUMB_CONTEXT.md). It renders an optional server-returned `navigation_context` only after the destination's ordinary session/permission resolution. The browser never fetches a parent solely from an origin ID, renders a URL-provided label, or treats retained context as access to an ancestor/action. |
| Error | `{ "code": string, "message": string, "field_errors": object or null, "request_id": string }`. The UI maps `field_errors` to controls and preserves unrelated form input. |
| Error codes | `AUTH_REQUIRED`, `CSRF_REJECTED`, `ORIGIN_REJECTED`, `VALIDATION_FAILED`, `NOT_FOUND`, `FORBIDDEN`, `VERSION_CONFLICT`, `IDEMPOTENCY_CONFLICT`, `RESULT_ALREADY_FINALIZED`, `BIOMETRIC_CAPTURE_REJECTED`, `BIOMETRIC_DUPLICATE`, `PAYMENT_TEST_MODE_ONLY`, `PAYMENT_EVIDENCE_MISMATCH`, `SOLANA_EVIDENCE_MISMATCH`, `SOLANA_PENDING_FINALITY`, `SOLANA_DEVNET_ONLY`, `RATE_LIMITED`, `MAINTENANCE`, `INTEGRATION_UNAVAILABLE` and `UPLOAD_REJECTED`. Biometric capture and duplicate codes have generic messages and reveal neither a matched account nor an internal score. A missing/mismatched biometric model, entitlement, approved Human browser asset or capture-policy version is `INTEGRATION_UNAVAILABLE`; a rejected, expired or malformed browser capture report is `BIOMETRIC_CAPTURE_REJECTED`. PayMongo test-mode errors never expose provider secrets, billing data or raw responses; chain errors never expose signer material or raw wallet-provider payloads. The client uses codes for behavior and shows the safe message, never parses server prose. |
| Idempotent mutation | For each logical create, result, review, payment or issuance action, generate one UUID `Idempotency-Key`, retain it only until that operation resolves, and reuse it exactly for a network retry. Reusing it with different input is `409 IDEMPOTENCY_CONFLICT`; a matching replay returns the original outcome/reference. |
| Optimistic edit | Send the displayed aggregate `version` on PATCH/command routes that require it. On `409 VERSION_CONFLICT`, retain the draft, reload the projection and present the user a merge/retry choice; do not silently overwrite. |
| Throttle/unavailable | Respect `Retry-After` where supplied. A `429 RATE_LIMITED` or `503 INTEGRATION_UNAVAILABLE` is not success and must not advance the UI state. |

On an immediate scrimmage result submission, a `200` proves the result was atomically accepted and final. A `409 RESULT_ALREADY_FINALIZED` means another valid first result already won; reload the canonical scrimmage/match projection. The client must never wait for, show, or attempt a second-party confirmation.

## Wallet and Solana state behavior

The wallet modal displays only `Solana Devnet`. After a `POST /wallet/challenges` response, it asks the connected wallet to sign the exact returned message once and submits the signature plus fresh biometric authorization to the API. A wallet-provider approval screen or local “signed” callback is not linked until the returned server projection includes the linked address.

For SOL entry fees, the browser uses the server payment snapshot/instructions and sends only the resulting signature to verification. It renders `SOLANA_PENDING_FINALITY` as pending and polls/refetches the payment projection; `SOLANA_EVIDENCE_MISMATCH` is an unpaid failure that keeps registration pending; `SOLANA_DEVNET_ONLY` or `INTEGRATION_UNAVAILABLE` disables the action with its safe reason. It never sends a transaction to an address/amount/memo assembled from stale client state, switches RPC cluster, or promotes the success toast to paid. Escrow funding follows the same pattern with a server-created short-lived funding intent. Certificate UI has no wallet-signing control: the portal distinguishes `DRAFT`, `PENDING_RECONCILIATION`, `ISSUED` and `VOIDED`; only the server-reported finalized Core NFT evidence is issued. A public pending lookup says only that it is not yet valid, and a public voided lookup retains evidence without implying a chain mutation. See [Solana readiness](SOLANA.md).

## Authentication projections and hackathon demo OTP exception

The current-user projection includes `authentication_mode`, whose only client-visible values are `EMAIL_VERIFIED` and `DEMO_BYPASS`. It may include `email_verified_at` only after actual OTP evidence verifies the email. Account readiness, wallet, biometric, payment, settlement and certificate fields remain governed by their own evidence requirements.

For the user-authorized hackathon exception, the server reads `PCC_HACKATHON_DEMO_OTP_CODE`, which must be the committed non-secret value `123456`. It is accepted only when all of the following are true:

- `PCC_HACKATHON_DEMO_OTP_CODE` is exactly `123456`.
- `PCC_ENVIRONMENT` is exactly `staging`.
- `PCC_HACKATHON_DEMO_OTP_ENABLED` is exactly `true`.

The code is rejected as an ordinary invalid code otherwise. A successful bypass creates/returns a clearly classified `DEMO_BYPASS` session and records an `otp.demo_bypass_used` audit event with the account/session reference but never the raw OTP. It does **not** set `email_verified_at`, create email/provider verification evidence, grant a Verified identity presentation, or satisfy biometric, wallet, payment, settlement, credential or certificate requirements. The frontend labels it as demo access rather than a verified identity. Disabling the flag revokes/rejects existing demo-bypass sessions; it does not alter real verified sessions. A missing or altered code configuration leaves the bypass unavailable.

## Assets and maintenance behavior

`POST /assets` is multipart with a `purpose` field and one file. A successful response is a safe staging projection:

`{ "id", "purpose", "content_type", "byte_size", "width", "height", "sha256", "status": "STAGED" }`.

It never returns a storage access key, private object key, arbitrary object URL or automatic business attachment. The subsequent feature command attaches the asset after purpose/ownership/authorization validation. Unsupported type, excessive size, unreadable image or purpose mismatch is `422 UPLOAD_REJECTED` with a field error. Content retrieval remains `GET /assets/{id}/content` and applies the owning-context permission check.

A scoreboard-evidence attachment returns only the evidence/extraction reference and truthful pending or unavailable state. The browser gets an OCR draft only through the reviewer-authorized projection: source evidence under its normal permission check, field values/nulls, local diagnostics, catalog candidate ranks and frozen-roster choices. It never receives a provider result because this local path has none. The browser must label every draft/candidate/fuzzy/unreadable state as non-official; only a successful versioned/idempotent review command can produce the recorded-game projection.

`GET /api/health` is a small non-secret readiness projection with `state` of `ready` or `maintenance`; it exposes no build, provider, database or credential details. While operator maintenance is enabled, a state-changing request returns `503 MAINTENANCE` with `Retry-After`. The frontend shows a persistent maintenance notice, disables commit actions, and retains local in-progress form drafts. Permission-filtered reads may remain available unless an operator explicitly quiesces the service.

## Real-time subscription wire contract

The browser connects to same-origin `wss://<public-origin>/ws/events` using the session cookie during the upgrade; it does not put tokens in query strings or local storage. The upgrade performs the same session and Origin checks as the HTTP boundary.

After connection, the browser sends a control message with a client-generated `request_id`:

`{ "type": "subscribe", "request_id": "uuid", "channels": [{ "kind": "team|community|tournament|user", "id": "uuid" }] }`

It removes subscriptions with the identical shape and `type: "unsubscribe"`. The server replies with an accepted/rejected control result for that `request_id`; it authorizes every requested channel and may subscribe a user only to their own user channel. A rejected channel leaks no existence details. Delivery events use the durable event envelope defined in [storage and jobs](STORAGE_JOBS.md); on reconnect, the client refreshes affected API projections rather than treating an event as the sole authoritative record. During maintenance, the server may close the socket with retryable code `1013`.

## Implementation hand-off checklist

- Frontend feature containers use this contract, [route contracts](screens/ROUTE_CONTRACTS.md) and [cross-feature breadcrumb context](screens/BREADCRUMB_CONTEXT.md), rather than copying external client-local actions.
- Backend route/projection ownership follows [backend structure](BACKEND_STRUCTURE.md), and shared configuration follows [configuration](CONFIGURATION.md).
- Focused unit, API/integration and Vitest component checks cover changed behavior. Developers complete the required manual UI report; automated browser E2E/visual-regression suites are intentionally out of hackathon scope.
