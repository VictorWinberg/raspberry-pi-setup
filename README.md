<pre align="center">
          __  __          _____      _                        
         |  \/  |        / ____|    | |                       
  _____  | \  / |_   _  | (___   ___| |_ _   _ _ __    _____  
 |_____| | |\/| | | | |  \___ \ / _ \ __| | | | '_ \  |_____| 
         | |  | | |_| |  ____) |  __/ |_| |_| | |_) |         
  _____  |_|  |_|\__, | |_____/ \___|\__|\__,_| .__/ _____ _  
 |  __ \          __/ || |                    | |   |  __ (_) 
 | |__) |__ _ ___|___/ | |__   ___ _ __ _ __ _|_|_  | |__) |  
 |  _  // _` / __| '_ \| '_ \ / _ \ '__| '__| | | | |  ___/ | 
 | | \ \ (_| \__ \ |_) | |_) |  __/ |  | |  | |_| | | |   | | 
 |_|  \_\__,_|___/ .__/|_.__/ \___|_|  |_|   \__, | |_|   |_| 
                 | |                          __/ |           
                 |_|                         |___/            
</pre>
<p align="center">
<b>My complete Raspberry Pi setup</b> :octocat:
</p>

This repo is a **versioned backup** of the live Pi. `/opt/stacks` on the Pi is the source of truth; Compose files are synced here nightly via [`sync-setup.sh`](https://github.com/VictorWinberg/raspberry-pi-backup/blob/main/crons/sync-setup.sh) in [raspberry-pi-backup](https://github.com/VictorWinberg/raspberry-pi-backup).

| Path | What |
| ---- | ---- |
| [`stacks/`](stacks/) | Mirror of `/opt/stacks` |
| [`data/homeassistant/`](data/homeassistant/) | Home Assistant config backup (live: `/srv/data/homeassistant`) |
| [`data/zigbee2mqtt/`](data/zigbee2mqtt/) | Zigbee2MQTT config backup (live: `/srv/data/zigbee2mqtt`) |

Nightly sync and restore workflow: [raspberry-pi-backup/crons](https://github.com/VictorWinberg/raspberry-pi-backup/tree/main/crons).

Table of contents :book:
=======================
- [Raspberry Pi :strawberry:](#raspberry-pi-strawberry)
   - [Raspberry Pi OS :cd:](#raspberry-pi-os-cd)
- [Configuration :wrench:](#configuration-wrench)
   - [Network - Static IP :pushpin:](#network---static-ip-pushpin)
   - [Network - External IP :earth_africa:](#network---external-ip-earth_africa)
   - [External Storage :file_folder:](#external-storage-file_folder)
   - [Remote Access (Samba) :open_file_folder:](#remote-access-samba-open-file_folder)
   - [Remote Access (SSH) :key:](#remote-access-ssh-key)
   - [Remote Access (RDP) :computer:](#remote-access-rdp-computer)
   - [Remote Access (Traefik) :earth_africa:](#remote-access-traefik-earth_africa)
   - [Crontab :clock4:](#crontab-clock4)
- [Services](#services)
   - [Docker :whale:](#docker-whale)
   - [Postgres :elephant:](#postgres-elephant)
   - [Node apps (GHCR) :diamond_shape_with_a_dot_inside:](#node-apps-ghcr-diamond_shape_with_a_dot_inside)
   - [Backup :floppy_disk:](#backup-floppy_disk)
   - [Healthchecks :heartbeat:](#healthchecks-heartbeat)
- [Applications :computer:](#applications-computer)
   - [Home Assistant :house:](#home-assistant-house)
   - [Zigbee2MQTT + Mosquitto :speaking_head:](#zigbee2mqtt--mosquitto-speaking_head)
   - [Music Assistant :notes:](#music-assistant-notes)
   - [Immich :camera:](#immich-camera)
- [Layout :file_folder:](#layout-file_folder)
- [Git :octocat:](#git-octocat)
- [Recovery :recycle:](#recovery-recycle)

Raspberry Pi :strawberry:
========================
[Raspberry Pi Documentation](https://www.raspberrypi.org/documentation/)

Parts:
- Raspberry Pi 4 (8 GB)
- USB SSD (boot drive)
- External USB HDD → `/mnt/storage`
- Zigbee USB coordinator (ConBee II / Sonoff / CC2652)
- Charger / case (optional)
- Domain `codies.se` with DNS pointing to the public IP

Raspberry Pi OS :cd:
-----------------------------
[Raspberry Pi Imager](https://www.raspberrypi.com/software/)

Flash **Raspberry Pi OS Lite (64-bit)** to the USB SSD. Create user `dev`, enable SSH in the imager advanced options.

Configuration :wrench:
=====================

Network - Static IP :pushpin:
---------------------------
[TCP/IP Documentation](https://www.raspberrypi.org/documentation/configuration/tcpip/)

Set a static LAN IP (e.g. `192.168.0.100`) so port forwarding to Traefik stays stable:
- Assign a static IP on the router, and/or
- Request a static IP with DHCPCD / NetworkManager on the Pi

Router should forward ports **80** and **443** to the Pi.

Network - External IP :earth_africa:
------------------------------
```
$ curl https://ipinfo.io/ip
```

External Storage :file_folder:
-----------------------------
[External Storage Documentation](https://www.raspberrypi.org/documentation/configuration/external-storage.md)

External HDD mounted at `/mnt/storage` (ext4) for Immich media and Restic backups.

- [Automatically mount storage devices using `fstab`](https://www.raspberrypi.com/documentation/computers/configuration.html#setting-up-automatic-mounting)
```vim
# /etc/fstab
UUID=XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX /mnt/storage ext4 defaults,nofail 0 2
```

```
/mnt/storage/
├── media/      # Immich uploads
└── backups/    # Restic repo
```

Remote Access (Samba) :open_file_folder:
---------------------------------------
File and print services using SMB/CIFS protocol.

[Samba Documentation](https://www.raspberrypi.org/documentation/remote-access/samba.md)

- Shared access to mounted storage device
```vim
# /etc/samba/smb.conf
[share]
comment = Shared storage
path = /mnt/storage
browseable = yes
writeable = yes
guest ok = yes
create mask = 0777
directory mask = 0777
```
```cs
$ sudo smbpasswd -a dev
```

Remote Access (SSH) :key:
------------------------
SSH or Secure Shell is a cryptographic network protocol, typical used for remote command-line, login, and remote command execution.

[SSH Documentation](https://www.raspberrypi.org/documentation/remote-access/ssh/)

> **Fix Raspberry Pi SSH freezing issue**
>
> Solution 1: Open `/etc/ssh/sshd_config`, add `ClientAliveInterval=60` and `ClientAliveCountMax=3` and run `sudo service sshd restart`.
> Solution 2: Open `/etc/ssh/sshd_config`, add `IPQoS cs0 cs0` or `IPQoS 0x00` at the bottom and run `sudo service sshd restart`.

Remote Access (RDP) :computer:
-----------------------------
Remote Desktop Protocol is a proprietary protocol which provides a user with a graphical interface to connect to another computer over a network connection.

[Remote Desktop Setup](https://pimylifeup.com/raspberry-pi-remote-desktop/)

**Install Xrdp**
```cs
$ sudo apt-get install xrdp
```

**Connect to raspberry pi**

Use a RDP or a VNC software, and enter your raspberry pi's local IP address.

Remote Access (Traefik) :earth_africa:
-----------------------------------
[Traefik](https://traefik.io/) is the reverse proxy for all public HTTPS services. It terminates TLS with **Let's Encrypt** (ACME HTTP challenge) — no Certbot or nginx.

Live stack: [`stacks/traefik/`](stacks/traefik/)

- Listens on ports `80` / `443` (dashboard on LAN `:9000`)
- Docker provider + file provider (`dynamic/` for host-network services like Home Assistant and Music Assistant)
- Apps expose themselves with Traefik labels on the shared `proxy` network

### DNS setup
| Host      | Type | TTL   | Target      |
| --------- | ---- | ----- | ----------- |
|           | A    | 86400 | {SERVER_IP} |
| www       | A    | 86400 | {SERVER_IP} |
| {PROJECT} | A    | 86400 | {SERVER_IP} |
| ...

##### Alt with wildcard domain name support
| Host      | Type | TTL   | Target      |
| --------- | ---- | ----- | ----------- |
|           | A    | 86400 | {SERVER_IP} |
| *         | A    | 86400 | {SERVER_IP} |

### Subdomain map (`codies.se`)

| Service | Host |
| ------- | ---- |
| Home / www | `codies.se`, `www.codies.se` |
| Home Assistant | `home.codies.se` |
| Music Assistant | `music.codies.se` |
| OneList | `shop.codies.se` |
| OneMenu | `menu.codies.se` |
| jsonvault | `json.codies.se` |
| wishlist | `wish.codies.se` |
| qr-hunt | `qr.codies.se` |
| Immich | `photos.codies.se` |
| Dozzle | `docker.codies.se` |
| Dockge | LAN only `:5001` |
| pgweb | LAN only `:5050` |
| Traefik dashboard | LAN only `:9000` |

Crontab :clock4:
-----------------
The editor for the cron jobs (time-based job scheduler).

[Scheduling tasks with Cron](https://www.raspberrypi.org/documentation/linux/usage/cron.md)

Nightly dumps + stack sync live in [raspberry-pi-backup/crons](https://github.com/VictorWinberg/raspberry-pi-backup/tree/main/crons) (`backup.sh` → `db-dumps.sh` → `sync-setup.sh` → `sync-backup.sh`). Healthchecks.io pings run every few minutes from [`stacks/health/healthchecks/`](stacks/health/healthchecks/).

Services
========

Docker :whale:
-------------
Docker is an open platform for developing, shipping, and running applications.

[Docker](https://www.docker.com/)
- [Dockge](https://github.com/louislam/dockge) — stack manager UI for `/opt/stacks` (LAN `:5001`), see [`stacks/dockge/`](stacks/dockge/)
- [Dozzle](https://dozzle.dev/) — Docker log viewer at `docker.codies.se`, see [`stacks/dozzle/`](stacks/dozzle/)

Create the shared Traefik network once:

```bash
docker network create proxy
```

Postgres :elephant:
------------------
PostgreSQL is a powerful, open source object-relational database system.

[Postgres](https://www.postgresql.org/)

Shared app database runs as **Postgres 16 in Docker** ([`stacks/postgres/`](stacks/postgres/)), data at `/srv/data/postgres`. Immich uses its **own** Postgres instance.

[pgweb](https://github.com/sosedoff/pgweb) provides a LAN Postgres UI at `:5050` ([`stacks/pgweb/`](stacks/pgweb/)); connection settings live in `.env` on the Pi.

**Reset / restore a database**

[db-dumps](https://github.com/VictorWinberg/raspberry-pi-backup/tree/main/db-dumps)

```bash
# From a dump in raspberry-pi-backup
docker exec -i postgres psql -U vicnie DATABASE < /path/to/DATABASE.sql
```

**PG CLI**

[pgcli](https://www.pgcli.com/install) is a command line interface for Postgres with auto-completion and syntax highlighting.

Node apps (GHCR) :diamond_shape_with_a_dot_inside:
-------------------------------------
Node apps run as Docker containers pulling images from [GitHub Container Registry](https://github.com/features/packages) — not git-push + PM2.

| App | Image | Stack | Public host |
| --- | ----- | ----- | ----------- |
| codies (www) | `ghcr.io/victorwinberg/home` | [`stacks/codies/`](stacks/codies/) | `codies.se` |
| OneList | `ghcr.io/victorwinberg/onelist` | [`stacks/onelist/`](stacks/onelist/) | `shop.codies.se` |
| OneMenu | `ghcr.io/annieleonia/onemenu` | [`stacks/onemenu/`](stacks/onemenu/) | `menu.codies.se` |
| wishlist | `ghcr.io/annieleonia/wishlist` | [`stacks/wishlist/`](stacks/wishlist/) | `wish.codies.se` |
| jsonvault | `ghcr.io/victorwinberg/jsonvault` | [`stacks/jsonvault/`](stacks/jsonvault/) | `json.codies.se` |
| qr-hunt | `ghcr.io/victorwinberg/qr-hunt` | [`stacks/qr-hunt/`](stacks/qr-hunt/) | `qr.codies.se` |
| fitness24seven | `ghcr.io/victorwinberg/fitness24seven` | [`stacks/fitness24seven/`](stacks/fitness24seven/) | none (internal scraper) |

Update an app:

```bash
cd /opt/stacks/<app>
docker compose pull
docker compose up -d
```

`.env` files stay on the Pi (excluded from git sync).

Backup :floppy_disk:
-------------------
[`stacks/backup/`](stacks/backup/) runs two containers from `ghcr.io/victorwinberg/pi-backup-sync`:

- **pi-backup-sync** — syncs selected paths into the git clones under `/home/dev/git/`
- **pi-backup-restic** — Restic backups to `/mnt/storage/backups/restic`

What gets synced or backed up is defined in [`stacks/backup/manifest.yaml`](stacks/backup/manifest.yaml).

Healthchecks :heartbeat:
-----------------------
Shell scripts in [`stacks/health/healthchecks/`](stacks/health/healthchecks/) ping [Healthchecks.io](https://healthchecks.io/) on a short cron interval:

- `hc-website.sh` — public site
- `hc-home-assistant.sh` — Home Assistant
- `hc-hard-drive.sh` — storage
- `hc-external.sh` — external checks

Applications :computer:
======================

Home Assistant :house:
---------------------
**[My Home Assistant Configuration](data/homeassistant)**

Open source home automation that puts local control and privacy first. Powered by a worldwide community of tinkerers and DIY enthusiasts. Perfect to run on a Raspberry Pi or a local server.

[Home Assistant](https://www.home-assistant.io/)
1. Stack: [`stacks/homeassistant/`](stacks/homeassistant/) — config at `/srv/data/homeassistant`
2. Install [Home Assistant Community Store (HACS)](https://hacs.xyz/)
3. Configure [HTTP Integration](https://www.home-assistant.io/integrations/http/) for Traefik
```yaml
# /srv/data/homeassistant/configuration.yaml

http:
  use_x_forwarded_for: true
  trusted_proxies:
    - 127.0.0.1
    - ::1
    - <your external ip>
```

Home Assistant uses `network_mode: host`; Traefik routes `home.codies.se` via [`stacks/traefik/dynamic/homeassistant.yaml`](stacks/traefik/dynamic/homeassistant.yaml).

Zigbee2MQTT + Mosquitto :speaking_head:
--------------------------------------
Zigbee devices are bridged with [Zigbee2MQTT](https://www.zigbee2mqtt.io/) (replacing deCONZ / Phoscon) over MQTT.

- Mosquitto: [`stacks/mosquitto/`](stacks/mosquitto/) — broker on host network, auth via `passwordfile` (not in git)
- Zigbee2MQTT: [`stacks/zigbee2mqtt/`](stacks/zigbee2mqtt/) — ConBee II USB device bind-mounted; config under `/srv/data/zigbee2mqtt` (backed up → [`data/zigbee2mqtt/`](data/zigbee2mqtt/))

**Home Assistant Integration**
- MQTT integration pointing at the Mosquitto broker

Music Assistant :notes:
----------------------
[Music Assistant](https://music-assistant.io/) server for multi-room audio.

- Stack: [`stacks/music-assistant/`](stacks/music-assistant/) — data at `/srv/data/music-assistant`
- Uses `network_mode: host`
- Public host: `music.codies.se` via Traefik ([`stacks/traefik/dynamic/music-assistant.yaml`](stacks/traefik/dynamic/music-assistant.yaml))

Immich :camera:
----------------
Self-hosted photo and video backup ([Immich](https://immich.app/)) — replaces Nextcloud for media.

- Stack: [`stacks/immich/`](stacks/immich/)
- Uploads on external HDD: `/mnt/storage/media`
- Public host: `photos.codies.se` (Traefik labels)
- Uses Immich's own Postgres + Valkey (not the shared app Postgres)

On a Pi 4, disable or avoid heavy machine-learning features if the box is under load.

Layout :file_folder:
===================

```
/
├── opt/stacks/          # Compose source of truth (backed up → stacks/)
├── srv/data/            # Persistent app data (partially backed up → data/)
├── mnt/storage/         # External HDD (media + backups)
└── home/dev/
    └── git/             # Clones of this repo + raspberry-pi-backup
```

Edit stacks on the Pi (or via Dockge), then sync — do not treat this git repo as the live deploy source.

Git :octocat:
============

This repo and [raspberry-pi-backup](https://github.com/VictorWinberg/raspberry-pi-backup) are **backups**, not a git deploy server.

- App images: built in GitHub Actions → pushed to GHCR → pulled on the Pi with `docker compose pull`
- Stacks: rsync `/opt/stacks` → `stacks/` (excludes `.env`, `passwordfile`, `credentials.json`, `secrets.yaml`)
- DB dumps + crons: see raspberry-pi-backup

Legacy bare repos under `/home/git` and PM2 `post-receive` hooks were removed.

Recovery :recycle:
=================
- PC/Laptop
- USB SSD / adapter
- [Raspberry Pi Imager](https://www.raspberrypi.com/software/)
- Restore stacks from this repo + SQL dumps from [raspberry-pi-backup](https://github.com/VictorWinberg/raspberry-pi-backup); Restic repo at `/mnt/storage/backups/restic`

> [TOC Generate](https://magnetikonline.github.io/markdown-toc-generate/)

<p align="center">
<b>The End :tada:</b>
</p>
