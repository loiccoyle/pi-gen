#!/bin/bash -e

touch ${ROOTFS_DIR}/boot/ssh

mv ${ROOTFS_DIR}/etc/wpa_supplicant/wpa_supplicant.conf ${ROOTFS_DIR}/etc/wpa_supplicant/wpa_supplicant.conf.comitup_disable

rm -f ${ROOTFS_DIR}/etc/network/interfaces
install -m 644 files/interfaces ${ROOTFS_DIR}/etc/network/

cp files/davesteele-comitup-apt-source*deb ${ROOTFS_DIR}/tmp/
on_chroot << EOF
dpkg -i /tmp/davesteele-comitup-apt-source*deb
rm -f /tmp/davesteele-comitup-apt-source*deb
apt-get update
systemctl mask dnsmasq.service
systemctl mask systemd-resolved.service
systemctl mask dhcpd.service
EOF

