#!/usr/bin/env zsh

set -ex -o pipefail

if [ -z "$DOTFILES_PATH" ]; then
    echo "DOTFILES_PATH is not set. Please set it to the path of your dotfiles dir"
    # sudo echo 'export DOTFILES_PATH=$HOME/.local/share/dotfiles' > /etc/profile.d/dotfiles.sh
    exit 1
fi

# Install yay if missing
if ! command -v yay &> /dev/null; then
    git clone https://aur.archlinux.org/yay.git /tmp/yay
    cd /tmp/yay
    makepkg -si --noconfirm
    cd -
    rm -rf /tmp/yay
fi

# Install rustup if missing
if ! command -v rustup &> /dev/null; then
    yay -S --noconfirm rustup
    rustup default stable
fi

# https://github.com/natpen/awesome-wayland

# Install hyprland and core dependencies
yay -S --noconfirm --norebuild \
    hyprland hyprcursor \
    uwsm \
    wdisplays \
    foot \
    foot-terminfo \
    waybar \
    sworkstyle \
    wev \
    xdg-desktop-portal-hyprland \
    polkit-gnome \
    nemo \
    playerctl \
    network-manager \
    network-manager-applet \
    gvfs gvfs-smb \
    gnome-keyring \
    liboauth \
    greetd-tuigreet \
    font-manager \
    hypridle \
    hyprlock \
    hyprpaper \
    qt5-wayland \
    qt6-wayland \
    ttf-jetbrains-mono-nerd ttf-roboto inotify-tools papirus-icon-theme xcursor-breeze noto-fonts-emoji

# Install additional dependencies
yay -S --noconfirm --norebuild \
    wl-clipboard cliphist \
    wofi walker-bin \
    elephant elephant-clipboard elephant-menus elephant-runner elephant-desktopapplications \
    elephant-symbols elephant-unicode elephant-websearch elephant-archlinuxpkgs elephant-providerlist \
    pipewire wireplumber \
    swappy \
    hyprshot \
    wf-recorder \
    swaync-git \
    yazi zoxide poppler fd \
    brightnessctl \
    mpv mpv-mpris \
    hyprpicker \
    bluetuith bluez-obex overskride-bin \
    streamlink twitch-cli-bin \
    firefox \
    rclone \
    nomacs

# Themes
yay -S --noconfirm --norebuild socat geticons nwg-look fastfetch
# Install GTK themes https://github.com/Fausto-Korpsvart/Catppuccin-GTK-Theme
yay -S --noconfirm --norebuild sassc gtk-engine-murrine

# if option argument is passed, install the optionnal dependencies
if [[ $1 == "--optional" ]]; then
    yay -S --noconfirm --norebuild discord ticktick cryptomator-bin signal-desktop 1password 1password-cli
fi

if command -v cargo &> /dev/null; then
    cargo install pomodoro-cli twitch-tui
else
    echo "Cargo is not installed, skipping pomodoro-cli installation"
fi
