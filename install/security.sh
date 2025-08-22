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
ufw --force reset

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

info "Resetting Firefox preferences for all existing profiles..."
for profile in /home/*/.mozilla/firefox/*.default*; do
    [ -d "$profile" ] || continue
    prefs_file="$profile/prefs.js"
    if [ -f "$prefs_file" ]; then
        info "Deleting $prefs_file to reset Firefox preferences"
        rm -f "$prefs_file"
    fi
done

info "Setting default Firefox settings all users..."
POLICY_DIR="/etc/firefox-esr/policies"
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

# Clear existing firefox profiles
rm -rf /home/*/.mozilla/firefox

info "Security Configuration Complete!"