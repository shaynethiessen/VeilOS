#!/bin/sh
. ./helper.sh;

info "Setting up Media..."

info "Installing firefox-esr: web browser for internet access."
info "Installing plasma-browser-integration: integrates Firefox/Chromium with KDE Plasma features."
info "Installing dragonplayer: simple KDE video player."
info "Installing gwenview: KDE image viewer for photos."
info "Installing qt6-image-formats-plugins: additional image format support for KDE/Qt6 apps."
info "Installing kimageformats-plugins: extra image format plugins for KDE applications."

apt-get install -y --no-install-recommends \
  firefox-esr plasma-browser-integration dragonplayer gwenview \
  qt6-image-formats-plugins kimageformats-plugins

info "Media Configuration Complete!"
