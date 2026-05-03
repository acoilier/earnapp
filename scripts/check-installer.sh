#!/usr/bin/env bash
set -euo pipefail

URL="${EARNAPP_INSTALL_URL:-https://brightdata.com/static/earnapp/install.sh}"
EXPECTED="${EARNAPP_INSTALL_SHA256:-ff6647905a43245bac71edce3d3a49bab72e0ef5a17c6a42fdebe2c14b37261e}"

tmp="$(mktemp)"
trap 'rm -f "$tmp"' EXIT
curl -fsSL "$URL" -o "$tmp"
actual="$(sha256sum "$tmp" | awk '{print $1}')"
bytes="$(wc -c < "$tmp")"

printf 'URL: %s
Bytes: %s
Expected: %s
Actual:   %s
' "$URL" "$bytes" "$EXPECTED" "$actual"

if [[ "$actual" != "$EXPECTED" ]]; then
  printf 'ERROR: EarnApp installer checksum changed. Audit the new script before updating the pinned hash.
' >&2
  exit 1
fi
