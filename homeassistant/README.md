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
- [HACS :books:](#hacs-books)
- [Automations :repeat:](#automations-repeat)
- [Scripts :page_with_curl:](#scripts-page_with_curl)
- [Custom Components :computer:](#custom-components-computer)
	- [Vicnie](#vicnie)

Devices :iphone:
=======

### Lights

#### IKEA
- Trådfri LED bulb E27 600 lumen dimmable color
- Trådfri LED bulb E27 806 lumen dimmable white (x5)
- Omlopp LED spot (x3) + Trådfri driver

#### Philips
- Philips Hue
- Philips Lightstrip

#### LIFX
- LIFX Z - Lightstrip

### Switches

#### IKEA
- FYRTUR roller blind (x2) + Trådfri open/close switch (x2)
- Trådfri Remote Control
- Symfonisk Controller

#### INNR
- SP 120 (x2)

#### Sonoff
- Sonoff T1 - Smart Wall Light Switch

#### Nedis
- Nedis Wifi Water Pump

### Media

#### Google Cast
- JBL Link 10
- Chromecast
- Chromecast Audio

#### LG
- LG Smart TV

### Sensors

#### Netatmo
- Netatmo Smart Indoor Air Quality Monitor 

#### Aqara
- Aqara Temperature/Humidity Sensor (x2)

#### Mobile App
- Mr Phone
- Ms Phone

HACS :books:
====
**Frontend** [Code](.storage/lovelace_resources)
- [card-mod](https://github.com/thomasloven/lovelace-card-mod)
- [mini-media-player](https://github.com/kalkih/mini-media-player)
- [fold-entity-row](https://github.com/thomasloven/lovelace-fold-entity-row)
- [slider-entity-row](https://github.com/thomasloven/lovelace-slider-entity-row)
- [multiple-entity-row](https://github.com/benct/lovelace-multiple-entity-row)
- [button-card](https://github.com/custom-cards/button-card)
- [roku-card](https://github.com/iantrich/roku-card)
- [weather-card](https://github.com/bramkragten/weather-card)
- [kiosk-mode](https://github.com/maykar/kiosk-mode)
- [swipe-navigation](https://github.com/maykar/Lovelace-Swipe-Navigation)
- [mini-graph-card](https://github.com/kalkih/mini-graph-card)
- [vertical-stack-in-card](https://github.com/ofekashery/vertical-stack-in-card)
- [atomic_calendar (modified)](https://github.com/AnnieLeonia/atomic_calendar) [atomic_calendar (original)](https://github.com/atomic7777/atomic_calendar)

**Integrations**
- [Spotcast - Start Spotify on chromecast](https://github.com/fondberg/spotcast)
- [Sonoff LAN - Control Sonoff devices](https://github.com/AlexxIT/SonoffLAN)
- [Avanza Stock](https://github.com/custom-components/sensor.avanza_stock)

Automations :repeat:
===========
[Code](automations.yaml)
- Alarm Clock - Wake me up with lights
- Arrive Home - Turn on lights
- Leave Home - Turn off lights
- Goodnight - Turn off lights
- Brightness Slider - Set light brightness
- Evening - Dim lights
- Sunset - Balcony Lights
- Certificate Expiration - Notification
- Sunrise - Watering Plants

Scripts :page_with_curl:
=======
[Code](scripts.yaml)
- Start Video with Lights
- Power on
- Power off
- Goodnight
- Toggle Power on/off
- Toggle Play/Pause
- Play Spotify

Custom Components :computer:
=================
[Code](custom_components)

Vicnie
------
[Code](custom_components/vicnie/__init__.py)

**Remote Control Service** - Making my IKEA Trådfri remotes ''smart'' and able to control lights, speakers, tv, blinds, power on/off.

**Tetzipetzi Service** - Playing the latest youtube video from tetzipetzi's channel.

> [TOC Generate](https://magnetikonline.github.io/markdown-toc-generate/)

<p align="center">
<b>The End :tada:</b>
</p>
