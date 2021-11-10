#!/bin/bash

set -e

on_chroot <<EOF
sed -i "s/# ap_name: comitup-<nnn>/ap_name: ${TARGET_HOSTNAME}/" /etc/comitup.conf
sudo -u ${FIRST_USER_NAME} python3 -m pip install --user pipx
sudo -u ${FIRST_USER_NAME} python3 -m pipx ensurepath
sudo -u ${FIRST_USER_NAME} python3 -m pipx install --system-site-packages tinyticker
sudo -u ${FIRST_USER_NAME} /home/${FIRST_USER_NAME}/.local/bin/tinyticker --start-on-boot
EOF
