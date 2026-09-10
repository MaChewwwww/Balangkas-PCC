# Hackathon manual UI review report

**Use after onsite development authorization. This is a handoff/report template, not an automated E2E or visual-regression test plan.** Complete one section for every frontend work package that changes a route, shared component, responsive behavior or user interaction. Attach it to the work-package handoff or PR description.

## Report header

| Field | Record |
| --- | --- |
| Work package / commit | Exact identifier and commit under review. |
| Developer and reviewer | Person who checked it; independent reviewer if one was available. |
| Runtime | Local/onsite environment, browser and date/time. |
| Data state | Actual local seeded/created records used; never claim fixture/sample success is live evidence. |
| Automated fast checks | Focused unit, API/integration and/or Vitest component checks actually run, with pass/fail result. Write `not added` where no focused check was appropriate. |

## Route and state review

List each changed route. Add rows rather than compressing multiple unrelated states into one result.

| Route ID and URL | Permission/data state | Action checked | Result | Issue or follow-up |
| --- | --- | --- | --- | --- |
| R-- | Loaded, empty, loading, error, denied, validation, pending or completed state | User-visible action/navigation | Pass / fail / blocked | Concrete defect, reason, or `none` |

Use [route contracts](ROUTE_CONTRACTS.md), [CRUD matrix](CRUD_MATRIX.md) and [visualizations](VISUALIZATIONS.md) to select the route state and action. A claimed `pass` means the reviewer actually observed the server-authorized behavior for that state.

## Layout and interaction review

| Check | Required report detail |
| --- | --- |
| Desktop | State the checked width and whether the required columns, primary/secondary rail ownership, table behavior and action hierarchy matched [LAYOUT](LAYOUT.md). |
| Narrow viewport | State the checked width, normally 375px plus the relevant collapse width; confirm stack order, no page-level horizontal overflow, contained table/dialog scrolling and reachable actions. |
| Keyboard/focus | State the trigger, visible focus, Tab behavior where relevant, Escape close and focus return result. |
| Motion/fallback | When the changed surface has animation/WebGL/carousel behavior, state reduced-motion, pause/offscreen/context-loss fallback result. Otherwise write `not applicable`. |
| Data presentation | State the checked metric/table fields and confirm zero, unavailable, pending and error were not replaced by source sample data. |
| Primitive adoption | When shadcn/Base UI primitive changed, record its locked provider/version, consuming PCC component and observed keyboard/focus result. |

## Result and escalation

Summarize open defects, accepted limitations and who owns the next action. Do not write “fully tested” unless every applicable row above is completed. A known issue may ship only when the user/team explicitly accepts it and the report states the effect.

Automated Playwright/Cypress browser E2E and screenshot/visual-regression suites are intentionally out of scope for this hackathon. Manual reporting does not replace focused unit, API/integration or Vitest checks where those are practical; it replaces the slow browser-automation layer only.
