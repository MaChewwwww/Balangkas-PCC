# Preparation boundary and transfer policy

## Authorized state

This repository is a specification and infrastructure baseline. No application code, model definitions, database schema files, migrations, seeders, tests, smart contracts, or generated scaffolds may exist before explicit onsite authorization. The only model-artifact exceptions are the user-authorized W600K-R50 ONNX face-embedding file at `models/face-recognition/w600k_r50.onnx`, governed by [the face-model record](FACE_RECOGNITION_MODEL.md), and the RF-DETR MLBB-layout checkpoint at `models/scoreboard/roboflow_weights.pt`, governed by [the MLBB extraction record](MLBB_SCOREBOARD_EXTRACTION.md). They are ignored, manually provisioned runtime inputs with fixed SHA-256 identities, not application source, image-layer inputs, or Git-tracked transfers. The exact `@vladmandic/human` package/lock entry is an allowed dependency record only: do not obtain, copy, bundle or serve its browser-model assets until onsite review records their identity and permitted use. Database design is prose/table documentation, not SQL. Dependency-only images are allowed; application images are not built during preparation.

## Transfer allowlist

| Category | Permitted form | Exclusion |
| --- | --- | --- |
| Documentation | Markdown prose, tables, non-executable diagrams | Copied implementation blocks, stale shipped claims |
| Agent guidance | Markdown rules and SKILL.md entrypoints | Application-generating scripts |
| Infrastructure | Compose YAML, Dockerfiles, Nginx config, env examples | Running application/worker commands in the default stack |
| Dependencies | package.json, pnpm locks, requirements input/locks | Framework source/config scripts and generated clients |
| Brand/reference assets | PNG/JPG, passive SVG, fonts, attribution | Scripts in SVG, code-built graphics copied as components |
| Reference data | Institution/hero JSON and portrait files | Personal records, external database exports, generated fake entities |
| Folder skeleton | Empty .gitkeep files | Placeholder source or executable tests |
| Approved local model artifacts | The ignored W600K-R50 face-embedding ONNX file and RF-DETR MLBB-layout checkpoint, each at its documented target path with its documented SHA-256 | Every other trained weight; Git, image-layer, release-bundle, browser or object-store transfer |

Fresh local infrastructure credentials may exist only in ignored .env. Provider credentials, host addresses, keypairs, chain identifiers, deployed program IDs, asset addresses, metadata URIs and deployment secrets are never inherited from external material. No external Git history or remote is copied.

## Activation

After an explicit onsite instruction, record the instruction and timestamp in DECISIONS.md, change the phase deliberately, and implement from specs. Create fresh migrations only after models and tests are written onsite. Dependency preparation does not prove an integration works. Remote deployment requires its own authorized task and configured target.

## Ad hoc external reference

This repository retains no location, commit, external-path inventory, hash inventory, or implementation extract from an external repository. If a developer needs an unrecorded visual or behavioral nuance onsite, the operator may explicitly supply the relevant material to the working agent for that task. It is evidence only: do not copy code, configuration, identities, credentials, provider outcomes, database history, trained weights, or deployment state into PCC.
