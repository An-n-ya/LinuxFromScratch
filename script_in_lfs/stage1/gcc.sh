#! /bin/bash

pushd $LFS/sources

if [[ ! -d $GCC ]]; then
    tar -xf $GCC$GCC_SUFFIX
fi
pushd $GCC
if [[ ! -d $MPFR ]]; then
    tar -xf ../$MPFR$MPFR_SUFFIX
    tar -xf ../$GMP$GMP_SUFFIX
    tar -xf ../$MPC$MPC_SUFFIX
    set -e '/m64=/s/lib64/lib/' -i.orig gcc/config/i386/t-linux64
fi

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
    cat gcc/limitx.h gcc/glimits.h gcc/limity.h >$(dirname $($LFS_TGT-gcc -print-libgcc-file-name))/include/limits.h
    touch .buildstamp
fi

popd
popd
