#!/bin/bash

. buildenv
[ `whoami` == root   ] || exit 2
[ "$LFS"     != ""   ] || exit 2
[ -d $LFS/lost+found ] || exit 2

[ -d $LFS/scripts ] || mkdir -pv $LFS/scripts
cp -a ../scripts/* $LFS/scripts/
chown -R lfs:lfs $LFS/scripts

