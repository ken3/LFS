#!/bin/bash

. buildenv
[ `whoami` == root ] || exit 2
[ "$LFS"   != ""   ] || exit 2

mount -v --bind  /dev   $LFS/dev
mount -vt devpts devpts $LFS/dev/pts -o gid=5,mode=620
mount -vt proc   proc   $LFS/proc
mount -vt sysfs  sysfs  $LFS/sys
mount -vt tmpfs  tmpfs  $LFS/run

