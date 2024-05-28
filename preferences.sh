#!/bin/bash

# shellcheck source=/dev/null

declare current_dir &&
    current_dir="$(dirname "${BASH_SOURCE[0]}")" &&
    cd "${current_dir}" &&
    source <(curl -s "https://raw.githubusercontent.com/dotbrains/utilities/master/utilities.sh")

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
main() {

    # Check if OS is Debian
    if ! is_debian; then
        error "This script is only for Debian!"
        return 1
    fi

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # Colorschems

    # Nord
    ./colorschemes/nord.sh

    # Catppuccin
    # ./colorschemes/catppuccino.sh

}

main
