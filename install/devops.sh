#!/bin/sh
. ./helper.sh;

info "Setting up DevOps..."

info "Installing yakuake: Drop-down terminal emulator for KDE."
info "Installing testdisk: Data recovery and disk partition repair tool."
info "Installing krdc: Remote Desktop Connection client."

apt-get install -y --no-install-recommends \
  yakuake testdisk krdc

info "DevOps Complete!"
