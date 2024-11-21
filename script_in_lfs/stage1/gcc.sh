#! /bin/bash

pushd $LFS/sources

if [[ ! -d $GCC ]]; then
    tar -xf $GCC$GCC_SUFFIX
    tar -xf ../$MPFR$MPFR_SUFFIX
    tar -xf ../$GMP$GMP_SUFFIX
    tar -xf ../$MPC$MPC_SUFFIX
    set -e '/m64=/s/lib64/lib/' -i.orig gcc/config/i386/t-linux64
fi
pushd $GCC

if [[ ! -e .buildstamp ]]; then
    mkdir -v build
    pushd build
    ../configure --target=$LFS_TGT \
        --prefix=$LFS/tools \
        --with-glibc-version=2.40 \
        --with-sysroot=$LFS \
        --with-newlib \
        --without-headers \
        --enable-default-pie \
        --enable-default-ssp \
        --disable-nls \
        --disable-shared \
        --disable-multilib \
        --disable-threads \
        --disable-libatomic \
        --disable-libgomp \
        --disable-libquadmath \
        --disable-libssp \
        --disable-libvtv \
        --disable-libstdcxx \
        --enable-languages=c,c++
    make
    make install
    popd
    touch .buildstamp
fi

popd
popd
