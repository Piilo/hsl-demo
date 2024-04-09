*** Settings ***
Documentation    Common keywords
Resource    apibase.resource
Variables    variables.py


*** Keywords ***

Suite teardown keywords
    [Documentation]    todo
    Clear API Sessions
    Close Browser

I Get Disruptions Data From API
    [Documentation]    todo
    VAR    &{query}    query={alerts {alertDescriptionText}}
    ${res}=    Post Data    ${BASE_URL}/routing/v1/routers/hsl/index/graphql    json=${query}
    VAR    ${DISRUPTIONS_DATA_FROM_API}    ${res}    scope=TEST

I Open HSL Web Page
    [Documentation]    todo
    New Browser    ${BROWSER}    headless=false
    New Page       ${UI_URL}
    Get Title      ==    Reittiopas, liput ja hinnat, asiakaspalvelu | HSL.fi

I Navigate To Traffic Page
    [Documentation]    todo
    Click    ${TRAFFIC_NOW_LINK}
    Get Element States    //*[@id="main"]/div/div/div/div/h1[text()="Liikenne"]    contains    visible
