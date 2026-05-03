# acoilier/earnapp

[![ci](https://github.com/acoilier/earnapp/actions/workflows/ci.yml/badge.svg)](https://github.com/acoilier/earnapp/actions/workflows/ci.yml)
[![publish](https://github.com/acoilier/earnapp/actions/workflows/publish.yml/badge.svg)](https://github.com/acoilier/earnapp/actions/workflows/publish.yml)

A maintained Docker image for EarnApp, built in the open, with a pinned installer checksum and automated security checks.

This image exists for one simple reason: running random EarnApp containers from Docker Hub is hard to trust. With this repository, you can see exactly how the image is built, which installer is used, which hash is expected, and what happens when upstream changes.

GitHub repository: https://github.com/acoilier/earnapp
Docker image: https://hub.docker.com/r/acoilier/earnapp

## Why use this image?

The goal is not to hide EarnApp behind a black box. The goal is the opposite: make the container as transparent and maintainable as possible.

What this project does:

- downloads the public EarnApp Linux installer from BrightData
- verifies the installer with a pinned SHA256 checksum before it is used
- fails the build if the installer changes unexpectedly
- builds the image through GitHub Actions, not from an unknown local machine
- scans the image with Trivy before publishing
- publishes multi-architecture images for amd64 and arm64
- includes Docker Compose hardening options such as dropped capabilities and `no-new-privileges`
- keeps the source code, CI configuration and Dockerfile public

Current pinned installer:

```text
https://brightdata.com/static/earnapp/install.sh
```

Current SHA256:

```text
ff6647905a43245bac71edce3d3a49bab72e0ef5a17c6a42fdebe2c14b37261e
```

If BrightData changes this script, the automated check fails. The image is not silently updated with unknown code. A review is required first.

## Quick start

Pull the published image:

```bash
docker pull acoilier/earnapp:latest
```

Run with Docker Compose:

```bash
git clone https://github.com/acoilier/earnapp.git
cd earnapp
cp .env.example .env
docker compose up -d
```

Follow logs:

```bash
docker logs -f earnapp
```

Stop the container:

```bash
docker compose down
```

The EarnApp state is stored in a Docker volume mounted at `/etc/earnapp`, so the node state survives container restarts and image updates.

## Tags

Recommended:

```text
acoilier/earnapp:latest
acoilier/earnapp:v0.1.0
```

For fully pinned deployments, use a version tag instead of `latest`.

## Trust model

This image is not an official EarnApp or BrightData image. It is a community-maintained container around the public EarnApp Linux installer.

That matters. You should not trust it because a README says "safe". You should trust it because the important parts are visible:

- the Dockerfile is short and readable
- the installer URL is explicit
- the installer hash is pinned
- the CI checks run publicly on GitHub Actions
- Docker Hub publication is automated from Git tags/releases
- dependency updates are tracked by Dependabot
- upstream installer changes are detected automatically

You can audit the full build path here:

```text
Dockerfile
entrypoint.sh
.github/workflows/ci.yml
.github/workflows/publish.yml
.github/workflows/upstream-check.yml
scripts/check-installer.sh
```

## Security checks

Every normal change runs the `ci` workflow:

- checksum verification of the EarnApp installer
- Docker Compose config validation
- local image build
- Trivy vulnerability scan for HIGH and CRITICAL findings

Publishing runs through the `publish` workflow:

- Docker Hub login through GitHub Secrets
- multi-architecture build for linux/amd64 and linux/arm64
- SBOM and provenance generation through BuildKit
- push to Docker Hub only from an explicit tag, release or manual workflow run

There is also a daily upstream check. If the official installer changes, GitHub opens an issue so the new script can be reviewed before the pinned hash is updated.

## Supporting maintenance through referral

Maintaining this image takes time: checking upstream changes, keeping the Dockerfile clean, reviewing CI failures, updating dependencies and making sure the published image stays usable.

This project may include a maintainer referral code during the EarnApp registration flow when the official flow supports it. If you use this image and leave the referral configuration unchanged, you help support that maintenance work at no extra cost to you.

Please keep the referral code enabled if this image saves you time or gives you confidence. It is a small way to support continued maintenance, security checks and updates.

If you prefer to remove or replace it, the project remains open source. Nothing is hidden. The request is simply: if you benefit from the maintained image, consider leaving the referral in place.

## Configuration

Copy the example environment file:

```bash
cp .env.example .env
```

Available variables:

```text
EARNAPP_UUID=
EARNAPP_REFERRAL_CODE=
EARNAPP_INSTALL_URL=https://brightdata.com/static/earnapp/install.sh
EARNAPP_INSTALL_SHA256=ff6647905a43245bac71edce3d3a49bab72e0ef5a17c6a42fdebe2c14b37261e
```

Notes:

- `EARNAPP_UUID` is optional and can help preserve a known node identity if needed.
- `EARNAPP_REFERRAL_CODE` is intentionally visible. Referral behavior depends on the official EarnApp flow.
- `EARNAPP_INSTALL_URL` and `EARNAPP_INSTALL_SHA256` should only be changed after auditing the installer.

## Docker Compose hardening

The included Compose file uses conservative defaults:

```yaml
cap_drop:
  - ALL
security_opt:
  - no-new-privileges:true
tmpfs:
  - /tmp
  - /run
```

If EarnApp changes its runtime requirements, these settings may need adjustment. The preference here is to start restrictive and loosen only when there is a clear reason.

## Updating the image

Pull the latest image and recreate the container:

```bash
docker compose pull
docker compose up -d
```

Or rebuild locally from source:

```bash
make check
make build
```

## When the installer hash changes

A changed hash is treated as a security event, not as a routine update.

Review process:

1. Download the previous and new installer scripts.
2. Compare the diff.
3. Check URLs, downloaded binaries, service files, telemetry and shell commands.
4. Build and test locally.
5. Update the pinned hash in the repository.
6. Let CI build, scan and publish a new versioned image.

The point is simple: no silent upstream code changes.

## Limitations

No Docker image can make EarnApp risk-free.

Known limits:

- the EarnApp installer can download additional upstream artifacts
- Trivy cannot detect every behavioral or business logic risk
- EarnApp network behavior is controlled by EarnApp/BrightData, not by this repository
- container hardening may need changes if EarnApp changes its Linux runtime assumptions

This repository reduces supply-chain uncertainty around the Docker image. It does not replace your own judgment about whether EarnApp is appropriate for your machine, network or jurisdiction.

## Build locally

```bash
make check
make build
```

Run locally:

```bash
docker compose up -d --build
```

## Repository maintenance

Public files:

```text
Dockerfile
entrypoint.sh
docker-compose.yml
.env.example
scripts/check-installer.sh
.github/workflows/*.yml
```

Private notes are kept out of Git through `.gitignore`. In particular, `docs/private.md` is not meant to be published.

## License

This repository packages and automates the container build. EarnApp itself belongs to its respective owners. This project is not affiliated with or endorsed by EarnApp or BrightData.
