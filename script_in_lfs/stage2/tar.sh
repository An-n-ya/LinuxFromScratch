#! /bin/bash

pushd $LFS/sources

if [[ ! -d $TAR ]]; then
    tar -xf $TAR$TAR_SUFFIX
fi
pushd $TAR

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
