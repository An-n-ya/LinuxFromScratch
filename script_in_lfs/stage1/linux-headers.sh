#! /bin/bash

pushd $LFS/sources

if [[ ! -d $LINUX ]]; then
    tar -xf $LINUX$LINUX_SUFFIX
fi
pushd $LINUX

if [[ ! -e .buildstamp ]]; then
    make mrproper
    make headers
    find usr/include -type f ! -name '*.h' -delete
    cp -rv usr/include $LFS/usr
    touch .buildstamp
fi

popd
popd
