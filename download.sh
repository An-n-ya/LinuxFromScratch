#! /bin/bash

LFS=/mnt/lfs

if [[ ! -e wget-list ]]; then
    echo "No wget-list file" >&2
    exit 1
fi

if [[ ! -d $LFS/sources ]]; then
    mkdir $LFS/sources
    wget --input-file=wget-list --continue --directory-prefix=$LFS/sources
fi
