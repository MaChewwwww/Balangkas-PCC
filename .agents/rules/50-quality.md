# 50: quality and validation

Every onsite feature change requires updated unit/integration coverage and relevant browser/UI scenarios. Every data change requires migration rendering, empty database upgrade and seed verification. Mock providers in CI; never send payments or sign live transactions in ordinary tests.

Immediate scrimmage result behavior is fixed: one authorized participating leader finalizes atomically; identical retry returns same result; conflicting later input returns 409. No timer/worker/dual-confirmation fallback may be reintroduced without an explicit decision update. Follow [testing](../../docs/TESTING.md).
