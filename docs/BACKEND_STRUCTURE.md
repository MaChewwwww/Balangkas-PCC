# Backend ownership structure

**Status: preparation blueprint only.** This describes the folder boundaries to create after the explicit onsite-development authorization. It is not an application scaffold and none of the folders contains application source yet.

## Target structure

| Location | Owns after activation | Must not own |
| --- | --- | --- |
| `backend/app/api/v1` | HTTP routing, request parsing, response projection and transport dependency wiring | business decisions, direct cross-domain writes or provider calls |
| `backend/app/core` | configuration loading, session/CSRF verification, standardized errors, request IDs and observability wiring | feature policy or database aggregates |
| `backend/app/db` | database connection, unit-of-work/transaction boundary and migration integration | HTTP behavior, authorization policy or feature orchestration |
| `backend/app/domains` | Feature commands, authorization decisions, aggregates, query projections and domain-specific invariants | framework routing and external-provider SDK setup |
| `backend/app/integrations` | Typed adapters for Brevo, Challonge, PayMongo test-mode Hosted Checkout/webhook reconciliation, Devnet-only Solana finalized-read/escrow/Core certificate work, object storage, local MLBB extraction (hash-verified RF-DETR, detector-crop PaddleOCR and pinned template catalog), and the hash-verified W600K-R50 embedding runtime | face detection/multiple-face detection, external screenshot/model fallback, fallback success, fabricated provider evidence, Mainnet/Testnet/flexible-RPC Solana work, API/frontend signer access, Token Metadata certificate minting, PayMongo live/Wallet/transfer/payout/refund operations or feature ownership |
| `backend/app/workers` | Durable outbox/job claim, retry, reconciliation and delivery handlers | polling a second confirmation for scrimmage results or replacing database authority |
| `backend/migrations` | Fresh schema-migration tooling and revisions created after activation | external migration histories or upgrade assumptions |
| `backend/tests/unit` | Fast isolated checks of domain decisions and projections | browser E2E suites |
| `backend/tests/integration` | Database/API/adapter-boundary checks that use controlled infrastructure | production provider credentials |

The approved empty-directory baseline mirrors these locations. It deliberately contains no `main`, router, model, migration, test or other executable implementation before the preparation gate is unlocked.

## Dependency direction

`api/v1` may call a single appropriate domain command or query through its application boundary. A domain may use `db`, its declared integration port and durable job/outbox abstractions. Integrations and workers may not grant authorization, manufacture source-system state, or bypass a domain invariant. The composition root connects those pieces only after activation.

Domains are `auth`, `identity`, `teams`, `communities`, `tournaments`, `matches`, `scrimmages`, `history`, `rewards`, `certificates`, `notifications` and `public_discovery`. A cross-domain workflow is an explicit command with one transaction boundary and an audited outcome; it is not a router importing another router or a client selecting an actor ID.

## Critical implementation boundaries

- The session principal is the sole actor source. Routes never accept an owner, creator or user field as authorization evidence.
- A successful `POST /scrimmages/{id}/result` must commit authorization, finality check, match/history projection and outbox records atomically. The first valid participating-leader result wins immediately; a conflicting later request returns `RESULT_ALREADY_FINALIZED`. No worker or confirmation timer may decide finality.
- Provider/OCR/biometric adapters return verified evidence, an explicit pending state, or an explicit unavailable/failure state. The biometric adapter validates bounded crop bytes, model identity, a single-use challenge's server-known session/action/crop binding, and embedding policy. Face detection, multiple-face rejection, alignment and blink/liveness/anti-spoof capture checks stay in the frontend `@vladmandic/human` pipeline and are never repeated by the backend. A Human browser report is not a cryptographic provider attestation; no adapter may represent it as one or return a simulated successful verification.
- Async work begins from the transactionally persisted outbox. Redis is transient delivery/throttle infrastructure, not a source of truth.
- Client projections are selected intentionally at the API boundary. Hashes, tokens, provider secrets, raw biometric material, internal object keys and audit-only fields never cross it.

The browser-facing details belong to [API integration](API_INTEGRATION.md); durable records belong to [the data dictionary](DATABASE.md); deployment configuration belongs to [configuration](CONFIGURATION.md).
