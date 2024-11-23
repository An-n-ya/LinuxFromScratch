#! /bin/bash

pushd $LFS/sources

if [[ ! -d $PATCH ]]; then
    tar -xf $PATCH$PATCH_SUFFIX
fi
pushd $PATCH

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
