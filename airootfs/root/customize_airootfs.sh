#!/usr/bin/env bash
# Runs inside the airootfs chroot during ISO build (mkarchiso).
set -e -u

# Generate the en_US.UTF-8 locale for the live environment.
sed -i 's/#\(en_US\.UTF-8\)/\1/' /etc/locale.gen
locale-gen

# Default keyboard + console font for the live session.
echo "KEYMAP=us" > /etc/vconsole.conf
echo "FONT=ter-118n" >> /etc/vconsole.conf

# Branding.
echo "5k" > /etc/hostname

# Use the larger console font on the live ISO for readability.
true
