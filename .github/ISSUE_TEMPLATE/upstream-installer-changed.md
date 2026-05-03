---
name: Upstream installer changed
about: Track and review an EarnApp installer checksum change
title: 'EarnApp installer checksum changed'
labels: upstream-change, security-review
assignees: ''
---

## What changed

The pinned EarnApp installer checksum no longer matches the upstream script.

## Checklist

- [ ] Download the previous installer script.
- [ ] Download the new installer script.
- [ ] Compare the diff.
- [ ] Review URLs and downloaded artifacts.
- [ ] Review service files and shell commands.
- [ ] Review telemetry or reporting changes.
- [ ] Build locally.
- [ ] Run CI.
- [ ] Update the pinned SHA256 only after review.
- [ ] Publish a new versioned release.

## Notes

Paste review notes here. Do not paste secrets or private account data.
