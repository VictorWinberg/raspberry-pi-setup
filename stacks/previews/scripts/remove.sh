#!/usr/bin/env bash
set -euo pipefail

# Usage: remove.sh <app> <pr-number>
ROOT=/opt/stacks/previews
APP=$1
PR=$2
DIR="$ROOT/prs/${APP}-pr-${PR}"
COMPOSE_FILE="$ROOT/$APP/compose.yaml"
PROJECT="preview-${APP}-pr-${PR}"

if [[ ! -d "$DIR" ]]; then
  echo "No preview found for ${APP} pr-${PR}" >&2
  exit 0
fi

export CITY=$(<"$DIR/city")
export IMAGE=""
[[ -f "$DIR/image" ]] && IMAGE=$(<"$DIR/image")

docker compose -f "$COMPOSE_FILE" --project-name "$PROJECT" down --remove-orphans

[[ -n "$IMAGE" ]] && docker image rm "$IMAGE" 2>/dev/null || true

rm -rf "$DIR"

echo "Removed preview ${APP} pr-${PR} (${CITY})"
