*** Variables ***
# ---------- SEARCH ----------
${SEARCH_BUTTON}
...    xpath=//*[@content-desc='Search' or @content-desc='Search YouTube' or @resource-id='com.google.android.youtube:id/menu_item_1']

${SEARCH_INPUT}
...    id=com.google.android.youtube:id/search_edit_text

${SEARCH_INPUT_XPATH}
...    xpath=//android.widget.EditText

${SEARCH_SUBMIT}
...    accessibility_id=Search

# ---------- SEARCH RESULT - CHANNEL ----------
${CHANNEL_NAME_LOC}
...    xpath=//*[contains(@text,'Entronica') or contains(@content-desc,'Entronica')]

${VIEW_CHANNEL}
...    xpath=(//*[@content-desc='View Channel' or (contains(@content-desc,'Entronica') and contains(@content-desc,'subscribers'))])[1]

# ---------- CHANNEL PAGE ----------
${VIDEOS_TAB}
...    xpath=//*[@text='Videos' or @content-desc='Videos']

${VIDEO_TITLE}
...    xpath=//android.view.ViewGroup[contains(@content-desc,'play video')]

${FIRST_VIDEO}
...    xpath=(//android.view.ViewGroup[contains(@content-desc,'play video')])[1]

# ---------- WATCH PAGE ----------
${WATCH_LOADING}
...    id=com.google.android.youtube:id/video_info_loading_layout

${WATCH_LIST}
...    id=com.google.android.youtube:id/watch_list

${PLAYER_TITLE}
...    xpath=(//*[@resource-id='com.google.android.youtube:id/watch_list']/android.view.ViewGroup)[1]

${DESC_PANEL}
...    id=com.google.android.youtube:id/engagement_panel_wrapper