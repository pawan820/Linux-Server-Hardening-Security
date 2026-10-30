Linux Server Hardening & Security – RHEL 10

Project Overview

This project focuses on improving Linux server security using shell scripting and built-in RHEL 10 security tools.

It includes scripts for SSH hardening, firewall configuration, SELinux management, user permission auditing, and security checks.

Technologies Used

- Red Hat Enterprise Linux (RHEL 10)
- Bash Shell Scripting
- SSH
- Firewalld
- SELinux
- systemd
- DNF Package Manager

Project Features

Script| Purpose
"ssh-hardening.sh"| Applies basic SSH security settings
"firewall-hardening.sh"| Enables firewall and allows SSH
"selinux-security.sh"| Checks and enables SELinux Enforcing mode
"user-permission-hardening.sh"| Audits users, sudo access and permissions
"security-audit.sh"| Checks services, ports, firewall and security updates

Project Structure

linux-server-hardening-security/
├── ssh-hardening.sh
├── firewall-hardening.sh
├── selinux-security.sh
├── user-permission-hardening.sh
├── security-audit.sh
└── README.md

How to Use

Clone the repository:

git clone https://github.com/pawan820/linux-server-hardening-security.git

Open the project directory:

cd linux-server-hardening-security

Give execution permission:

chmod +x *.sh

Run individual scripts as root:

sudo ./ssh-hardening.sh
sudo ./firewall-hardening.sh
sudo ./selinux-security.sh
sudo ./user-permission-hardening.sh
sudo ./security-audit.sh

Learning Outcomes

- Linux server security fundamentals
- SSH configuration and hardening
- Firewall management using Firewalld
- SELinux security management
- User and permission auditing
- Linux security monitoring using Bash

Important Notes

- Designed for RHEL 10 lab environments.
- Review scripts before executing them on any server.
- Test configuration changes in a virtual machine first.
- Maintain console access before changing SSH or firewall settings.
- These scripts are learning and administration tools, not a complete security solution.

