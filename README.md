# Balangkas-PCC

**Preparation only. No application code is implemented.**

Balangkas connects grassroots and collegiate esports identity, teams, communities, tournaments, reviewed match records and recognition. The finalized practice frontend defines the intended experience. This workspace prepares its specifications and infrastructure for onsite reconstruction.

Start with [agent instructions](AGENTS.md), [documentation index](docs/README.md), [preparation boundary](docs/PREPARATION.md), [readiness](docs/FOUNDATION_STATUS.md), and [onsite work plan](docs/PROJECT_TIMELINE.md).

The deployment target is one Azure VPS hosting Next.js, FastAPI, PostgreSQL/pgvector, Redis, MinIO and background processing behind Nginx. External providers remain external. Local Compose runs infrastructure only; see [Docker setup](docs/DOCKER.md).

Approved assets live in assets/ and reference datasets in reference-data/. Empty application folders are intentionally not runnable. No remote has been created, no server has been changed, and no existing practice implementation is included.
