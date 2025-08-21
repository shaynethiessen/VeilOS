#!/bin/sh
. ./helper.sh;

info "Setting up Security..."

info "Installing sudo: allows users to execute commands with administrative privileges."
info "Installing ufw: uncomplicated firewall to manage iptables rules."
info "Installing gufw: graphical interface for UFW for easier firewall management."

apt-get install -y --no-install-recommends sudo ufw gufw

info "Enabling and configuring UFW firewall..."
ufw default deny incoming
ufw --force enable

info "Security Configuration Complete!"