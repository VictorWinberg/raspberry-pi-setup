"""Vicnie custom components."""
import re
import logging
import requests
import os
from dotenv import load_dotenv
load_dotenv()

# The domain of your component. Should be equal to the name of your component.
DOMAIN = "vicnie"
_LOGGER = logging.getLogger(__name__)

def setup(hass, config):
    """Set up the remote controller service component."""
    def remote_control_service(call):
        """Service data"""
        id = call.data.get("id")
        input_select_entity_id = {
          'symfonisk_sound_remote': 'input_select.symfonisk_play_entity',
          'symfonisk_sound_controller': 'input_select.symfonisk_wheel_entity',
          'tradfri_remote_control': 'input_select.remote_entity',
        }.get(id, '')
        if input_select_entity_id:
          entity_id = hass.states.get(input_select_entity_id).state
          domain = entity_id.split(":")[0].split(".")[0]
          entity_id = re.sub("[^:]+:", "", entity_id)
        else:
          domain = id
          entity_id = None

        events = {
          "1001": "MDWN", "1002": "MBTN", "1003": "MUP", "2001": "UDWN", "2002": "UBTN", "2003": "UUP", "3001": "DDWN", "3002": "DBTN", "3003": "DUP", "4001": "LDWN", "4002": "LBTN", "4003": "LUP", "5001": "RDWN", "5002": "RBTN", "5003": "RUP"
        }
        if id == "symfonisk_sound_controller": events = {**events, "1004": "RBTN", "1005": "LBTN", "2001": "UBTN", "3001": "DBTN"}
        event = events.get(str(call.data.get("event")), "NUL")

        """Variables"""
        s = hass.services.call
        color_list = ["white", "bisque", "red", "orange", "yellow", "green", "cyan", "blue", "purple", "pink"]

        defaults = {
          "LDWN": lambda: select_entity("media_player.kasinot_speaker"),
          "RDWN": lambda: select_entity("media_player.mio_tv"),
          "UDWN": lambda: select_entity("light.ikea_lights"),
          "DDWN": lambda: select_entity("default")
        }

        """Helpers"""
        def select_entity(option): s("input_select", "select_option", {"entity_id": input_select_entity_id, "option": option}, False)
        def select_side(option): s("input_select", "select_option", {"entity_id": "input_select.magic_cube_side", "option": option}, False)
        def set_color(d):
            color_id = "input_number.color_index"
            light_on_ids = list(map(lambda x: x.entity_id, filter(lambda x: x.domain == "light" and x.state == "on", hass.states.all())))
            prev_color_index = int(float(hass.states.get(color_id).state))
            color_index = (prev_color_index + d) % len(color_list)
            color = color_list[color_index]

            s("input_number", "set_value", {"entity_id": color_id, "value": color_index}, False)
            s("light", "turn_on", {"entity_id": light_on_ids, "color_name": color}, False)

        """Domain functions"""
        def default_domain(event):
            entity_id = []
            if not hass.states.is_state("media_player.speakers", "off") and not hass.states.is_state("media_player.speakers", "unavailable"):
              entity_id.append("media_player.speakers")
            if not hass.states.is_state("media_player.kasinot_speaker", "off") and not hass.states.is_state("media_player.kasinot_speaker", "unavailable") and (hass.states.is_state("media_player.speakers", "off") or hass.states.is_state("media_player.speakers", "unavailable")):
              entity_id.append("media_player.kasinot_speaker")
            if not hass.states.is_state("media_player.mio_tv", "off") and not hass.states.is_state("media_player.mio_tv", "unavailable"):
              entity_id.append("media_player.mio_tv")

            if event == "DDWN":
              s("script", "default_toggle", {}, False)
            elif event == "UDWN":
              light_on = hass.states.is_state("light.kitchen_lights", "on")
              s("light", "turn_off" if light_on else "turn_on", {"entity_id": "light.ikea_lights"}, False)
            elif not entity_id:
              run_service("light", "light.ikea_lights", event)
            else:
              run_service("media_player", entity_id, event)

        def media_player_domain(entity_id, event):
            volume, volume_entity = None, None
            if isinstance(entity_id, str) and len(entity_id):
              volume_entity = entity_id
            if isinstance(entity_id, list) and len(entity_id):
              if hass.states.is_state("media_player.speakers", "playing"):
                volume_entity = "media_player.speakers"
              elif hass.states.is_state("media_player.kasinot_speaker", "playing"):
                volume_entity = "media_player.kasinot_speaker"
              elif hass.states.is_state("media_player.mio_tv", "on"):
                volume_entity = "media_player.mio_tv"
            if volume_entity:
              volume = hass.states.get(volume_entity).attributes.get('volume_level')

            {
              **defaults,
              "MBTN": lambda: s("media_player", "media_play_pause", {"entity_id": entity_id}, False),
              "UBTN": lambda: volume and s("media_player", "volume_set", {"entity_id": volume_entity, "volume_level": volume + 0.05}, False),
              "DBTN": lambda: volume and s("media_player", "volume_set", {"entity_id": volume_entity, "volume_level": volume - 0.05}, False),
              "LBTN": lambda: s("media_player", "media_previous_track", {"entity_id": entity_id}, False),
              "RBTN": lambda: s("media_player", "media_next_track", {"entity_id": entity_id}, False),
            }.get(event, lambda: _LOGGER.warning("Missing event: " + event))()

        def light_domain(entity_id, event):
            light_on = hass.states.is_state(entity_id, "on")
            brightness_id = "input_number.light_brightness"
            brt = float(hass.states.get(brightness_id).state)

            {
              **defaults,
              "MBTN": lambda: s("light", "turn_off" if light_on else "turn_on", {"entity_id": entity_id}, False),
              "UBTN": lambda: s("input_number", "set_value", {"entity_id": brightness_id, "value": brt + 10}, False),
              "DBTN": lambda: s("input_number", "set_value", {"entity_id": brightness_id, "value": brt - 10}, False),
              "LBTN": lambda: set_color(-1),
              "RBTN": lambda: set_color(1),
            }.get(event, lambda: _LOGGER.warning("Missing event: " + event))()

        def tradfri_open_close_remote(event):
            {
              "MBTN": lambda: s("script", "blinds_open", {}, False),
              "UBTN": lambda: s("script", "blinds_close", {}, False),
              "MUP":  lambda: s("script", "good_morning", {}, False),
              "UUP":  lambda: s("script", "good_night", {}, False),
            }.get(event, lambda: _LOGGER.warning("Missing event: " + event))()

        """Run service"""
        def run_service(domain, entity_id, event):
            {
              "default":                     lambda: default_domain(event),
              "media_player":                lambda: media_player_domain(entity_id, event),
              "light":                       lambda: light_domain(entity_id, event),
              "automation":                  lambda: s("automation", "trigger", {"entity_id": entity_id}, False),
              "tradfri_open_close_remote":   lambda: tradfri_open_close_remote(event),
            }.get(domain, lambda: _LOGGER.warning("Missing domain: " + domain))()

        run_service(domain, entity_id, event)

    # Register our service with Home Assistant.
    hass.services.register(DOMAIN, 'remote_control', remote_control_service)

    # Return boolean to indicate that initialization was successfully.
    return True
