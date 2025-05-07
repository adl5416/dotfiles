#!/bin/bash

set -e

stow_packages=(
    backgrounds
    bash
    ghostty
    git
    hypridle
    hyprland
    hyprlock
    hyprpaper
    mako
    nvim
    starship
    tmux
    waybar
    wofi
)

for package in "${stow_packages[@]}"; do
    stow "$package" -t ~
done
