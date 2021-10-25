*** Comments ***
J'AI REALISE 4 GRANDS TESTS AUTOMATISES SUR LE SITE WEB https://www.saucedemo.com/ EN UTILISANT 
ROBOT FRAMEWORK 4.1.2 SOUS PYTHON 3.10.0 AINSI QUE LA LIBRAIRIE SELENIUMLIBRARY 4.0.0. 
LES TESTS SE DECOMPOSENT COMME SUIT:

UN TEST SUR L'AUTHENTIFICATION D'UN UTILISATEUR AVEC DES INFORMATIONS CORRECTES,
        PUIS UN TEST SUR L'ACHAT D'UN PRODUIT APRES AUTHENTIFICATION;
        PUIS UN AUTRE TEST SUR LA DECONNECTION D'UN UTILISATEUR CONNECTE.

POUR FINIR, UN TEST SUR L'AUTHENTIFICATION D'UN UTILISATEUR DONT LE MOT DE PASSE EST INCORRECTE.

*** Settings ***
Library  SeleniumLibrary
Test Setup    Open Browser    ${appURL}    ${browser}
Test Teardown    Close Browser

*** Variables ***
${appURL}    https://www.saucedemo.com/
${browser}    Chrome



*** Test Cases ***
LoginTest With Valid Credentials
    [Tags]    Smoke
    Maximize Browser Window
    Input Username
    Input Password
    Click On Login Button
    Log To Inventory Page
    Buy a product
    Logout
    
LoginTest With InValid Credentials
    [Tags]    Regression
    Maximize Browser Window
    Input Text    id:user-name    standard_user    
    Input Text    name:password    secret_sauc
    Click Button    xpath://input[@value='Login']
    ${url}    Get Location
    Log To Console    ${url}
    Should Contain    ${url}    inventory
    


*** Keywords ***
Input Username
    Input Text    id:user-name    standard_user
    
Input Password
    Input Text    name:password    secret_sauce
    
Click On Login Button
    Click Button    xpath://input[@value='Login']
    
Log To Inventory Page
    ${url}    Get Location
    Log To Console    ${url}
    Should Contain    ${url}    inventory
    
Buy a product
    Click Button    id:add-to-cart-sauce-labs-backpack
    Click Link    class:shopping_cart_link
    Click Button    id:checkout
    Input Text    name:firstName    Romaric
    Input Text    name:lastName    DEMBELE
    Input Text    name:postalCode    44600
    Click Button    id:continue
    Click Button    id:finish
    ${orderCompleteURL}    Get Location
    Log To Console    ${orderCompleteURL}
    Should Contain    ${orderCompleteURL}    checkout-complete

Logout
    Click Button    id:react-burger-menu-btn
    Sleep    0.3s
    Click Link    id:logout_sidebar_link

