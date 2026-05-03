# Changelog

## v0.1.0

Initial public release.

- Published Docker image `acoilier/earnapp`.
- Added pinned EarnApp installer checksum verification.
- Added GitHub Actions CI for checksum, Compose validation, Docker build and Trivy scan.
- Added Docker Hub publishing workflow.
- Published multi-architecture images for linux/amd64 and linux/arm64.
- Enabled BuildKit SBOM and provenance generation.
- Added daily upstream installer checksum monitoring.
- Added Docker Compose hardening defaults.
- Documented referral-based maintenance support.

Published digest:

```text
docker.io/acoilier/earnapp@sha256:cdd20c7479dc13398920b62a3de55925075a1b5501bd86b20d7118c5f8641c3f
```

Pinned EarnApp installer SHA256:

```text
ff6647905a43245bac71edce3d3a49bab72e0ef5a17c6a42fdebe2c14b37261e
```
