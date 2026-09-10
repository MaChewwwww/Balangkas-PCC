# Solana Devnet readiness contract

**Status: preparation contract only.** PCC has no deployed program, Core asset, collection, signer, transaction, or Devnet account. No externally supplied program ID, collection address, metadata URI, transaction signature, keypair, generated IDL, build output or Devnet deployment may be reused.

PCC uses **Solana Devnet**, not Solana Testnet or Mainnet. Devnet SOL is test-only and has no real monetary value, but its public transactions, wallet addresses, asset ownership, metadata URI, and signatures are durable/public. No live-mainnet fallback, configuration switch, or cross-cluster verification is permitted during the hackathon.

## PCC replacement rules

| Capability | PCC decision |
| --- | --- |
| Entry-fee verification | Require a frozen payer/destination/lamport/memo snapshot plus finalized Devnet/genesis evidence. |
| Escrow program identity | Deploy a fresh onsite PCC program and treat missing capability as unavailable. |
| Escrow initialization | Preserve exactly two chain recipients, while creator browser funding does not require an operator co-signature. |
| Certificate assets | Use individually immutable frozen Core assets and make no collection-membership claim, matching current Core semantics. |

## Hard boundary

| Capability | Hackathon contract | Explicitly unavailable |
| --- | --- | --- |
| Wallet linking | Browser signs a PCC-issued, short-lived Solana Devnet challenge; API verifies the signature, then requires the existing biometric authorization before storing the canonical public key | Private-key upload/export, a browser-only success claim, EVM/non-Solana addresses, cluster inference from an address |
| SOL entry fee | Browser signs one native-SOL Devnet transfer from the registering leader's linked-wallet snapshot to the tournament creator's destination snapshot; API verifies finalized chain evidence | Escrow as an entry-fee destination, a client amount/paid claim, a shared signature, SPL-token fees, Mainnet/Testnet transfers |
| Blockchain prize | A new onsite Anchor escrow program holds one organizer-funded Devnet prize pool and releases exactly two finalized allocations: `CHAMPION` and `RUNNER_UP` | Additional on-chain placements, automatic release, pre-finalization release, an external pre-existing program/deployment, Mainnet funds |
| Certificates | Worker creates one individually immutable, permanently soulbound Metaplex Core NFT asset per issued certificate | Token Metadata mint/presentation copy, an unverified Core asset, mutable or transferable official credential, private recipient data in metadata |

The frontend may connect a wallet and sign its own challenge, entry, or escrow-funding transaction. It never receives a PCC signer, builds a source of truth from local wallet state, or marks a record paid, funded, released, or issued. The API verifies public evidence; the isolated worker alone reads the PCC operator signer for certificate issuance and escrow finalization/release.

## Required configuration and enablement

All variables below live in ignored application environment storage. At the user's direction, `.env.application.example` preselects every PCC Solana feature as the intended hackathon scope. Those booleans are neither authorization nor deployable evidence: an actual runtime is invalid, and must fail closed, until every required RPC, signer, program, metadata and finalized-evidence check passes.

| Variable | Required when enabled | Contract |
| --- | --- | --- |
| `PCC_SOLANA_ENABLED` | any chain capability | Exact `true` is the top-level switch; otherwise every chain action returns unavailable. |
| `PCC_SOLANA_DEVNET_ONLY` | always | Must be exact `true`; false, malformed, Mainnet, or Testnet configuration aborts startup. |
| `SOLANA_CLUSTER` | any chain capability | Exact `devnet`. It is returned in server projections and used to construct Explorer links; it is never accepted from a browser. |
| `SOLANA_RPC_URL` | any chain capability | HTTPS Devnet RPC endpoint. At startup it must answer healthy, return the configured Devnet genesis hash, and support finalized transaction/account reads. A public RPC is rate-limited; use an approved Devnet RPC only after recording its owner and limits outside Git. |
| `SOLANA_EXPECTED_GENESIS_HASH` | any chain capability | Exact expected genesis for the selected Devnet endpoint. The configuration example uses the currently documented public Devnet value; record a fresh check at enablement because Devnet can reset. |
| `PCC_SOLANA_ENTRY_FEES_ENABLED` | SOL entry fees | Exact `true` only after the finalized-read and wallet-adapter checks pass. |
| `PCC_SOLANA_ESCROW_ENABLED`, `SOLANA_ESCROW_PROGRAM_ID` | blockchain prize | Exact `true` plus a newly deployed PCC program ID. The program ID must be a canonical base58 public key and pass the release-record code/IDL/account checks below. |
| `PCC_SOLANA_CERTIFICATES_ENABLED`, `SOLANA_CERTIFICATE_METADATA_SCHEMA_VERSION` | certificates | Exact `true` only after Core asset, exact `pcc-certificate-v1` metadata-schema, SDK/version and metadata-storage checks pass. The schema is server-owned, never selected by an issuer/browser. |
| `PCC_SOLANA_OPERATOR_SIGNER_PATH` | escrow operator and certificate worker | Absolute path inside the **worker only** to a manually provisioned Devnet JSON keypair. It is mounted read-only from ignored host secrets, mode-restricted on host, and never loaded by API/frontend, logged, copied into an image, or returned by an endpoint. |
| `SOLANA_TEAM_CUSTODY_ADDRESS` | TEAM certificates | Canonical public key derived from the worker signer. It is the visible final owner of a TEAM certificate, never an invented captain/roster wallet. |
| `SOLANA_METADATA_STORAGE`, `SOLANA_IRYS_URL` | certificates | The approved Devnet permanent-metadata provider identifier and HTTPS endpoint. The adapter uploads only the reviewed public certificate JSON/image; an unavailable, mutable, wrong-environment, or hash-mismatched upload blocks issuance. The provider, endpoint, account custodian, retention/use terms and successful public read must be recorded outside Git before enablement. |

`PCC_SOLANA_ENABLED=true` is invalid unless the cluster/genesis/RPC checks pass. A feature flag is also invalid when its required program, signer, custody, metadata, or current SDK compatibility check is absent. The API process never mounts the signer directory; the worker has the narrow read-only secret mount already defined by deployment Compose.

## Wallet-link contract

The challenge binds `SOLANA`, exact canonical base58 public key, session user, `WALLET_LINK` purpose, random nonce, PCC public origin, Devnet cluster, issued/expiry times, and a server-computed message digest. It expires after five minutes and is single use. The wallet-signature verifier must check the detached Ed25519 signature against that exact stored message and proposed key before consuming the challenge. A valid signature still needs a fresh action-bound biometric authorization before the atomic user-wallet update.

Wallet addresses are deliberately allowed to be shared by different verified users, but each link/change has its own signed challenge and biometric authorization. The stored address is a Solana public key only; it does not prove a human, a team, a payment, a certificate, or a particular cluster by itself.

## SOL entry-fee contract

When a SOLANA registration is created, the server freezes a payment-attempt snapshot: Devnet network/genesis, exact positive lamports, registering leader's canonical linked-wallet address, creator destination address, registration ID, and a compact canonical memo derived from that registration. Editing either user wallet later cannot alter that attempt.

The browser first fetches the server's payment projection/instructions, then asks the leader's wallet to sign and submit exactly one native-SOL Devnet transaction. It posts only the resulting base58 signature to the verification endpoint. The server reads the configured Devnet RPC at `finalized` commitment and accepts the attempt only when all of the following match the frozen snapshot:

1. The signature is syntactically valid, unique, successful, and finalized; an unavailable/not-finalized RPC result remains pending rather than paid.
2. The transaction contains exactly one matching System Program native-SOL transfer from the expected payer to the expected destination for the exact lamport amount—never a summed balance delta or rounded SOL display value.
3. It contains exactly one expected PCC entry-fee memo, and its observed block/slot evidence is not earlier than the server-created attempt beyond the documented small clock-skew allowance.
4. The RPC endpoint still reports the configured Devnet genesis hash, and the transaction/version/instruction data is fully readable by the verifier.

The unique chain signature and finalized slot/time are durably recorded in the same transaction that changes the registration to paid. Wrong payer/destination/amount/memo/network, an errored transaction, a duplicate signature, unsupported transaction data, or a stale/missing snapshot creates no paid registration. A recoverable user mistake leaves the registration pending and records a failed attempt; a worker may re-read the same submitted signature but must never substitute a new signature or fabricate proof.

## Blockchain-prize escrow contract

SOLANA entry fees and a blockchain prize pool are separate. Entry fees go directly to the immutable creator snapshot; they never fund the prize PDA.

No pre-existing Anchor contract is sufficient for PCC. Onsite authors create and test a fresh, Devnet-only program with a fresh program ID and this public interface contract:

| State | Authorized action | Required invariant |
| --- | --- | --- |
| `AWAITING_DEPOSIT` | Creator browser initializes/funds deterministic PDA | PDA seed uses a versioned fixed prefix plus the raw 16-byte PCC tournament UUID. It stores the creator public key, operator public key, exact total lamports, rent reserve, and Devnet-only marker. Initial setup needs the creator signature; the operator is a validated stored public key, not a second browser co-signature. |
| `FUNDED` | API verifies creator's submitted funding signature | Finalized successful transaction/program account shows the expected PDA, creator, program ID, exact deposited amount above reserve, and state. |
| `REWARDS_FINALIZED` | Worker operator signs after PCC's immutable off-chain allocation finalizes | Exactly `CHAMPION` and `RUNNER_UP` recipient wallet snapshots are distinct, positive, and add exactly to the deposited lamports. The program stores their exact amounts and allocation digest once. |
| `RELEASED` | Worker operator signs one release | Release requires `REWARDS_FINALIZED`; sends only those stored amounts to those stored recipients and becomes permanently non-repeatable. API records the finalized release signature before any allocation is paid. |
| `CANCELLED` | Creator and worker operator jointly sign before reward finalization | Cancellation is allowed only from `FUNDED`, returns exactly the deposited lamports to the stored creator, and becomes permanently non-repeatable. |

The API creates a short-lived funding intent and returns a browser-signable Devnet transaction only after validating creator role, immutable tournament prize snapshot, and chain configuration. It records `AWAITING_DEPOSIT`; a signature submission is merely a request to verify. Release is an authorized operator-requested worker job, not a timer, an automatic bracket-completion side effect, or an API-held database transaction. All ambiguous send/timeout outcomes are reconciled by reading the expected PDA and signature at finalized commitment before another signature can be made.

Before enabling escrow, the non-secret release record must contain the new program ID, Devnet genesis result, deployment/upgrade-authority public keys, deployment signature/slot, source/IDL and deployed-binary checksums, PDA prefix/version, and a verified state-machine smoke result. A program with an unknown authority, incompatible IDL, mismatched binary/account owner, or any Mainnet/Testnet observation keeps blockchain prizes unavailable.

## Metaplex Core certificate contract

An official PCC certificate is a **Metaplex Core NFT asset**. It is not a legacy Token Metadata mint, even though both are NFTs. PCC calls its identifier a `core_asset_address`, never a mint address. PCC intentionally does not attach official assets to a Core collection: setting a Core asset update authority to `None` permanently makes it immutable but removes collection membership. PCC therefore makes no collection-membership claim.

### Public metadata schema

The server serializes only `pcc-certificate-v1`, using the standard Core JSON fields `name`, `description`, `image`, `category`, `external_url`, `attributes`, and `properties.files`. It derives every value from the approved certificate record and current public profile/team projection; issuers and browsers cannot submit arbitrary JSON, traits, URIs, image data, or a schema version.

| Field or attribute | Required public value | Privacy and integrity rule |
| --- | --- | --- |
| `name`, `description` | Approved certificate title and award description | Server validates the bounded certificate copy; no user-supplied HTML, internal identifiers, or personal-contact details. |
| `image`, `category`, `properties.files` | Approved static certificate image, `image` category and the exact image URI/MIME reference | The worker hashes and public-reads the immutable image before using it. No uploaded recipient photo, match screenshot, QR payload, or mutable object URL is permitted. |
| `external_url` | Public PCC lookup URL for the opaque `lookup_code` | The URL is server-derived from the configured public origin. It is a verifier route, not an authenticated portal or an object-store URL. |
| `attributes` | Fixed allowlist: schema version, issuer `Balangkas PCC`, credential type, public tournament name, award, recipient type, recipient public label, issue timestamp and network `Solana Devnet` | A USER label is the recipient's existing public display name at issuance or `Verified participant` when no public name is available; a TEAM label is the public team name. Never include email, phone, physical/student ID, raw wallet address, UUID, biometric/liveness data, internal team/award context, private match evidence, audit data, or a void reason. |

`core_asset_address`, transaction signatures, database IDs, recipient ownership snapshot and metadata SHA-256 remain in PCC's durable evidence and public lookup projection where appropriate; they are not inserted into the pre-creation JSON. The worker records the complete canonical JSON SHA-256, image SHA-256, provider receipt/reference and a successful independent public read before it signs a Core asset action. The hash is the exact metadata evidence; URI reachability alone is insufficient.

### Issuance, reconciliation and status

The certificate aggregate uses four states. `DRAFT` is private and has no public-verification result. `PENDING_RECONCILIATION` means that a metadata upload or Core submission may have occurred but final chain evidence is incomplete; a lookup by the exact code may show only that neutral status and the instruction that it is **not yet valid**, never recipient/award facts. `ISSUED` is the only valid public credential. `VOIDED` is a public PCC registry status that retains the original evidence but never claims an on-chain burn, transfer, thaw or revocation.

For each issuance, the worker performs this ordered, durable workflow:

1. The API validates issuer role, recipient type, completed award context, certificate draft and a server-calculated certificate-identity digest. `USER` requires the recipient's independently linked wallet snapshot; `TEAM` requires explicit team identity and the configured system-custody address. Only one non-voided certificate with that identity may have an active or issued attempt.
2. It creates one idempotent attempt with a request digest. The worker serializes the reviewed `pcc-certificate-v1` document and approved image to the configured immutable store, retaining URI, both SHA-256 values, provider receipt/reference, public-read result and public-data review. Metadata upload alone is not issuance.
3. Immediately before one creation broadcast, the worker persists the candidate Core asset public address and marks the attempt `SUBMISSION_STARTED`; it retains no asset or operator private bytes. It creates the asset at the exact destination snapshot with an asset-level `PermanentFreezeDelegate` created as `frozen: true` with plugin authority `None`, then sets the asset update authority to `None`. The `None` plugin authority is required: a named permanent-freeze delegate could thaw the asset. Token Metadata, browser-created assets, mutable Core assets, a collection-membership claim, or a transferable asset are not official certificates.
4. If send/finality is ambiguous, a crash occurs, or a signature is unavailable, the record becomes `PENDING_RECONCILIATION`. A worker or authorized operator only re-reads the saved candidate address/signature at finalized Devnet commitment. It never signs a replacement creation while outcome is ambiguous. A finalized matching asset completes one `ISSUED` transition; a definite pre-broadcast/provider rejection is retained as a failed attempt and may start a new attempt with a new candidate only after recording why the earlier candidate cannot exist on-chain.
5. The final read confirms Core standard, candidate address, exact destination snapshot, URI and metadata SHA-256, no update authority, `PermanentFreezeDelegate` with `frozen: true` and authority `None`, no collection, and the creation/immutability signatures at finalized commitment. Only then does the same durable transition mark `ISSUED` and emit the certificate notification.

Repeating the same issue request returns its recorded attempt. It cannot create another asset. A voided certificate remains in the public registry as `VOIDED`; any replacement is an explicit, separately authorized issuance that references the voided certificate and has a new lookup code and identity digest. `POST /certificates/{id}/void` accepts only a controlled reason category plus private operator note. Public output exposes the voided timestamp/status and original chain evidence, not the private note or a fabricated chain-side change.

Public lookup accepts a lookup code or exact Core asset address and builds a Devnet Explorer URL from server-stored identifiers. Recipient disconnects, browser callbacks, or client wallet state do not alter issuance: the worker issues only to the frozen destination snapshot and reconciliation decides the status.

## Failure, logging, and release evidence

No chain timeout or RPC/provider error can fabricate a wallet link, payment, funding, release, or issued certificate. Keep pending state and reconcile the original public identifier. Do not retain raw keypair bytes, signed transaction payloads, browser wallet-provider diagnostics, or certificate metadata containing restricted data in logs. Durable records hold only the necessary public key/signature/slot/URI/hash/status evidence and non-sensitive failure category.

Before turning on any Solana flag onsite, record outside Git: operator and signer custodian, Devnet faucet/source and spending cap, RPC provider/limits/genesis result, wallet-adapter versions, deployed program/IDL/binary evidence where relevant, metadata-store provider/endpoint/account custodian/terms, the exact `pcc-certificate-v1` schema, the pinned `mpl-core`/Umi/uploader package versions, independent metadata-image public reads and hashes, one wallet-link signature check, one deliberate invalid signature rejection, one entry/funding/issuance/release finality read per enabled capability, and the UI routes/states manually checked. Follow the [certificate issuance runbook](runbooks/SOLANA_CERTIFICATE_ISSUANCE.md) for the operator sequence. There is no automatic browser E2E suite, no Devnet-to-Mainnet promotion, and no automatic chain retry that signs a new transaction.

Official references: [Solana Devnet clusters](https://solana.com/docs/references/clusters), [transaction lookup](https://solana.com/docs/rpc/http/gettransaction), [transaction-status finality](https://solana.com/docs/rpc/deprecated/confirmtransaction), [RPC genesis check](https://solana.com/docs/rpc/http/getgenesishash), [Metaplex Core assets](https://www.metaplex.com/docs/smart-contracts/core/what-is-an-asset), [Core JSON schema](https://www.metaplex.com/docs/smart-contracts/core/json-schema), [Core update/immutability](https://www.metaplex.com/docs/smart-contracts/core/update), and [Permanent Freeze Delegate](https://www.metaplex.com/docs/smart-contracts/core/plugins/permanent-freeze-delegate).
