# 10: architecture

The target is one public origin on one Azure VPS: Nginx routes application paths to Next.js and `/api/`/`/ws/` to FastAPI. PostgreSQL/pgvector, Redis, MinIO and worker stay in the private Compose network. Ports other than Nginx remain private on the VPS.

PostgreSQL is canonical durable state. Redis is transient throttle/cache/pub-sub, not authority. MinIO holds authorized objects; raw biometrics are not retained. Worker side effects begin from durable jobs/outbox records. See [architecture](../../docs/ARCHITECTURE.md), [storage/jobs](../../docs/STORAGE_JOBS.md) and [data](../../docs/DATABASE.md).

There is one connected frontend, not a disconnected showcase. Preserve the approved visual/interaction baseline in [screens](../../docs/screens/README.md). Do not assume the practice frontend's local storage is a server contract.
