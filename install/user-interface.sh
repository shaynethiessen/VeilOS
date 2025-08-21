#!/bin/sh

echo "Installing KDE Plasma and core apps..."

echo "Installing KDE Plasma Desktop: provides the core desktop environment."
echo "Installing SDDM: Simple Desktop Display Manager (login screen)."
echo "Installing Dolphin: file manager for KDE."
echo "Installing Konsole: terminal emulator for KDE."
echo "Installing Plasma Network Manager: network management tools."
echo "Installing Plasma Audio: audio configuration tools for KDE."
echo "Installing Network Manager core: essential networking backend."

apt-get install -y --no-install-recommends \
    kde-plasma-desktop \
    sddm \
    dolphin \
    konsole \
    plasma-nm \
    plasma-pa \
    network-manager

echo "Setting SDDM as default display manager..."
systemctl enable sddm
systemctl set-default graphical.target

echo "Minimal KDE Plasma installation complete!"