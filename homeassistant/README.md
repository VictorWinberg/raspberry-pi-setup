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
  - [Google Cast](#google-cast)
  - [Mobile App](#mobile-app)
  - [IKEA](#ikea)
  - [Philips](#philips)
  - [INNR](#innr)
  - [LIFX](#lifx)
  - [LG](#lg)
  - [Sonoff](#sonoff)
- [HACS :books:](#hacs-books)
- [Automations :repeat:](#automations-repeat)
- [Scripts :page_with_curl:](#scripts-page_with_curl)
- [Custom Components :computer:](#custom-components-computer)
  - [Vicnie](#vicnie)

Devices :iphone:
=======

### Google Cast
- JBL Link 10
- Chromecast
- Chromecast Audio

### Mobile App
- Mr Phone
- Ms Phone

### IKEA
- Trådfri LED bulb E27 600 lumen dimmable color
- Trådfri LED bulb E27 806 lumen dimmable white (x5)
- Omlopp LED spot (x3) + Trådfri driver
- FYRTUR roller blind (x2) + Trådfri open/close switch (x2)
- Trådfri Remote Control
- Symfonisk Controller

### Philips
- Philips Hue
- Philips Lightstrip

### INNR
- SP 120 (x2)

### LIFX
- LIFX Z - Lightstrip

### LG
- LG Smart TV

### Sonoff
- Sonoff T1 - Smart Wall Light Switch

HACS :books:
====
**Frontend** [Code](homeassistant/.storage/lovelace_resources)
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
- [atomic_calendar (modified)](https://github.com/AnnieLeonia/atomic_calendar) [atomic_calendar (original)](https://github.com/atomic7777/atomic_calendar)

**Integrations**
- [Spotcast - Start Spotify on chromecast](https://github.com/fondberg/spotcast)
- [Sonoff LAN - Control Sonoff devices](https://github.com/AlexxIT/SonoffLAN)

Automations :repeat:
===========
[Code](homeassistant/automations.yaml)
- Alarm Clock - Wake me up with lights
- Arrive Home - Turn on lights
- Leave Home - Turn off lights
- Goodnight - Turn off lights
- Evening - Dim lights
- Sunset - Balcony Lights

Scripts :page_with_curl:
=======
[Code](homeassistant/scripts.yaml)
- Start Video with Lights
- Power off
- Power on
- Goodnight
- Toggle Power on/off
- Toggle Play/Pause
- Play Spotify

Custom Components :computer:
=================
[Code](homeassistant/custom_components)

Vicnie
------
[Code](homeassistant/custom_components/vicnie/__init__.py)

**Remote Control Service** - Making my IKEA Trådfri remotes ''smart'' and able to control lights, speakers, tv, blinds, power on/off.

**Tetzipetzi Service** - Playing the latest youtube video from tetzipetzi's channel.

> [TOC Generate](https://magnetikonline.github.io/markdown-toc-generate/)

<p align="center">
<b>The End :tada:</b>
</p>
