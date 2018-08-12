#!/bin/bash
source /in_chroot/functions/functions.sh

export DEBIAN_FRONTEND=noninteractive

_echo "Installing base packages"
yum -y --releasever=7 install yum centos-release
yum -y install @core @base redhat-lsb-core dracut-tools dracut-config-generic dracut-config-rescue grub2

DISK=$(cat /in_chroot/device)
_echo "Installing Linux boot loader (grub) to device $DISK"
grub2-install $DISK
grub2-mkconfig -o /boot/grub2/grub.cfg

set_password

touch /.autorelabel

_echo "Clean disk space"
yum clean all

exit
