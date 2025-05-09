packages=(
    bash-completion
    bat
    eza
    fastfetch
    fzf
    ghostty
    git
    git-completion
    hypridle
    hyprland
    hyprlock
    hyprpaper
    lazydocker
    lazygit
    mako
    starship
    stow
    tar
    tmux
    trash-cli
    tree
    unzip
    waybar
    wofi
    yazi
    zoxide
)

sudo apt update && sudo apt upgrade && sudo apt install "${packages[@]}"

