#!/bin/bash

# shellcheck source=/dev/null

declare current_dir &&
    current_dir="$(dirname "${BASH_SOURCE[0]}")" &&
    cd "${current_dir}" &&
    source "$HOME/set-me-up/dotfiles/utilities/utilities.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

    brew_bundle_install -f "brewfile"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    if brew info wallpaper &>/dev/null; then
        wallpaper set "${PWD}/wallpapers/grassland.jpg"
    fi

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    if cmd_exists "fish"; then
        fish -c "fisher install Jomik/fish-gruvbox"
        fish -c "fish_config theme save \"Gruvbox Dark\""
    fi

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # Gruvbox for Bat
    # see: https://github.com/peaceant/gruvbox-material-bat

    if cmd_exists "bat"; then
        git clone https://github.com/peaceant/gruvbox-material-bat ~/.config/bat/gruvbox

        cd ~/.config/bat/gruvbox || exit 1

        mkdir -p "$(bat --config-dir)/themes"

        cp ./*.tmTheme "$(bat --config-dir)/themes"

        bat cache --build
    fi

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # Gruvbox for starship
    # see: https://starship.rs/presets/gruvbox-rainbow

    if cmd_exists "starship"; then
        cp starship.toml ~/.config/starship.toml
    fi

}

main
