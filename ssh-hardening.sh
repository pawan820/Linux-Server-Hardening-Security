#!/bin/bash

# Linux SSH Server Hardening
# Platform: RHEL 10

set -e

CONFIG="/etc/ssh/sshd_config.d/99-hardening.conf"
BACKUP="/etc/ssh/sshd_config.d/99-hardening.conf.bak"

if [[ $EUID -ne 0 ]]; then
    echo "Please run this script as root."
    exit 1
fi

echo "Starting SSH Server Hardening..."

mkdir -p /etc/ssh/sshd_config.d

# Backup existing configuration
if [[ -f "$CONFIG" ]]; then
    cp -p "$CONFIG" "$BACKUP"
    echo "Backup created: $BACKUP"
fi

# Apply SSH security settings
cat > "$CONFIG" <<EOF
PermitRootLogin no
PermitEmptyPasswords no
MaxAuthTries 4
X11Forwarding no
EOF

chmod 600 "$CONFIG"

# Validate SSH configuration
if sshd -t; then
    echo "SSH configuration is valid."

    if systemctl reload sshd; then
        echo "SSH service reloaded successfully."
        echo "SSH Hardening completed."
    else
        echo "Reload failed. Restoring previous configuration."
        if [[ -f "$BACKUP" ]]; then
            cp -p "$BACKUP" "$CONFIG"
        else
            rm -f "$CONFIG"
        fi
        systemctl reload sshd || true
        exit 1
    fi
else
    echo "Invalid SSH configuration. Restoring previous configuration."
    if [[ -f "$BACKUP" ]]; then
        cp -p "$BACKUP" "$CONFIG"
    else
        rm -f "$CONFIG"
    fi
    exit 1
fi
