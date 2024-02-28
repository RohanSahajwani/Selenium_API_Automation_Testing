*** Settings ***
Documentation    A resource file with reusable keywords and variables.
...
...              The system specific keywords created here from our own
...              domain specific language. They utilize keywords provided
...              by the imported SeleniumLibrary.
Library          SeleniumLibrary

*** Variables ***
${user_name}                rahulshettyacademy
${valid_password}           learning
${invalid_password}         123456789
${base_url}                 https://rahulshettyacademy.com/loginpagePractise/
${shop_url}                 https://rahulshettyacademy.com/angularpractice/shop
${document_request_url}     https://rahulshettyacademy.com/documents-request
${browser_name}             Chrome

*** Keywords ***
Open the browser with the Mortgage payment url
    Create Webdriver    Chrome
    Go To               ${base_url}

Open the browser with the url
    Create Webdriver    ${browser_name}
    Go To               ${base_url}

Close Browser session
    Close Browser

Wait Until element passed is located on Page
    [Arguments]     ${page_locator}
    Wait Until Element Is Visible       ${page_locator}     timeout=10s