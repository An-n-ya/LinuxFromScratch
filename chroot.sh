#! /bin/bash
echo "STAGE3 CHROOT BEGINNING..."
LFS=/mnt/lfs

chown --from lfs -R root:root $LFS/{usr,lib,var,etc,bin,sbin,tools,lib64}

mkdir -pv $LFS/{dev,proc,sys,run}

if ! findmnt | grep -q "/mnt/lfs/dev"; then
    mount -v --bind /dev $LFS/dev
    mount -vt devpts devpts -o gid=5,mode=0620 $LFS/dev/pts
    mount -vt proc proc $LFS/proc
    mount -vt sysfs sysfs $LFS/sys
    mount -vt tmpfs tmpfs $LFS/run
    if [ -h $LFS/dev/shm ]; then
        install -v -d -m 1777 $LFS$(realpath /dev/shm)
    else
        mount -vt tmpfs -o nosuid,nodev tmpfs $LFS/dev/shm
    fi
fi

chroot "$LFS" /usr/bin/env -i \
    HOME=/root \
    TERM="$TERM" \
    PS1='(lfs chroot) \u:\w\$ ' \
    PATH=/usr/bin:/usr/sbin \
    MAKEFLAGS="-j$(nproc)" \
    TESTSUITEFLAGS="-j$(nproc)" \
    /bin/bash --login /bin/script_in_chroot/stage3.sh

echo "STAGE3 DONE"
