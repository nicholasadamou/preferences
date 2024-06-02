#!/bin/bash

source "$HOME/set-me-up/dotfiles/utilities/utilities.sh"

ask_for_sudo

# Customize Security & Privacy Settings in macOS:

# Use Touch ID to authenticate sudo commands
# https://apple.stackexchange.com/a/466029

# Check if the line is already uncommented in /etc/pam.d/sudo_local
if ! grep -q "^auth" /etc/pam.d/sudo_local; then
    sed "s/^#auth/auth/" /etc/pam.d/sudo_local.template | sudo tee /etc/pam.d/sudo_local >/dev/null
fi
