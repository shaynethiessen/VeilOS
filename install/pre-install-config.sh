#!/bin/sh
. ./helper.sh;

# Set APT sources for VeilOS
cat > /etc/apt/sources.list <<EOF
# VeilOS Packages
deb https://deb.debian.org/debian/ trixie main contrib non-free non-free-firmware
deb-src https://deb.debian.org/debian/ trixie main contrib non-free non-free-firmware

deb https://security.debian.org/debian-security trixie-security main contrib non-free non-free-firmware
deb-src https://security.debian.org/debian-security trixie-security main contrib non-free non-free-firmware

deb https://deb.debian.org/debian/ trixie-updates main contrib non-free non-free-firmware
deb-src https://deb.debian.org/debian/ trixie-updates main contrib non-free non-free-firmware
EOF
sync

# Update and upgrade all existing packages
export DEBIAN_FRONTEND=noninteractive

# Remove package usage survey
apt-get purge -y kde-inotify-survey

apt-get update -y
apt-get -y --no-install-recommends upgrade

info "APT sources updated and system upgraded"