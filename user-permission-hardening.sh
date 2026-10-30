#!/bin/bash

# Linux User and Permission Security Audit
# Platform: RHEL 10

if [[ $EUID -ne 0 ]]; then
    echo "Please run this script as root."
    exit 1
fi

echo "=================================="
echo " LINUX USER SECURITY AUDIT"
echo "=================================="

echo
echo "1. Users with UID 0:"
awk -F: '$3 == 0 {print $1}' /etc/passwd

echo
echo "2. Users with Login Shell:"
awk -F: '$7 !~ /nologin|false/ {print $1, $7}' /etc/passwd

echo
echo "3. Sudo/Wheel Group Members:"
getent group wheel

echo
echo "4. World-Writable Files in /etc:"
find /etc -xdev -type f -perm -0002 -print 2>/dev/null

echo
echo "5. Files with SUID Permission:"
find /usr/bin /usr/sbin -type f -perm -4000 -print 2>/dev/null

echo
echo "6. Password Policy Information:"
grep -E '^(PASS_MAX_DAYS|PASS_MIN_DAYS|PASS_WARN_AGE)' \
/etc/login.defs 2>/dev/null || true

echo
echo "Security audit completed."
