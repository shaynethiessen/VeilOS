#!/bin/sh
. ./helper.sh;

info "Setting up Media..."

info "Installing firefox-esr: web browser for internet access."
info "Installing plasma-browser-integration: integrates Firefox/Chromium with KDE Plasma features."
info "Installing dragonplayer: simple KDE video player."
info "Installing gwenview: KDE image viewer for photos."
info "Installing qt6-image-formats-plugins: additional image format support for KDE/Qt6 apps."
info "Installing kimageformat6-plugins: extra image format plugins for KDE applications."
info "Installing kdegraphics-thumbnailers: provides thumbnails for graphics files in KDE"
info "Installing ffmpegthumbs: generates video thumbnails for KDE file managers"
info "Installing ffmpegthumbnailer: backend tool to generate video thumbnails"

apt-get install -y --no-install-recommends \
  firefox-esr plasma-browser-integration dragonplayer gwenview \
  qt6-image-formats-plugins kimageformat6-plugins kdegraphics-thumbnailers \
  ffmpegthumbs ffmpegthumbnailer

info "Media Configuration Complete!"
