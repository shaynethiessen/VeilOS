#!/bin/sh
. ./helper.sh;

info "Setting up DevOps..."

info "Installing yakuake: Drop-down terminal emulator for KDE."
info "Installing testdisk: Data recovery and disk partition repair tool."
info "Installing krdc: Remote Desktop Connection client."

apt-get install -y --no-install-recommends \
  yakuake testdisk krdc

info "Start yakuake automatically"
# Create a system-wide location for the autostart file
mkdir -p /etc/xdg/autostart-files

# Desktop entry content
tee /etc/xdg/autostart-files/yakuake.desktop > /dev/null <<'EOF'
[Desktop Entry]
Type=Application
Exec=yakuake --hide
Hidden=false
X-GNOME-Autostart-enabled=true
Name=Yakuake
Comment=Drop-down terminal
EOF

# 1. Ensure new users get it
mkdir -p /etc/skel/.config/autostart
cp /etc/xdg/autostart-files/yakuake.desktop /etc/skel/.config/autostart/

# 2. Copy to all existing users
for user_home in /home/*; do
    if [ -d "$user_home" ]; then
        mkdir -p "$user_home/.config/autostart"
        cp /etc/xdg/autostart-files/yakuake.desktop "$user_home/.config/autostart/"
        chown $(basename "$user_home"):$(basename "$user_home") "$user_home/.config/autostart/yakuake.desktop"
    fi
done

info "DevOps Complete!"
