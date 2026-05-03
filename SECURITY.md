# Security policy

## Supported scope

This repository maintains the Docker build, CI/CD pipeline and documentation for `acoilier/earnapp`.

Security issues in scope:

- unsafe Dockerfile changes
- unexpected installer checksum changes
- GitHub Actions or Docker Hub publishing problems
- secrets accidentally committed to the repository
- container hardening regressions
- documentation that gives users unsafe instructions

Out of scope:

- EarnApp/BrightData service behavior
- EarnApp account, payout or business policy issues
- vulnerabilities in upstream EarnApp binaries that this repository does not modify
- network behavior intentionally implemented by EarnApp

## Reporting a vulnerability

Please open a private security advisory on GitHub if possible:

https://github.com/acoilier/earnapp/security/advisories/new

If that is not available, open a GitHub issue with minimal public details and mark it as security-related. Do not paste secrets, tokens or exploit details into a public issue.

## Upstream installer changes

The EarnApp installer is pinned by SHA256. A changed hash is treated as a security review event.

When the upstream installer changes, the maintainer should:

1. Download the previous and new installer.
2. Compare the diff.
3. Review downloaded URLs, service files, shell commands and telemetry.
4. Build locally.
5. Let CI build and scan the image.
6. Publish a new versioned release only after review.

No silent installer updates.

## Image signing

Published images are signed with Sigstore Cosign using GitHub Actions OIDC. Users can verify that an image was produced by this repository's publish workflow.

Example:

```bash
cosign verify   --certificate-identity-regexp 'https://github.com/acoilier/earnapp/.github/workflows/publish.yml@refs/tags/v.*'   --certificate-oidc-issuer https://token.actions.githubusercontent.com   acoilier/earnapp:v0.1.1
```

## Secrets

Do not commit `.env`, Docker Hub tokens, EarnApp credentials or private notes. The repository `.gitignore` excludes local private files, but you should still check `git diff` before pushing.
