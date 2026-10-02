#!/usr/bin/env bash
set -euo pipefail

# Usage: deploy.sh <app> <pr-number> <image>
ROOT=/opt/stacks/previews
APP=$1
PR=$2
IMAGE=$3
COMPOSE_FILE="$ROOT/$APP/compose.yaml"

[[ -f "$COMPOSE_FILE" ]] || { echo "Missing $COMPOSE_FILE" >&2; exit 1; }

DIR="$ROOT/prs/${APP}-pr-${PR}"
export CITY=$("$ROOT/scripts/allocate-city.sh" "$APP" "$PR") IMAGE
echo "$IMAGE" > "$DIR/image"

docker compose -f "$COMPOSE_FILE" --project-name "preview-${APP}-pr-${PR}" pull
docker compose -f "$COMPOSE_FILE" --project-name "preview-${APP}-pr-${PR}" up -d --remove-orphans

echo "PREVIEW_URL=https://${CITY}.codies.se"
