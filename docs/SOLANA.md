# Solana Devnet specification

PCC has no deployed program, collection, signer or certificate. Practice addresses/keypairs are excluded. Network is Devnet only.

## Escrow

Create tournament-bound deterministic PDA -> deposit exact lamports -> confirm funded -> after verified bracket completion finalize recipient wallets/amounts once -> authorized operator releases -> reconcile transaction and retain signature.

Preserve the audited two-recipient escrow capability: champion and runner-up. Allocation total equals deposited prize; recipients must be distinct and satisfy operator/signer restrictions. Additional physical/e-wallet placements do not imply additional on-chain recipients. Preserve rent reserve and reject repeated release. Author and deploy the program onsite.

## Entry fees

Entry transfer is separate from escrow. Snapshot creator wallet and exact lamports on event/registration. Browser signs to that destination. Backend verifies transaction success, network, amount, destination, payer, registration reference and signature uniqueness. Pending remains pending. Later wallet edits cannot redirect existing registration payment.

## Certificates

Use Metaplex Core. USER recipient receives the asset at that person's independently linked wallet. TEAM uses explicit team identity and final system custody with immutable team/tournament/placement metadata. System custody cannot stand in for a walletless individual. Persist intent before signing, reconcile ambiguous submission, and mark ISSUED only after confirmation. Standard-NFT preview artifacts are not production certificate types.

Mount signer read-only to the authorized worker; record program/version/network; verify the deployed program before use. Never expose signer material to the browser or public API. A timeout requires reconciliation, not fabricated failure/success.

Official references: [transactions](https://solana.com/docs/core/transactions), [PDAs](https://solana.com/docs/core/pda), [Metaplex Core](https://developers.metaplex.com/core). Verify current SDK compatibility before enabling onsite signing.
