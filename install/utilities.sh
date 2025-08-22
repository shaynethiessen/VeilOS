#!/bin/sh
. ./helper.sh;

info "Setting up Utilities..."

info "Installing plasma-systemmonitor: GUI task manager for KDE."
info "Installing xdg-user-dirs: creates standard user directories."
info "Installing kinfocenter: KDE system information tool."
info "Installing systemsettings: KDE Plasma configuration utility."
info "Installing kde-spectacle: KDE screenshot tool."
info "Installing kcalc: KDE calculator application."
info "Installing partitionmanager: KDE disk partition management tool."

apt-get install -y --no-install-recommends \
  plasma-systemmonitor xdg-user-dirs kinfocenter systemsettings kde-spectacle kcalc partitionmanager

# Create user directories
xdg-user-dirs-update

info "Utilities Configuration Complete!"
