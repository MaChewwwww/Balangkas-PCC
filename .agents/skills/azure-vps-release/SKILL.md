---
name: azure-vps-release
description: Prepare or perform an authorized Balangkas-PCC single-Azure-VPS release with immutable images, migration ordering, verification, backup, and rollback awareness.
---

# Balangkas-PCC Azure VPS release

Use after application code exists and an authorized deployment task names the PCC target. Read `docs/DEVOPS.md`, `docs/DOCKER.md`, `docs/FOUNDATION_STATUS.md`, relevant migration/provider documents and `.env.deployment.example` before selecting commands.

Never infer a host, SSH key, domain, secret, image tag or prior database state from the practice repository. Validate the target explicitly. Back up durable state, use the deployment lock, record immutable image digests, migrate before workers, and verify HTTPS/application/API/worker health afterward. Do not edit source or commit directly on the server. Stop for explicit direction before destructive volume/database actions or production recovery cutover.

During PREPARATION, use this skill only to review configuration and run local Compose validation. It does not authorize remote provisioning or deployment.
