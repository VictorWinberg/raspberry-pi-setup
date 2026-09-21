#!/bin/bash

set -a
source /opt/stacks/backup/.env
set +a

COMPOSE=(docker compose -f /opt/stacks/backup/compose.yaml)

git_push_if_changed() {
  local repo="$1"
  local message="$2"

  git -C "$repo" add -A

  if ! git -C "$repo" diff --staged --quiet; then
    git -C "$repo" commit -m "$message"
    git -C "$repo" push origin main
  fi
}

hc_ping() {
  curl --fail --silent --show-error --max-time 30 "$1"
}
