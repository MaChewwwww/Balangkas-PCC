# Blockchain workspace preparation boundary

This directory holds the pinned Node dependency manifest for onsite Solana work. It intentionally contains no program source, Anchor configuration, generated IDL, build output, deployment artifact, transaction, keypair, collection, Core asset, or executable test during PREPARATION.

After explicit onsite authorization, `programs/` is the approved empty source location for the new PCC Devnet escrow program. Its generated output must not be created or copied before that authorization. The implementation sequence, public state machine, signer separation, Core certificate rules, configuration gates, and release evidence are authoritative in [the Solana Devnet readiness contract](../docs/SOLANA.md).

Secrets are never placed here. The manually provisioned Devnet operator keypair stays in ignored VPS `secrets/` storage, mounted read-only into the worker only as documented in [Docker deployment](../docs/DOCKER.md).
