#!/bin/bash
set -euo pipefail

source /opt/stacks/backup/backup-common.sh

"${COMPOSE[@]}" run --rm pi-backup-restic restic-check

hc_ping "$HC_RESTIC_CHECK_URL"
