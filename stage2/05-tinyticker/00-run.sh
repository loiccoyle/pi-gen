#!/bin/bash -e

set -e

on_chroot <<EOF
id -u tinyticker || useradd -m tinyticker -G users,sudo,gpio,spi,i2c -p OlWmFBPK9SgIg
echo "tinyticker:tinyticker" | chpasswd
mkdir -p /var/lib/systemd/linger/
touch /var/lib/systemd/linger/tinyticker
echo "tinyticker ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
EOF

wget -P "${ROOTFS_DIR}/tmp" 'http://www.airspayce.com/mikem/bcm2835/bcm2835-1.60.tar.gz'

on_chroot <<EOF
cd /tmp
tar -xzvf bcm2835-1.60.tar.gz
cd bcm2835-1.60/
./configure
make
make install
EOF
