#! /bin/bash

pushd $LFS/sources

if [[ ! -d $FILE ]]; then
    tar -xf $FILE$FILE_SUFFIX
fi
pushd $FILE

if [[ ! -e .buildstamp ]]; then
    mkdir build
    pushd build
    ../configure --disable-bzlib \
        --disable-libseccomp \
        --disable-xzlib \
        --disable-zlib
    make
    popd
    ./configure --prefix=/usr \
        --host=$LFS_TGT \
        --build=$(./config.guess)
    make FILE_COMPILE=$(pwd)/build/src/file
    make DESTDIR=$LFS install
    rm -v $LFS/usr/lib/libmagic.la
    touch .buildstamp
fi

popd
popd
