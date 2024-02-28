*** Settings ***
Documentation    All the page objects and keywords of landing page
Library          SeleniumLibrary
Library          Collections
Resource        ../PO/LandingPage.robot

*** Variables ***
${Shop_page_load}           xpath://a[@class='nav-link btn btn-primary']

*** Keywords ***
Wait Until Element Is located in the page
    Wait Until element passed is located on Page        ${Shop_page_load}

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