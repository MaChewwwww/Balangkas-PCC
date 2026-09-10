# Preparation boundary and transfer policy

## Authorized state

This repository is a specification and infrastructure baseline. No application code, model definitions, database schema files, migrations, seeders, tests, smart contracts, or generated scaffolds may exist before explicit onsite authorization. Database design is prose/table documentation, not SQL. Dependency-only images are allowed; application images are not built during preparation.

## Transfer allowlist

| Category | Permitted form | Exclusion |
| --- | --- | --- |
| Documentation | Markdown prose, tables, non-executable diagrams | Copied implementation blocks, stale shipped claims |
| Agent guidance | Markdown rules and SKILL.md entrypoints | Application-generating scripts |
| Infrastructure | Compose YAML, Dockerfiles, Nginx config, env examples | Running application/worker commands in the default stack |
| Dependencies | package.json, pnpm locks, requirements input/locks | Framework source/config scripts and generated clients |
| Brand/reference assets | PNG/JPG, passive SVG, fonts, attribution | Scripts in SVG, code-built graphics copied as components |
| Reference data | Institution/hero JSON and portrait files | Personal records, practice database exports, generated fake entities |
| Folder skeleton | Empty .gitkeep files | Placeholder source or executable tests |

Fresh local infrastructure credentials may exist only in ignored .env. Provider credentials, host addresses, keypairs, chain identifiers, and deployment secrets are not inherited. The source practice repository remains untouched. No Git history or remote is copied.

## Activation

After an explicit onsite instruction, record the instruction and timestamp in DECISIONS.md, change the phase deliberately, and implement from specs. Create fresh migrations only after models and tests are written onsite. Dependency preparation does not prove an integration works. Remote deployment requires its own authorized task and configured target.

## Source reference

The sibling practice repository is ../Balangkas from the repository root. Source paths in audit tables are repository-relative within that source. They are reference identifiers, not files to recreate verbatim. Source commit is recorded in the transfer inventory. No code is imported at runtime from the practice directory.
