#!/usr/bin/env zsh

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
    ttf-jetbrains-mono-nerd ttf-roboto inotify-tools papirus-icon-theme xcursor-breeze

# Install additional dependencies
yay -S wl-clipboard cliphist \
    wofi walker-bin \
    pipewire wireplumber \
    grimshot swappy \
    wf-recorder \
    swaync-git \
    yazi zoxide poppler fd \
    brightnessctl \
    mpv mpv-mpris \
    hyprpicker \
    bluetuith bluez-obex \
    streamlink twitch-cli-bin

# Themes
yay -S socat geticons nwg-look fastfetch
