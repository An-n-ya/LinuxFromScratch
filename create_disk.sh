#! /bin/bash
set -x
set -e

if [[ ! -e rootfs.img ]]; then
    qemu-img create -f qcow2 rootfs.img 30G
fi

sudo modprobe nbd
lsblk -f | grep "nbd0" | grep -q "ext4" || sudo qemu-nbd -c /dev/nbd0 rootfs.img
lsblk -f | grep nbd0 | grep -q "ext4" || sudo mkfs.ext4 /dev/nbd0
df /dev/nbd0 | grep -q "/mnt/lfs" || sudo mount -v -t ext4 /dev/nbd0 $LFS

if [[ ! -d $LFS/etc ]]; then
    mkdir -pv $LFS/{etc,var} $LFS/usr/{bin,lib,sbin,lib64,tools}
    for i in bin lib sbin; do
        ln -sv usr/$i $LFS/$i
    done
fi
