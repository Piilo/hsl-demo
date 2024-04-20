*** Settings ***
Documentation     Common keywords
Resource          ./apibase.resource
Variables         ./variables.py
Library           Browser
Library    Collections
Library    String
Library    ./utils.py


*** Keywords ***
Suite Teardown Keywords
    [Documentation]    Clears API sessions and Closes the Browser
    Clear API Sessions
    Close Browser

I Get All Bike Stations From The API
    [Documentation]    Reads all bike stations from the API and saves response to test variable
    VAR    &{query}    query=${BIKE_STATIONS_QUERY}
    ${res}    Post Data    ${BASE_URL}/routing/v1/routers/hsl/index/graphql    json=${query}
    VAR    ${BIKE_STATIONS_FROM_API}    ${res}[data][bikeRentalStations]    scope=TEST

I Read Number of Available Bikes For The Bike Station "${bike_station}"
    [Documentation]    Reads number of available bikes on given bike station and saves value to test variable.
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
    IF    not ${found}    Fail    msg=Bike station "${bike_station}" not found from API

I Search Routes Where Name Starts With "${name}" From The API
    [Documentation]    Get all routes from API where name starts with given value and save routes to test variable.
    ...    Parameters:
    ...    ${name}= route name/part of the route name
    VAR    &{query}    query= {routes(name: "${name}") {shortName longName}}
    ${res}    Post Data    ${BASE_URL}/routing/v1/routers/hsl/index/graphql    json=${query}
    VAR    ${ROUTES_FROM_API}    ${res}[data][routes]    scope=TEST

I Open HSL Web Page
    [Documentation]    Open browser and open HSL web page. Allow cookies if asked.
    New Browser    ${BROWSER}    headless=${HEADLESS}
    Set Browser Timeout    15s
    New Page    ${UI_URL}
    ${Cookie_banner_visible}=    Run Keyword And Return Status
    ...    Get Element States    ${ACCCEPT_COOKIES_BTN}    contains    visible
    IF    ${Cookie_banner_visible}    Click    ${ACCCEPT_COOKIES_BTN}
    Get Title    ==    ${HSL_TITLE}

I Search Route, Stop Or Station Where Name Starts With "${name}"
    [Documentation]
    Fill Text    ${SEARCH_ROUTES_INPUT}    ${name}
    Keyboard Key    press    Enter
    ${search_results} =    Get Elements    ${SEARCH_RESULT_ITEMS_STARTING_WITH_NAME(${name})}
    Log    ${search_results}
    VAR    @{ROUTES_FROM_UI}    scope=TEST
    FOR    ${el}    IN    @{search_results}
        ${short_name}=    Get Text    ${el}
        ${split}    Split String    ${el}    >>
        ${loc}=    Catenate    SEPARATOR=    ${split}[0]    /following-sibling::div
        ${loc}    Catenate     ${loc}     >> ${split}[1]
        ${long_name}=    Get text    ${loc}
        VAR    &{names}    shortName=${short_name}    longName=${long_name}
        Append to list    ${ROUTES_FROM_UI}    ${names}     
    END
    ### todo remove
    #VAR    &{names_extra}    shortName=kissa    longName=koira
    #Append to list    ${ROUTES_FROM_UI}    ${names_extra}
    ###
    Log    ${ROUTES_FROM_UI}

I Navigate To City Bike View
    [Documentation]    Navigate to overall city bike view from the HSL front page
    Click    ${CITY_BIKES_BUTTON}
    Wait For Elements State    ${CITY_BIKE_VIEW_HEADER}    visible

I Go To City Bike Station View And Search Bike Station "${bike_station}"
    [Documentation]    Navigate to city bike station view and search given bike station.
    ...    Then navigate to given bike station view.
    ...    Parameters:
    ...    ${bike_station}= Name of the bike station
    Click    ${GET_CITY_BIKE_STATIONS_BTN}
    Wait For Elements State    ${SELECT_DEPARTURE_POINT_MODAL}    visible
    Fill Text    ${DEPARTURE_POINT_INPUT}    ${bike_station}
    Keyboard Key    press    Enter
    Click    ${BIKE_STATION_LIST_ITEM("${bike_station}")}
    Click    ${BIKE_STATION_LINK_LOCATOR("${bike_station}")}

I Read Available Bike Count Value From UI
    [Documentation]    Read and save to test variable available bike count
    ${bike_count}    Get text    ${AVAILABLE_BIKE_COUNT_LOCATOR}
    VAR    ${AVAILABLE_BIKE_COUNT_UI}    ${bike_count}    scope=TEST
    Log    ${bike_count} ui

I see Available Bike count Matches Between UI And API
    [Documentation]    Check that number of available bikes ate same in the UI and API for same bike station
    Log    ${AVAILABLE_BIKE_COUNT_UI} ui
    log    ${AVAILABLE_BIKE_COUNT_API}
    Should Be Equal As Strings    ${AVAILABLE_BIKE_COUNT_API}    ${AVAILABLE_BIKE_COUNT_UI}

I See Routes Matching Between UI And API
    [Documentation]    Checks if Searched routes from UI and API matches.
    ...    Results from API should be first saved to test variable ROUTES_FROM_API 
    ...    and results fom UI should be first saved to test variable ROUTES_FROM_UI
    ${result}    Check list differences    ${ROUTES_FROM_API}    ${ROUTES_FROM_UI}    shortName
    Log    ${result}
    Should be Empty    ${result}    msg=Routes are not matching between UI and API: differences: ${result}