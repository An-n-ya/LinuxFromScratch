#! /bin/bash

pushd $LFS/sources

if [[ ! -d $GLIBC ]]; then
    tar -xf $GLIBC$GLIBC_SUFFIX
fi
pushd $GLIBC

if [[ ! -e .buildstamp ]]; then
    ln -sfv ../lib/ld-linux-x86-64.so.2 $LFS/lib64
    ln -sfv ../lib/ld-linux-x86-64.so.2 $LFS/lib64/ld-lsb-x86-64.so.3
    patch -Np1 -i ../glibc-2.40-fhs-1.patch
    mkdir -v build
    pushd build
    echo "rootsbindir=/usr/sbin" >configparams
    ../configure \
        --prefix=/usr \
        --host=$LFS_TGT \
        --build=$(../scripts/config.guess) \
        --enable-kernel=4.19 \
        --with-headers=$LFS/usr/include \
        --disable-nscd \
        libc_cv_slibdir=/usr/lib
    make
    make DESTDIR=$LFS install
    sed '/RTLDLIST=/s@/usr@@g' -i $LFS/usr/bin/ldd
    popd
    touch .buildstamp
fi

# ensure the new toolchain are working as expected
echo 'int main() {}' | $LFS_TGT-gcc -xc -
if ! readelf -l a.out | grep -q ld-linux; then
    echo "toolchain incomplete!"
    rm -v a.out
    exit 1
fi
rm -v a.out

popd
popd
