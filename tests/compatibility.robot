*** Settings ***
Documentation     My First Test Suite
Library           SeleniumLibrary

*** Variables ***
${URL}            https://google.com
${Browser1}        Chrome


*** Test Cases ***
Chrome test
    Open Browser  ${URL}  ${BROWSER1}
    Close Browser


