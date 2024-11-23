#! /bin/bash

pushd $LFS/sources

if [[ ! -d $GAWK ]]; then
    tar -xf $GAWK$GAWK_SUFFIX
fi
pushd $GAWK

if [[ ! -e .buildstamp ]]; then
    sed -i 's/extras//' Makefile.in
    ./configure --prefix=/usr \
        --host=$LFS_TGT \
        --build=$(build-aux/config.guess)
    make
    make DESTDIR=$LFS install
    touch .buildstamp
fi

popd
popd
