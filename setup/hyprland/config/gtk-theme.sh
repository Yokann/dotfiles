if [ ! -d "$HOME/.themes/Catppuccin-Macchiato-Lavender-Dark" ]; then
    rm -rf /tmp/gtk-catppuccin
    git clone https://github.com/Fausto-Korpsvart/Catppuccin-GTK-Theme.git /tmp/gtk-catppuccin
    /tmp/gtk-catppuccin/themes/install.sh --tweaks macchiato -a lavender -m dark --libadwaita
fi

mkdir -p $HOME/.config/qt6ct/colors
if [ ! -f "$HOME/.config/qt6ct/colors/catppuccin-macchiato-lavender.conf" ]; then
    wget https://github.com/catppuccin/qt5ct/raw/refs/heads/main/themes/catppuccin-macchiato-lavender.conf \
        -O $HOME/.config/qt6ct/colors/catppuccin-macchiato-lavender.conf
fi
