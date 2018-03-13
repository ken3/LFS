#!/bin/bash

# LFSファイルシステムのバックアップを採取する

BASEDIR=`pwd`

. buildenv
[ `whoami` == root ] || exit 2
[ $LFS != ""       ] || exit 2

cp -p $LFS/tmp/stage3-*.log ${BASEDIR}/../

