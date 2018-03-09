#!/bin/bash

. buildenv
[ `whoami` == root ] || exit 2
[ "$LFS"   != ""   ] || exit 2

umount $LFS/run
umount $LFS/sys
umount $LFS/proc
umount $LFS/dev/pts
umount $LFS/dev

