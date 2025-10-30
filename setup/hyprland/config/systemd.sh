sudo systemctl enable --now greetd.service
sudo systemctl enable --now NetworkManager.service
sudo systemctl enable --now bluetooth.service

# Printer
# Disable mDNS in systemd-resolved to avoid conflicts with Avahi
if [ ! -f /etc/systemd/resolved.conf.d/10-disable-multicast.conf ]; then
    sudo mkdir -p /etc/systemd/resolved.conf.d
    echo -e "[Resolve]\nMulticastDNS=no" | \
        sudo tee /etc/systemd/resolved.conf.d/10-disable-multicast.conf
fi
if cat /etc/nsswitch.conf | grep -q 'mdns_minimal'; then
    # Update nsswitch.conf to enable mDNS resolution via Avahi
    sudo sed -i 's/^hosts:.*/hosts: mymachines mdns_minimal [NOTFOUND=return] resolve [!UNAVAIL=return] files myhostname dns/' /etc/nsswitch.conf
fi
sudo systemctl enable --now avahi-daemon.service
sudo systemctl enable --now cups.service cups-browsed.service
