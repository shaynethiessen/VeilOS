#!/bin/sh
. ./helper.sh;

info "Setting up Utilities..."

info "Installing plasma-systemmonitor: GUI task manager for KDE."
info "Installing xdg-user-dirs: creates standard user directories."
info "Installing kinfocenter: KDE system information tool."
info "Installing systemsettings: KDE Plasma configuration utility."
info "Installing kde-spectacle: KDE screenshot tool."
info "Installing kcalc: KDE calculator application."
info "Installing partitionmanager: KDE partition management tool."
info "Installing kscreen: KDE display configuration service."
info "Installing plasma-workspace-wallpapers: default wallpapers for KDE Plasma"
info "Installing filelight: graphical disk usage analyzer for KDE"
info "Installing kio-extras: provides additional KDE I/O plugins and thumbnailers for improved file manager functionality"

apt-get install -y --no-install-recommends \
  plasma-systemmonitor xdg-user-dirs kinfocenter systemsettings \
  kde-spectacle kcalc partitionmanager kscreen plasma-workspace-wallpapers \
  filelight kio-extras

# Create user directories
xdg-user-dirs-update

info "Utilities Configuration Complete!"
