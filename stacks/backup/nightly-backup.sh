#!/bin/bash
set -euo pipefail

cd /home/dev/git/raspberry-pi-backup && git pull --rebase origin main
cd /home/dev/git/raspberry-pi-setup && git pull --rebase origin main

docker compose -f /opt/stacks/backup/compose.yaml run --rm pi-backup-sync nightly
