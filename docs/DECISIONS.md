# Accepted decisions

| ID | Decision | Reason and effect |
| --- | --- | --- |
| ADR-001 | PREPARATION until explicit onsite unlock | No product code, models, schema scripts or executable tests before onsite. |
| ADR-002 | Every audited feature remains required | Scheduling risk is reported, not resolved by silently deleting scope. |
| ADR-003 | Final frontend is visual and interaction authority | Reconstruct approved layouts and flows onsite without a redesign. |
| ADR-004 | One Next.js client and one Azure VPS | Public and portal share server-owned data and HTTPS origin. No separate hosted showcase. |
| ADR-005 | Immediate scrimmage finalization | User selected one authorized participating leader's valid submission; remove confirmation timers and finalizer service. First committed result wins; conflicting later writes return 409. |
| ADR-006 | Fresh database schema | Practice migrations through revision 0013 document evolution, not a PCC upgrade path. |
| ADR-007 | One authoritative linked wallet per user | Store on users; profile projects it read-only. Duplicate addresses across users remain permitted as in practice wallet-sharing tests; verify each user's linking independently. |
| ADR-008 | Finalized data is server-owned | Client local state only covers draft forms, navigation and display preferences, not identity or official results. |
| ADR-009 | No fabricated biometric/provider success | Missing dependencies return unavailable; OCR remains draft until authorized review; chain/provider actions need evidence. |
| ADR-010 | Plain prose/table contracts | No SQL, Python, TS, Rust, generated OpenAPI or executable test implementations in docs. |
| ADR-011 | Approved non-code assets and reference datasets transfer | Preserve attribution and checksums; no trained weights or private records. |
| ADR-012 | PostgreSQL is durable event authority | Outbox records persist notifications/provider work; Redis carries transient delivery only. |
| ADR-013 | Exact amounts | PHP centavos and SOL lamports are canonical; decimals are formatted strings at UI boundaries. |
| ADR-014 | Public invitation-only tournaments remain discoverable | PRIVATE means registration requires a code, not hidden tournament discovery. |

## Deliberate differences from practice

| Practice observation | PCC target |
| --- | --- |
| Local notifications reset on component remount | Persist recipient read/dismiss state. |
| Models lack community posts and editorial tournament fields | Specify full frontend-supported persistence before coding. |
| Random face fallback and unconditional VERIFIED route | Reject/unavailable with no verified mutation. |
| Some routes accept/generated acting-user IDs | Derive actor from verified session. |
| Profile contains duplicate wallet and aggregate counters | Project authoritative wallet and calculate canonical statistics. |
| Scrimmage backend waits six hours | Immediate atomic finalization, no scheduled finalizer. |
| Local SVG/3D components render brand motion | Preserve static approved images; specify motion for onsite recreation. |

## Unresolved external facts

VPS hostname/capacity and provider entitlements are not yet supplied. They are deployment prerequisites, not reasons to omit specifications. No official event-rule compliance certification is implied. Team/event timing comes from the user's accepted schedule.
