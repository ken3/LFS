#!/bin/bash

# LFSファイルシステムのバックアップを採取する

BASEDIR=`pwd`

. buildenv
[ `whoami` == root ] || exit 2
[ $LFS != ""       ] || exit 2

cp -p $LFS/tmp/stage3-*.log ${BASEDIR}/../

cd $LFS && tar zcvf ${BASEDIR}/../lfs-stage3.tar.gz \
    bin      \
    boot     \
    dev      \
    etc      \
    home     \
    lib      \
    lib64    \
    media    \
    mnt      \
    opt      \
    proc     \
    root     \
    run      \
    sbin     \
    scripts  \
    sources  \
    srv      \
    sys      \
    tools    \
    tmp      \
    usr      \
    var

