#!/bin/bash

# LFS�ե����륷���ƥ�ΥХå����åפ�μ褹��

BASEDIR=`pwd`

. buildenv
[ `whoami` == root ] || exit 2
[ $LFS != ""       ] || exit 2

cp -p /tmp/stage4.log ${BASEDIR}/../

