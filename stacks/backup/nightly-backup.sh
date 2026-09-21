#!/bin/bash
set -euo pipefail

source /opt/stacks/backup/backup-common.sh

git -C "$BACKUP" pull --rebase origin main
git -C "$SETUP" pull --rebase origin main

"${COMPOSE[@]}" run --rm pi-backup-sync nightly

git_push_if_changed "$SETUP" "Backup Nightly - $(date +%F)"
git_push_if_changed "$BACKUP" "Backup Nightly - $(date +%F)"

hc_ping "$HC_NIGHTLY_URL"
