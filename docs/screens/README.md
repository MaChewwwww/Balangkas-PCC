# Screen preservation catalogue

Each exact [route](ROUTES.md) inherits the corresponding family specification below, the shared [layout and data-presentation contract](LAYOUT.md), the [cross-feature breadcrumb-context contract](BREADCRUMB_CONTEXT.md), and the [design contract](../DESIGN.md). [Controls](CONTROLS.md) records actual labels and handler references, [tokens](TOKENS.md) records values, and the [acceptance baseline](../acceptance/FRONTEND_BASELINE.md) records all 123 named source-test expectations. No UI code is copied.

Before reconstructing a screen, begin with the self-contained [onsite reconstruction blueprint](ON_SITE_BLUEPRINT.md), then read its [exact route composition](ROUTE_CONTRACTS.md), family file, layout contract, controls, tokens, [CRUD binding](CRUD_MATRIX.md), [visualization semantics](VISUALIZATIONS.md), [component catalogue](COMPONENT_CATALOG.md), [asset readiness](ASSET_READINESS.md), and relevant feature contract. The layout contract is intentionally explicit about desktop columns, rail ownership, field order, responsive reductions, and contained table scrolling so an implementation agent does not substitute a generic layout.

| Onsite reconstruction package | Purpose |
| --- | --- |
| [ON_SITE_BLUEPRINT](ON_SITE_BLUEPRINT.md) | Read order, boundaries and completion evidence without an external-repository dependency. |
| [ROUTE_CONTRACTS](ROUTE_CONTRACTS.md) | All 41 routes’ ordered assemblies, desktop behavior and states. |
| [BREADCRUMB_CONTEXT](BREADCRUMB_CONTEXT.md) | Valid cross-feature origin propagation, active-sidebar ownership and safe fallback rules. |
| [CRUD_MATRIX](CRUD_MATRIX.md) | Field/API/permission/lifecycle bindings for visible reads and writes. |
| [CRUD readiness audit](CRUD_READINESS_AUDIT.md) | Checksum-verified CRUD route, form, layout and policy-alignment record. |
| [VISUALIZATIONS](VISUALIZATIONS.md) | Metric formulas, table columns/reduction and honest zero/pending/unavailable states. |
| [COMPONENT_CATALOG](COMPONENT_CATALOG.md) | Documentation-only modular custom-component plan for authorized onsite work. |
| [ASSET_READINESS](ASSET_READINESS.md) | Locally available approved assets and non-evidence boundaries. |
| [MANUAL_UI_REPORT](MANUAL_UI_REPORT.md) | Fast manual browser-review handoff template; no automated E2E/visual-regression suite required. |

| Family | Specification |
| --- | --- |
| Authentication and onboarding | [authentication-onboarding](authentication-onboarding.md) |
| Career portfolio and player dossiers | [identity-portfolio](identity-portfolio.md) |
| Teams and current/past affiliations | [teams](teams.md) |
| Community directory and command workspace | [communities](communities.md) |
| Tournament discovery and command center | [tournaments](tournaments.md) |
| Match dossier and game review | [brackets-scoreboard](brackets-scoreboard.md) |
| Scrimmage board and match room | [scrimmages](scrimmages.md) |
| Match and tournament history | [match-history](match-history.md) |
| Rewards and fee checkout | [rewards-entry-fees](rewards-entry-fees.md) |
| Credentials and verification | [certificates](certificates.md) |
| Overview, bell and activity | [notifications-activity](notifications-activity.md) |
| Landing and public discovery | [public-discovery](public-discovery.md) |
