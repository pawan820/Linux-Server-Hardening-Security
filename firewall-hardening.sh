#!/bin/bash

# Linux Firewall Hardening
# Platform: RHEL 10

if [[ $EUID -ne 0 ]]; then
    echo "Please run this script as root."
    exit 1
fi

echo "Starting Firewall Configuration..."

# Install firewalld if missing
if ! rpm -q firewalld >/dev/null 2>&1; then
    echo "Installing firewalld..."
    dnf install -y firewalld || exit 1
fi

# Enable and start firewall
systemctl enable --now firewalld || exit 1

# Allow SSH access
firewall-cmd --permanent --add-service=ssh || exit 1

# Apply firewall rules
firewall-cmd --reload || exit 1

echo "Firewall Status:"
firewall-cmd --state

echo "Active Firewall Rules:"
firewall-cmd --list-all

echo "Firewall configuration completed."
