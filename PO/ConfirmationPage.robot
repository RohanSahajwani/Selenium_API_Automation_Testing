*** Settings ***
Documentation    All the page objects and keywords of landing page
Library          SeleniumLibrary
Resource        ../PO/Generic.robot

*** Variables ***
${Shop_page_load}           xpath://a[@class='nav-link btn btn-primary']
${country_name}             xpath://a[text()='Armenia']
${success_text}             Success! Thank you! Your order will be delivered in next few weeks :-).

*** Keywords ***
Enter the Country and select the terms
    [Arguments]      ${country_name}
    Input Text       country       ${country_name}
    Generic.Wait Until element passed is located on Page        xpath://a[text()='${country_name}']
    Click Element    xpath://a[text()='${country_name}']
    Click Element    css:label[for='checkbox2']

Purchase the Product and Confirm the Purchase
    Click Element    css:input[value='Purchase']
    Page Should Contain    ${success_text}
