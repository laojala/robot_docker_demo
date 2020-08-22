*** Settings ***

Documentation       Tests for keyword "Is On Dinosaur List"
...                 Test syntax is Data Driven, which means that the keyword given in "Test Template" 
...                 is run for each input.

Default Tags        tests
Suite Setup         Read Dinosaurs

Resource            keywords/dinosaur_keywords.robot

Test Template       Test Keyword Is On Dinosaur List


*** Test Cases ***          CREATURE        IS_DINOSAUR      
Dinosaur                    erketu          True
Capital Letters             ERKETU          True
Not Dinosaur                cat             False
Not Dinosaur Capital        Cat             False
Last on File                zuul            True
First on File               aachenosaurus   True
Two Words (not on list)     T Rex           False

*** Keywords ***

Test Keyword Is On Dinosaur List
    [Arguments]  ${creature}  ${is_dinosaur}
    ${result}       Is On Dinosaur List   ${creature}
    Should Be True  ${result} == ${is_dinosaur}
