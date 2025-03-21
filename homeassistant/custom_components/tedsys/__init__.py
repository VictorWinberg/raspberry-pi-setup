import os
import json
import logging
import random
import requests
from datetime import datetime
from zoneinfo import ZoneInfo
from dotenv import load_dotenv
load_dotenv()

# The domain of your component. Should be equal to the name of your component.
DOMAIN = "tedsys"
_LOGGER = logging.getLogger(__name__)

API_URL = "https://tedbiz-tedsys-api.tedsys.net/api/v1"
BOOKING_URL = "https://api.paxaplats.com/v1"
RESOURCE_IDS = [70, 59, 60, 61, 62]
TIMEZONE = ZoneInfo("Europe/Stockholm")

class Weekday:
    def __init__(self, date, start, end):
        self.date = date
        self.start = start
        self.end = end

    def __str__(self):
        return str(int(self.date.timestamp()))

def get_random_in_range(integers):
    return random.choice(integers)

def authenticate():
    email = os.getenv("EMAIL")
    password = os.getenv("PASSWORD")
    if not email or not password:
        raise EnvironmentError("EMAIL or PASSWORD not set in environment")

    response = requests.post(
        f"{API_URL}/auth/login",
        headers={"Content-Type": "application/json"},
        data=json.dumps({"email": email, "password": password})
    )

    if response.status_code != 200:
        raise Exception("Authentication failed")

    auth_response = response.json()
    return auth_response["jwtToken"]

def get_booking_token(token):
    response = requests.get(
        f"{API_URL}/booking/login",
        headers={"Content-Type": "application", "Authorization": f"Bearer {token}"}
    )

    if response.status_code != 200:
        raise Exception("Booking login url failed")

    booking_login_response = response.json()
    login_url = booking_login_response["data"]["loginUrl"]
    token = login_url.split("token=")[1].split("&")[0]

    response = requests.post(f"{BOOKING_URL}/sso/login/{token}")
    sso_response = response.json()
    return sso_response["jwtToken"]


def get_booking_availability(weekday, resource_id, token):
    response = requests.get(
        f"{BOOKING_URL}/booking/{resource_id}/periods",
        params={"startDate": weekday.date.strftime("%Y-%m-%d"), "endDate": weekday.date.strftime("%Y-%m-%d")},
        headers={"Content-Type": "application/json", "Authorization": f"Bearer {token}"}
    )

    if response.status_code != 200:
        return False

    booking_response = response.json()
    return len(booking_response["data"]) == 0

def get_random_resource_id(weekday, token):
    resource_ids = RESOURCE_IDS[:]
    for _ in range(len(RESOURCE_IDS) + 1):
        resource_id = get_random_in_range(resource_ids)
        if get_booking_availability(weekday, resource_id, token):
            return resource_id
        resource_ids.remove(resource_id)
    return -1

def get_booking(weekday, resource_id):
    data = {
        "resourceId": resource_id,
        "startDate": weekday.start.isoformat(),
        "endDate": weekday.end.isoformat(),
    }
    return json.dumps(data).encode('utf-8')

def post_booking(booking, resource_id, token):
    response = requests.post(
        f"{BOOKING_URL}/booking/{resource_id}/period",
        headers={"Content-Type": "application/json", "Authorization": f"Bearer {token}"},
        data=booking
    )

    booking_response = response.json()
    return booking_response

def setup(hass, config):
    """Set up the tedbiz service component."""
    def tedbiz_booking_service(call):
        token = authenticate()
        booking_token = get_booking_token(token)

        date = call.data.get("date") or datetime.now(TIMEZONE).strftime("%Y-%m-%d")
        notify = call.data.get("notify")
        specific_date = datetime.strptime(date, "%Y-%m-%d").replace(tzinfo=TIMEZONE)
        weekday = Weekday(
            specific_date,
            specific_date.replace(hour=8, minute=0, second=0, microsecond=0),
            specific_date.replace(hour=17, minute=0, second=0, microsecond=0)
        )

        resource_id = get_random_resource_id(weekday, booking_token)
        if resource_id == -1:
            _LOGGER.warning(f"No resources available for {weekday.date.strftime('%Y-%m-%d')}")
            if notify: hass.services.call("notify", notify, {"title": "Tedbiz", "message": f"No resources available for {weekday.date.strftime('%a %d %b')}"})
            return

        booking = get_booking(weekday, resource_id)
        booking = post_booking(booking, resource_id, booking_token)
        if notify: hass.services.call("notify", notify, {"title": "Tedbiz", "message": f"{booking['message']} {booking['data'][0]['resourceName']} on {weekday.date.strftime('%a %d %b')}"})

    # Register our service with Home Assistant.
    hass.services.register(DOMAIN, 'tedbiz_booking', tedbiz_booking_service)

    # Return boolean to indicate that initialization was successfully.
    return True
