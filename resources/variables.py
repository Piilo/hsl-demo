
BASE_URL = 'https://api.digitransit.fi'
UI_URL = 'https://hsl.fi'
BROWSER = 'chromium'

ROUTE_I_SHORT_NAME = 'I'
ROUTE_I_GTFSID = 'HSL:3001I'

# UI texts

HSL_TITLE = 'Reittiopas, liput ja hinnat, asiakaspalvelu | HSL.fi'
ALERT_TEXT = 'Pääradan ja kehäradan itäosan junaliikenteeseen huomattavia muutoksia 2.4.2024 alkaen'

# Locators

TRAFFIC_NOW_LINK = '//a[@title="Liikenne nyt"]'
ACCCEPT_COOKIES_BTN = '//*[@id="coiConsentBannerBase"]/div/div/button[contains(text(), "Hyväksy kaikki")]'
TRAFFIC_PAGE_HEADER = '//*[@id="main"]/div/div/div/div/h1[text()="Liikenne"]'
SEARCH_ROUTE_INPUT = 'id=stop-route-station'
DISRUPTION_ELEMENT = '//*/div[contains(text(), "+' + ALERT_TEXT + '")]'
CHECKBOX_SHOW_ONLY_CURRENT_INFO = 'css=div.Toggle_switch__h84OX > input'
#ROUTE_SEARCH_RESULT_CONTAINER = 'id=react-autowhatever-stop-route-station'
ROUTE_SEARCH_RESULT_CONTAINER = '//*[@id="react-autowhatever-stop-route-station"]'




# Query

DISRUPTIONS_DATA_QUERY = '{alerts (route: ["' + ROUTE_I_GTFSID +'"] severityLevel: [WARNING]){alertDescriptionText}}'
