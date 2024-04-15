*** Settings ***
Documentation     Common keywords
Resource          ./apibase.resource
Variables         ./variables.py
Library           Browser
Library    Collections
Library    String


*** Keywords ***
Suite Teardown Keywords
    [Documentation]    todo
    Clear API Sessions
    Close Browser


I Get Disruptions Data From API For Route I
    [Documentation]    Reads disruptions info from digitransit API for specific route
    VAR    &{query}    query=${DISRUPTIONS_DATA_QUERY}
    ${res}=    Post Data    ${BASE_URL}/routing/v1/routers/hsl/index/graphql    json=${query}
    VAR    @{DISRUPTIONS_FROM_API}    scope=TEST
    FOR    ${item}    IN    @{res}[data][alerts]
        Log    ${item}[alertDescriptionText]
        #${disruption}=  Replace String    ${item}[alertDescriptionText]    \n    ${EMPTY}
        #Log    ${disruption}
        Append To List    ${DISRUPTIONS_FROM_API}    ${item}[alertDescriptionText]
    END

I Open HSL Web Page
    [Documentation]    Open browser and open HSL web page. Allow cookies if asked.
    New Browser    ${BROWSER}    headless=false
    Set Browser Timeout    15s
    New Page    ${UI_URL}
    
    ${Cookie_banner_visible}=    Run Keyword And Return Status
    ...    Get Element States    ${ACCCEPT_COOKIES_BTN}    contains    visible
    IF    ${Cookie_banner_visible}    Click    ${ACCCEPT_COOKIES_BTN}
    Get Title    ==    ${HSL_TITLE}

I Navigate To Traffic Page
    [Documentation]    Navigate to HSL traffic page and verify that correct header is visible.
    Click    ${TRAFFIC_NOW_LINK}
    Wait For Elements State    ${TRAFFIC_PAGE_HEADER}    visible

I Navigate To City Bike View
    [Documentation]
    Click    ${CITY_BIKES_BUTTON}
    Wait For Elements State    ${CITY_BIKE_VIEW_HEADER}    visible

I Navigate To City Bike Station View
    [Documentation]
    Click    ${GET_CITY_BIKE_STATIONS_BTN}
    Wait For Elements State    ${SELECT_DEPARTURE_POINT_MODAL}    visible

I Search Traffic Info For Route I
    [Documentation]    todo
    Wait For Elements State    ${SEARCH_ROUTE_INPUT}
    Fill Text    ${SEARCH_ROUTE_INPUT}    ${ROUTE_I_SHORT_NAME}
    Keyboard Key    press    Enter
    Wait For Elements State    ${ROUTE_SEARCH_RESULT_CONTAINER}    visible
    Keyboard Key    press    Enter
    Wait For Elements State    ${ROUTE_SEARCH_RESULT_CONTAINER}    hidden
    Uncheck Checkbox    ${CHECKBOX_SHOW_ONLY_CURRENT_INFO}
    Wait For Elements State    ${ROUTE_SEARCH_RESULT_CONTAINER}    unchecked
    #Sleep    10s

I Read All Exceptions From The UI
    [Documentation]    todo remove??
    ${exceptions_UI}=    Get Elements      div.Exception_exceptionContentText__R5Y7V
    log    ${exceptions_UI}
    VAR    @{EXCEPTIONS_FROM_UI}    scope=TEST
    FOR    ${elem}    IN    @{exceptions_UI}
        ${text} =    Get Property    ${elem}    innerText
        ${text}=    Convert to String    ${text}
        Append to list    ${EXCEPTIONS_FROM_UI}   ${text}
    END

I See Disruptions Matches Between UI And API
    [Documentation]    Checks that disruption info from API can be found from the UI
    FOR    ${item}    IN    @{DISRUPTIONS_FROM_API}
        Wait For Elements State   //div[@class="Exception_exceptionContentText__R5Y7V" and contains(text(), "${item}")]    visible
        #List should contain value    ${EXCEPTIONS_FROM_UI}    ${item}
    END

