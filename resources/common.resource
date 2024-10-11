*** Settings ***
Documentation       Common keywords for API and UI usage

Library             Collections
Library             String
Library             Browser
Library             ./utils.py
Resource            ./apibase.resource
Variables           ./variables.py


*** Keywords ***
Suite Teardown Keywords
    [Documentation]    Clears API sessions and Closes the Browser
    Clear API Sessions
    Close Browser

I Get All Bike Stations From The API
    [Documentation]    Reads all bike stations from the API and saves response to test variable
    VAR    &{query}    query={bikeRentalStations {name stationId bikesAvailable}}
    ${res}    Post Data    ${BASE_URL}/routing/v1/routers/hsl/index/graphql    json=${query}
    VAR    ${BIKE_STATIONS_FROM_API}    ${res}[data][bikeRentalStations]    scope=TEST

I Read Number Of Available Bikes For The Bike Station "${bike_station}"
    [Documentation]    Reads number of available bikes for given bike station and saves value to test variable.
    ...    Parameters:
    ...    ${bike_station}= name of the bike station
    VAR    ${found}    False
    FOR    ${station}    IN    @{BIKE_STATIONS_FROM_API}
        IF    "${station}[name]"=="${bike_station}"
            VAR    ${AVAILABLE_BIKE_COUNT_API}    ${station}[bikesAvailable]    scope=TEST
            Log    api ${AVAILABLE_BIKE_COUNT_API}
            VAR    ${found}    True
            BREAK
        END
    END
    IF    not ${found}
        Fail    msg=Bike station "${bike_station}" not found from API
    END

I Search Routes Where Name Starts With "${name}" From The API
    [Documentation]    Get all routes from API where name starts with given value and save routes to test variable.
    ...    Parameters:
    ...    ${name}= route name/beginning of the route name
    VAR    &{query}    query= {routes(name: "${name}") {shortName longName}}
    ${res}    Post Data    ${BASE_URL}/routing/v1/routers/hsl/index/graphql    json=${query}
    VAR    ${ROUTES_FROM_API}    ${res}[data][routes]    scope=TEST

I Open HSL Web Page
    [Documentation]    Open browser and open HSL web page. Allow cookies if asked.
    New Browser    ${BROWSER}    headless=${HEADLESS}
    Set Browser Timeout    25s
    New Page    ${UI_URL}
    ${Cookie_banner_visible}    Run Keyword And Return Status    Get Element States
    ...    ${ACCCEPT_COOKIES_BTN}
    ...    contains
    ...    visible
    IF    ${Cookie_banner_visible}    Click    ${ACCCEPT_COOKIES_BTN}
    Get Title    ==    ${HSL_TITLE}

I Search Stop, Route Or Station With "${name}"
    [Documentation]    Search stop, route or station with given name.
    ...    Inputs the given name to search field and 'submits' search and verifies
    ...    that search result container list is visible. Fails if no search results found.
    ...    Parameters:
    ...    ${name}= Whole name of the route/stop/station, or part of the name
    Fill Text    ${SEARCH_ROUTES_INPUT}    ${name}
    Keyboard Key    press    Enter
    Get Element States    ${SEARCH_RESULTS_CONTAINER_LIST}
    ...    contains
    ...    visible
    ...    message=Did not find any routes/stops/stations with name "${name}"

I Search Route, Stop Or Station Where Name Starts With "${name}"
    [Documentation]    From the HSL front page search route, stop or station with
    ...    given name or partial name starting with given string. Saves all search matches to list,
    ...    for each route short name and long name is saved.
    ...    Parameters:
    ...    ${name}= Whole name of the route/stop/station, or beginning of the name
    VAR    @{ROUTES_FROM_UI}    @{EMPTY}    scope=TEST
    I Search Stop, Route Or Station With "${name}"
    ${search_results}    Get Elements    ${SEARCH_RESULT_ITEMS_STARTING_WITH_NAME(${name})}
    FOR    ${el}    IN    @{search_results}
        ${short_name}    Get Text    ${el}
        ${split}    Split String    ${el}    >>
        ${loc}    Catenate    SEPARATOR=    ${split}[0]    /following-sibling::div
        ${loc}    Catenate    ${loc}    >> ${split}[1]
        ${long_name}    Get Text    ${loc}
        VAR    &{names}    shortName=${short_name}    longName=${long_name}
        Append To List    ${ROUTES_FROM_UI}    ${names}
    END

I Navigate To City Bike View
    [Documentation]    Navigate to overall city bike view from the HSL front page
    Click    ${CITY_BIKES_BUTTON}
    Wait For Elements State    ${CITY_BIKE_VIEW_HEADER}    visible

I Go To City Bike Station View And Search Bike Station "${bike_station}"
    [Documentation]    Navigate to city bike station view of the Helsinki city bikes
    ...    and search given bike station. Then navigate to bike station view of the given bike station.
    ...    Parameters:
    ...    ${bike_station}= Name of the bike station
    Click    ${HELSINKI_CITY_BIKES_BTN}
    Click    ${GET_CITY_BIKE_STATIONS_BTN}
    Wait For Elements State    ${SELECT_DEPARTURE_POINT_MODAL}    visible
    Fill Text    ${DEPARTURE_POINT_INPUT}    ${bike_station}
    Keyboard Key    press    Enter
    Click    ${BIKE_STATION_LIST_ITEM("${bike_station}")}
    Click    ${BIKE_STATION_LINK_LOCATOR("${bike_station}")}

I Read Available Bike Count Value From UI
    [Documentation]    Read and save to test variable available bike count from UI.
    ${bike_count}    Get Text    ${AVAILABLE_BIKE_COUNT_LOCATOR}
    VAR    ${AVAILABLE_BIKE_COUNT_UI}    ${bike_count}    scope=TEST

I See Available Bike Count Matches Between UI And API
    [Documentation]    Check that number of available bikes are same in the UI and API for the same bike station.
    Log    ${AVAILABLE_BIKE_COUNT_UI} UI
    Log    ${AVAILABLE_BIKE_COUNT_API} API
    Should Be Equal As Strings    ${AVAILABLE_BIKE_COUNT_API}
    ...    ${AVAILABLE_BIKE_COUNT_UI}
    ...    msg=Bike count in UI and API did not match, UI ${AVAILABLE_BIKE_COUNT_UI} != API ${AVAILABLE_BIKE_COUNT_UI}

I See Routes Matching Between UI And API
    [Documentation]    Checks if Searched routes from UI and API matches.
    ...    Results from API should be first saved to test variable ROUTES_FROM_API
    ...    and results fom UI should be first saved to test variable ROUTES_FROM_UI
    ${result}    Check List Differences    ${ROUTES_FROM_API}    ${ROUTES_FROM_UI}    shortName
    Should Be Empty    ${result}    msg=Routes are not matching between UI and API: differences: ${result}

Pass Or Fail Randomly
    [Documentation]    Keyword that passes or fails randomly
    ${val}    Evaluate    random.choice([True, False])
    Should Be True    ${val}
