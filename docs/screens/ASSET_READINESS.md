# Onsite asset readiness

**Audited 2026-09-11.** The repository already contains the approved static visual inputs needed to reconstruct the approved presentation without an external repository. The authoritative PCC target path, size and SHA-256 for every item are in [the approved asset manifest](../ASSET_MANIFEST.md).

## What is already local

| Local category | Count | Target location | Intended use |
| --- | ---: | --- | --- |
| Brand and UI fonts | 3 | `assets/public/fonts` | Balangkas wordmark plus local Manrope and Plus Jakarta Sans variable fonts; no build-time Google-font fetch. |
| Font licenses | 2 | `assets/public/fonts/licenses` | SIL Open Font License copies for Manrope and Plus Jakarta Sans; retain alongside each family. |
| Public/portal visual assets | 7 | `assets/public/images` | Logo, backgrounds, editorial/public surface artwork. |
| Community editorial/preset images | 8 | `assets/public/images/communities` | Approved community visual identity presets and editorial composition. |
| MLBB hero portraits and attribution | 30 | `assets/public/images/mlbb` | Catalog-backed hero display only; preserve attribution. |
| Reference match-evidence images | 3 | `assets/public/images/match-evidence` | Layout/test reference only; never participant evidence. |
| MLBB catalog reference data | 135 | `reference-data/mlbb/heroes/2026-09-09-rone` | Pinned, attributed hero lookup/portrait mapping input for onsite seeding. |
| Institution reference data | 1 | `reference-data/institutions.json` | Canonical institution search/select input. |

There are **51 approved visual target assets**, **136 pinned reference-data files** and two retained font-license files in the manifest. The hash/byte record makes the package reproducible even when no external repository is present or an onsite build has no Google Fonts access.

## Use boundaries

- Serve presentation files from the listed PCC target paths after onsite application work is authorized. Do not import external-repository files or hotlink external paths.
- `reference-data` is approved static source material, not a runtime fixture or identity source. Seed/update it repeat-safely according to the fresh-migration acceptance in [DATABASE](../DATABASE.md). The MLBB catalog contains 133 checksum-pinned portraits; `assets/public/images/mlbb/heroes` currently has a 29-image presentation subset, not a completeness claim.
- Portrait images must resolve through the pinned hero catalog/version; a filename or template candidate is not an assertion of a player’s selected hero or an official stat.
- The three `match-evidence` images exist only to reproduce evidence-region layout and test upload/review flows. They are not user uploads, are not a PCC match record, and must never enter `match_evidence`, an OCR result, an official statistic or a public evidence gallery.
- Community presets and editorial images are visual defaults only. A user-selected custom image must follow the authorized asset upload flow and permission checks.
- Preserve `assets/public/images/mlbb/ATTRIBUTION.md` alongside portrait use. Do not strip attribution when optimizing or relocating assets.
- Load Manrope from `assets/public/fonts/Manrope[wght].ttf` for public surfaces and Plus Jakarta Sans from `assets/public/fonts/PlusJakartaSans[wght].ttf` for portal surfaces. Keep the family licenses beside the files; do not replace these with runtime `next/font/google` downloads.
- The landing `HeroShield` has no standalone `.glb`, `.gltf` or other transferred model asset: it is a documented procedural Three.js scene. Its required static fallback is the approved local `assets/public/images/logo.png`; reconstruct the dynamic scene only from [the HeroShield fidelity contract](COMPONENT_CATALOG.md#heroshield-scene-fidelity).

## Onsite verification procedure

Before frontend work, validate every target file against [ASSET_MANIFEST](../ASSET_MANIFEST.md): target path exists, byte count matches and SHA-256 matches. Treat a missing or mismatched file as a build blocker for the affected visual region; restore it from the approved transfer package rather than substituting a lookalike.

After the application is built, verify at desktop and mobile widths that local assets load without old-repository paths, external image hotlinks, browser console failures or cumulative layout shifts. Verify an unavailable catalog image and a user-upload failure both have purposeful fallback UI; neither may silently become one of the reference images.
