#! /bin/bash

pushd $LFS/sources

if [[ ! -d $GZIP ]]; then
    tar -xf $GZIP$GZIP_SUFFIX
fi
pushd $GZIP

if [[ ! -e .buildstamp ]]; then
    ./configure --prefix=/usr \
        --host=$LFS_TGT
    make
    make DESTDIR=$LFS install
    touch .buildstamp
fi

popd
popd
