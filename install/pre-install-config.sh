#!/bin/sh
. ./helper.sh;

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
info "$NEW_HOSTNAME" > /etc/hostname

# Update /etc/hosts
# Replace 127.0.0.1 and 127.0.1.1 entries
sed -i "s/^127\.0\.0\.1\s.*/127.0.0.1 localhost $FQDN/" /etc/hosts 2>/dev/null || true
if grep -q "127.0.1.1" /etc/hosts; then
    sed -i "s/^127\.0\.1\.1\s.*/127.0.1.1 $FQDN/" /etc/hosts
else
    info "127.0.1.1 $FQDN" >> /etc/hosts
fi

info "Hostname and domain successfully set."

# Set APT sources for VeilOS
cat > /etc/apt/sources.list <<EOF
# VeilOS Packages
deb http://deb.debian.org/debian/ trixie main contrib non-free
deb-src http://deb.debian.org/debian/ trixie main contrib non-free

deb http://security.debian.org/debian-security trixie-security main contrib non-free
deb-src http://security.debian.org/debian-security trixie-security main contrib non-free

deb http://deb.debian.org/debian/ trixie-updates main contrib non-free
deb-src http://deb.debian.org/debian/ trixie-updates main contrib non-free
EOF

# Update and upgrade all existing packages
export DEBIAN_FRONTEND=noninteractive

# Remove package usage survey
apt-get remove -y kde-inotify-survey

apt-get update -y
apt-get upgrade -y

info "APT sources updated and system upgraded"