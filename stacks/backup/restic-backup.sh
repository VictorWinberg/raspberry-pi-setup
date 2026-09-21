#!/bin/bash
set -euo pipefail

HC_RESTIC_URL=https://hc-ping.com/1609a9e3-9186-4bb8-af57-19d978e837a5

docker compose -f /opt/stacks/backup/compose.yaml run --rm pi-backup-restic

curl --fail --silent --show-error --max-time 30 "$HC_RESTIC_URL"
