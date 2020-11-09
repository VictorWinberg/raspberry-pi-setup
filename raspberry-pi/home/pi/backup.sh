#!/bin/bash
GIT="/home/pi/git/raspberry-pi-setup"
BACKUP="raspberry-pi"
PATHS=(
/etc/nginx/sites-available/default
/home/pi/backup.sh
/home/pi/homeassistant/.storage/lovelace*
/home/pi/homeassistant/automations.yaml
/home/pi/homeassistant/configuration.yaml
/home/pi/homeassistant/custom_components/vicnie/__init__.py
/home/pi/homeassistant/custom_components/vicnie/manifest.json
/home/pi/homeassistant/custom_components/vicnie/services.yaml
/home/pi/homeassistant/groups.yaml
/home/pi/homeassistant/scenes.yaml
/home/pi/homeassistant/scripts.yaml
/home/pi/homeassistant/sensors.yaml
/home/pi/homeassistant/www/*.*
)

cd "$GIT"
git fetch
git reset --hard origin/main
git clean -xfd

find "$BACKUP" -type f ! -name '*.md' -delete
rsync -vr --files-from=<(find "${PATHS[@]}" -type f -not -name ".*") / "$BACKUP"

git add .
git commit -m "Update Server Files - $(date)"
git push
