#!/bin/bash

# SELinux Security Configuration
# Platform: RHEL 10

if [[ $EUID -ne 0 ]]; then
    echo "Please run this script as root."
    exit 1
fi

echo "Checking SELinux status..."

# Check SELinux availability
if ! command -v getenforce >/dev/null 2>&1; then
    echo "SELinux tools are not installed."
    exit 1
fi

# Display current SELinux status
getenforce

# Enable enforcing mode for current session
setenforce 1 || {
    echo "Unable to enable enforcing mode."
    exit 1
}

echo "SELinux mode after configuration:"
getenforce

# Display SELinux configuration
echo "SELinux configuration:"
grep -E '^SELINUX=' /etc/selinux/config

echo "SELinux security check completed."
