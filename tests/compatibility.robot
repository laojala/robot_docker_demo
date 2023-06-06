*** Settings ***
Documentation     My First Test Suite
Library           SeleniumLibrary

*** Variables ***
${URL}            https://s.gptfu.com
${Browser1}        Chrome
${Browser2}        edge
${Browser3}        firefox
${Browser4}        brave
${Browser4}        safari

*** Test Cases ***
Chrome test
    Open Browser  ${URL}  ${BROWSER1}
    Close Browser
Edge test
    Open Browser  ${URL}  ${BROWSER2}
    Close Browser
firefox test
    Open Browser  ${URL}  ${BROWSER3}
    Close Browser
Brave test
    Open Browser  ${URL}  ${BROWSER4}
    Close Browser
Safari test
    Open Browser  ${URL}  ${BROWSER5}
    Close Browser

