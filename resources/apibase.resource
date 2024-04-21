*** Settings ***
Documentation       Keywords for basic API usage

Library             RequestsLibrary
Variables           ./variables.py


*** Keywords ***
I Use Digitransit API
    [Documentation]    Initialies API session to Digitransit API
    VAR    &{headers}    digitransit-subscription-key=%{DD_API_KEY}    Content-Type=application/json
    Create Session    session    ${BASE_URL}    ${headers}    verify=True

Clear API Sessions
    [Documentation]    Clear created API sessions
    Delete All Sessions

Get Data
    [Documentation]    Send GET request to given endpoint using existing API session
    [Arguments]    ${url}    ${session}=session    ${status_code}=200    ${params}=
    ${res}=    Get On Session    ${session}    ${url}    ${params}    ${status_code}
    Log    ${res.json()}
    RETURN    ${res.json()}

Post Data
    [Documentation]    Send POST request to given endpoint using existing API session
    [Arguments]    ${url}    ${session}=session    ${status_code}=200    ${data}=    ${json}=
    ${res}=    Post On Session    ${session}    ${url}    ${data}    ${json}    ${status_code}
    Log    ${res.json()}
    RETURN    ${res.json()}
