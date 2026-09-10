# Functional and non-functional requirements

**All modules below are required. Status: specified, unimplemented.** Priority sequences work; it does not drop features.

| Requirement | Required capability | Acceptance |
| --- | --- | --- |
| FR-AUTH | [Authentication and onboarding](features/authentication-onboarding.md) | AC-AUTH-01 through AC-AUTH-05 |
| FR-IDENT | [Identity, career portfolio and wallet](features/identity-portfolio.md) | AC-IDENT-01 through AC-IDENT-05 |
| FR-TEAM | [Teams, rosters and affiliations](features/teams.md) | AC-TEAM-01 through AC-TEAM-05 |
| FR-COMM | [Communities and social activity](features/communities.md) | AC-COMM-01 through AC-COMM-05 |
| FR-TOURN | [Tournament creation, registration and operations](features/tournaments.md) | AC-TOURN-01 through AC-TOURN-05 |
| FR-MATCH | [Brackets, game evidence and organizer review](features/brackets-scoreboard.md) | AC-MATCH-01 through AC-MATCH-05 |
| FR-SCRIM | [Scrimmage board and immediate results](features/scrimmages.md) | AC-SCRIM-01 through AC-SCRIM-05 |
| FR-HISTORY | [Match history and calculated analytics](features/match-history.md) | AC-HISTORY-01 through AC-HISTORY-05 |
| FR-PAY | [Entry fees and prize settlement](features/rewards-entry-fees.md) | AC-PAY-01 through AC-PAY-05 |
| FR-CERT | [Certificate issuance and public lookup](features/certificates.md) | AC-CERT-01 through AC-CERT-05 |
| FR-NOTIFY | [Notifications and activity](features/notifications-activity.md) | AC-NOTIFY-01 through AC-NOTIFY-05 |
| FR-PUBLIC | [Public discovery and information](features/public-discovery.md) | AC-PUBLIC-01 through AC-PUBLIC-05 |

## Non-functional requirements

| ID | Requirement | Acceptance evidence |
| --- | --- | --- |
| NFR-01 | One Azure VPS, private internal services | Compose topology and HTTPS smoke checks. |
| NFR-02 | UI parity with finalized practice frontend | Route-by-route and state-by-state comparison; responsive widths 375, 600, 768, 1024, 1440. |
| NFR-03 | Durable history and audit | Restart/retry and historical-affiliation tests. |
| NFR-04 | No false verification or settlement | Negative biometric/provider and draft certificate tests. |
| NFR-05 | Keyboard and reduced motion support | Focus, Escape, filter reset and fallback scenarios. |
| NFR-06 | Bounded external operations and worker load | Timeouts, one OCR slot and pending/failed UI. |
| NFR-07 | Recovery | Backup restore to separate volumes and image rollback rehearsal. |
| NFR-08 | No secrets or private bytes in public/log output | Permission and log inspection tests. |
| NFR-09 | Traceable feature completion | Every FR maps to screen, contract, data and passing onsite tests. |
| NFR-10 | Performance observation | Record list response, upload and OCR timing on target VPS; report actual values, do not assert unmeasured SLA. |
