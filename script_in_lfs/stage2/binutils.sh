#! /bin/bash

pushd $LFS/sources

if [[ ! -d $BUINUTILS ]]; then
    tar -xf $BINUTILS$BINUTILS_SUFFIX
fi
pushd $BINUTILS

if [[ ! -e .buildstamp-pass2 ]]; then
    sed '6009s/$add_dir//' -i ltmain.sh
    mkdir -v build-pass2
    pushd build-pass2
    ../configure --prefix=$LFS/tools \
        --with-sysroot=$LFS \
        --target=$LFS_TGT \
        --disable-nls \
        --enable-shared \
        --enable-gprofng=no \
        --disable-werror \
        --enable-64-bit-bfd \
        --enable-new-dtags \
        --enable-default-hash-style=gnu
    make
    make DESTDIR=$LFS install
    popd
    rm -v $LFS/usr/lib/lib{bfd,ctf,ctf-nobfd,opcodes,sframe}.{a,la}
    touch .buildstamp-pass2
fi

popd
popd
