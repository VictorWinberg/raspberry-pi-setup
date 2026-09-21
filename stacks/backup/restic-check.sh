#!/bin/bash
set -euo pipefail

HC_RESTIC_CHECK_URL=https://hc-ping.com/656315fb-675e-45e9-b97f-5b08a34a1db7

docker compose -f /opt/stacks/backup/compose.yaml run --rm pi-backup-restic restic-check

curl --fail --silent --show-error --max-time 30 "$HC_RESTIC_CHECK_URL"
