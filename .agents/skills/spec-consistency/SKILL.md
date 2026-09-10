---
name: spec-consistency
description: Audit Balangkas-PCC requirements, data, API, screen, decision, and acceptance documents when changing product specifications or preparing onsite work.
---

# Balangkas-PCC specification consistency

Use for specification changes and pre-onsite audits. Read `docs/PREPARATION.md`, `docs/DECISIONS.md`, the relevant `docs/features/` file, `docs/DATABASE.md`, `docs/API_SPEC.md`, and its screen specification before editing.

Keep one authoritative statement for a rule and cross-link from related documents. Update `docs/TRACEABILITY.md`, acceptance scenarios and readiness when a requirement, screen, field, state, permission, endpoint or decision changes. Do not retain external-repository identifiers or copy implementation files during PREPARATION; the operator may supply reference material ad hoc when needed.

Check that frontend interaction parity has a server-authoritative counterpart, privacy checks derive actor from session, provider status is evidence-based, and plain documentation contains no executable product artifacts. For immediate scrimmage finalization, reject documentation that reintroduces confirmation timers or finalizer jobs.
