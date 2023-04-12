*** Settings ***
Documentation     Example test cases using the keyword-driven testing approach.
...
...               All tests contain a workflow constructed from keywords in
...               ``CalculatorLibrary.py``. Creating new tests or editing
...               existing is easy even for people without programming skills.
...
...               The _keyword-driven_ appoach works well for normal test
...               automation, but the _gherkin_ style might be even better
...               if also business people need to understand tests. If the
...               same workflow needs to repeated multiple times, it is best
...               to use to the _data-driven_ approach.
Library           CalculatorLibrary.py

*** Test Cases ***
Push button
    Push button    1
    Result should be    1

Push multiple buttons
    Push button    1
    Push button    2
    Result should be    12

Simple calculation modified
    Push button    1
    Push button    *
    Push button    9
    Push button    =
    Result should be    9

Longer calculation
    Push buttons    5 + 4 - 3 * 2 / 1 =
    result should be    3

Calculate this hard expression
    Push buttons        1 + 2 * 3= 
    Result should be    7


Clear
    Push button     1
    Push button     C
    Result should be    ${EMPTY}    # ${EMPTY} is a built-in variable

Divide By Zero Should Fail
    Push buttons    1 / 0 
    should cause error      invalid


Test that all buttons return the same value clicked 
    @{buttons}=    create list    1    2    3    4    5    6    7    8    9    0
    FOR    ${button}    IN    @{buttons}
        Log   ${button}
        Push button         ${button}
        Result should be    ${button}
        Push button         C
    END