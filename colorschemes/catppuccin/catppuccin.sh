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
        wallpaper set "${PWD}/wallpapers/black-hole.png"
    fi

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    if cmd_exists "fish"; then
        fish -c "fisher install catppuccin/fish"
        fish -c "fish_config theme save \"Catppuccin Macchiato\""
    fi

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # Catppuccin for Bat
    # see: https://github.com/catppuccin/bat

    if cmd_exists "bat"; then
        git clone https://github.com/catppuccin/bat ~/.config/bat/catppuccin

        cd ~/.config/bat/catppuccin || exit 1

        mkdir -p "$(bat --config-dir)/themes"

        cp ./*.tmTheme "$(bat --config-dir)/themes"

        bat cache --build
    fi

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # Catppuccin for lazygit
    # see: https://github.com/catppuccin/lazygit

    if cmd_exists "lazygit"; then
        git clone https://github.com/catppuccin/lazygit ~/.config/lazygit/catppuccin

        cd ~/.config/lazygit/catppuccin || exit 1

        config_dir="$(lazygit --config-dir)"

        lazygit --use-config-file="${config_dir}/config.yml,macchiato-blue.yml"
    fi

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # Catppuccin for starship
    # see: https://github.com/catppuccin/starship

    if cmd_exists "starship"; then
        cp starship.toml ~/.config/starship.toml
    fi

}

main
