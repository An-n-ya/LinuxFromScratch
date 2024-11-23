#! /bin/bash

pushd $LFS/sources

if [[ ! -d $BASH ]]; then
    tar -xf $BASH$BASH_SUFFIX
fi
pushd $BASH

if [[ ! -e .buildstamp ]]; then
    ./configure --prefix=/usr \
        --host=$LFS_TGT \
        --build=$(sh support/config.guess) \
        --without-bash-malloc \
        bash_cv_strtold_broken=no
    make
    make DESTDIR=$LFS install
    ln -sv bash $LFS/bin/sh
    touch .buildstamp
fi

popd
popd
