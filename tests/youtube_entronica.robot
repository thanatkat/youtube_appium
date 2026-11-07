*** Settings ***
Documentation     Search Entronica -> channel -> Videos tab -> compare first video title with watch page title
Library           AppiumLibrary    timeout=20
Library           String

Resource          ../pages/search_page.robot
Resource          ../pages/channel_page.robot
Resource          ../pages/video_page.robot

Suite Setup       Open YouTube Application
Suite Teardown    Close All Applications
Test Teardown     Run Keyword If Test Failed    Log Source

*** Variables ***
${APPIUM_SERVER}     http://127.0.0.1:4723
${APP_PACKAGE}       com.google.android.youtube
${APP_ACTIVITY}      com.google.android.apps.youtube.app.WatchWhileActivity

${CHANNEL_NAME}      Entronica
${SEARCH_NAME}       Entronica

*** Test Cases ***
Verify Entronica First Video Title
    [Documentation]    First video title in Videos tab must equal the title on the watch page.

    Click Search
    Search Channel    ${SEARCH_NAME}

    Verify Channel Result    ${CHANNEL_NAME}
    Open Channel

    Open Videos Tab
    Validate Video Count

    ${expected_title}=    Open First Video
    Log To Console    \nEXPECTED (list): ${expected_title}

    Verify Video Title    ${expected_title}

    Capture Page Screenshot

*** Keywords ***
Open YouTube Application
    Open Application    ${APPIUM_SERVER}
    ...    automationName=UiAutomator2
    ...    platformName=Android
    ...    appPackage=${APP_PACKAGE}
    ...    appActivity=${APP_ACTIVITY}
    ...    noReset=${True}
    ...    forceAppLaunch=${True}
    ...    shouldTerminateApp=${True}
    ...    newCommandTimeout=300