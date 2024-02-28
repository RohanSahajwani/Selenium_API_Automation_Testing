*** Settings ***
Documentation   To validate the Login form
Library         SeleniumLibrary
Library         Collections
Library         String
Test Setup      Open the browser with the Mortgage payment url
Test Teardown   Close Browser session
Resource        ../PO/Generic.robot

*** Variables ***
${Error_Message_Login}      css:.alert-danger

*** Test Cases ***
Validate Child window Functionality
    [Tags]    SMOKE
    Select the link of Child window
    Verify the user is Switched to the Child window
    Grab the Email id in the Child window
    Switch to Parent window and enter the Email

*** Keywords ***
Select the link of Child window
    Click Element       xpath://a[@class="blinkingText"]

Verify the user is Switched to the Child window
    Switch Window       NEW
    Element Text Should Be   xpath://h1     DOCUMENTS REQUEST
    ${current_url}    Get Location
    Should Be Equal As Strings    ${current_url}    ${document_request_url}

Grab the Email id in the Child window
    ${text}=        Get Text    xpath://p[@class="im-para red"]
    @{words_1}=     Split String        ${text}       at
    ${text_split}=  Get From List       ${words_1}    1
    Log     ${text_split}
    @{words_2}=     Split String        ${text_split}
    ${email}=       Get From List       ${words_2}    0
    Set Global Variable    ${email}

Switch to Parent window and enter the Email
    Switch Window       MAIN
    Title Should Be     LoginPage Practise | Rahul Shetty Academy
    Input Text          id:username     ${email}
