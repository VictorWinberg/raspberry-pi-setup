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
- [Config files](#config-files)
- [Integrations :electric_plug:](#integrations-electric_plug)
- [HACS :books:](#hacs-books)
- [Automations :repeat:](#automations-repeat)
- [Scripts :page_with_curl:](#scripts-page_with_curl)
- [Scenes :clapper:](#scenes-clapper)

Devices :iphone:
=======

| Name | Type | Brand | Model | Room | Integration |
| ---- | ---- | ----- | ----- | ---- | ----------- |
| Balcony Sensor | Sensor | Aqara | Temperature and humidity sensor | Balcony | Zigbee2MQTT |
| Tuya Power Strip | Plug | Tuya | — | Balcony | Tuya Local |
| Water pump | Switch | Nedis | Wifi Water Pump | Balcony | Tuya Local |
| Bali | Media | Google | Google Nest Mini | Bathroom | Google Cast |
| Bedroom Blind L | Blind | IKEA | FYRTUR roller blind, block-out | Bedroom | Zigbee2MQTT |
| Bedroom Ceiling | Light | IKEA | TRADFRI bulb E27 color/white spectrum, 600 lm | Bedroom | Zigbee2MQTT |
| Bedroom Repeater | Repeater | IKEA | TRADFRI signal repeater | Bedroom | Zigbee2MQTT |
| Bedroom Sensor | Sensor | Netatmo | Healthy Home Coach | Bedroom | HomeKit |
| Bed Strip | Plug | Innr | Smart plug | Bedroom | Zigbee2MQTT |
| Philips Hue | Light | Philips | Hue Go with Bluetooth | Bedroom | Zigbee2MQTT |
| Rey | Media | Google | Google Nest Mini | Bedroom | Google Cast |
| Dining Table M | Light | IKEA | TRADFRI bulb E27 warm white, 250 lm | Dining | Zigbee2MQTT |
| Dining Table N | Light | IKEA | TRADFRI bulb E27 warm white, 250 lm | Dining | Zigbee2MQTT |
| Dining Table S | Light | IKEA | TRADFRI bulb E27 warm white, 250 lm | Dining | Zigbee2MQTT |
| Dashboard | Plug | Innr | Smart plug | Hallway | Zigbee2MQTT |
| Hallway Door | Light | IKEA | TRADFRI bulb E27 warm white, 806 lm | Hallway | Zigbee2MQTT |
| Hallway Kitchen | Light | IKEA | TRADFRI bulb E27 warm white, 806 lm | Hallway | Zigbee2MQTT |
| Hallway Spots | Light | IKEA | TRADFRI LED driver, 10 W | Hallway | Zigbee2MQTT |
| Motion Hallway | Sensor | Aqara | Motion sensor P1 | Hallway | Zigbee2MQTT |
| Kasinot | Media | JBL | JBL Link 10 | Kitchen | Google Cast |
| Kitchen Oven | Light | IKEA | TRADFRI bulb E27 warm white, 806 lm | Kitchen | Zigbee2MQTT |
| Kitchen Sink | Light | IKEA | TRADFRI bulb E27 warm white, 806 lm | Kitchen | Zigbee2MQTT |
| Kitchen Table | Light | TP-Link | L510 | Kitchen | TP-Link |
| Motion Kitchen | Sensor | Aqara | Motion sensor P1 | Kitchen | Zigbee2MQTT |
| Led Stip TV | Light | LIFX | LIFX Z | Living Room | LIFX |
| Living Room | Light | Philips | Hue white E27 LED bulb filament giant globe | Living Room | Zigbee2MQTT |
| Living Room Plug | Plug | Innr | Smart plug | Living Room | Zigbee2MQTT |
| Mio Cast | Media | Google | Chromecast | Living Room | Google Cast |
| Mio TV | Media | LG | 55UM7100PLB | Living Room | webOS |
| Rio | Media | Google | Chromecast Audio | Living Room | Google Cast |
| Window Plug | Plug | Innr | Smart plug | Living Room | Zigbee2MQTT |
| Zanzibar | Media | Samsung | HW-Q800C | Living Room | Google Cast |
| Office Sensor | Sensor | Aqara | Temperature and humidity sensor | Office | Zigbee2MQTT |
| Office Switch | Switch | SONOFF | TX1C | Office | Sonoff LAN |
| Mr Phone | Phone | Apple | iPhone16,1 | — | Mobile App |
| Mrs Phone | Phone | Samsung | SM-S921B | — | Mobile App |
| Roborock Q5 Pro | Vacuum | Roborock | roborock.vacuum.a72 | — | Roborock |
| SYMFONISK Sound Remote | Remote | IKEA | SYMFONISK sound remote, gen 2 | — | Zigbee2MQTT |
| TRADFRI Open/Close Remote | Remote | IKEA | TRADFRI open/close remote | — | Zigbee2MQTT |
| TRADFRI Remote Control | Remote | IKEA | TRADFRI remote control | — | Zigbee2MQTT |

*Verified against HA device registry on the Pi, 2026-10-02.*

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
