#! /bin/bash

pushd $LFS/sources

pushd $GCC

if [[ ! -e .buildstamp_stdcpp ]]; then
    mkdir -v build_stdcpp
    pushd build_stdcpp
    ../libstdc++-v3/configure \
        --host=$LFS_TGT \
        --build=$(../config.guess) \
        --prefix=/usr \
        --disable-multilib \
        --disable-nls \
        --disable-libstdcxx-pch \
        --with-gxx-include-dir=/tools/$LFS_TGT/include/c++/14.2.0
    make
    make DESTDIR=$LFS install
    popd
    # Remove the libtool archive files because they are harmful for cross-compilation
    rm -v $LFS/usr/lib/lib{stdc++{,exp,fs},supc++}.la
    touch .buildstamp_stdcpp
fi

popd
popd
