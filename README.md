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
   - [External Storage :file_folder:](#external-storage-file_folder)
   - [Remote Access (Samba) :open_file_folder:](#remote-access-samba-open_file_folder)
   - [Remote Access (SSH) :key:](#remote-access-ssh-key)
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
- [Extras :heavy_plus_sign:](#extras-heavy_plus_sign)
   - [Git on the Server :octocat:](#git-on-the-server-octocat)
- [Recovery :recycle:](#recovery-recycle)

To Do :notebook_with_decorative_cover:
-------------------------------------
- [ ] Home Assistant
  - [ ] HACS Dependencies
  - [ ] README.md
  - [ ] Google Calendar
  - [ ] Custom component Vicnie
- [ ] Git on the Server
  - [ ] Git hooks
  - [ ] Github sync actions
- [ ] Swap file 

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

Remote Access (Nginx) :earth_africa:
-----------------------------------
Nginx is a web server that can also be used as a reverse proxy, load balancer, mail proxy and HTTP cache.

[Nginx Documentation](https://www.raspberrypi.org/documentation/remote-access/web-server/nginx.md)

**Install Nginx**

```cs
$ sudo apt install nginx
```

**My Nginx Configuration**

[/etc/nginx/sites-available/default](/raspberry-pi/etc/nginx/sites-available/default)

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

**My Home Assistant Configuration**

[/home/pi/homeassistant](/raspberry-pi/home/pi/homeassistant)

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

Extras :heavy_plus_sign:
=======================

Git on the Server :octocat:
--------------------------
Convenient for deploying applications to the raspberry pi using git

[Git on the Server](https://git-scm.com/book/fa/v2/Git-on-the-Server-Setting-Up-the-Server)

```cs
/home/git
├── repos
│   └── pm-ui.git
└── www
    └── pm-ui
```

Recovery :recycle:
=================
- PC/Laptop
- Adapter Micro-SD
- OS Image Tool https://www.raspberrypi.org/downloads/ (use the recommended installer, when writing it was `Raspberry Pi Imager`)

> [TOC Generate](https://magnetikonline.github.io/markdown-toc-generate/)

<p align="center">
<b>The End :tada:</b>
</p>
