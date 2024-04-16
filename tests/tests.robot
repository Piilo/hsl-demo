*** Settings ***
Resource    ../resources/apibase.resource
Resource    ../resources/common.resource
Suite Setup    I Use Digitransit API
Suite Teardown    Suite Teardown Keywords

*** Test Cases ***
Check Available Bike Count Matchec Between UI And API
    [Documentation]    Reads bike count for specific bike station from the API and UI
    ...    and checks that bike count matches between UI and API.
    [Tags]    bike
    Given I Open HSL Web Page
    And I Navigate To City Bike View
    And I Get All Bike Stations From The API
    When I Read Number of Available Bikes For The Bike Station "Mestarinkatu"
    And I Go To City Bike Station View And Search Bike Station "Mestarinkatu"
    And I Read Available Bike Count Value From UI
    Then I see Available Bike count Matches Between UI And API

