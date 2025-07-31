packages=(
    bash-completion
    bat
    btop
    eza
    fastfetch
    fd
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
    ouch
    starship
    stow
    tar
    tmux
    trash-cli
    tree
    unzip
    uwsm
    waybar
    wofi
    yazi
    zoxide
)

sudo apt update && sudo apt upgrade && sudo apt install "${packages[@]}"

