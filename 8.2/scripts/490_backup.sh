#!/bin/bash

# LFSファイルシステムのバックアップを採取する

BASEDIR=`pwd`

. buildenv
[ `whoami` == root ] || exit 2
[ $LFS != ""       ] || exit 2

cp -p /tmp/stage4.log ${BASEDIR}/../

