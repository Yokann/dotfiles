sudo pacman -S fakeroot base-devel --noconfirm

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
    acpi \
    acpid \
    avahi \
    bat \
    bind \
    bluez-utils \
    bluetuith bluez-obex \
    brightnessctl \
    btop \
    btrfs-progs \
    cronie \
    docker \
    docker-buildx \
    docker-compose \
    device-mapper \
    dhclient \
    discord \
    dnsmasq \
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
    ffmpegthumbnailer \
    firefox \
    foot \
    foot-terminfo \
    font-manager \
    fzf \
    gnome-keyring \
    greetd-tuigreet \
    gvfs gvfs-smb \
    httpie \
    helium-browser-bin \
    hyprland \
    hyprcursor \
    hypridle \
    hyprlock \
    hyprpaper \
    hyprshot \
    inetutils \
    inotify-tools \
    inxi \
    jq \
    scdoc geticons \
    git \
    git-delta \
    gnome-calculator \
    gum \
    lazygit \
    lazyjournal-bin \
    less \
    localsend-bin \
    logrotate \
    liboauth \
    lua luarocks \
    man-db \
    man-pages \
    mise \
    nemo \
    neovim \
    network-manager-applet \
    nfs-utils \
    gnu-netcat \
    nomacs \
    nss-mdns \
    nwg-look \
    nwg-displays \
    pipewire wireplumber \
    playerctl \
    pamixer \
    polkit-gnome \
    poppler \
    powertop  \
    qt5-wayland  qt6-wayland \
    qt5ct hyprqt6engine \
    rclone \
    ripgrep \
    sbctl \
    seahorse \
    signal-desktop \
    socat \
    sof-firmware \
    starship \
    sqlite \
    sworkstyle \
    ticktick \
    tlp \
    tcpdump \
    usbutils \
    ufw \
    ufw-docker \
    uwsm \
    waybar \
    wev \
    wget \
    wiki-tui \
    xdg-user-dirs \
    xdg-desktop-portal-hyprland \
    yazi \
    zoxide
