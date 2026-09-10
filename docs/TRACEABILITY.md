# Traceability matrix

Read together with the self-contained [onsite reconstruction blueprint](screens/ON_SITE_BLUEPRINT.md), [frontend ownership structure](FRONTEND_STRUCTURE.md), [exact route contracts](screens/ROUTE_CONTRACTS.md), [cross-feature breadcrumb context](screens/BREADCRUMB_CONTEXT.md), [CRUD matrix](screens/CRUD_MATRIX.md), [CRUD readiness audit](screens/CRUD_READINESS_AUDIT.md), [visualization semantics](screens/VISUALIZATIONS.md), [component catalogue](screens/COMPONENT_CATALOG.md), [asset readiness](screens/ASSET_READINESS.md), [manual UI report](screens/MANUAL_UI_REPORT.md), [browser/API integration](API_INTEGRATION.md), [backend structure](BACKEND_STRUCTURE.md), [configuration](CONFIGURATION.md), [face-model record](FACE_RECOGNITION_MODEL.md), exact [route map](screens/ROUTES.md) and [frontend acceptance baseline](acceptance/FRONTEND_BASELINE.md).

| Requirement | Feature and contract | Screen family | Data family | Acceptance | Work package |
| --- | --- | --- | --- | --- | --- |
| FR-AUTH | [Authentication and onboarding](features/authentication-onboarding.md) | authentication-onboarding in screen catalogue | AUTH in data dictionary | AC-AUTH-01..07 | WP-AUTH |
| FR-IDENT | [Identity, career portfolio and wallet](features/identity-portfolio.md) | identity-portfolio in screen catalogue | IDENT in data dictionary | AC-IDENT-01..12 | WP-IDENT |
| FR-TEAM | [Teams, rosters and affiliations](features/teams.md) | teams in screen catalogue | TEAM in data dictionary | AC-TEAM-01..06 | WP-TEAM |
| FR-COMM | [Communities and social activity](features/communities.md) | communities in screen catalogue | COMM in data dictionary | AC-COMM-01..05 | WP-COMM |
| FR-TOURN | [Tournament creation, registration and operations](features/tournaments.md) | tournaments in screen catalogue | TOURN in data dictionary | AC-TOURN-01..06 | WP-TOURN |
| FR-MATCH | [Brackets, game evidence and organizer review](features/brackets-scoreboard.md) | brackets-scoreboard in screen catalogue | MATCH in data dictionary | AC-MATCH-01..11 | WP-MATCH |
| FR-SCRIM | [Scrimmage board and immediate results](features/scrimmages.md) | scrimmages in screen catalogue | SCRIM in data dictionary | AC-SCRIM-01..05 | WP-SCRIM |
| FR-HISTORY | [Match history and calculated analytics](features/match-history.md) | match-history in screen catalogue | HISTORY in data dictionary | AC-HISTORY-01..05 | WP-HISTORY |
| FR-PAY | [Entry fees and prize settlement](features/rewards-entry-fees.md) | rewards-entry-fees in screen catalogue | PAY in data dictionary | AC-PAY-01..08 | WP-PAY |
| FR-CERT | [Certificate issuance and public lookup](features/certificates.md) | certificates in screen catalogue | CERT in data dictionary | AC-CERT-01..08 | WP-CERT |
| FR-NOTIFY | [Notifications and activity](features/notifications-activity.md) | notifications-activity in screen catalogue | NOTIFY in data dictionary | AC-NOTIFY-01..05 | WP-NOTIFY |
| FR-PUBLIC | [Public discovery and information](features/public-discovery.md) | public-discovery in screen catalogue | PUBLIC in data dictionary | AC-PUBLIC-01..05 | WP-PUBLIC |
| NFR-02/NFR-08 | [Cross-feature breadcrumb context](screens/BREADCRUMB_CONTEXT.md) and shared [API protocol](API_SPEC.md#shared-protocol) | all context-capable portal details | permission-filtered detail projections only | AC-NAV-01..03 | every affected portal work package |
