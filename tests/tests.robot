*** Settings ***
Resource    ../resources/apibase.resource
Resource    ../resources/common.resource
Suite Setup    I Use Digitransit API
Suite Teardown    Suite Teardown Keywords

*** Test Cases ***
Check Available Bike Count Matchec Between UI And API
    [Documentation]    Reads bike count for specific bike station from the API and UI
    ...    and checks that bike count matches between UI and API.
    [Tags]    bikes
    Given I Open HSL Web Page
    And I Navigate To City Bike View
    And I Get All Bike Stations From The API
    When I Read Number of Available Bikes For The Bike Station "Mestarinkatu"
    And I Go To City Bike Station View And Search Bike Station "Mestarinkatu"
    And I Read Available Bike Count Value From UI
    Then I see Available Bike count Matches Between UI And API

Search Routes And Check Same Routes Can Be Found From UI And API
    [Documentation]    Search routes from API and UI with specific name and
    ...    check that results matches.
    [Tags]    routes
    Given I Open HSL Web Page
    When I Search Routes Where Name Starts With "10" From The API
    And I Search Route, Stop Or Station Where Name Starts With "10"
    Then I See Routes Matching Between UI And API