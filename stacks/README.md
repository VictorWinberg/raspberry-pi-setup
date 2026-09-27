# Stacks backup

This directory mirrors `/opt/stacks` on the Pi. It is a **backup**, not the live source of truth.

Edit compose files on the Pi (or via Dockge), then sync here via the nightly [`sync-setup.sh`](https://github.com/VictorWinberg/raspberry-pi-backup/blob/main/crons/sync-setup.sh) cron in [raspberry-pi-backup](https://github.com/VictorWinberg/raspberry-pi-backup). What gets synced is defined in [`backup/manifest.yaml`](backup/manifest.yaml).

## Stack inventory

| Category | Stacks |
| -------- | ------ |
| Infrastructure | `traefik`, `dockge`, `dozzle`, `postgres`, `pgweb` |
| Home automation | `homeassistant`, `zigbee2mqtt`, `mosquitto`, `music-assistant` |
| Media | `immich` |
| Web apps (GHCR) | `codies`, `onelist`, `onemenu`, `wishlist`, `jsonvault`, `qr-hunt`, `fitness24seven` |
| Ops | `backup`, `health` |
