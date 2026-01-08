#!/bin/bash
set -e -u

# Generate locale
sed -i 's/#\(en_US\.UTF-8\)/\1/' /etc/locale.gen
locale-gen

# Set timezone
ln -sf /usr/share/zoneinfo/UTC /etc/localtime

# Configure users
usermod -s /usr/bin/bash root
useradd -m -G wheel -s /bin/bash liveuser

# Set passwords
echo 'root:root' | chpasswd
echo 'liveuser:liveuser' | chpasswd

# Enable services
systemctl enable NetworkManager
systemctl enable sddm

# System configuration
echo 'liveuser ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers
