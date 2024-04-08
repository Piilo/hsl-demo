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
