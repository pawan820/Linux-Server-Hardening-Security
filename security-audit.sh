#!/bin/bash

# Linux Server Security Audit
# Platform: RHEL 10

if [[ $EUID -ne 0 ]]; then
    echo "Please run this script as root."
    exit 1
fi

echo "===================================="
echo "      LINUX SECURITY AUDIT"
echo "===================================="

echo
echo "1. SELinux Status:"
getenforce 2>/dev/null || echo "SELinux status unavailable"

echo
echo "2. Firewall Status:"
firewall-cmd --state 2>/dev/null || echo "Firewall not running"

echo
echo "3. Active Services:"
systemctl list-units --type=service --state=running --no-pager

echo
echo "4. Listening Network Ports:"
ss -tuln

echo
echo "5. Recent Failed Login Attempts:"
if command -v journalctl >/dev/null 2>&1; then
    journalctl -b --no-pager 2>/dev/null \
    | grep -i "failed password" | tail -10 \
    || true
fi

echo
echo "6. Available Security Updates:"
dnf check-update --security || true

echo
echo "===================================="
echo "       AUDIT COMPLETED"
echo "===================================="
