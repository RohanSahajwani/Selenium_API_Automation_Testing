*** Settings ***
Documentation   To validate the Login form
Library         SeleniumLibrary
Library         DataDriver      file=resources/data.csv     encoding=utf_8      dialect=unix
Test Teardown   Close Browser
Test Template   Validate UnSuccessfull Login

*** Variables ***
${Error_Message_Login}      css:.alert-danger

*** Test Cases ***
[Tags]    SMOKE
Login with user ${username} and password ${password}        defaultDataUsername     defaultDataPassword

*** Keywords ***
Validate UnSuccessfull Login
    [Arguments]             ${username}     ${password}
    Open the browser with the Mortgage payment url
    Fill the login Form     ${username}     ${password}
    Wait until it checks and display error message
    Verify error message is correct

Open the browser with the Mortgage payment url
    Create Webdriver    Chrome
    Go To               https://rahulshettyacademy.com/loginpagePractise/

Fill the login Form
    [Arguments]         ${username}     ${password}
    Input Text          id:username     ${username}
    Input Password      id:password     ${password}
    Click Button        id:signInBtn

Wait until it checks and display error message
    Wait Until Element Is Visible   ${Error_Message_Login}

Verify error message is correct
    ${result}=  Get Text            ${Error_Message_Login}
    Should Be Equal As Strings      ${result}                  Incorrect username/password.
    Element Text Should Be          ${Error_Message_Login}     Incorrect username/password.
