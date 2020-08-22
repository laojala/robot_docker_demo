*** Settings ***

Documentation       Gets two creatures DINOSAUR and NOT_DINOSAUR as input and tests
...                 if those are dinosaur by comparing name to an attached list.
...                 Syntax for giving variables in robot startup script:
...                 -v DINOSAUR:Achillobator -v NOT_DINOSAUR:Ptreranodon

Default Tags        dinosaur
Suite Setup         Read Dinosaurs

Resource            keywords/dinosaur_keywords.robot

*** Variables ***

${DINOSAUR}
${NOT_DINOSAUR}

*** Test Cases  ***

${DINOSAUR} Should Be Dinosaur
    [Tags]  is_dinosaur
    Should Be On Dinosaur List      ${DINOSAUR}

${NOT_DINOSAUR} Shoud Not Be Dinosaur
    [Tags]  not_dinosaur
    Should Not Be On Dinosaur List  ${NOT_DINOSAUR} 
