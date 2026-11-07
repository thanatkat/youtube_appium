
*** Settings ***
Library    AppiumLibrary

*** Keywords ***
Click Element With Fallback
    [Arguments]    ${primary_locator}    ${fallback_xpath}

    ${is_visible}=    Run Keyword And Return Status
    ...    Wait Until Element Is Visible
    ...    ${primary_locator}
    ...    timeout=5s

    IF    ${is_visible}
        Click Element    ${primary_locator}
    ELSE
        Wait Until Element Is Visible
        ...    ${fallback_xpath}
        ...    timeout=10s

        Click Element    ${fallback_xpath}
    END
