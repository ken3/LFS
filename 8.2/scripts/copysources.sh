#!/bin/bash

# ソースパッケージをLFS側にコピーする

. buildenv
[ `whoami` == root   ] || exit 2
[ "$LFS" != ""       ] || exit 2
[ -d $LFS/lost+found ] || exit 2
[ -d $SOURCEDIR      ] || mkdir -pv $SOURCEDIR

cp -a ../packages/* $SOURCEDIR

