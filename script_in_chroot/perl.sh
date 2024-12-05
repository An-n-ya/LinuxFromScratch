#! /bin/bash

set -e
set -x
pushd /sources

if [[ ! -d $PERL ]]; then
    tar -xf $PERL$PERL_SUFFIX
fi
pushd $PERL

if [[ ! -e .buildstamp ]]; then
    sh Configure -des \
        -D prefix=/usr \
        -D vendorprefix=/usr \
        -D useshrplib \
        -D privlib=/usr/lib/perl5/5.40/core_perl \
        -D archlib=/usr/lib/perl5/5.40/core_perl \
        -D sitelib=/usr/lib/perl5/5.40/site_perl \
        -D sitearch=/usr/lib/perl5/5.40/site_perl \
        -D vendorlib=/usr/lib/perl5/5.40/vendor_perl \
        -D vendorarch=/usr/lib/perl5/5.40/vendor_perl
    make
    make install
    touch .buildstamp
fi

popd
popd
