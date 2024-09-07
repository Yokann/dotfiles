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
    font-manager \
    hypridle \
    hyprlock \
    hyprpaper

# Install additional dependencies
yay -S wl-clipboard cliphist \ # clipboard
    wofi walker-bin \ # rofi alternative
    pipewire wireplumber \ # audio
    grimshot swappy \ # screenshot
    wf-recorder \ # screen recording
    swaync-git \ # notification
    yazi zoxide poppler fd \ # tui file manager
    brightnessctl \ # brightness
    mpv mpv-mpris \ # video player
    hyprpicker \ # color picker
    streamlink  # openstream in mpv

# Themes
yay -S socat geticons nwg-look
