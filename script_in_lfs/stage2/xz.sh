#! /bin/bash

pushd $LFS/sources

if [[ ! -d $XZ ]]; then
    tar -xf $XZ$XZ_SUFFIX
fi
pushd $XZ

if [[ ! -e .buildstamp ]]; then
    ./configure --prefix=/usr \
        --host=$LFS_TGT \
        --build=$(build-aux/config.guess) \
        --disable-static \
        --docdir=/usr/share/doc/xz-5.6.2
    make
    make DESTDIR=$LFS install
    rm -v $LFS/usr/lib/liblzma.la
    touch .buildstamp
fi

popd
popd
