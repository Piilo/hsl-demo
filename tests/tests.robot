*** Settings ***
Resource    resources/apibase.resource
Resource    resources/common.resource
Library   Browser

Suite Setup    I Use Digitransit API
Suite Teardown    Suite Teardown Keywords

*** Test Cases ***
First Case
    [Documentation]    todo
    Log    message
    Get Data    ${BASE_URL}/routing/v1/routers/hsl/
    When I Get Disruptions Data From API
    New Page    https://playwright.dev
    Get Text    h1    contains    Playwright
