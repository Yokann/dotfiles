yay -S --noconfirm --norebuild --needed \
    1password \
    1password-cli \
    cryptomator-bin \
    discord \
    firefox \
    gnome-calculator \
    helium-browser-bin \
    httpie \
    lazygit \
    lazyjournal-bin \
    localsend \
    mpv mpv-mpris \
    nemo \
    seahorse \
    signal-desktop \
    ticktick \
    wayscriber \
    wiki-tui

if command -v luarocks &> /dev/null; then
    luarocks install --local dkjson
else
    echo "Luarocks is not installed, skipping installation"
fi
