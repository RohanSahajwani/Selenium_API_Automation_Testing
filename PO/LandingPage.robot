*** Settings ***
Documentation    All the page objects and keywords of landing page
Library          SeleniumLibrary
Resource        ../PO/Generic.robot

*** Variables ***
${Error_Message_Login}      xpath://div[@class='alert alert-danger col-md-12']

*** Keywords ***
Fill the login Form
    [Arguments]         ${username}     ${password}
    Input Text          id:username     ${username}
    Input Password      id:password     ${password}
    Click Button        id:signInBtn

Wait Until Element Is located in the page
    Wait Until element passed is located on Page        ${Error_Message_Login}


Verify error message is correct
    ${result} =  Get Text           ${Error_Message_Login}
    Should Be Equal As Strings      ${result}                  Incorrect username/password.
    Element Text Should Be          ${Error_Message_Login}     Incorrect username/password.

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