*** Settings ***
Resource    resources/apibase.resource
Resource    resources/common.resource

Suite Setup    I Use Digitransit API
Suite Teardown    Clear API Sessions

*** Test Cases ***
First Case
    [Documentation]    todo
    Log    message
    Get Data    ${BASE_URL}/routing/v1/routers/hsl/
    When I Get Disruptions Data From API
