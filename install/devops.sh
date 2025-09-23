#!/bin/sh
. ./helper.sh;

info "Setting up DevOps..."

info "Installing yakuake: Drop-down terminal emulator for KDE."
info "Installing testdisk: Data recovery and disk partition repair tool."
info "Installing krdc: Remote Desktop Connection client."

apt-get install -y --no-install-recommends \
  yakuake testdisk krdc

info "Start yakuake automatically"

tee /etc/xdg/autostart/yakuake.desktop > /dev/null <<'EOF'
[Desktop Entry]
Type=Application
Exec=yakuake --hide
Hidden=false
NoDisplay=false
X-GNOME-Autostart-enabled=true
Name=Yakuake
Comment=Drop-down terminal
EOF

chmod 644 /etc/xdg/autostart/yakuake.desktop

info "DevOps Complete!"
