#!/bin/sh

# Post-install cleanup
apt-get clean
apt-get autoremove -y
rm -rf /var/lib/apt/lists/*

info "System cleaned"