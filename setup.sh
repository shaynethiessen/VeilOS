#!/bin/sh
# VeilOS setup script
# Must be run as root on Debian minimal

set -e
set -u

# Check privileges
if [ "$(id -u)" -ne 0 ]; then
  echo "The install script must be run as root."
  exit 1
fi

# Run modular install scripts
sh ./install/pre-install-config.sh
sh ./install/user-interface.sh
sh ./install/post-install-config.sh

REBOOT="N"
if [ -t 0 ]; then
    echo "Install is complete. Reboot now? (y/N)"
    read -r REBOOT
fi

if [ "$REBOOT" = "y" ] || [ "$REBOOT" = "Y" ]; then
    reboot
fi