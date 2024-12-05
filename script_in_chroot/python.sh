#! /bin/bash

set -e
set -x
pushd /sources

if [[ ! -d $PYTHON ]]; then
    tar -xf $PYTHON$PYTHON_SUFFIX
fi
pushd $PYTHON

if [[ ! -e .buildstamp ]]; then
    ./configure --prefix=/usr \
        --enable-shared \
        --without-ensurepip
    make
    make install
    touch .buildstamp
fi

popd
popd
