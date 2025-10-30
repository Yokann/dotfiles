# Install yay if missing, install golang on the way
if ! command -v yay &> /dev/null; then
    git clone https://aur.archlinux.org/yay.git /tmp/yay
cd /tmp/yay
    makepkg -si --noconfirm
    cd -
    rm -rf /tmp/yay
fi

# Install rustup if missing
if ! command -v rustup &> /dev/null; then
    yay -S --noconfirm rustup
    rustup default stable
fi

# Install hyprland and core dependencies
yay -S --noconfirm --norebuild --needed \
    1password \
    1password-cli \
    avahi \
    bat \
    bluetuith bluez-obex \
    brightnessctl \
    btop \
    cromite-bin \
    docker \
    docker-buildx \
    docker-compose \
    discord \
    dkms \
    cliphist wl-clipboard \
    cups \
    cups-browsed \
    cups-filters \
    cups-pdf \
    cryptomator-bin \
    eza \
    fastfetch \
    fd \
    firefox \
    foot \
    foot-terminfo \
    font-manager \
    fzf \
    gnome-keyring \
    greetd-tuigreet \
    gvfs gvfs-smb \
    httpie \
    hyprland \
    hyprcursor \
    hypridle \
    hyprlock \
    hyprpaper \
    hyprshot \
    inotify-tools \
    inxi \
    jq \
    scdoc geticons \
    git \
    git-delta \
    gnome-calculator \
    gum \
    lazygit \
    less \
    localsend-bin \
    liboauth \
    lua luarocks \
    mise \
    nemo \
    neovim \
    network-manager-applet \
    nomacs \
    notion-app-electron \
    nwg-look \
    pipewire wireplumber \
    playerctl \
    polkit-gnome \
    poppler \
    qt5-wayland  qt6-wayland \
    qt5ct hyprqt6engine \
    rclone \
    ripgrep \
    seahorse \
    signal-desktop \
    socat \
    starship \
    sqlite \
    sworkstyle \
    ticktick \
    ufw \
    ufw-docker \
    uwsm \
    waybar \
    wdisplays \
    wev \
    xdg-desktop-portal-hyprland \
    yazi \
    zoxide
