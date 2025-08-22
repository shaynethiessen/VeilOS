#!/bin/sh
. ./helper.sh;

info "Setting up Security..."

info "Installing sudo: allows users to execute commands with administrative privileges."
info "Installing ufw: uncomplicated firewall to manage iptables rules."
info "Installing gufw: graphical interface for UFW for easier firewall management."
info "Installing clamav: open-source antivirus engine."
info "Installing clamtk: graphical interface for ClamAV."

apt-get install -y --no-install-recommends sudo ufw gufw clamav clamtk

info "Configuring UFW firewall..."
# Reset previous rules
ufw --force reset

# Default deny
ufw default deny incoming
ufw default deny outgoing

# Allow essential outgoing connections
ufw allow out 53     # DNS
ufw allow out 443    # HTTPS
ufw allow out 123    # NTP

ufw --force enable
systemctl enable ufw
systemctl start ufw

info "Updating ClamAV virus database..."
systemctl stop clamav-freshclam || true
freshclam
systemctl start clamav-freshclam || true
systemctl enable clamav-freshclam || true

info "Enforcing HTTPS-Only Mode in Firefox for all users..."

# Create mozilla.cfg
MOZILLA_CFG="/usr/lib/firefox-esr/mozilla.cfg"
cat > "$MOZILLA_CFG" <<'EOF'
//
lockPref("dom.security.https_only_mode", true);
EOF
chmod 644 "$MOZILLA_CFG"

# Create local-settings.js
LOCAL_SETTINGS="/usr/lib/firefox-esr/defaults/pref/local-settings.js"
mkdir -p "$(dirname "$LOCAL_SETTINGS")"
cat > "$LOCAL_SETTINGS" <<'EOF'
pref("general.config.filename", "mozilla.cfg");
pref("general.config.obscure_value", 0);
EOF
chmod 644 "$LOCAL_SETTINGS"

# Clear existing prefs.js to ensure policy takes effect
for profile in /home/*/.mozilla/firefox/*.default*; do
    [ -d "$profile" ] || continue
    prefs_file="$profile/prefs.js"
    if [ -f "$prefs_file" ]; then
        info "Deleting $prefs_file to reset Firefox preferences"
        rm -f "$prefs_file"
    fi
done

# Restart Firefox to apply policy
pkill -f firefox-esr || true
sync

info "HTTPS-Only Mode enforced for all users."
info "Security Configuration Complete!"
