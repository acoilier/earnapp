# Changelog

## v0.1.1

Trust and signing release.

- Added Sigstore Cosign keyless signatures for published images.
- Added `SECURITY.md` with reporting scope and verification guidance.
- Added `SUPPORT.md` for maintenance support.
- Added `CHANGELOG.md`.
- Added an upstream installer review issue template.
- Added public verification instructions to the README.
- Enabled branch protection on `main` with required CI status.

Published digest:

```text
docker.io/acoilier/earnapp@sha256:f6aa57f162c9ce80a0859999aa12b05398935d76d2c74e34ddabd5036a6a823b
```

Cosign verification:

```bash
cosign verify \
  --certificate-identity-regexp 'https://github.com/acoilier/earnapp/.github/workflows/publish.yml@refs/tags/v.*' \
  --certificate-oidc-issuer https://token.actions.githubusercontent.com \
  acoilier/earnapp:v0.1.1
```

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
- Documented support link for maintenance.

Published digest:

```text
docker.io/acoilier/earnapp@sha256:cdd20c7479dc13398920b62a3de55925075a1b5501bd86b20d7118c5f8641c3f
```

Pinned EarnApp installer SHA256:

```text
ff6647905a43245bac71edce3d3a49bab72e0ef5a17c6a42fdebe2c14b37261e
```
