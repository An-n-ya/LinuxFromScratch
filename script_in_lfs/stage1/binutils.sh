#! /bin/bash

pushd $LFS/sources

if [[ ! -d $BUINUTILS ]]; then
    tar -xf $BINUTILS$BINUTILS_SUFFIX
fi
cd $BINUTILS

if [[ ! -e .buildstamp ]]; then
    # TODO: build stamp
    mkdir -v build
    pushd build
    ../configure --prefix=$LFS/tools \
        --with-sysroot=$LFS \
        --target=$LFS_TGT \
        --disable-nls \
        --enable-gprofng=no \
        --disable-werror \
        --enable-new-dtags \
        --enable-default-hash-style=gnu
    make
    make install
    popd
    touch .buildstamp
fi

popd
