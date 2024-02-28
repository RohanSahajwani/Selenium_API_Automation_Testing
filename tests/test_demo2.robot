*** Settings ***
Documentation   To validate the Login form
Library         SeleniumLibrary
Library         Collections
Test Setup      Open the browser with the Mortgage payment url
Test Teardown   Close Browser session
Resource        ../PO/Generic.robot

*** Variables ***
${Error_Message_Login}      xpath://div[@class='alert alert-danger col-md-12']
${Shop_page_load}           xpath://a[@class='nav-link btn btn-primary']

*** Test Cases ***
Validate UnSuccessfull Login
    [Tags]    SMOKE
    Fill the login Form     ${user_name}    ${invalid_password}
    Wait Until Element Is Visible       ${Error_Message_Login}
    Verify error message is correct

Validate Cards display in the Shopping Page
    [Tags]    REGRESSION
    Fill The Login Form     ${user_name}    ${valid_password}
    Wait Until Element Is Visible    ${Shop_page_load}
    Verify Card titles in the Shop page
    Select the Card     Nokia Edge

Select the Form and navigate to Child window
    [Tags]    NEWFEATURE
    Fill The Login Details and Login Form

*** Keywords ***

Fill the login Form
    [Arguments]         ${username}     ${password}
    Input Text          id:username     ${username}
    Input Password      id:password     ${password}
    Click Button        id:signInBtn

Wait Until Element Is located in the page
    [Arguments]                     ${element}
    Wait Until Element Is Visible   ${element}

Verify error message is correct
    ${result} =  Get Text           ${Error_Message_Login}
    Should Be Equal As Strings      ${result}                  Incorrect username/password.
    Element Text Should Be          ${Error_Message_Login}     Incorrect username/password.

Verify Card titles in the Shop page
    @{expectedList} =   Create List    iphone X     Samsung Note 8     Nokia Edge     Blackberry
    ${elements} =   Get Webelements    xpath://h4[@class="card-title"]
    @{actualList} =   Create List
    FOR   ${element}   IN   @{elements}
        Log    ${element.text}
        Append To List      ${actualList}    ${element.text}
    END
    Lists Should Be Equal   ${expectedList}     ${actualList}

Select the Card
    [Arguments]     ${cardName}
    ${elements} =   Get Webelements    xpath://h4[@class="card-title"]
    ${index} =  Set Variable    1
    FOR   ${element}   IN   @{elements}
        Exit For Loop If    '${cardName}' == '${element.text}'

        ${index}=  Evaluate    ${index} + 1

    END
    Click Button     xpath:(//button[@class="btn btn-info"])[${index}]

Fill The Login Details and Login Form
    Input Text          id:username     ${user_name}
    Input Password      id:password     ${valid_password}
    Click Element    xpath:(//span[@class="checkmark"])[2]
    Wait Until Element Is Visible    xpath://div[@class="modal-body"]
    Click Button     xpath://button[@id="okayBtn"]
    Select From List By Value    xpath://select[@class="form-control"]    teach
    Select Checkbox    terms
    Checkbox Should Be Selected    terms
    Click Button     id:signInBtn
    Wait Until Element Is Visible   xpath://a[@class="nav-link btn btn-primary"]
    ${current_url}    Get Location
    Should Be Equal As Strings    ${current_url}    ${shop_url}