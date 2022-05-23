#!/bin/bash -e

set -e

wget -P "${ROOTFS_DIR}/tmp" http://www.airspayce.com/mikem/bcm2835/bcm2835-1.60.tar.gz

on_chroot <<EOF
cd /tmp
tar -xzvf bcm2835-1.60.tar.gz
cd bcm2835-1.60/
./configure
make
make install
EOF