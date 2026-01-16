#!/bin/bash

# shellcheck source=/dev/null

# Universal Preferences Configuration
#
# This configuration applies to all operating systems and sets up
# cross-platform preferences and configurations.
#
# @author Nicholas Adamou

declare current_dir &&
    current_dir="$(dirname "${BASH_SOURCE[0]}")" &&
    cd "${current_dir}" || exit

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

    # Cross-platform application preferences
    # TODO: Add preferences for applications that work across all platforms
    # Examples: VS Code, Git, shell configurations, etc.

    echo "Universal preferences configuration complete"

}

main
