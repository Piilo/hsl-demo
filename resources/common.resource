*** Settings ***
Documentation     Common keywords
Resource          ./apibase.resource
Variables         ./variables.py
Library           Browser
Library    Collections
Library    String


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
    IF    not ${found}    Fail    msg=Bike station "${bike_station}"" not found from API

I Open HSL Web Page
    [Documentation]    Open browser and open HSL web page. Allow cookies if asked.
    New Browser    ${BROWSER}    headless=true
    Set Browser Timeout    15s
    New Page    ${UI_URL}
    ${Cookie_banner_visible}=    Run Keyword And Return Status
    ...    Get Element States    ${ACCCEPT_COOKIES_BTN}    contains    visible
    IF    ${Cookie_banner_visible}    Click    ${ACCCEPT_COOKIES_BTN}
    Get Title    ==    ${HSL_TITLE}

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



# obsolete

#I Get Disruptions Data From API For Route I
#    [Documentation]    Reads disruptions info from digitransit API for specific route
#    VAR    &{query}    query=${DISRUPTIONS_DATA_QUERY}
#    ${res}    Post Data    ${BASE_URL}/routing/v1/routers/hsl/index/graphql    json=${query}
#    VAR    @{DISRUPTIONS_FROM_API}    scope=TEST
#    FOR    ${item}    IN    @{res}[data][alerts]
#        Log    ${item}[alertDescriptionText]
#        #${disruption}=  Replace String    ${item}[alertDescriptionText]    \n    ${EMPTY}
#        #Log    ${disruption}
#        Append To List    ${DISRUPTIONS_FROM_API}    ${item}[alertDescriptionText]
#    END

#I Search Traffic Info For Route I
#    [Documentation]    todo
#    Wait For Elements State    ${SEARCH_ROUTE_INPUT}
#    Fill Text    ${SEARCH_ROUTE_INPUT}    ${ROUTE_I_SHORT_NAME}
#    Keyboard Key    press    Enter
#    Wait For Elements State    ${ROUTE_SEARCH_RESULT_CONTAINER}    visible
#    Keyboard Key    press    Enter
#    Wait For Elements State    ${ROUTE_SEARCH_RESULT_CONTAINER}    hidden
#    Uncheck Checkbox    ${CHECKBOX_SHOW_ONLY_CURRENT_INFO}
#    Wait For Elements State    ${ROUTE_SEARCH_RESULT_CONTAINER}    unchecked
#    #Sleep    10s
#
#I Read All Exceptions From The UI
#    [Documentation]    todo remove??
#    ${exceptions_UI}=    Get Elements      div.Exception_exceptionContentText__R5Y7V
#    log    ${exceptions_UI}
#    VAR    @{EXCEPTIONS_FROM_UI}    scope=TEST
#    FOR    ${elem}    IN    @{exceptions_UI}
#        ${text} =    Get Property    ${elem}    innerText
#        ${text}=    Convert to String    ${text}
#        Append to list    ${EXCEPTIONS_FROM_UI}   ${text}
#    END
#
#
#I See Disruptions Matches Between UI And API
#    [Documentation]    Checks that disruption info from API can be found from the UI
#    FOR    ${item}    IN    @{DISRUPTIONS_FROM_API}
#        Wait For Elements State   //div[@class="Exception_exceptionContentText__R5Y7V" and contains(text(), "${item}")]    visible
#        #List should contain value    ${EXCEPTIONS_FROM_UI}    ${item}
#    END
#
#
#I Navigate To Traffic Page
#    [Documentation]    Navigate to HSL traffic page and verify that correct header is visible.
#    Click    ${TRAFFIC_NOW_LINK}
#    Wait For Elements State    ${TRAFFIC_PAGE_HEADER}    visible