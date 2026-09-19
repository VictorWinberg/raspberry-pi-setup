# raspberry-pi-setup

Versioned backup of the Raspberry Pi homelab Docker stacks and Home Assistant config.

**`/opt/stacks` on the Pi is the source of truth.** This repo is synced nightly via `sync-setup.sh` in [raspberry-pi-backup](https://github.com/VictorWinberg/raspberry-pi-backup).

## Contents

| Path | What |
| ---- | ---- |
| [`stacks/`](stacks/) | Mirror of `/opt/stacks` (Compose files, Traefik config, Mosquitto config) |
| [`homeassistant/`](homeassistant/) | Home Assistant config backup (live path: `/srv/data/homeassistant`) |

## Related repos

- **rpi-setup** — step-by-step rebuild guides; start at `setup/README.md`
- **[raspberry-pi-backup](https://github.com/VictorWinberg/raspberry-pi-backup)** — crons and Postgres SQL dumps

## Notes

Legacy git-push / PM2 deploy hooks were removed. Apps deploy via GHCR images and Docker Compose (see `rpi-setup/setup/09-node-apps.md`).
