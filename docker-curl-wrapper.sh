#!/usr/bin/env bash
set -euo pipefail

real_curl="/usr/bin/curl"
connect_timeout="${EARNAPP_CURL_CONNECT_TIMEOUT:-10}"
max_time="${EARNAPP_CURL_MAX_TIME:-60}"

has_connect_timeout=0
has_max_time=0
for arg in "$@"; do
  case "$arg" in
    --connect-timeout|--connect-timeout=*) has_connect_timeout=1 ;;
    --max-time|--max-time=*|-m) has_max_time=1 ;;
  esac
done

extra_args=()
if [[ "$has_connect_timeout" -eq 0 ]]; then
  extra_args+=(--connect-timeout "$connect_timeout")
fi
if [[ "$has_max_time" -eq 0 ]]; then
  extra_args+=(--max-time "$max_time")
fi

exec "$real_curl" "${extra_args[@]}" "$@"
