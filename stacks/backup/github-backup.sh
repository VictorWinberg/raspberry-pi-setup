#!/bin/bash
set -euo pipefail

COMPOSE=(docker compose -f /opt/stacks/backup/compose.yaml)
SETUP=/home/dev/git/raspberry-pi-setup
BACKUP=/home/dev/git/raspberry-pi-backup
HC_NIGHTLY_URL=https://hc-ping.com/5143c6ae-4155-4ad8-a8be-2e9771ccac24

git_push_if_changed() {
  git -C "$1" add -A
  git -C "$1" diff --staged --quiet || { git -C "$1" commit -m "$2"; git -C "$1" push origin main; }
}

git -C "$BACKUP" pull --rebase origin main
git -C "$SETUP" pull --rebase origin main
"${COMPOSE[@]}" run --rm pi-backup-sync nightly
git_push_if_changed "$SETUP" "Backup setup $(date +%F)"
git_push_if_changed "$BACKUP" "Backup data $(date +%F)"
curl --fail --silent --show-error --max-time 30 "$HC_NIGHTLY_URL"
