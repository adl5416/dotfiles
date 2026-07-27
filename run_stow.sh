#!/bin/bash

set -e

stow_packages=(
    backgrounds
    bash
    claude
    ghostty
    git
    herdr
    hypridle
    hyprland
    hyprlock
    hyprpaper
    kiro
    mako
    nvim
    starship
    tmux
    waybar
    wofi
    yazi
)

for package in "${stow_packages[@]}"; do
    stow "$package" -t ~
done
