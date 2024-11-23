#! /bin/bash

pushd $LFS/sources

if [[ ! -d $DIFFUTILS ]]; then
    tar -xf $DIFFUTILS$DIFFUTILS_SUFFIX
fi
pushd $DIFFUTILS

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
