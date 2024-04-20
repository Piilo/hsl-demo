import random

BASE_URL = 'https://api.digitransit.fi'
UI_URL = 'https://hsl.fi'
BROWSER = 'chromium'
HEADLESS = 'true'

# UI texts

HSL_TITLE = 'Reittiopas, liput ja hinnat, asiakaspalvelu | HSL.fi'

# Locators

ACCCEPT_COOKIES_BTN = '//*[@id="coiConsentBannerBase"]/div/div/button[contains(text(), "Hyväksy kaikki")]'
CITY_BIKES_BUTTON = '//a[@href="/kaupunkipyorat/helsinki"]'
CITY_BIKE_VIEW_HEADER = 'main > div.Introduction_introductionContainer__CU96D > div > div > h1'
GET_CITY_BIKE_STATIONS_BTN = '//a[@href="https://reittiopas.hsl.fi/lahellasi/CITYBIKE/POS"]'
SELECT_DEPARTURE_POINT_MODAL = 'body > div.ReactModalPortal > div > div > div > div'
DEPARTURE_POINT_INPUT = 'id=origin-stop-near-you'
BIKE_STATION_SEARCH_RESULT_CONTAINER = 'id=react-autowhatever-origin-stop-near-you'
AVAILABLE_BIKE_COUNT_LOCATOR = 'span.available-bikes'
SEARCH_ROUTES_INPUT = 'id=stop-route-station'
SEARCH_RESULTS_CONTAINER = 'id=react-autowhatever-stop-route-station'


def BIKE_STATION_LIST_ITEM(station):
    return (f'//div[@class="styles_suggestion-name__iADbo" and text()="{station}"]'
            + f'/following-sibling::div[contains(text(), "Pyöräasema")]')

def BIKE_STATION_LINK_LOCATOR(station):
    return  f'//h3[@class="stop-near-you-name" and text()="{station}"]/..'

def SEARCH_RESULT_ITEMS_STARTING_WITH_NAME(name):
    return (f'//*[@id="react-autowhatever-stop-route-station"]//*'
            + f'/div[@class="styles_suggestion-name__iADbo" and starts-with(text(),"{name}")]')

# Query

#DISRUPTIONS_DATA_QUERY = '{alerts (route: ["' + ROUTE_I_GTFSID +'"] severityLevel: [WARNING]){alertDescriptionText}}'
BIKE_STATIONS_QUERY = '{bikeRentalStations {name stationId bikesAvailable}}'
