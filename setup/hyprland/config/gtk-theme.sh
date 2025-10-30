if [ ! -d "$HOME/.themes/Catppuccin-Lavender-Dark-Macchiato" ]; then
    git clone https://github.com/Fausto-Korpsvart/Catppuccin-GTK-Theme.git /tmp/gtk-catppuccin
    /tmp/gtk-catppuccin/themes/install.sh --tweaks macchiato -t lavender
    rm -rf /tmp/gtk-catppuccin
fi

mkdir -p $HOME/.config/qt5ct/colors
mkdir -p $HOME/.config/qt6ct/colors
if [ ! -f "$HOME/.config/qt5ct/colors/catppuccin-macchiato-lavender.conf" ]; then
    wget https://github.com/catppuccin/qt5ct/raw/refs/heads/main/themes/catppuccin-macchiato-lavender.conf \
    -O $HOME/.config/qt5ct/colors/catppuccin-macchiato-lavender.conf
    cp $HOME/.config/qt5ct/colors/catppuccin-macchiato-lavender.conf \
        $HOME/.config/qt6ct/colors/catppuccin-macchiato-lavender.conf
fi
