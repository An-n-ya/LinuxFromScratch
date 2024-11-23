#! /bin/bash

pushd $LFS/sources

if [[ ! -d $MAKE ]]; then
    tar -xf $MAKE$MAKE_SUFFIX
fi
pushd $MAKE

if [[ ! -e .buildstamp ]]; then
    ./configure --prefix=/usr \
        --host=$LFS_TGT \
        --build=$(build-aux/config.guess) \
        --without-guile
    make
    make DESTDIR=$LFS install
    touch .buildstamp
fi

popd
popd
