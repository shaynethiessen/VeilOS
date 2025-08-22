#!/bin/sh
. ./helper.sh;

OS_NAME="VeilOS"

info "Changing OS name to $OS_NAME"

# Backup existing os-release
cp /etc/os-release /etc/os-release.bak

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

# Set APT sources for VeilOS
cat > /etc/apt/sources.list <<EOF
# VeilOS Packages
deb https://deb.debian.org/debian/ trixie main contrib non-free
deb-src https://deb.debian.org/debian/ trixie main contrib non-free

deb https://security.debian.org/debian-security trixie-security main contrib non-free
deb-src https://security.debian.org/debian-security trixie-security main contrib non-free

deb https://deb.debian.org/debian/ trixie-updates main contrib non-free
deb-src https://deb.debian.org/debian/ trixie-updates main contrib non-free
EOF
sync

# Update and upgrade all existing packages
export DEBIAN_FRONTEND=noninteractive

# Remove package usage survey
apt-get purge -y kde-inotify-survey

apt-get update -y
apt-get -y --no-install-recommends upgrade

info "APT sources updated and system upgraded"