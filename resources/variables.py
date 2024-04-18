import random

BASE_URL = 'https://api.digitransit.fi'
UI_URL = 'https://hsl.fi'
BROWSER = 'chromium'
HEADLESS = 'true'

#ROUTE_I_SHORT_NAME = 'I'
#ROUTE_I_GTFSID = 'HSL:3001I'
#SAMMONPUISTIKKO_BIKE_STATION = 

# UI texts

HSL_TITLE = 'Reittiopas, liput ja hinnat, asiakaspalvelu | HSL.fi'

# Locators

#TRAFFIC_NOW_LINK = '//a[@title="Liikenne nyt"]'
ACCCEPT_COOKIES_BTN = '//*[@id="coiConsentBannerBase"]/div/div/button[contains(text(), "Hyväksy kaikki")]'
#TRAFFIC_PAGE_HEADER = '//*[@id="main"]/div/div/div/div/h1[text()="Liikenne"]'
#SEARCH_ROUTE_INPUT = 'id=stop-route-station'
#DISRUPTION_ELEMENT = '//*/div[contains(text(), "+' + ALERT_TEXT + '")]'
#CHECKBOX_SHOW_ONLY_CURRENT_INFO = 'css=div.Toggle_switch__h84OX > input'
#ROUTE_SEARCH_RESULT_CONTAINER = 'id=react-autowhatever-stop-route-station'
#ROUTE_SEARCH_RESULT_CONTAINER = '//*[@id="react-autowhatever-stop-route-station"]'
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
