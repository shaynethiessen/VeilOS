#!/bin/sh
. ./helper.sh;

info "Installing plymouth: Boot animation, logger and I/O multiplexer"
apt-get install -y --no-install-recommends plymouth

OS_NAME="VeilOS"

info "Changing OS name to $OS_NAME"

# Overwrite /etc/os-release
cat > /etc/os-release <<EOF
NAME="$OS_NAME"
VERSION="0.2 (Beta)"
ID=veil
PRETTY_NAME="$OS_NAME"
VERSION_ID="0.2"
EOF

# Optional: update /etc/issue and /etc/issue.net (login banners)
echo "$OS_NAME" > /etc/issue
echo "$OS_NAME" > /etc/issue.net

info "OS name successfully updated to $OS_NAME"

# Generate 8 random alphanumeric characters
RAND=$(tr -dc 'a-z0-9' </dev/urandom | head -c 8)

NEW_HOSTNAME="veilos-$RAND"
DOMAIN="veilos.local"
FQDN="$NEW_HOSTNAME.$DOMAIN"

info "Setting hostname to $NEW_HOSTNAME"
info "Setting domain to $DOMAIN"
info "Fully qualified domain name (FQDN) will be $FQDN"

# Set runtime hostname and domain
hostname "$NEW_HOSTNAME"
hostname --fqdn "$FQDN" 2>/dev/null || true

# Update /etc/hostname
echo "$NEW_HOSTNAME" > /etc/hostname

# Update /etc/hosts
# Replace 127.0.0.1 and 127.0.1.1 entries
sed -i "s/^127\.0\.0\.1\s.*/127.0.0.1 localhost/" /etc/hosts 2>/dev/null || true
if grep -q "127.0.1.1" /etc/hosts; then
    sed -i "s/^127\.0\.1\.1\s.*/127.0.1.1 $NEW_HOSTNAME/" /etc/hosts
else
    echo "127.0.1.1 $NEW_HOSTNAME" >> /etc/hosts
fi

info "Hostname and domain successfully set."

REPO_DIR="/opt/VeilOS"

chmod +x "$REPO_DIR/setup.sh"

# System paths
DESKTOP_FILE="/usr/share/applications/veil-os.desktop"
ICON_DIR="/usr/share/icons/hicolor/48x48/apps"
ICON_FILE="$ICON_DIR/veil-os.png"

# Ensure dirs exist
mkdir -p "$ICON_DIR"

# Install icon (from repo root)
install -m 644 "$REPO_DIR/media/logo/square.png" "$ICON_FILE"

# Update GTK icon cache
gtk-update-icon-cache -f /usr/share/icons/hicolor

# Create or update the desktop entry
sudo tee "$DESKTOP_FILE" > /dev/null <<EOF
[Desktop Entry]
Version=1.0
Type=Application
Name=Veil OS Updater
Comment=Fetch and install the latest Veil OS updates
Exec=konsole --hold -e bash -c "cd /opt/VeilOS && sudo ./setup.sh; exec bash"
Terminal=false
Icon=/usr/share/icons/hicolor/48x48/apps/veil-os.png
Categories=System;Utility;
EOF

chmod 644 "$DESKTOP_FILE"

info "System-wide Veil OS menu entry installed."