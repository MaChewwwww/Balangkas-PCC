# Solana Devnet certificate issuance runbook

**Use only after explicit onsite authorization to implement application features and an authorized staging release.** This is an operator checklist, not application implementation. It creates no signer, account, asset, upload, or transaction during PREPARATION.

The authoritative product contract is [Solana readiness](../SOLANA.md). This runbook applies only to a Metaplex Core NFT certificate on Solana Devnet. It never authorizes Testnet/Mainnet, legacy Token Metadata minting, a collection, a browser-issued asset, a transferable credential, a named freeze delegate, or a chain-side revocation.

## Before enabling certificates

1. Confirm the release is the authorized `staging` release and leave every Solana feature flag false until all checks below pass.
2. Record outside Git the release commit/image digests, current Devnet RPC owner/limits/health/genesis result, Devnet faucet/source and spending cap, wallet-adapter version, worker signer custodian and derived public key. Confirm that only the worker has the read-only signer mount.
3. Record the exact dependency versions from the committed blockchain lock: `@metaplex-foundation/mpl-core` 1.10.0, `@metaplex-foundation/umi` 1.5.1, `@metaplex-foundation/umi-bundle-defaults` 1.5.1, and `@metaplex-foundation/umi-uploader-irys` 1.5.0. Recheck them if the lock intentionally changes.
4. Record the selected metadata-store provider identifier, HTTPS endpoint, account custodian, rights/retention terms and its Devnet compatibility. Verify the provider can return an immutable public JSON document and static PNG/JPEG image without authentication.
5. Confirm `SOLANA_CERTIFICATE_METADATA_SCHEMA_VERSION=pcc-certificate-v1`. Review the fixed field allowlist and a rendered public preview: title/description, image, public lookup URL, fixed attributes, no restricted data. Confirm the recipient public label comes from the existing public profile/team projection, not free text.
6. Check a health/genesis/finalized-read capability against the configured RPC. Verify the worker signer is funded only from the recorded Devnet source within the spending cap. Do not put private bytes, a provider token, or an RPC credential in Git, image layers, logs or the API/frontend environment.
7. Enable `PCC_SOLANA_ENABLED` and `PCC_SOLANA_CERTIFICATES_ENABLED` only after the preceding record exists. Keep entry-fee and escrow flags independently false unless those capabilities also pass their own gates.

## Issuing one certificate

1. An authorized issuer creates a draft from completed award context. Confirm the certificate-identity digest has no active/issued duplicate and freeze the destination wallet/system-custody snapshot.
2. Review the server-derived public metadata and approved static image. Reject any private name/contact/identifier, wallet address, private evidence, biometric/audit field, arbitrary URI or arbitrary attribute.
3. Store the JSON and image with the selected provider. Record both canonical SHA-256 values, provider receipt/reference and an independent public read. A successful upload is still not an issued certificate.
4. Start the one idempotent issuance attempt. Persist the attempt/request digest and candidate Core asset public address before broadcast. Never persist raw asset private bytes.
5. The worker creates the Core asset at the frozen destination with the exact reviewed URI. It creates an asset-level `PermanentFreezeDelegate` as `frozen: true` and authority `None`, then sets asset update authority to `None`. Do not attach a collection, use a named freeze authority, add a transfer delegate, or create a Token Metadata asset.
6. Re-read at finalized Devnet commitment. Confirm the Core NFT standard, candidate address, exact owner, URI and metadata hash, image hash, no collection, no update authority, `PermanentFreezeDelegate(frozen: true, authority: None)`, and the recorded creation/immutability signatures.
7. Only after every check succeeds, atomically mark the record `ISSUED`, write audit/outbox evidence, emit the notification and enable the public verification view. Record the non-secret finalized evidence in the release/operator log.

## Reconciliation and voiding

| Situation | Required action |
| --- | --- |
| Metadata/image upload succeeds; no asset creation started | Keep the certificate draft/attempt. Retain the reviewed hash and provider receipt; retry only with the recorded logical request. The upload is never public proof. |
| Worker/API crashes, RPC times out, or no signature is returned after creation starts | Move to `PENDING_RECONCILIATION`. Read only the saved candidate Core address and any saved signature on configured Devnet at finalized commitment. Do not sign a new asset or regenerate a candidate while outcome is unknown. |
| Finalized candidate matches every required invariant | Complete the same one `ISSUED` transition; never issue a second asset for the same certificate identity. |
| Provider proves broadcast never occurred and the candidate cannot exist on-chain | Mark the attempt `FAILED_PRE_SUBMISSION` with a non-sensitive category. A new attempt may be explicitly authorized, retains the prior audit record, and uses a new candidate only after that proof. |
| Recipient disconnects | Take no browser-driven action. The frozen destination snapshot and finalized worker verification remain authoritative. |
| Issued credential must be withdrawn from PCC recognition | Authorized issuer uses the registry void action with controlled category and private note. Mark `VOIDED`, retain original evidence and publish only neutral voided status/timestamp. Never claim a burn, transfer, thaw or on-chain revocation. A replacement requires separately authorized issuance with a new lookup code and reference to the voided record. |

## Release evidence and shutdown

For each enabled certificate path, retain the non-secret configuration/compatibility record, one successful finality evidence record, one deliberate invariant-rejection result, metadata/image public-read hashes, manual UI report for draft/pending/issued/voided views, and the reconciliation outcome if exercised. Keep no private key bytes, signed payloads, raw provider diagnostics or restricted metadata in those records.

When the hackathon staging deployment is no longer authorized, set the certificate and umbrella Solana flags false through the authorized maintenance process. Do not delete public Devnet evidence, rewrite registry history, or reuse the signer/keypair/program/asset identity in another environment.
