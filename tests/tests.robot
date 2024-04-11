*** Settings ***
Resource    ../resources/apibase.resource
Resource    ../resources/common.resource

Suite Setup    I Use Digitransit API
Suite Teardown    Suite Teardown Keywords

*** Test Cases ***
First Case
    [Documentation]    todo
    Given I Open HSL Web Page
    When I Get Disruptions Data From API
    Then I Navigate To Traffic Page
