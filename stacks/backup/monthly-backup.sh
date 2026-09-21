#!/bin/bash
set -euo pipefail

source /opt/stacks/backup/backup-common.sh

git -C "$BACKUP" pull --rebase origin main
git -C "$SETUP" pull --rebase origin main

"${COMPOSE[@]}" run --rm pi-backup-sync monthly

git_push_if_changed "$SETUP" "Backup Monthly - $(date +%F)"
git_push_if_changed "$BACKUP" "Backup Monthly - $(date +%F)"

hc_ping "$HC_MONTHLY_URL"
