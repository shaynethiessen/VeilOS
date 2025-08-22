#!/bin/sh
. ./helper.sh;

info "Setting up Security..."

info "Installing sudo: allows users to execute commands with administrative privileges."
info "Installing ufw: uncomplicated firewall to manage iptables rules."
info "Installing gufw: graphical interface for UFW for easier firewall management."
info "Installing clamav: open-source antivirus engine."
info "Installing clamtk: graphical interface for ClamAV."

apt-get install -y --no-install-recommends sudo ufw gufw clamav clamtk

info "Enabling and configuring UFW firewall..."
# Clear previous ufw settings
ufw reset

# Default to deny
ufw default deny incoming
ufw default deny outgoing

# Allow only essential outgoing connections
ufw allow out 53     # DNS
ufw allow out 443    # HTTPS
ufw allow out 123    # NTP (time sync)

ufw --force enable
systemctl enable ufw
systemctl start ufw

info "Updating ClamAV virus database..."
systemctl stop clamav-freshclam || true
freshclam
systemctl start clamav-freshclam || true
systemctl enable clamav-freshclam || true

info "Enforcing Firefox HTTPS-Only Mode enforced for all users..."
POLICY_DIR="/usr/lib/firefox-esr/distribution"
mkdir -p "$POLICY_DIR"
cat > "$POLICY_DIR/policies.json" <<EOF
{
  "policies": {
    "HTTPSOnlyMode": {
      "Enabled": true,
      "Locked": true
    }
  }
}
EOF
sync


info "Security Configuration Complete!"