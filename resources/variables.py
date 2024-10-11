""" Variables collected here """

BASE_URL = 'https://api.digitransit.fi'
UI_URL = 'https://hsl.fi'
BROWSER = 'firefox'
HEADLESS = 'true'

# UI texts
HSL_TITLE = 'Reittiopas, liput ja hinnat, asiakaspalvelu | HSL.fi'

# UI Locators
ACCCEPT_COOKIES_BTN = '//*[@id="coiConsentBannerBase"]/div/div/button[contains(text(), "Hyväksy kaikki")]'
CITY_BIKES_BUTTON = '//a[@href="/kaupunkipyorat"]'
HELSINKI_CITY_BIKES_BTN = '//a[@href="https://www.hsl.fi/kaupunkipyorat/helsinki"]'
CITY_BIKE_VIEW_HEADER = '//*[@id="main"]/div/h1[starts-with(@class, "CityBikesIntroduction")]'
GET_CITY_BIKE_STATIONS_BTN = '//a[@href="https://reittiopas.hsl.fi/lahellasi/CITYBIKE/POS"]'
SELECT_DEPARTURE_POINT_MODAL = 'body > div.ReactModalPortal > div > div > div > div'
DEPARTURE_POINT_INPUT = 'id=origin-stop-near-you'
BIKE_STATION_SEARCH_RESULT_CONTAINER = 'id=react-autowhatever-origin-stop-near-you'
AVAILABLE_BIKE_COUNT_LOCATOR = 'span.available-bikes'
SEARCH_ROUTES_INPUT = 'id=stop-route-station'
SEARCH_RESULTS_CONTAINER = 'id=react-autowhatever-stop-route-station'
SEARCH_RESULTS_CONTAINER_LIST = '//*[@id="react-autowhatever-stop-route-station"]/ul'

def BIKE_STATION_LIST_ITEM(station):
    """Return UI locator for given bike station in the search result list"""
    return (f'//div[@class="styles_suggestion-name__iADbo" and text()="{station}"]'
            + '/following-sibling::div[contains(text(), "Pyöräasema")]')

def BIKE_STATION_LINK_LOCATOR(station):
    """Return UI locator for navigation link of the given bike station"""
    return  f'//h3[@class="stop-near-you-name" and text()="{station}"]/..'

def SEARCH_RESULT_ITEMS_STARTING_WITH_NAME(name):
    """Return UI locator for route starting with given name in the search result list"""
    return ('//*[@id="react-autowhatever-stop-route-station"]//*'
            + f'/div[@class="styles_suggestion-name__iADbo" and starts-with(text(),"{name}")]')
