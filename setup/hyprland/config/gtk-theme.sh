if [ ! -d "$HOME/.themes/Catppuccin-Purple-Dark-Macchiato" ]; then
    git clone https://github.com/Fausto-Korpsvart/Catppuccin-GTK-Theme.git /tmp/gtk-catppuccin
    /tmp/gtk-catppuccin/themes/install.sh --tweaks macchiato -t lavender
    rm -rf /tmp/gtk-catppuccin
fi
