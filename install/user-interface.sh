#!/bin/sh
. ./helper.sh;

info "Setting up User Interface..."

info "Installing KDE Plasma Desktop: provides the core desktop environment."
info "Installing SDDM: Simple Desktop Display Manager (login screen)."
info "Installing SDDM Breeze theme: modern KDE login theme."
info "Installing Dolphin: file manager for KDE."
info "Installing Konsole: terminal emulator for KDE."
info "Installing Plasma Network Manager: network management tools."
info "Installing Plasma Audio: audio configuration tools for KDE."
info "Installing Network Manager core: essential networking backend."

apt-get install -y --no-install-recommends \
    kde-plasma-desktop \
    sddm \
    sddm-theme-breeze \
    dolphin \
    konsole \
    plasma-nm \
    plasma-pa \
    network-manager

info "Setting SDDM as default display manager..."
systemctl enable sddm
systemctl set-default graphical.target

info "User Interface Configuration Complete!"
