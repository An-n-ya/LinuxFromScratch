#! /bin/bash

set -e
set -x
pushd /sources

if [[ ! -d $TEXINFO ]]; then
    tar -xf $TEXINFO$TEXINFO_SUFFIX
fi
pushd $TEXINFO

if [[ ! -e .buildstamp ]]; then
    ./configure --prefix=/usr
    make
    make install
    touch .buildstamp
fi

popd
popd
