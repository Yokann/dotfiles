#!/usr/bin/env bash

# https://github.com/natpen/awesome-wayland

# Install hyprland and core dependencies
yay -S hyprland hyprcursor \
    wdisplays \
    foot \
    foot-terminfo \
    waybar \
    sworkstyle \
    mako-git \
    wev \
    xdg-desktop-portal-wlr \
    polkit-gnome \
    pcmanfm-gtk3 \
    playerctl \
    network-manager \
    network-manager-applet \
    gvfs gvfs-smb \
    gnome-keyring \
    liboauth \
    greetd-tuigreet \
    font-manager

# Install additional dependencies
yay -S wl-clipboard cliphist \ # clipboard
    pipewire wireplumber \ # audio
    grimshot swappy \ # screenshot
    wf-recorder \ # screen recording
    swaylock-effects-git \ # lockscreen
    swww \ # wallpaper 
    swayidle-git \ # idle
    swaync-git \ # notification
    yazi \ # tui file manager
    brightnessctl \ # brightness
    mpv mpv-mpris \ # video player
    streamlink  # openstream in mpv

# Themes
yay -S socat geticons nwg-look
