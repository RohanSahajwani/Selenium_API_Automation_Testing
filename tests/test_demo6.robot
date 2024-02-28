*** Settings ***
Documentation   To validate the Login form
Library         SeleniumLibrary
Library         Collections
Library         ../customLibraries/Shop.py
Test Setup      Open the browser with the url
Suite Setup
Suite Teardown
Test Teardown   Close Browser session
Resource        ../PO/Generic.robot
Resource        ../PO/LandingPage.robot
Resource        ../PO/ShopPage.robot
Resource        ../PO/CheckoutPage.robot
Resource        ../PO/ConfirmationPage.robot


*** Variables ***
@{listOfProducts}           Blackberry      Nokia Edge      Samsung Note 8      iphone X
${country_name}             Armenia

*** Test Cases ***
Validate UnSuccessfull Login
    [Tags]    SMOKE
    LandingPage.Fill the login Form     ${user_name}    ${invalid_password}
    LandingPage.Wait Until Element Is located in the page
    LandingPage.Verify error message is correct

Validate Cards display in the Shopping Page
    [Tags]    END2END
    LandingPage.Fill The Login Form     ${user_name}    ${valid_password}
    ShopPage.Wait Until Element Is located in the page
    ShopPage.Verify Card titles in the Shop page
    Add Items To Card And Checkout      ${listOfProducts}
    CheckoutPage.Verify items in the Checkout Page and proceed
    ConfirmationPage.Enter the Country and select the terms     ${country_name}
    ConfirmationPage.Purchase the Product and Confirm the Purchase

Select the Form and navigate to Child window
    LandingPage.Fill The Login Details and Login Form
