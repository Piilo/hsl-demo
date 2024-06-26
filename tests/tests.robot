*** Settings ***
Documentation       Test suite containing HSL example tests and one flaky demonstration test

Resource            ../resources/apibase.resource
Resource            ../resources/common.resource

Suite Setup         I Use Digitransit API
Suite Teardown      Suite Teardown Keywords


*** Test Cases ***
Check Available Bike Count Matchec Between UI And API
    [Documentation]    Reads bike count for specific bike station from the API and UI
    ...    and checks that bike count matches between UI and API.
    [Tags]
    ...    bikes
    ...    allure.label.severity:critical
    ...    allure.label.epic:hsl
    ...    allure.label.feature:essential_features
    ...    allure.label.story:city_bikes
    Given I Open HSL Web Page
    And I Navigate To City Bike View
    And I Get All Bike Stations From The API
    When I Read Number Of Available Bikes For The Bike Station "Mestarinkatu"
    And I Go To City Bike Station View And Search Bike Station "Mestarinkatu"
    And I Read Available Bike Count Value From UI
    Then I See Available Bike Count Matches Between UI And API

Search Routes And Check Same Routes Can Be Found From UI And API
    [Documentation]    Search routes from API and UI with specific name and
    ...    check that results matches.
    [Tags]
    ...    routes
    ...    allure.label.severity:normal
    ...    allure.label.epic:hsl
    ...    allure.label.feature:essential_features
    ...    allure.label.story:routes
    Given I Open HSL Web Page
    When I Search Routes Where Name Starts With "10" From The API
    And I Search Route, Stop Or Station Where Name Starts With "10"
    Then I See Routes Matching Between UI And API

Flaky Tests Which Sometimes Passes And Sometimes Fails
    [Documentation]    Just for demonstration purposes
    [Tags]
    ...    random
    ...    allure.label.severity:minor
    ...    allure.label.epic:random
    ...    allure.label.feature:demonstration
    ...    allure.label.story:flaky_test
    Given Pass Or Fail Randomly
