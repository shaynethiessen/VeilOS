#!/bin/sh
. ./helper.sh;

info "Installing okular: Boot animation, logger and I/O multiplexer"
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