# Install additional dependencies for theme
yay -S --noconfirm --norebuild --needed \
    wofi walker-bin \
    elephant elephant-clipboard elephant-menus elephant-runner elephant-desktopapplications \
    elephant-symbols elephant-unicode elephant-websearch elephant-archlinuxpkgs elephant-providerlist \
    swappy \
    wf-recorder \
    swaync-git \
    mpv mpv-mpris \
    hyprpicker \
    streamlink twitch-cli-bin \
    ttf-jetbrains-mono-nerd \
    ttf-roboto \
    ttf-firacode-nerd \
    papirus-icon-theme \
    xcursor-breeze \
    phinger-cursors \
    noto-fonts-emoji \
    cantarell-fonts

# Themes
# Install GTK themes https://github.com/Fausto-Korpsvart/Catppuccin-GTK-Theme
yay -S --noconfirm --norebuild --needed \
    gnome-theme-extra sassc murrine-engine gtk-engine-murrine

