#! /bin/bash

pushd $LFS/sources

if [[ ! -d $NCURSES ]]; then
    tar -xf $NCURSES$NCURSES_SUFFIX
fi
pushd $NCURSES

if [[ ! -e .buildstamp ]]; then
    sed -i s/mawk// configure
    mkdir build
    pushd build
    ../configure
    make -C include
    make -C progs tic
    popd
    ./configure --prefix=/usr \
        --host=$LFS_TGT \
        --build=$(./config.guess) \
        --mandir=/usr/share/man \
        --with-manpage-format=normal \
        --with-shared \
        --without-normal \
        --with-cxx-shared \
        --without-debug \
        --without-ada \
        --disable-stripping
    make DESTDIR=$LFS TIC_PATH=$(pwd)/build/progs/tic install
    ln -sv libncursesw.so $LFS/usr/lib/libncurses.so
    sed -e 's/^#if.*XOPEN.*$/#if 1/' \
        -i $LFS/usr/include/curses.h
    touch .buildstamp
fi

popd
popd
