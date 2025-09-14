#!/bin/sh
. ./helper.sh;

info "Setting up DevOps..."

info "Installing yakuake: Drop-down terminal emulator for KDE."
info "Installing testdisk: Data recovery and disk partition repair tool."

apt-get install -y --no-install-recommends \
  yakuake testdisk

info "DevOps Complete!"
