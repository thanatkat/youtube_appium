*** Settings ***
Library    AppiumLibrary
Library    String
Resource   ../resources/locators/youtube_locators.robot

*** Keywords ***
Open First Video
    Wait Until Element Is Visible    ${FIRST_VIDEO}    30s
    ${desc}=    Get Element Attribute    ${FIRST_VIDEO}    content-desc
    ${title}=    Extract Title    ${desc}
    Log    Raw list desc: ${desc}
    Log    List title: ${title}
    Click Element    ${FIRST_VIDEO}
    RETURN    ${title}

Get Playing Video Title
    [Arguments]    ${expected_title}
    Wait Until Element Is Visible    ${WATCH_LIST}    30s
    Run Keyword And Ignore Error
    ...    Wait Until Page Does Not Contain Element    ${WATCH_LOADING}    20s
    Sleep    3s

    # Strategy 1: title row exposes content-desc (or text) once loaded
    ${desc}=    Get Element Attribute    ${PLAYER_TITLE}    content-desc
    ${text}=    Get Text    ${PLAYER_TITLE}
    ${desc_blank}=    Is Blank Value    ${desc}
    ${text_blank}=    Is Blank Value    ${text}
    IF    not ${text_blank}
        ${title}=    Extract Title    ${text}
        RETURN    ${title}
    ELSE IF    not ${desc_blank}
        ${title}=    Extract Title    ${desc}
        RETURN    ${title}
    END
    Log    Strategy 1 found nothing (desc=${desc}, text=${text})    WARN

    # Strategy 2: open description panel, look for the expected title
    Click Element    ${PLAYER_TITLE}
    Run Keyword And Ignore Error    Wait Until Element Is Visible    ${DESC_PANEL}    8s
    Sleep    2s
    ${xp}=    Set Variable
    ...    xpath=//*[contains(@text,"${expected_title}") or contains(@content-desc,"${expected_title}")]
    ${found}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${xp}    8s
    IF    ${found}
        ${d}=    Get Element Attribute    ${xp}    content-desc
        ${t}=    Get Text    ${xp}
        ${t_blank}=    Is Blank Value    ${t}
        ${raw2}=    Set Variable If    not ${t_blank}    ${t}    ${d}
        ${title}=    Extract Title    ${raw2}
        RETURN    ${title}
    END
    Log    Strategy 2 found nothing    WARN

Is Blank Value
    [Arguments]    ${value}
    ${blank}=    Evaluate    str($value).strip().lower() in ('', 'none', 'null')
    RETURN    ${blank}

Verify Video Title
    [Arguments]    ${expected_title}
    ${actual_title}=    Get Playing Video Title    ${expected_title}
    ${a}=    Normalize Title    ${actual_title}
    ${b}=    Normalize Title    ${expected_title}
    Log To Console    ACTUAL (watch) : ${actual_title}
    Should Be Equal As Strings    ${a}    ${b}    Titles do not match!

Extract Title
    [Arguments]    ${desc}
    # cut at first " - <duration>", " - <n> views" or " - Go to channel"
    ${title}=    Evaluate
    ...    re.split(r' - (?=\\d+ (?:hours?|minutes?|seconds?)|\\d[\\d.,]*\\s?[KMB]? views|Go to channel)', $desc, 1)[0].strip()
    ...    modules=re
    RETURN    ${title}

Normalize Title
    [Arguments]    ${text}
    ${n}=    Evaluate    ' '.join($text.split()).strip().lower()
    RETURN    ${n}