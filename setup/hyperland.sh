#!/usr/bin/env zsh

set -ex -o pipefail

# https://github.com/natpen/awesome-wayland

# Install hyprland and core dependencies
yay -S hyprland hyprcursor \
    wdisplays \
    foot \
    foot-terminfo \
    waybar \
    sworkstyle \
    wev \
    xdg-desktop-portal-hyprland \
    polkit-gnome \
    pcmanfm-gtk3 \
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
    ttf-jetbrains-mono-nerd ttf-roboto inotify-tools papirus-icon-theme xcursor-breeze noto-fonts-emoji

# Install additional dependencies
yay -S wl-clipboard cliphist \
    wofi walker-bin \
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
    rclone \
    nomacs

# Themes
yay -S socat geticons nwg-look fastfetch 
# Install GTK themes https://github.com/Fausto-Korpsvart/Catppuccin-GTK-Theme
yay -S sassc gtk-engine-murrine

# if option argument is passed, install the optionnal dependencies
if [[ $1 == "--optional" ]]; then
    yay -S discord ticktick cryptomator-bin signal-desktop 1password 1password-cli
fi

if [[ command -v cargo ]]; then
    cargo install pomodoro-cli twitch-tui
else
    echo "Cargo is not installed, skipping pomodoro-cli installation"
fi
