# Configure Docker daemon:
# - limit log size to avoid running out of disk
sudo mkdir -p /etc/docker
sudo tee /etc/docker/daemon.json >/dev/null <<'EOF'
{
    "log-driver": "json-file",
    "log-opts": { "max-size": "10m", "max-file": "5" }
}
EOF

# Start Docker automatically
sudo cat <<EOF >/etc/subuid
$USER:231072:65536
EOF

sudo cat <<EOF >/etc/subgid
$USER:231072:65536
EOF
systemctl --user enable --now docker.socket

# Prevent Docker from preventing boot for network-online.target
sudo mkdir -p /etc/systemd/system/docker.service.d
sudo tee /etc/systemd/system/docker.service.d/no-block-boot.conf <<'EOF'
[Unit]
DefaultDependencies=no
EOF
