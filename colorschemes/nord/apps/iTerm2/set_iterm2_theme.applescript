#!/usr/bin/osascript

tell application "iTerm"

    set themeName to "Nord"
    set appName to "iTerm2"

    -- Define the paths to the custom theme file
    set homePath to POSIX path of (path to home folder)
    set setMeUpPath to homePath & "set-me-up"
    set dotfilesPath to setMeUpPath & "/dotfiles"
    set modulesPath to dotfilesPath & "/modules"
    set preferencesPath to modulesPath & "/macos/preferences"
    set colorschemesPath to preferencesPath & "/colorschemes"
    set nordPath to colorschemesPath & "/nord"
    set itermPath to nordPath & "/apps/iterm2"
    set themesPath to itermPath & "/themes"
    set themeFilePath to themesPath & "/" & themeName & ".itermcolors"

    -- Print the theme file path for debugging purposes
    # display dialog "Theme file path: " & themeFilePath

    -- Verify the theme file exists
    do shell script "if [ ! -f \"" & themeFilePath & "\" ]; then echo \"Theme file not found\"; exit 1; fi"

    -- Open the custom theme
    do shell script "open '" & themeFilePath & "'"

    -- Wait a little bit to ensure that the custom theme is added
    delay 1

    -- Iterate over all open windows and their tabs to apply the theme
    repeat with aWindow in windows
        repeat with aTab in tabs of aWindow
            repeat with aSession in sessions of aTab
                tell aSession
                    -- Set the color preset to the custom theme
                    try
                        set color preset to themeName
                    on error errMsg number errNum
                        display dialog "Error " & errNum & ": " & errMsg
                    end try
                end tell
            end repeat
        end repeat
    end repeat

end tell
