#!/bin/sh
. ./helper.sh;

info "Setting up Office..."

info "Installing libreoffice: office productivity suite"
info "Installing libreoffice-style-breeze: Breeze icons for LibreOffice"
info "Installing libreoffice-kf6: KDE Frameworks 6 integration for LibreOffice"
info "Installing okular: KDE PDF and document viewer with annotations and multi-format support"

apt-get install -y --no-install-recommends \
  libreoffice libreoffice-style-breeze libreoffice-kf6 okular

info "Office Configuration Complete!"
