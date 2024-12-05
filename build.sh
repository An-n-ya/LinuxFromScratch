#! /bin/bash

set -x
set -e

LFS=/mnt/lfs

source create_disk.sh
source download.sh
source add_user_and_change.sh
# sudo -i "/tmp/chroot.sh"
sudo -i bash /tmp/chroot.sh
