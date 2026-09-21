#!/bin/bash
set -euo pipefail

COMPOSE=(docker compose -f /opt/stacks/backup/compose.yaml)
SETUP=/home/dev/git/raspberry-pi-setup
BACKUP=/home/dev/git/raspberry-pi-backup
HC_MONTHLY_URL=https://hc-ping.com/adce5fc5-7b6f-4141-a7eb-9c29c9e6cb6c

git_push_if_changed() {
  git -C "$1" add -A
  git -C "$1" diff --staged --quiet || { git -C "$1" commit -m "$2"; git -C "$1" push origin main; }
}

git -C "$BACKUP" pull --rebase origin main
git -C "$SETUP" pull --rebase origin main

"${COMPOSE[@]}" run --rm pi-backup-sync monthly

git_push_if_changed "$SETUP" "Backup Monthly - $(date +%F)"
git_push_if_changed "$BACKUP" "Backup Monthly - $(date +%F)"

curl --fail --silent --show-error --max-time 30 "$HC_MONTHLY_URL"
