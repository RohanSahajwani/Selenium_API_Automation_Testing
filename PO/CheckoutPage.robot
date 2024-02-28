*** Settings ***
Documentation    All the page objects and keywords of landing page
Library          SeleniumLibrary

*** Variables ***
${Shop_page_load}           xpath://a[@class='nav-link btn btn-primary']

*** Keywords ***
Verify items in the Checkout Page and proceed
    Click Element    css:button[class='btn btn-success']
