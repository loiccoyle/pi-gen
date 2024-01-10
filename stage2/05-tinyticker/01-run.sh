#!/bin/bash

set -e

on_chroot <<EOF
sed -i "s/# ap_name: comitup-<nnn>/ap_name: ${TARGET_HOSTNAME}/" /etc/comitup.conf
sudo -u tinyticker python3 -m pip install --user --break-system-packages tinyticker
EOF

on_chroot <<EOF
sudo -u tinyticker mkdir -p /home/tinyticker/.config/systemd/user/
EOF
install -m 644 files/*.service "${ROOTFS_DIR}/home/tinyticker/.config/systemd/user/"
on_chroot <<EOF
chown tinyticker:tinyticker /home/tinyticker/.config/systemd/user/*
EOF

install -m 644 files/90-unpriviledge-port.conf "${ROOTFS_DIR}/etc/sysctl.d/"

on_chroot <<EOF
sudo -u tinyticker systemctl enable --user tinyticker.service
sudo -u tinyticker systemctl enable --user tinyticker-qrcode.service
sudo -u tinyticker systemctl enable --user tinyticker-web.service
EOF
