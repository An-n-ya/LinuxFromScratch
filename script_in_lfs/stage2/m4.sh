#! /bin/bash

pushd $LFS/sources

if [[ ! -d $M4 ]]; then
    tar -xf $M4$M4_SUFFIX
fi
pushd $M4

if [[ ! -e .buildstamp ]]; then
    ./configure --prefix=/usr \
        --host=$LFS_TGT \
        --build=$(build-aux/config.guess)
    make
    make DESTDIR=$LFS install
    touch .buildstamp
fi

popd
popd
