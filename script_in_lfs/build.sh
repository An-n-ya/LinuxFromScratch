#! /bin/bash
set -x
set -e

# setting up environment
if [[ ! -e ~/.bash_profile ]]; then
    cat >~/.bash_profile <<"EOF"
exec env -i HOME=$HOME TERM=$TERM PS='\u:\w\$ ' /bin/bash
EOF
fi

if [[ ! -e ~/.bashrc ]]; then
    cat >~/.bashrc <<"EOF"
set +h
umask 022
LFS=/mnt/lfs
LC_ALL=POSIX
LFS_TGT=$(uname -m)-lfs-linux-gnu
PATH=/usr/bin
if [ ! -L /bin ]; then PATH=/bin:$PATH; fi
PATH=$LFS/tools/bin:$PATH
CONFIG_SITE=$LFS/usr/share/config.site
export LFS LC_ALL LFS_TGT PATH CONFIG_SITE
EOF
fi

source ~/.bashrc

source variable.sh

export MAKEFLAGs=-j28
for ((i = 1; i <= 1; i = i + 1)); do
    pushd stage$i
    source stage$i.sh
    popd
done
