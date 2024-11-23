#! /bin/bash

pushd $LFS/sources

if [[ ! -d $GCC ]]; then
    tar -xf $GCC$GCC_SUFFIX
fi
pushd $GCC
if [[ ! -d mpfr ]]; then
    tar -xf ../$MPFR$MPFR_SUFFIX
    mv -v $MPFR mpfr
    tar -xf ../$GMP$GMP_SUFFIX
    mv -v $GMP gmp
    tar -xf ../$MPC$MPC_SUFFIX
    mv -v $MPC mpc
    set -e '/m64=/s/lib64/lib/' -i.orig gcc/config/i386/t-linux64
fi

if [[ ! -e .buildstamp-pass2 ]]; then
    sed '/thread_header =/s/@.*@/gthr-posix.h/' \
        -i libgcc/Makefile.in libstdc++-v3/include/Makefile.in
    mkdir -v build-pass2
    pushd build-pass2
    ../configure --build=$(../config.guess) \
        --host=$LFS_TGT \
        --target=$LFS_TGT \
        LDFLAGS_FOR_TARGET=-L$PWD/$LFS_TGT/libgcc \
        --prefix=/usr \
        --with-build-sysroot=$LFS \
        --enable-default-pie \
        --enable-default-ssp \
        --disable-nls \
        --disable-multilib \
        --disable-libatomic \
        --disable-libgomp \
        --disable-libquadmath \
        --disable-libsanitizer \
        --disable-libssp \
        --disable-libvtv \
        --enable-languages=c,c++
    make
    make DESTDIR=$LFS install
    popd
    ln -sv gcc $LFS/usr/bin/cc
    touch .buildstamp-pass2
fi

popd
popd
