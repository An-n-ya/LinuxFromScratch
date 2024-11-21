#! /bin/bash
set -e
LFS=/mnt/lfs

if ! cat /etc/passwd | grep -q "lfs"; then
    groupadd lfs
    useradd -s /bin/bash -g lfs -m -k /dev/null lfs
    echo "setting passwd for new user lfs:"
    passwd lfs
    chown -v lfs $LFS/{usr{,/*},lib,var,etc,bin,sbin,tools,lib64}
fi

sudo rm -rf /tmp/script_in_lfs/
cp -r script_in_lfs /tmp/script_in_lfs
sudo chown -R lfs /tmp/script_in_lfs

sudo -i -u lfs bash <<EOF
cd /tmp/script_in_lfs
./build.sh
EOF
