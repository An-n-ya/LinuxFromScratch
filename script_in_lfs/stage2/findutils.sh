#! /bin/bash

pushd $LFS/sources

if [[ ! -d $FINDUTILS ]]; then
    tar -xf $FINDUTILS$FINDUTILS_SUFFIX
fi
pushd $FINDUTILS

if [[ ! -e .buildstamp ]]; then
    ./configure --prefix=/usr \
        --localstatedir=/var/lib/locate \
        --host=$LFS_TGT \
        --build=$(build-aux/config.guess)
    make
    make DESTDIR=$LFS install
    touch .buildstamp
fi

popd
popd
