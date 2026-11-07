*** Settings ***
Library    AppiumLibrary
Resource   ../resources/locators/youtube_locators.robot

*** Keywords ***
Open Videos Tab
    Wait Until Element Is Visible    ${VIDEOS_TAB}    20s
    Click Element    ${VIDEOS_TAB}
    Wait Until Element Is Visible    ${FIRST_VIDEO}    30s

Validate Video Count
    ${videos}=    Get Webelements    ${VIDEO_TITLE}
    ${count}=    Get Length    ${videos}
    Log    Total videos: ${count}
    Should Be True    ${count} >= 1    Expected at least 1 video, but found ${count}