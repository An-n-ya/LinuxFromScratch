#! /bin/bash
set -e
set -x
pushd /sources

if [[ ! -d $BISON ]]; then
    tar -xf $BISON$BISON_SUFFIX
fi
pushd $BISON

if [[ ! -e .buildstamp ]]; then
    ./configure --prefix=/usr \
        --docdir=/usr/share/doc/bison-3.8.2
    make
    make install
    touch .buildstamp
fi

popd
popd
