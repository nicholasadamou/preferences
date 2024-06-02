#!/usr/bin/osascript

tell application "Terminal"

    local allOpenedWindows
    local initialOpenedWindows
    local windowID

    set themeName to "Nord"
    set appName to "Terminal"
    
    -- Convert appName to lowercase
    set appNameLowercase to do shell script "echo " & appName & " | tr '[:upper:]' '[:lower:]'"

    -- Define the paths to the custom theme file
    set homePath to POSIX path of (path to home folder)
    set setMeUpPath to homePath & "set-me-up"
    set dotfilesPath to setMeUpPath & "/dotfiles"
    set modulesPath to dotfilesPath & "/modules"
    set preferencesPath to modulesPath & "/macos/preferences"
    set colorschemesPath to preferencesPath & "/colorschemes"
    set nordPath to colorschemesPath & "/nord"
    set terminalPath to nordPath & "/apps/" & appNameLowercase
    set themesPath to terminalPath & "/themes"
    set themeFilePath to themesPath & "/" & themeName & ".terminal"

    -- Print the theme file path for debugging purposes
    # display dialog "Theme file path: " & themeFilePath

    (* Verify the theme file exists *)
    do shell script "if [ ! -f \"" & themeFilePath & "\" ]; then echo \"Theme file not found\"; exit 1; fi"

    (* Store the IDs of all the open terminal windows. *)
    set initialOpenedWindows to id of every window

    (* Open the custom theme so that it gets added to the list
       of available terminal themes (note: this will open two
       additional terminal windows). *)
    do shell script "open '" & themeFilePath & "'"

    (* Wait a little bit to ensure that the custom theme is added. *)
    delay 1

    (* Set the custom theme as the default terminal theme. *)
    set default settings to settings set themeName

    (* Get the IDs of all the currently opened terminal windows. *)
    set allOpenedWindows to id of every window

    repeat with windowID in allOpenedWindows

        (* Close the additional windows that were opened in order
           to add the custom theme to the list of terminal themes. *)
        if initialOpenedWindows does not contain windowID then
            close (every window whose id is windowID)

        (* Change the theme for the initial opened terminal windows
           to remove the need to close them in order for the custom
           theme to be applied. *)
        else
            set current settings of tabs of (every window whose id is windowID) to settings set themeName
        end if

    end repeat

end tell
