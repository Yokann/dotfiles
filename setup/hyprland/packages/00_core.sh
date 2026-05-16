sudo pacman -S fakeroot base-devel --noconfirm

# Install yay if missing, install golang on the way
if ! command -v yay &>/dev/null; then
    git clone https://aur.archlinux.org/yay.git /tmp/yay
    makepkg -si --noconfirm -D /tmp/yay
    rm -rf /tmp/yay
fi

# Install rustup if missing
if ! command -v rustup &>/dev/null; then
    yay -S --noconfirm rustup
    rustup default stable
fi
