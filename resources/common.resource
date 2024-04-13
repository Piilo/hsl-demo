*** Settings ***
Documentation     Common keywords
Resource          ./apibase.resource
Variables         ./variables.py
Library           Browser


*** Keywords ***
Suite Teardown Keywords
    [Documentation]    todo
    Clear API Sessions
    Close Browser

I Get Disruptions Data From API For Route I
    [Documentation]    todo
    VAR    &{query}    query=${DISRUPTIONS_DATA_QUERY}
    ${res}=    Post Data    ${BASE_URL}/routing/v1/routers/hsl/index/graphql    json=${query}
    VAR    ${DISRUPTIONS_DATA_FROM_API}    ${res}    scope=TEST

I Open HSL Web Page
    [Documentation]    Open browser and open HSL web page. Allow cookies if asked.
    New Browser    ${BROWSER}    headless=false
    New Page    ${UI_URL}
    Get Title    ==    ${HSL_TITLE}
    ${Cookie_banner_visible}=    Run Keyword And Return Status
    ...    Get Element States    ${ACCCEPT_COOKIES_BTN}    contains    visible
    IF    ${Cookie_banner_visible}    Click    ${ACCCEPT_COOKIES_BTN}

I Navigate To Traffic Page
    [Documentation]    Navigate to HSL traffic page and verify that correct header is visible.
    Click    ${TRAFFIC_NOW_LINK}
    Get Element States    ${TRAFFIC_PAGE_HEADER}    contains    visible

I Read Current Traffic Info For Route I
    [Documentation]    todo
    Fill Text    ${SEARCH_ROUTE_INPUT}    ${ROUTE_I_SHORT_NAME}
    Keyboard Key    press    Enter
    Sleep    15s


