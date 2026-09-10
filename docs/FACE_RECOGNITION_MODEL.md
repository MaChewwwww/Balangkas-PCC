# Face-recognition model artifact

**Status: approved local runtime artifact; biometric implementation remains onsite work.**

This is one of two preparation-phase exceptions for trained model weights. It defines one exact file identity so a future developer or staging operator can use face inference without rediscovering or silently replacing the model. The separate RF-DETR scoreboard checkpoint is governed by [MLBB extraction](MLBB_SCOREBOARD_EXTRACTION.md) and is not interchangeable with this artifact.

## Approved identity

| Property | Required value |
| --- | --- |
| Artifact | InsightFace ArcFace W600K-R50 face-embedding ONNX model |
| Transfer classification | Manually provisioned operator artifact; evidence only, never a runtime dependency |
| Repository-local path | `models/face-recognition/w600k_r50.onnx` |
| In-container path | `/models/face-recognition/w600k_r50.onnx` |
| Byte size | 174,383,860 bytes |
| SHA-256 | `4c06341c33c2ca1f86781dab0e829f88ad5b64be9fba56e56bc9ebdefc619e43` |
| Architecture | ResNet-50 ArcFace, WebFace600K-trained |
| Runtime owner | Biometric adapter in the FastAPI service; mounted read-only |
| Input contract | Landmark-aligned or cropped 112 × 112 RGB face, normalized as `(pixel - 127.5) / 127.5` |
| Output contract | L2-normalized `float32[512]` face embedding, subject to consent, liveness and duplicate-check policy |
| Duplicate policy | Cosine similarity of 0.65 or greater is a duplicate-account conflict |

The file is intentionally ignored by Git. Its presence is expected on every developer machine that works on biometric inference and on the staging VPS, but it must not appear in a commit, Docker build context/image layer, frontend bundle, browser response, MinIO/object store, release artifact or source-based fixture.

## InsightFace provenance and permitted use

This is an InsightFace model artifact. The InsightFace source code is MIT-licensed, but InsightFace states that its public pretrained models and their training data are for non-commercial research unless a separate commercial license is granted. The code license therefore does not itself authorize this W600K-R50 weight for every deployment. See InsightFace's [repository license statement](https://github.com/deepinsight/insightface) and [model-license guidance](https://github.com/deepinsight/insightface/blob/master/server/LICENSING.md).

Before a developer enables biometric endpoints on a machine or the staging VPS, an operator must record outside the repository: the official acquisition source/version, the applicable InsightFace model-use entitlement, the intended hackathon use, and the approving owner. A public event or staging label is not by itself a license determination. At the user's direction, the preparation template preselects `PCC_BIOMETRIC_USAGE_APPROVED=true`; that value is not the record and the API returns `INTEGRATION_UNAVAILABLE` whenever the required external evidence is absent. Do not redistribute the model through Git, a container image, a browser response, MinIO, or an arbitrary mirror.

## Manual provisioning and verification

Manually download or retrieve the approved W600K-R50 ONNX artifact, place it at the exact repository-local path above, and calculate its SHA-256 before enabling biometric work. The value must exactly match the approved identity table. Record the date, operator, byte size and successful hash comparison in the machine or VPS operator log outside this repository.

On the staging VPS, provision the file before an authorized release. The inactive application profile maps the host `models` directory to `/models` read-only for the backend. Set `PCC_FACE_MODEL_PATH=/models/face-recognition/w600k_r50.onnx` in the ignored `.env.application` copied from `.env.application.example`; a different mount may use a different path only when it resolves to these exact approved bytes. Operators must not download it dynamically at application start, inject it into an image, or use a public URL. The backend dependency lock includes CPU ONNX Runtime for this exact ONNX artifact. It verifies the SHA-256 and loads the CPU session during controlled service startup, records only a non-secret ready/unavailable metric or operator log, and then reuses that validated session. A model update needs an explicit decision, a new documented filename/version and hash, a compatibility review for stored embeddings, and a staged rollout; replacing these bytes in place is forbidden.

## Required companion controls

W600K-R50 receives an already detected, landmark-aligned face and produces an embedding. The version-pinned frontend `@vladmandic/human` 3.3.6 capture pipeline owns face detection, zero/multiple-face rejection, landmark alignment, crop generation, the server-prompted blink sequence, and its configured liveness/anti-spoof results before upload. The backend accepts only that bounded crop; it does not independently detect faces or count faces.

The exact Human package pin is a preparation dependency record, not permission to copy arbitrary browser models into this repository. The W600K-R50 exception covers only the server embedding artifact. Before the capture UI is enabled onsite, the operator records the locked package version and integrity, every enabled Human browser-model asset's local source/path, immutable digest, license/use review, and selected capture-policy version. Serve that reviewed asset set from the same PCC origin; no public CDN, model-provider call, or runtime download is allowed. The dependency lock must be refreshed and this record revised before the package or enabled asset set changes.

`@vladmandic/human` 3.3.6 is the selected frontend package and is MIT-licensed; the lockfile records its package integrity. Its own type contract exposes blink gestures and liveness/anti-spoof result families, which is why it is the PCC browser-only capture gate. Package licensing does not automatically clear any separately obtained model asset: record the source and rights of each enabled asset before serving it. See the upstream [Human package](https://github.com/vladmandic/human) and its [type contract](https://github.com/vladmandic/human/blob/main/types/human.d.ts).

Human's blink/liveness/anti-spoof output is a client-side hackathon capture gate, not a cryptographic or independently server-verifiable proof of a live person. The server issues a short-lived, one-use liveness challenge bound to the session user, purpose and later submitted crop digest. It validates the challenge scope, expiry, one-use state, crop bounds/digest and the report's expected Human/policy identity, but it cannot prove browser landmark/model output. PCC must present the resulting status as successful biometric capture/enrollment under this hackathon control, never as a high-assurance identity or third-party liveness attestation. A missing reviewed asset, version mismatch, unavailable camera/Human pipeline, failed capture gate, bad challenge or failed W600K-R50 inference must fail closed with no enrollment/authorization write. Do not add another liveness provider or server model merely as an implementation convenience.

## Runtime failure boundary

Future onsite biometric code must validate the configured path and the documented file identity during controlled startup before inference. A missing file, hash mismatch, unreadable mount, invalid model load, absent reviewed Human asset/policy, absent use approval or inference error produces the documented biometric `UNAVAILABLE`/failure outcome. It must not create or update a biometric record, return a successful biometric presentation, issue a biometric authorization, or satisfy wallet/tournament requirements. Raw face bytes and browser reports are discarded after the permitted inference path; only the specified embedding and consent/model/capture-policy audit identities may be retained.

See [preparation boundary](PREPARATION.md), [configuration](CONFIGURATION.md), [security](SECURITY.md), [identity feature](features/identity-portfolio.md), [testing](TESTING.md), and [DevOps](DEVOPS.md).
