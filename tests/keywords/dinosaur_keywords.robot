*** Settings ***

Library             OperatingSystem
Library             String


*** Keywords ***

Read Dinosaurs
    [Documentation]     Reads dinosaur.csv to a suite level variable
    ${file}     Get File        ../tests/data/dinosaur.csv
    @{list}     Split To Lines  ${file}
    Set Suite Variable          @{DINOSAUR_LIST}    @{list}

Fail If Creature Not Given
    [Arguments]         ${creature}
    Should Not Be Empty         ${creature}         Creature name is empty

Is On Dinosaur List
    [Arguments]         ${creature}
    Fail If Creature Not Given  ${creature}
    ${is_on_list}       Run Keyword And Return Status    Should Contain     ${DINOSAUR_LIST}   ${{ '${creature}'.lower() }}
    [Return]  ${is_on_list}

Should Be On Dinosaur List
    [Arguments]         ${creature}
    ${is_dinosaur}      Is On Dinosaur List     ${creature}
    Should Be True      ${is_dinosaur}

Should Not Be On Dinosaur List
    [Arguments]         ${creature}
    ${is_dinosaur}      Is On Dinosaur List     ${creature}
    Should Be True      ${is_dinosaur} == False