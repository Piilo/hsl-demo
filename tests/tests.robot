*** Settings ***
Resource    ../resources/apibase.resource
Resource    ../resources/common.resource

Suite Setup    I Use Digitransit API
Suite Teardown    Suite Teardown Keywords

*** Test Cases ***
First Case
    [Documentation]    todo
    Given I Open HSL Web Page
    When I Get Disruptions Data From API For Route I
    And I Navigate To Traffic Page
    And I Search Traffic Info For Route I
    #I Read All Exceptions From The UI
    Then I See Disruptions Matches Between UI And API

Check Available Bike Count Matchec Between UI And API
    [Documentation]    todo
    [Tags]    test
    Given I Open HSL Web Page

    I Navigate To City Bike View
    I Navigate To City Bike Station View
    #When I Read Available Bike Count For Sammonpuistikko

