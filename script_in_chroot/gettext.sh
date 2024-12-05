#! /bin/bash

set -e
set -x
pushd /sources

if [[ ! -d $GETTEXT ]]; then
    tar -xf $GETTEXT$GETTEXT_SUFFIX
fi
pushd $GETTEXT

if [[ ! -e .buildstamp ]]; then
    ./configure --disable-shared
    make
    cp -v gettext-tools/src/{msgfmt,msgmerge,xgettext} /usr/bin
    touch .buildstamp
fi

popd
popd
