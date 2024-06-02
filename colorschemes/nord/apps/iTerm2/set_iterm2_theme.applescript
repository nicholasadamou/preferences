#!/usr/bin/osascript

tell application "iTerm2"
    
    set themeName to "Nord"

    -- Define the paths to the custom theme file
    set homePath to POSIX path of (path to home folder)
    set setMeUpPath to homePath & "set-me-up"
    set dotfilesPath to setMeUpPath & "/dotfiles"
    set modulesPath to dotfilesPath & "/modules"
    set preferencesPath to modulesPath & "/macos/preferences"
    set themeFilePath to preferencesPath & "/colorschemes/nord/themes/" & themeName & ".itermcolors"

    (* Verify the theme file exists *)
    do shell script "if [ ! -f \"" & themeFilePath & "\" ]; then echo \"Theme file not found\"; exit 1; fi"

    (* Open the custom theme. This assumes that the theme file is in a 'themes' folder
       relative to the current path. Adjust the path as necessary. *)
    do shell script "open '" & themeFilePath & "'"

    (* Wait a little bit to ensure that the custom theme is added.
       Adjust the delay as necessary. *)
    delay 1

    (* Iterate over all open windows and their tabs to apply the theme. *)
    repeat with aWindow in windows
        repeat with aTab in tabs of aWindow
            repeat with aSession in sessions of aTab
                tell aSession
                    (* Set the color preset to the custom theme. *)
                    set color preset to themeName
                end tell
            end repeat
        end repeat
    end repeat

end tell
