#!/bin/sh
. ./helper.sh;

info "Setting up Firmware..."

info "Installing firmware-linux-free: free firmware previously included in the Linux kernel"
info "Installing firmware-linux-nonfree: non-free firmware for kernel drivers"
info "Installing firmware-iwlwifi: Intel wireless card firmware"
info "Installing firmware-intel-sound: Intel DSP sound firmware"
info "Installing firmware-realtek: Realtek wired/wireless/Bluetooth firmware"
info "Installing intel-microcode: CPU firmware updates for Intel processors"
info "Installing amd64-microcode: CPU firmware updates for AMD processors"
info "Installing linux-headers-amd64: kernel headers for building modules"

apt-get install -y --no-install-recommends \
  firmware-linux-free firmware-linux-nonfree \
  firmware-iwlwifi firmware-intel-sound firmware-realtek \
  intel-microcode amd64-microcode linux-headers-amd64

info "Firmware Configuration Complete!"
