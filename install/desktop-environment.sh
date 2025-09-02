#!/bin/sh
. ./helper.sh;

info "Setting up User Interface..."

info "Installing kde-plasma-desktop: KDE Plasma Desktop environment."
info "Installing sddm: Simple Desktop Display Manager (login screen)."
info "Installing sddm-theme-breeze: Breeze theme for SDDM login screen."
info "Installing dolphin: KDE file manager."
info "Installing konsole: KDE terminal emulator."
info "Installing yakuake: Quake-style terminal emulator."
info "Installing plasma-nm: KDE Plasma Network Manager applet."
info "Installing plasma-pa: KDE Plasma Audio configuration tools."
info "Installing network-manager: core networking backend."

apt-get install -y --no-install-recommends \
    kde-plasma-desktop \
    sddm \
    sddm-theme-breeze \
    dolphin \
    konsole \
    yakuake \
    plasma-nm \
    plasma-pa \
    network-manager

info "Setting SDDM as default display manager..."
systemctl enable sddm
systemctl set-default graphical.target

info "User Interface Configuration Complete!"
