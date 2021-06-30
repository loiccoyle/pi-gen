#!/bin/bash -e

set -e

touch ${ROOTFS_DIR}/boot/ssh

mv ${ROOTFS_DIR}/etc/wpa_supplicant/wpa_supplicant.conf ${ROOTFS_DIR}/etc/wpa_supplicant/wpa_supplicant.conf.comitup_disable

rm -f ${ROOTFS_DIR}/etc/network/interfaces
install -m 644 files/interfaces ${ROOTFS_DIR}/etc/network/

install -m 644 files/comitup.list ${ROOTFS_DIR}/etc/apt/sources.list.d/
on_chroot apt-key add - < files/8A3171EF366150CE.asc
on_chroot << EOF
apt-get update
systemctl mask dnsmasq.service
systemctl mask systemd-resolved.service
systemctl mask dhcpd.service
systemctl mask dhcpcd.service
EOF


