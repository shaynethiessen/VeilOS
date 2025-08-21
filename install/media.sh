#!/bin/sh
. ./helper.sh;

info "Setting up Media..."

info "Installing Firefox ESR: web browser for internet access."
info "Installing Plasma Browser Integration: integrates Firefox/Chromium with KDE Plasma features."

apt-get install -y --no-install-recommends firefox-esr plasma-browser-integration

info "Media Configuration Complete!"