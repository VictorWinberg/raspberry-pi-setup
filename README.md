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

**My complete Raspberry Pi setup** :octocat:

Table of contents :book:
-----------------
1. [Raspberry Pi](#raspberry-pi-strawberry)
1. [Network - Static IP](#network---static-ip-wrench)
1. [Remote Access (SSH)](#remote-access-ssh-wrench)
1. [Remote Access (Nginx)](#remote-access-nginx-wrench)
1. [Let's Encrypt with Certbot](#lets-encrypt-with-certbot-shipit)
1. [Docker](#docker-whale)
1. [Home Assistant](#home-assistant-house)
1. [Conbee II](#conbee-ii-speaking_head)
1. [Postgres](#postgres-elephant)
1. [Node](#node-diamond_shape_with_a_dot_inside)
1. [Git on the Server](#git-on-the-server-octocat)
1. [Crontab](#crontab-clock4)
1. [Recovery](#recovery-recycle)

Raspberry Pi :strawberry:
------------
[Raspberry Pi Documentation](https://www.raspberrypi.org/documentation/)

Parts:
- Raspberry Pi (motherboard)
- Micro-SD
- Charger
- Case (optional)

Network - Static IP :wrench:
-------------------
[TCP/IP Documentation](https://www.raspberrypi.org/documentation/configuration/tcpip/)

You might want to set your RPi to a Static IP (e.g. `192.168.0.100`) if you would like to port forward your RPi online. This could be done by either or both of the following:
- Assign a static IP adress to RPi with a router, using some router settings
- Request a static IP adress for the RPi with DHCPCD

Remote Access (SSH) :wrench:
-------------------
[SSH Documentation](https://www.raspberrypi.org/documentation/remote-access/ssh/)

If you would like to be able to SSH into your RPi you need to enable ssh, since it is disabled by default.

Remote Access (Nginx) :wrench:
---------------------
[Nginx Documentation](https://www.raspberrypi.org/documentation/remote-access/web-server/nginx.md)

**Install Nginx**

`sudo apt install nginx`

**Example Configuration**

[/etc/nginx/sites-available/default](nginx)

Let's Encrypt with Certbot :shipit:
--------------------------
[Let's Encrypt](https://letsencrypt.org/)

**Install Certbot**

[Certbot](https://certbot.eff.org/)

`sudo apt install python-certbot-nginx`

**Update certs**
```
$ sudo certbot --authenticator webroot --installer nginx
Input webroot: /var/www/html
$ sudo nano /etc/nginx/sites-available/default
$ sudo /etc/init.d/nginx reload (start/restart)
```

Docker :whale:
--------------
[Docker](https://www.docker.com/)
- [Portainer](https://www.portainer.io/)


Home Assistant :house:
--------------
[Home Assistant Documentation](https://www.home-assistant.io/)
1. Install [Home Assistant Docker Image](https://www.home-assistant.io/docs/installation/docker/)
2. Install [Home Assistant Community Store (HACS)](https://hacs.xyz/)
3. Configure [HTTP Integration](https://www.home-assistant.io/integrations/http/)
```
# /home/pi/homeassistant/configuration.yaml

http:
  use_x_forwarded_for: true
  trusted_proxies:
    - 127.0.0.1
    - <your external ip>
```

// TODO: Add list of HACS deps, example conf and readme

// Google Calendar

// Smart TV
Example Configuration [/home/pi/homeassistant](homeassistant)

Conbee II :speaking_head:
---------
[Conbee II Documentation](https://phoscon.de/en/conbee2)

Zigbee USB gateway

- [Install Conbee II Docker Image](https://phoscon.de/en/conbee2/install#docker)
- Open Phoscon App and sync Zigbee devices

**Home Assistant**
- Install [deCONZ Integration](https://www.home-assistant.io/integrations/deconz/)

Postgres :elephant:
--------
[Postgres](https://www.postgresql.org/)

- [Install Postgres](https://www.postgresql.org/download/linux/ubuntu/) `sudo apt-get -y install postgresql`
- Create user `sudo -u postgres createuser USERNAME --interactive --pwprompt`
- Create database `sudo -u postgres createdb -O USERNAME DBNAME`
- Drop database `sudo -u postgres dropdb DBNAME`
- PostgreSQL interactive terminal `sudo -u postgres psql` or `psql postgres://USERNAME:PASSWORD@localhost/DBNAME`

Node :diamond_shape_with_a_dot_inside:
----
- [Install NVM](https://github.com/nvm-sh/nvm#installing-and-updating)
- [Install Node](https://github.com/nvm-sh/nvm#usage)
- [Install PM2](https://github.com/Unitech/pm2)

Git on the Server :octocat:
-----------------
[Git on the Server](https://git-scm.com/book/fa/v2/Git-on-the-Server-Setting-Up-the-Server)

```
/home/git
├── repos
│   └── pm-ui.git
└── www
    └── pm-ui
```

Crontab :clock4:
-------
[Scheduling tasks with Cron](https://www.raspberrypi.org/documentation/linux/usage/cron.md)

Recovery :recycle:
--------
- PC/Laptop
- Adapter Micro-SD
- OS Image Tool https://www.raspberrypi.org/downloads/ (use the recommended installer, when writing it was `Raspberry Pi Imager`)

**You're Welcome!** :tada:
