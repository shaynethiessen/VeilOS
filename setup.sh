#!/bin/sh
# VeilOS setup script
# Must be run as root on Debian minimal

set -e

# Check privileges
if [ "$EUID" -ne 0 ]; then
  echo "The install script must be run as root."
  exit 1
fi

# Reset APT sources for VeilOS
cat > /etc/apt/sources.list <<EOF
# VeilOS Packages
deb http://deb.debian.org/debian/ trixie main contrib non-free
deb-src http://deb.debian.org/debian/ trixie main contrib non-free

deb http://security.debian.org/debian-security trixie-security main contrib non-free
deb-src http://security.debian.org/debian-security trixie-security main contrib non-free

deb http://deb.debian.org/debian/ trixie-updates main contrib non-free
deb-src http://deb.debian.org/debian/ trixie-updates main contrib non-free
EOF

# Update and upgrade system
DEBIAN_FRONTEND=noninteractive
apt-get update -y
apt-get upgrade -y

# Run modular install scripts
./install/core.sh
