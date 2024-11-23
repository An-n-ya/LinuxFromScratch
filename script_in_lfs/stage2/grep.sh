#! /bin/bash

pushd $LFS/sources

if [[ ! -d $GREP ]]; then
    tar -xf $GREP$GREP_SUFFIX
fi
pushd $GREP

if [[ ! -e .buildstamp ]]; then
    ./configure --prefix=/usr \
        --host=$LFS_TGT \
        --build=$(./build-aux/config.guess)
    make
    make DESTDIR=$LFS install
    touch .buildstamp
fi

popd
popd
