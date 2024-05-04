#!/usr/bin/env bash

# https://github.com/natpen/awesome-wayland

# Install hyprland and core dependencies
yay -S hyprland wdisplays foot foot-terminfo waybar sworkstyle mako-git wev xdg-desktop-portal-wlr
# xdg-desktop-portal-hyprland-git

# Install additional dependencies
yay -S wl-clipboard cliphist \ # clipboard
    pipewire wireplumber \ # audio
    grimshot swappy \ # screenshot
    wf-recorder \ # screen recording
    swaylock-effects-git \ # lockscreen
    swww \ # wallpaper 
    swayidle-git \ # idle
    swaync-git \ # notification
    brightnessctl # brightness

# Themes
yay -S socat geticons
