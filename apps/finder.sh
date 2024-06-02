#!/bin/bash

# Customize Finder Preferences and Views on macOS:

# Set Documents as the Default Location for New Finder Windows
defaults write com.apple.finder NewWindowTarget -string "PfDo"
defaults write com.apple.finder NewWindowTargetPath -string "file://${HOME}/Documents/"

# Show Icons for Various Drives on the Desktop
defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true
defaults write com.apple.finder ShowHardDrivesOnDesktop -bool true
defaults write com.apple.finder ShowMountedServersOnDesktop -bool true
defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool true

# Finder: Show All Filename Extensions
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# Finder: Show Status Bar
defaults write com.apple.finder ShowStatusBar -bool true

# Finder: Allow Text Selection in Quick Look
defaults write com.apple.finder QLEnableTextSelection -bool true

# Display Full POSIX Path as Finder Window Title
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true

# Set Default Search Scope to Current Folder
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

# Disable Warning When Changing a File Extension
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

# Enable Spring Loading for Directories
defaults write NSGlobalDomain com.apple.springing.enabled -bool true

# Reduce Spring Loading Delay for Directories
defaults write NSGlobalDomain com.apple.springing.delay -float 0.1

# Avoid Creating .DS_Store Files on Network Volumes
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true

# Enable Snap-to-Grid for Icons
# The following commands use PlistBuddy to modify Finder's preferences file directly.
# They set icon arrangement to a grid layout on the desktop and in other icon views.
/usr/libexec/PlistBuddy -c "Add :DesktopViewSettings:IconViewSettings:arrangeBy string grid" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Add :FK_StandardViewSettings:IconViewSettings:arrangeBy string grid" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Add :StandardViewSettings:IconViewSettings:arrangeBy string grid" ~/Library/Preferences/com.apple.finder.plist

# Set the Size of Icons
# These commands set the icon size to 64x64 pixels on the desktop and in other icon views.
/usr/libexec/PlistBuddy -c "Add :DesktopViewSettings:IconViewSettings:iconSize integer 64" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Add :FK_StandardViewSettings:IconViewSettings:iconSize integer 64" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Add :StandardViewSettings:IconViewSettings:iconSize integer 64" ~/Library/Preferences/com.apple.finder.plist

# Use Column View in All Finder Windows by Default
defaults write com.apple.finder FXPreferredViewStyle -string "clmv"

# Show the ~/Library Folder
chflags nohidden ~/Library

killall "Finder" &>/dev/null

# Starting with Mac OS X Mavericks preferences are cached,
# so in order for things to get properly set using `PlistBuddy`,
# the `cfprefsd` process also needs to be killed.
#
# https://github.com/alrra/dotfiles/commit/035dda057ddc6013ba21db3d2c30eeb51ba8f200

killall "cfprefsd" &>/dev/null
