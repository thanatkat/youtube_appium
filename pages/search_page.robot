*** Settings ***
Library    AppiumLibrary
Resource   ../resources/locators/youtube_locators.robot

*** Keywords ***
Click Search
    Dismiss Popups If Any
    Wait Until Element Is Visible    ${SEARCH_BUTTON}    30s
    Click Element    ${SEARCH_BUTTON}

Search Channel
    [Arguments]    ${channel_name}
    Wait Until Element Is Visible    ${SEARCH_INPUT}    15s
    Click Element    ${SEARCH_INPUT}
    Clear Text       ${SEARCH_INPUT}
    Input Text       ${SEARCH_INPUT}    ${channel_name}
    Press Keycode    66

Verify Channel Result
    [Arguments]    ${channel_name}
    Wait Until Element Is Visible    ${CHANNEL_NAME_LOC}    30s

Open Channel
    Wait Until Element Is Visible    ${VIEW_CHANNEL}    20s
    Click Element    ${VIEW_CHANNEL}

Dismiss Popups If Any
    FOR    ${txt}    IN    Not now    Skip    No thanks    Dismiss    Don't allow
        ${xp}=    Set Variable    xpath=//*[@text="${txt}" or @content-desc="${txt}"]
        ${seen}=    Run Keyword And Return Status    Element Should Be Visible    ${xp}
        IF    ${seen}    Click Element    ${xp}
    END