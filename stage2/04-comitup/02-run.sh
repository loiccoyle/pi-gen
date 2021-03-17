#!/bin/bash -e

set -e

rm ${ROOTFS_DIR}/etc/apt/sources.list.d/comitup.list
on_chroot apt-key del 8A3171EF366150CE

for conn in dhcp static; do
    install -m 600 files/${conn}.nmconnection ${ROOTFS_DIR}/etc/NetworkManager/system-connections/
done

install -m 755 files/set_comitup_hostname_once "${ROOTFS_DIR}/etc/init.d/"

on_chroot <<EOF
systemctl enable set_comitup_hostname_once
EOF
