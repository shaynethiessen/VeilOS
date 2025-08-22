#!/bin/sh
. ./helper.sh;

info "Setting up Utilities..."

info "Installing plasma-systemmonitor: GUI task manager for KDE."
info "Installing xdg-user-dirs: creates standard user directories."
info "Installing kinfocenter: KDE system information tool."

apt-get install -y --no-install-recommends plasma-systemmonitor xdg-user-dirs kinfocenter

info "Utilities Configuration Complete!"