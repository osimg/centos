#!/bin/bash
source /in_container/in_chroot/functions/functions.sh

cd /in_container

yum -y install e2fsprogs
create_disk 8192

_echo "Bootstrapping target OS"
yum -y --installroot=/target --releasever=7 install yum

make_fstab
prepare_chroot

cp -rp /in_container/in_chroot /target
chroot /target /in_chroot/build.sh

disk_clean

umount_disk

exit
