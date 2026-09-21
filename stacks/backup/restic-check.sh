#!/bin/bash
set -euo pipefail
docker compose -f /opt/stacks/backup/compose.yaml run --rm pi-backup-restic restic-check
