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

key = os.environ.get("yt-api-key")
channelId = "UCKBW7WWWKIrewD13oRkaDag"

def setup(hass, config):
    """Set up the tetzipetzi service component."""
    def tetzipetzi_service(call):
        res = requests.get('https://www.googleapis.com/youtube/v3/search?part=snippet&channelId=' + channelId + '&maxResults=1&order=date&type=video&key=' + key)
        item = res.json()["items"][0]

        rgb_color = call.data.get("rgb_color")
        video = 'https://www.youtube.com/watch?v=' + item["id"]["videoId"]
        service_data = {"rgb_color": rgb_color, "video": video}
        hass.services.call("script", "start_video_lights", service_data, False)
        player = "media_player.sorrysound_audio"
        message = "Hej Hej Annie, Tetzipetzi haer. " #+ item["snippet"]["title"]
        hass.services.call("tts", "google_translate_say", {"entity_id": player, "message": message}, False)

    """Set up the remote controller service component."""
    def remote_control_service(call):
        """Service data"""
        id = call.data.get("id")
        input_select_entity_id = {
          'symfonisk_controller': 'input_select.symfonisk_entity',
          'tradfri_remote_control': 'input_select.remote_entity',
        }.get(id, '')
        if input_select_entity_id:
          entity_id = hass.states.get(input_select_entity_id).state
          domain = entity_id.split(":")[0].split(".")[0]
          entity_id = re.sub("[^:]+:", "", entity_id)
        else:
          domain = id

        events = {
          "1001": "MDWN", "1002": "MBTN", "1003": "MUP", "2001": "UDWN", "2002": "UBTN", "2003": "UUP", "3001": "DDWN", "3002": "DBTN", "3003": "DUP", "4001": "LDWN", "4002": "LBTN", "4003": "LUP", "5001": "RDWN", "5002": "RBTN", "5003": "RUP"
        }
        if id == "symfonisk_controller": events = {**events, "1004": "RBTN", "1005": "LBTN", "2001": "UBTN", "3001": "DBTN"}
        event = events.get(call.data.get("event"), "NUL")

        """Variables"""
        s = hass.services.call
        color_list = ["white", "bisque", "red", "orange", "yellow", "green", "cyan", "blue", "purple", "pink"]

        defaults = {"MDWN": lambda: s("homeassistant", "restart", {}, False),
                    "LDWN": lambda: select("media_player.portable_speaker"),
                    "RDWN": lambda: select("media_player.mio_tv"),
                    "UDWN": lambda: select("light:group.ikea"),
                    "DDWN": lambda: select("default")}


        """Helpers"""
        def select(option): s("input_select", "select_option", {"entity_id": input_select_entity_id, "option": option}, False)
        def set_color(d):
            color_id = "input_number.color_index"
            light_on_ids = list(map(lambda x: x.entity_id, filter(lambda x: x.domain == "light" and x.state == "on", hass.states.all())))
            prev_color_index = int(float(hass.states.get(color_id).state))
            color_index = (prev_color_index + d) % len(color_list)
            color = color_list[color_index]

            s("input_number", "set_value", {"entity_id": color_id, "value": color_index}, False)
            s("light", "turn_on", {"entity_id": light_on_ids, "color_name": color}, False)

        """Domain functions"""
        def default_domain():
            audio_id = "media_player.portable_speaker" if hass.states.is_state("media_player.speakers", "off") else "media_player.speakers"
            volume = hass.states.get(audio_id).attributes.get('volume_level')
            {
            **defaults,
            "MBTN": lambda: (s("script", "goodnight_at_night", {}, False), s("script", "toggle_play_pause", {}, False)),
            "UBTN": lambda: volume and s("media_player", "volume_set", {"entity_id": audio_id, "volume_level": volume + 0.05}, False),
            "DBTN": lambda: volume and s("media_player", "volume_set", {"entity_id": audio_id, "volume_level": volume - 0.05}, False),
            "LBTN": lambda: s("media_player", "media_previous_track", {"entity_id": audio_id}, False),
            "RBTN": lambda: s("media_player", "media_next_track", {"entity_id": audio_id}, False),
            }.get(event, lambda: _LOGGER.warning("Missing event: " + event))()

        def media_player_domain():
            volume = hass.states.get(entity_id).attributes.get('volume_level')
            {
            **defaults,
            "MBTN": lambda: s("media_player", "media_play_pause", {"entity_id": entity_id}, False),
            "UBTN": lambda: volume and s("media_player", "volume_set", {"entity_id": entity_id, "volume_level": volume + 0.05}, False),
            "DBTN": lambda: volume and s("media_player", "volume_set", {"entity_id": entity_id, "volume_level": volume - 0.05}, False),
            "LBTN": lambda: s("media_player", "media_previous_track", {"entity_id": entity_id}, False),
            "RBTN": lambda: s("media_player", "media_next_track", {"entity_id": entity_id}, False),
            }.get(event, lambda: _LOGGER.warning("Missing event: " + event))()

        def light_domain():
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


        def tradfri_open_close_remote():
            {
            "MBTN": lambda: s("script", "blinds_open", {}, False),
            "UBTN": lambda: s("script", "blinds_close", {}, False),
            "MUP": lambda: s("automation", "trigger", {"entity_id": "automation.alarm_clock_wake_me_up_with_lights"}, False),
            "UUP": lambda: s("automation", "trigger", {"entity_id": "automation.goodnight_turn_off_the_lights"}, False),
            }.get(event, lambda: _LOGGER.warning("Missing event: " + event))()

        """Run service"""
        {
          'default': default_domain,
          'media_player': media_player_domain,
          'light': light_domain,
          'automation': lambda: s("automation", "trigger", {"entity_id": entity_id}, False),
          'tradfri_open_close_switch': tradfri_open_close_remote,
          'tradfri_open_close_switch_2': tradfri_open_close_remote,
        }.get(domain, lambda: _LOGGER.warning("Missing domain: " + domain))()

    # Register our service with Home Assistant.
    hass.services.register(DOMAIN, 'tetzipetzi', tetzipetzi_service)
    hass.services.register(DOMAIN, 'remote_control', remote_control_service)

    # Return boolean to indicate that initialization was successfully.
    return True
