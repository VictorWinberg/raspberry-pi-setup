<pre align="center">
  _    _                                         _     _              _
 | |  | |                          /\           (_)   | |            | |
 | |__| | ___  _ __ ___   ___     /  \   ___ ___ _ ___| |_ __ _ _ __ | |_
 |  __  |/ _ \| '_ ` _ \ / _ \   / /\ \ / __/ __| / __| __/ _` | '_ \| __|
 | |  | | (_) | | | | | |  __/  / ____ \\__ \__ \ \__ \ || (_| | | | | |_
 |_|  |_|\___/|_| |_| |_|\___| /_/    \_\___/___/_|___/\__\__,_|_| |_|\__|
      / ____|           / _(_)                     | | (_)
     | |     ___  _ __ | |_ _  __ _ _   _ _ __ __ _| |_ _  ___  _ __
     | |    / _ \| '_ \|  _| |/ _` | | | | '__/ _` | __| |/ _ \| '_ \
     | |___| (_) | | | | | | | (_| | |_| | | | (_| | |_| | (_) | | | |
      \_____\___/|_| |_|_| |_|\__, |\__,_|_|  \__,_|\__|_|\___/|_| |_|
                               __/ |
                              |___/
</pre>
<p align="center">
<b>My Home Assistant Configuration</b> :house:
</p>

Table of contents :book:
=======================

- [Table of contents :book:](#table-of-contents-book)
- [Devices :iphone:](#devices-iphone)
  - [Lights](#lights)
  - [Switches](#switches)
  - [Media](#media)
  - [Sensors](#sensors)
  - [Vacuum](#vacuum)
  - [Helpers & presence](#helpers--presence)
- [Config files](#config-files)
- [Integrations :electric_plug:](#integrations-electric_plug)
- [HACS :books:](#hacs-books)
- [Automations :repeat:](#automations-repeat)
- [Scripts :page_with_curl:](#scripts-page_with_curl)
- [Scenes :clapper:](#scenes-clapper)

Devices :iphone:
=======

### Lights

#### IKEA

- Trådfri LED bulb E27 600 lumen dimmable color
- Trådfri LED bulb E27 806 lumen dimmable white (x4)
- Trådfri LED bulb E27 250 lumen dimmable white (x3)
- Omlopp LED spot (x3) + Trådfri driver

#### Philips

- Philips Hue
- Philips Lightstrip
- Hue white E27 LED bulb filament giant globe

#### LIFX

- LIFX Z - Lightstrip

#### TP-Link

- Tapo L510

### Switches

#### IKEA

- FYRTUR roller blind + Trådfri open/close switch
- Trådfri Remote Control
- Symfonisk Controller
- Trådfri Signal Repeater

#### INNR

- SP 120 (x4)

#### Sonoff

- Sonoff T1 - Smart Wall Light Switch

#### Nedis

- Nedis Wifi Water Pump

### Media

#### Google Cast

- JBL Link 10
- Chromecast
- Chromecast Audio
- Google Nest Mini (x2)

#### LG

- LG Smart TV

#### Samsung

- Samsung HW-Q800C Soundbar

### Sensors

#### Netatmo

- Netatmo Smart Indoor Air Quality Monitor

#### Aqara

- Aqara Temperature/Humidity Sensor (x2)
- Aqara Motion sensor P1 (x2)

#### Mobile App

- Mr Phone
- Ms Phone

### Vacuum

#### Roborock

- Roborock Q5 Pro

### Helpers & presence

Used by current automations (entities live on the Pi / in `.storage`):

- `binary_sensor.someone_home` — household presence
- `binary_sensor.motion_detected` — kitchen / hallway motion
- `input_number.light_brightness` — shared brightness slider
- `input_boolean.guest_mode` — guest mode (auto-reset at 04:00)
- `switch.dashboard` — dashboard display power

Config files
============

Synced YAML in this repo (see [manifest.yaml](../../stacks/backup/manifest.yaml)):

| File | What |
| ---- | ---- |
| [`configuration.yaml`](configuration.yaml) | Core config (Google Assistant + TTS; service account excluded from git) |
| [`automations.yaml`](automations.yaml) | Automations |
| [`scripts.yaml`](scripts.yaml) | Scripts |
| [`scenes.yaml`](scenes.yaml) | Scenes |
| [`templates.yaml`](templates.yaml) | Template sensors (weather forecasts) |
| [`blueprints/`](blueprints/) | Blueprints (`motion_light`, `notify_leaving_zone`, `confirmable_notification`, `inverted_binary_sensor`) |

Integrations :electric_plug:
============

Configured on the Pi (verified 2026-09-27).

### Media & entertainment

- Google Cast
- LG webOS TV
- Spotify
- Music Assistant
- Android TV Remote (Mio Cast)

### Lights, switches & Zigbee

- LIFX
- Sonoff LAN
- TP-Link (Tapo L510)
- ZHA (ConBee II)
- MQTT (Zigbee2MQTT)

### Vacuum

- Roborock

### Presence & mobile

- Mobile App (Mr Mobile, Mrs Mobile)

### Calendar & voice

- Google Calendar
- Google Assistant
- Google Translate (TTS)

### HomeKit

- HomeKit Controller (Healthy Home Coach, TV)

### Custom (HACS / local)

- HACS
- [Life Events](https://github.com/victorwinberg/rpi-setup/tree/main/homeassistant/custom_components/life_event)

### Built-in

- Met (weather)
- Sun

HACS :books:
====

**Frontend** (verified against `lovelace_resources` on the Pi, 2026-09-27)

- [apexcharts-card](https://github.com/RomRider/apexcharts-card)
- [Bubble-Card](https://github.com/Clooos/Bubble-Card)
- [button-card](https://github.com/custom-cards/button-card)
- [calendar-card-pro](https://github.com/alexpfau/calendar-card-pro)
- [card-mod](https://github.com/thomasloven/lovelace-card-mod)
- [config-template-card](https://github.com/iantrich/config-template-card)
- [ha-floorplan](https://github.com/ExperienceLovelace/ha-floorplan)
- [kiosk-mode](https://github.com/NemesisRE/kiosk-mode)
- [lovelace-auto-entities](https://github.com/thomasloven/lovelace-auto-entities)
- [mini-media-player](https://github.com/kalkih/mini-media-player)
- [mushroom](https://github.com/piitaya/lovelace-mushroom)
- [simple-swipe-card](https://github.com/nutteloost/simple-swipe-card)
- [slider-entity-row](https://github.com/thomasloven/lovelace-slider-entity-row)
- [vertical-stack-in-card](https://github.com/ofekashery/vertical-stack-in-card)
- [weather-chart-card](https://github.com/mlamberts78/weather-chart-card)
- `www/fonts/ds-digital.css` (local CSS resource)

Automations :repeat:
===========

[Code](automations.yaml)

- Brightness Slider - Set Value
- Light On - Set Brightness
- Home Presence - Power On/Off
- Dashboard - Turn On/Off
- Guest Mode - Reset
- Light Brightness - Set Value
- Motion Detected - Kitchen & Hallway Lights

Scripts :page_with_curl:
=======

[Code](scripts.yaml)

- Power On
- Power Off

Scenes :clapper:
======

[Code](scenes.yaml)

- TV Night
- Good Night
- Good Morning

> [TOC Generate](https://magnetikonline.github.io/markdown-toc-generate/)

<p align="center">
<b>The End :tada:</b>
</p>
