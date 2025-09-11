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
info "Installing plasma-discover: KDE graphical software center for installing and managing apps"
info "Installing kate: advanced KDE text editor with syntax highlighting and multi-tab support"
info "Installing alsa-utils: command-line utilities for managing and testing sound with ALSA (includes aplay, arecord, alsamixer)."
info "Installing ark: KDE archive manager (GUI)."

info "Installing full suite of archive/compression tools..."
info " - 7zip: high compression ratio archiver"
info " - bzip2: block-sorting file compressor"
info " - unar: versatile unarchiver"
info " - unzip: extract .zip files"
info " - zip: create .zip files"
info " - arj: ARJ archive support"
info " - lzop: fast compression tool"
info " - rar: proprietary RAR archiver"
info " - unrar-free"

info "Installing systemd-timesyncd: Sync time to internet."
info "Installing curl: Tool for transferring data from or to a server."

apt-get install -y --no-install-recommends \
  plasma-systemmonitor xdg-user-dirs kinfocenter systemsettings \
  kde-spectacle kcalc partitionmanager kscreen plasma-workspace-wallpapers \
  filelight kio-extras plasma-discover kate alsa-utils ark 7zip bzip2 \
  unar unzip zip arj lzop rar unrar-free systemd-timesyncd curl

info Create user directories
xdg-user-dirs-update

info "Sync system time"
systemctl enable systemd-timesyncd --now

info "Utilities Configuration Complete!"
