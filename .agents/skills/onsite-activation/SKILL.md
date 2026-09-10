---
name: onsite-activation
description: Activate the Balangkas-PCC preparation baseline for explicitly authorized onsite hackathon development by revising phase records, agent rules, readiness, and validation expectations. Use only when the active user expressly authorizes application development onsite; it does not authorize deployment or external-provider changes.
---

# PCC onsite activation

Use this skill for the deliberate transition from the documented PREPARATION baseline to onsite application development. Its outcome is an accurate, traceable implementation workspace, not a fictional deployment, configured provider, or finished feature.

## Trigger and boundary

Proceed only when the active user explicitly authorizes application development onsite. A date, event title, request to "get ready," dependency setup, or a request to implement a plan is not enough. If the authorization is ambiguous, ask for the exact confirmation before changing the phase.

Activation authorizes PCC application development in this repository. It does not by itself authorize a remote deployment, Azure provisioning, database destruction or restore, live provider calls, Solana signing, PayMongo transfers, or changes to an external system. Those remain separate, explicit tasks.

## Pre-flight record

Before editing, read `AGENTS.md`, all numbered rules, `docs/PREPARATION.md`, `docs/DECISIONS.md`, `docs/FOUNDATION_STATUS.md`, `docs/TESTING.md`, `docs/TRACEABILITY.md`, and `docs/DEVOPS.md`. Run a read-only inventory:

```bash
git status --short
git branch --show-current
git log --oneline -5
docker compose config
docker compose -f compose.staging.yaml config
docker compose -f compose.tools.yaml config
```

Preserve unrelated changes. Continue on the existing `chore/pcc-preparation-infrastructure` branch; do not create, rename, delete, or switch branches unless the active user explicitly changes that instruction.

Record the authorization verbatim with date, timezone, and active-session source in `docs/DECISIONS.md`. Preserve ADR-001 as the historical preparation decision; add a clearly dated onsite-activation entry rather than rewriting history.

## Required transition sweep

Update each of the following in one coherent documentation change:

| Location | Required update |
| --- | --- |
| `AGENTS.md` | Change the active phase and replace preparation-only prohibitions with onsite implementation gates while retaining safety, branch, and external-change boundaries. |
| `docs/PREPARATION.md` | Preserve the completed preparation record, record activation, and state what is now permitted versus still separately authorized. |
| `docs/README.md` | Remove a current-tense "code-free preparation baseline" claim; retain it as historical context if useful. |
| `docs/FOUNDATION_STATUS.md` | Mark the repository phase as onsite development, but do not mark any feature, integration, or deployment implemented without actual evidence. |
| `docs/TESTING.md` | Make onsite test layers mandatory for new work and preserve preparation checks as baseline evidence. |
| `.agents/rules/00-repository-onboarding.md` | Replace the preparation gate with the onsite read/implement/verify gate. |
| `.agents/rules/20-documentation.md` and `.agents/rules/50-quality.md` | Ensure data/API/screen/acceptance synchronization and onsite test/migration expectations remain explicit. |
| `.agents/skills/` | Reconcile skill descriptions and boundaries with the new phase; retain `staging-maintenance` as separately authorized remote work. |

Update `docs/TRACEABILITY.md`, feature contracts, API/data contracts, screen specifications, and acceptance scenarios only when the activation changes a stated requirement or when a feature is actually implemented. Do not perform cosmetic mass edits or claim all work packages are complete.

## Onsite implementation gates

After the transition sweep, implementation may begin only for an explicitly selected work package. Before writing that package, read its feature specification, screen family, acceptance rows, API contract, data dictionary section, relevant decision/provider guides, and `docs/TRACEABILITY.md`.

For each feature/data change:

1. Implement the server-authoritative behavior; session identity, idempotency, exact money, privacy, and durable state rules remain non-negotiable.
2. Add/update unit, API/integration, and relevant browser/UI coverage in the same change.
3. For schema work, create fresh PCC migrations only after models and tests exist; render migration SQL, upgrade an empty database, and verify repeat-safe seeding.
4. Update affected feature, data, API, screen, acceptance, traceability, testing, readiness, and provider documents with actual evidence, not plans presented as outcomes.
5. Run the checks required by the changed surface and record the real result in the handoff or PR.

No externally supplied implementation, fixture identity, migration history, credential, host value, keypair, trained weight, or fabricated provider success becomes valid merely because onsite development is active. The immediate scrimmage rule remains one authorized participating leader's atomic first result; do not reintroduce a finalizer, timer, or dual-confirmation flow.

## Completion and handoff

The activation is complete only when the phase record, governing rules, readiness language, and test expectations agree; preparation claims are historical rather than current; and no unsupported live/deployed claim was introduced. Report:

- the exact authorization recorded;
- every governance/documentation file changed;
- validation commands and results;
- the first selectable work packages; and
- still-unmet external prerequisites such as VPS identity, secrets, providers, model weights, or remote deployment authorization.

Do not begin a remote release through this skill. Use `staging-maintenance` only after a configured staging target and a separately authorized maintenance/deployment task exist.
