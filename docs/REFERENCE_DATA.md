# Reference-data preparation

[institutions.json](../reference-data/institutions.json) is the approved institution reference list. School selection is reference lookup, not proof of enrollment. Validate normalized uniqueness when writing the onsite seeder; preserve canonical names and stable IDs.

The versioned catalog under reference-data/mlbb/heroes/ retains heroes.json, manifest.json, portraits and source attribution. Hero IDs are strings scoped by catalog version. Resolve catalog portrait paths against the bundle, not the old backend directory. Preserve the declared manifest checksum scope. Brand/public hero images live separately under assets/public/images/.

No seeder, trained model, import script, database export or fake player/team dataset is transferred. Create reference tables and seed them onsite. Repeat execution must preserve row IDs and counts. See [asset provenance](ASSET_MANIFEST.md).
