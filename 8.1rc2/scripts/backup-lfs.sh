#!/bin/bash

# LFS�ե����륷���ƥ�ΥХå����åפ�μ褹��

BASEDIR=`pwd`

. buildenv
[ `whoami` == root ] || exit 2
[ $LFS != ""       ] || exit 2

cd $LFS && tar zcvf ${BASEDIR}/../snapshot/lfs-snapshot.tar.gz \
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

