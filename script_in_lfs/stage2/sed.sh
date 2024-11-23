#! /bin/bash

pushd $LFS/sources

if [[ ! -d $SED ]]; then
    tar -xf $SED$SED_SUFFIX
fi
pushd $SED

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
