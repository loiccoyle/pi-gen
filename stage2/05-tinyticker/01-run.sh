#!/bin/bash

set -e

on_chroot <<EOF
sed -i "s/# ap_name: comitup-<nnn>/ap_name: ${TARGET_HOSTNAME}/" /etc/comitup.conf
sudo -u tinyticker python3 -m pip install --user pipx
sudo -u tinyticker python3 -m pipx ensurepath
sudo -u tinyticker python3 -m pipx install tinyticker
sudo -u tinyticker /home/tinyticker/.local/bin/tinyticker --start-on-boot
EOF
