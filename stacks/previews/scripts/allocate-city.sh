#!/usr/bin/env bash
set -euo pipefail

# Usage: allocate-city.sh <app> <pr-number>
# Prints the preview city (reuses this PR's city or picks a random free one).
ROOT=/opt/stacks/previews
PRS="$ROOT/prs"
APP=$1
PR=$2
DIR="$PRS/${APP}-pr-${PR}"

mkdir -p "$DIR"

if [[ -f "$DIR/city" ]]; then
  cat "$DIR/city"
  exit 0
fi

city_in_use() {
  local city=$1 city_file
  for city_file in "$PRS"/*-pr-*/city; do
    [[ -f "$city_file" && "$(<"$city_file")" == "$city" ]] && return 0
  done
  return 1
}

free_cities=()
while read -r city; do
  [[ -n "$city" ]] || continue
  city_in_use "$city" || free_cities+=("$city")
done < "$ROOT/cities.txt"

if [[ ${#free_cities[@]} -eq 0 ]]; then
  echo "No free preview city" >&2
  exit 1
fi

city=${free_cities[$((RANDOM % ${#free_cities[@]}))]}
echo "$city" > "$DIR/city"
echo "$city"
