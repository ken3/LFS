#!/bin/bash

# LFS�ե����륷���ƥ�ΥХå����åפ�μ褹��

BASEDIR=`pwd`

. buildenv
[ `whoami` == root ] || exit 2
[ $LFS != ""       ] || exit 2

cp -p /tmp/stage1.log ${BASEDIR}/../

cd $LFS && tar zcvf ${BASEDIR}/../lfs-stage1.tar.gz .

