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

Table of contents :book:
=======================
- [Raspberry Pi :strawberry:](#raspberry-pi-strawberry)
- [Configuration :wrench:](#configuration-wrench)
   - [Network - Static IP :pushpin:](#network---static-ip-pushpin)
   - [Network - External IP :earth_africa:](#network---external-ip-earth_africa)
   - [External Storage :file_folder:](#external-storage-file_folder)
   - [Remote Access (Samba) :open_file_folder:](#remote-access-samba-open_file_folder)
   - [Remote Access (SSH) :key:](#remote-access-ssh-key)
   - [Remote Access (RDP) :computer:](#remote-access-rdp-computer)
   - [Remote Access (Nginx) :earth_africa:](#remote-access-nginx-earth_africa)
   - [Crontab :clock4:](#crontab-clock4)
   - [Let's Encrypt with Certbot :shipit:](#lets-encrypt-with-certbot-shipit)
- [Services](#services)
   - [Docker :whale:](#docker-whale)
   - [Postgres :elephant:](#postgres-elephant)
   - [Node :diamond_shape_with_a_dot_inside:](#node-diamond_shape_with_a_dot_inside)
- [Applications :computer:](#applications-computer)
   - [Home Assistant :house:](#home-assistant-house)
   - [Conbee II :speaking_head:](#conbee-ii-speaking_head)
   - [Nextcloud :cloud:](#nextcloud-cloud)
- [Git :octocat:](#git-octocat)
   - [Git Server :octocat:](#git-server-octocat)
   - [Git Client :octocat:](#git-client-octocat)
   - [Github Actions :octocat:](#github-actions-octocat)
- [Recovery :recycle:](#recovery-recycle) 

Raspberry Pi :strawberry:
========================
[Raspberry Pi Documentation](https://www.raspberrypi.org/documentation/)

Parts:
- Raspberry Pi (motherboard)
- Micro-SD
- Charger
- Case (optional)

Configuration :wrench:
=====================

Network - Static IP :pushpin:
---------------------------
[TCP/IP Documentation](https://www.raspberrypi.org/documentation/configuration/tcpip/)

You might want to set your RPi to a Static IP (e.g. `192.168.0.100`) if you would like to port forward your RPi online. This could be done by either or both of the following:
- Assign a static IP adress to RPi with a router, using some router settings
- Request a static IP adress for the RPi with DHCPCD

Network - External IP :earth_africa:
------------------------------
```
$ curl https://ipinfo.io/ip
```

External Storage :file_folder:
-----------------------------
[External Storage Documentation](https://www.raspberrypi.org/documentation/configuration/external-storage.md)

- Automatically mount storage devices using `fstab`
```vim
# /etc/fstab
UUID=XXXX-XXXX /mnt/exfat exfat defaults,auto,users,rw,nofail 0 0
```

Remote Access (Samba) :open_file_folder:
---------------------------------------
File and print services using SMB/CIFS protocol.

[Samba Documentation](https://www.raspberrypi.org/documentation/remote-access/samba.md)

- Shared access to mounted storage device
```vim
# /etc/samba/smb.conf
[share]
comment = Shared Exfat
path = /mnt/exfat
browseable = yes
writeable = yes
guest ok = yes
create mask = 0777
directory mask = 0777
```
```cs
$ sudo smbpasswd -a pi
```

Remote Access (SSH) :key:
------------------------
SSH or Secure Shell is a cryptographic network protocol, typical used for remote command-line, login, and remote command execution.

[SSH Documentation](https://www.raspberrypi.org/documentation/remote-access/ssh/)

> If you would like to be able to SSH into your RPi you need to enable ssh, since it is disabled by default.

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

Remote Access (Nginx) :earth_africa:
-----------------------------------
Nginx is a web server that can also be used as a reverse proxy, load balancer, mail proxy and HTTP cache.

[Nginx Documentation](https://www.raspberrypi.org/documentation/remote-access/web-server/nginx.md)

**Install Nginx**

```cs
$ sudo apt install nginx
```

**Nginx Configuration**

`$ sudo nano /etc/nginx/sites-available/default`

```nginx
# APPLICATION_NAME :: PORT - SUBDOMAIN
#
server {
  listen 443;
  server_name SUBDOMAIN.DOMAIN;

  location / {
    proxy_pass http://localhost:PORT;

    # If you have header issues add the following lines
    # proxy_set_header Host $http_host;
    # proxy_set_header X-Forwarded-Proto $scheme;
  }
}
```

`$ sudo /etc/init.d/nginx reload (start/restart)`

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

Crontab :clock4:
-----------------
The editor for the cron jobs (time-based job scheduler).

[Scheduling tasks with Cron](https://www.raspberrypi.org/documentation/linux/usage/cron.md)

Let's Encrypt with Certbot :shipit:
----------------------------------
A free, automated, and open certificate authority brought to you by the nonprofit ISRG.

[Let's Encrypt](https://letsencrypt.org/)

**Install Certbot**

Automatically enable HTTPS on your website with EFF's Certbot, deploying Let's Encrypt certificates.

[Certbot](https://certbot.eff.org/)

```cs
$ sudo apt install python-certbot-nginx
```

**Update certs**
```cs
$ sudo certbot --authenticator webroot --installer nginx
Input webroot: /var/www/html
$ sudo nano /etc/nginx/sites-available/default
$ sudo /etc/init.d/nginx reload (start/restart)
```

Services
========

Docker :whale:
-------------
Docker is an open platform for developing, shipping, and running applications.

[Docker](https://www.docker.com/)
- [Portainer](https://www.portainer.io/) - Portainer simplifies container management in Docker by providing an UI

Postgres :elephant:
------------------
PostgreSQL is a powerful, open source object-relational database system.

[Postgres](https://www.postgresql.org/)

- [Install Postgres](https://www.postgresql.org/download/linux/ubuntu/) `sudo apt-get -y install postgresql`
- Create user `sudo -u postgres createuser USERNAME --interactive --pwprompt`
- Create database `sudo -u postgres createdb -O USERNAME DBNAME`
- Drop database `sudo -u postgres dropdb DBNAME`
- PostgreSQL interactive terminal `sudo -u postgres psql` or `psql postgres://USERNAME:PASSWORD@localhost/DBNAME`
- Allow remote connection
   - Add following to `postgresql.conf`:
      - `listen_addresses = '*'`
   - Add following to `pg_hba.conf`:
      - `host    all             all              0.0.0.0/0              md5`
      - `host    all             all              ::/0                   md5`
   - Restart postgresql `sudo /etc/init.d/postgresql restart`


**Reset Database**

[db-dumps](https://github.com/VictorWinberg/raspberry-pi-backup/tree/main/db-dumps)

`pg_dump --format=c -h 192.168.0.100 -U USERNAME DATABASE | pg_restore --clean --no-owner -h localhost -d DATABASE`

Node :diamond_shape_with_a_dot_inside:
-------------------------------------
Node.js is an open-source, cross-platform, back-end, JavaScript runtime environment that executes JavaScript code outside a web browser.

- [Install NVM](https://github.com/nvm-sh/nvm#installing-and-updating) - Node Version Manager
- [Install Node](https://github.com/nvm-sh/nvm#usage) - JavaScript Engine
- [Install PM2](https://github.com/Unitech/pm2) - Process Manager 2

Applications :computer:
======================

Home Assistant :house:
---------------------
**[My Home Assistant Configuration](homeassistant)**

Open source home automation that puts local control and privacy first. Powered by a worldwide community of tinkerers and DIY enthusiasts. Perfect to run on a Raspberry Pi or a local server.

[Home Assistant](https://www.home-assistant.io/)
1. Install [Home Assistant Docker Image](https://www.home-assistant.io/docs/installation/docker/)
2. Install [Home Assistant Community Store (HACS)](https://hacs.xyz/)
3. Configure [HTTP Integration](https://www.home-assistant.io/integrations/http/)
```yaml
# /home/pi/homeassistant/configuration.yaml

http:
  use_x_forwarded_for: true
  trusted_proxies:
    - 127.0.0.1
    - <your external ip>
```

Conbee II :speaking_head:
------------------------
The universal Zigbee USB gateway unites Zigbee devices of many vendors with a cloud free solution, works with popular Home Automation Systems.

[Conbee II Documentation](https://phoscon.de/en/conbee2)

- [Install Conbee II Docker Image](https://phoscon.de/en/conbee2/install#docker)
- Open Phoscon App and sync Zigbee devices

**Home Assistant Integration**
- Install [deCONZ Integration](https://www.home-assistant.io/integrations/deconz/)

Nextcloud :cloud:
----------------
The self-hosted productivity platform that keeps you in control. Share and collaborate on documents, images and videos. Nextcloud is a suite of client-server software for creating and using file hosting services.

[Nextcloud](https://nextcloud.com/)
- Install [Nextcloud Docker Image](https://github.com/nextcloud/docker/)
- Nextcloud shell `docker exec -it nextcloud_app_1 /bin/bash`
- Update config
```cs
sudo nano /home/pi/.nextcloud-config.php
docker cp /home/pi/.nextcloud-config.php nextcloud_app_1:/var/www/html/config/config.php
docker exec nextcloud_app_1 chown -R www-data:www-data /var/www/html/config
```

**External Storage**
- [Use bind mounts](https://docs.docker.com/storage/bind-mounts/)
- Enable "External storage support" in Apps
- Add External Storage in Settings/Admin

Git :octocat:
============

Git Server :octocat:
-------------------
Convenient for deploying applications to the raspberry pi using git

[Git on the Server](https://git-scm.com/book/fa/v2/Git-on-the-Server-Setting-Up-the-Server)

```cs
/home/git
├── repos
│   └── pm-ui.git
└── www
    └── pm-ui
```

#### Setup bare repo
```sh
$ ssh git@DOMAIN
$ git init --bare repos/{PROJECT}.git
$ mkdir www/{PROJECT}
```

#### Add ssh keys
`$ nano /home/git/.ssh/authorized_keys`

```
ssh-rsa ABC123 user@domain.com
```

#### Add post-receive hook
*Requires: pm2*

`$ cd repos/{PROJECT}.git && nano hooks/post-receive`

```
#!/bin/bash
set -eu # exit script on errors
. $HOME/.nvm/nvm.sh

PROJECT="INSERT_PROJECT_NAME_HERE"
MAIN="INSERT_NODE_SCRIPT_PATH_HERE"
BRANCH="master"

WORK_TREE="/home/git/www/${PROJECT}"
GIT_DIR="/home/git/repos/${PROJECT}.git"

while read oldrev newrev ref
do
  echo "Ref $ref received."

  if [[ $ref = refs/heads/"$BRANCH" ]];
  then
    echo "Deploying ${BRANCH} branch..."

    echo "> git checkout..."
    git --work-tree="$WORK_TREE" --git-dir="$GIT_DIR" checkout -f
    cd "$WORK_TREE"

    echo "> npm install..."
    npm install

    # # If build wasn't done on github uncomment this
    # echo "> npm run build..."
    # npm run build

    # I use pm2 for process management of my Node applications
    echo "> pm2 start server"
    pm2 restart "${PROJECT}" || pm2 start "${MAIN}" --name "${PROJECT}"

    echo "> pm2 save"
    pm2 save

    echo "Deployment ${BRANCH} branch complete."

  else
    echo "No deployment done."
    echo "Only the ${BRANCH} branch may be deployed."
  fi
done
```

**Don't forget to make hook executable**

`$ chmod +x hooks/post-receive`

Git Client :octocat:
-------------------
#### Clone
`$ git clone git@{DOMAIN}:repos/{PROJECT}.git`

#### Add remote
`$ git remote add server git@{DOMAIN}:repos/{PROJECT}.git`

#### Init repo
```sh
$ cd {PROJECT}
# Fetch or create a .gitignore
$ curl -o .gitignore https://raw.githubusercontent.com/github/gitignore/master/Node.gitignore
$ npm init
$ npm install express --save
$ code server/index.js
```
```js
// server/index.js
const express = require('express');
const path = require("path");
const app = express();

const PORT = <<INSERT_PORT_HERE>>;

// Serve static files
app.use(express.static(path.resolve(__dirname, "dist")));

app.get('/api', (req, res) => res.send('API Running!'))

app.listen(PORT, () => console.log(`App running on port ${PORT}!`))
```

Github Actions :octocat:
-----------------------
#### Action
```
name: Build (+Deploy)
on:
  push:
    branches:
      - master
  pull_request:
    branches:
      - master

jobs:
  build:
    name: Test and Build
    runs-on: ubuntu-latest

    strategy:
      matrix:
        node-version: [12.x]

    steps:
      - uses: actions/checkout@v2
      - name: Use Node.js ${{ matrix.node-version }}
        uses: actions/setup-node@v1
        with:
          node-version: ${{ matrix.node-version }}

      - name: Install and cache dependencies
        uses: bahmutov/npm-install@v1

      - name: Build
        run: npm run build

      - name: Test
        run: npm test

      - uses: actions/upload-artifact@v2
        with:
          name: BUILD_FOLDER
          path: BUILD_FOLDER
  deploy:
    needs: build

    name: Deploy to Server
    runs-on: ubuntu-latest
    if: ${{ github.event_name == 'push' }}

    steps:
      - uses: actions/checkout@v2
        with:
          fetch-depth: '0'
          ref: 'master'

      - uses: actions/download-artifact@v2
        with:
          name: BUILD_FOLDER
          path: BUILD_FOLDER

      - name: Install SSH key
        uses: shimataro/ssh-key-action@v2
        with:
          key: ${{ secrets.SSH_PRIVATE_KEY }}
          name: id_rsa # optional
          known_hosts: ${{ secrets.KNOWN_HOSTS }}

      - name: Git Push
        run: |
          git remote add server git@YOUR_DOMAIN:YOUR_GIT_REPO_PATH
          git config --global user.email "actions@github.com"
          git config --global user.name "Github Actions"
          git add build -f
          git commit -m "Build files"
          git push -u server master -f
```

#### Secrets
- `SSH_PRIVATE_KEY`: `-----BEGIN RSA PRIVATE KEY----- ...`
- `KNOWN_HOSTS`: `YOUR_DOMAIN,EXTERNAL_IP sha XXXXXX`

Recovery :recycle:
=================
- PC/Laptop
- Adapter Micro-SD
- OS Image Tool https://www.raspberrypi.org/downloads/ (use the recommended installer, when writing it was `Raspberry Pi Imager`)

> [TOC Generate](https://magnetikonline.github.io/markdown-toc-generate/)

<p align="center">
<b>The End :tada:</b>
</p>
