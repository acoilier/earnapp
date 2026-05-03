#!/usr/bin/env bash
set -euo pipefail

log() { printf '[earnapp-safe] %s
' "$*"; }

if [[ "${1:-}" == "install" ]]; then
  exec earnapp-install -y
fi

if [[ "${1:-}" != "run" ]]; then
  exec "$@"
fi

mkdir -p /etc/earnapp /var/log/earnapp

if ! command -v earnapp >/dev/null 2>&1; then
  log "EarnApp binary not found; running checksum-pinned official installer."
  earnapp-install -y
fi

if [[ -n "${EARNAPP_UUID:-}" && ! -s /etc/earnapp/uuid ]]; then
  log "Writing provided EARNAPP_UUID to persistent state."
  printf '%s' "$EARNAPP_UUID" > /etc/earnapp/uuid
  chmod 0600 /etc/earnapp/uuid || true
fi

if command -v service >/dev/null 2>&1; then
  service earnapp start || true
  service earnapp_upgrader start || true
fi

if command -v earnapp >/dev/null 2>&1; then
  log "Starting EarnApp foreground monitor."
  while true; do
    if ! pgrep -x earnapp >/dev/null 2>&1; then
      earnapp start >/dev/null 2>&1 || true
    fi
    sleep 60
  done
fi

log "EarnApp did not install correctly; keeping container alive for inspection."
sleep infinity
