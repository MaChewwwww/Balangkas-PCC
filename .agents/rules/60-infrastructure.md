# 60: infrastructure and Azure VPS

Default Compose starts infrastructure only. Inactive onsite application services have intentionally unavailable image defaults. Do not expose database, Redis or MinIO ports on the VPS. Use Nginx for public HTTPS and authenticated application/API/WebSocket routing.

Treat one VPS as a failure domain. Back up before schema change, record image digest, use deployment lock, migrate before workers, verify health after deployment, and distinguish image rollback from database recovery. Do not reuse externally supplied server credentials or paths. See [Docker](../../docs/DOCKER.md) and [DevOps](../../docs/DEVOPS.md).
