#!/bin/sh

set -euo pipefail

if [ -z "${CADDY_EMAIL}" ]; then
    echo "Must set CADDY_EMAIL"
    exit 1
fi
if [ "$1" = 'caddy' ]; then
    /bin/caddy -email="${CADDY_EMAIL}" -agree=true -log=/logs/caddy.log -conf=/caddy/Caddyfile
else
    exec "$@"
fi;
