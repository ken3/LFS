#!/bin/bash

# Linux From Scratch - Version 8.2
# Chapter 6. Installing Basic System Software

. buildenv
[ `whoami` == root ] || exit 2
[ "$LFS"   != ""   ] || exit 2

# initrdを作成する
PKGVERSION=4.15.3
SOURCEROOT=linux-${PKGVERSION}
KVERSION=${PKGVERSION}-lfs-8.2

/bin/rm -rf /lib/modules/$PKGVERSION
/bin/cp -a $LFS/lib/modules/$PKGVERSION /lib/modules/$PKGVERSION

mkinitramfs -o $LFS/boot/initrd.img-$KVERSION $PKGVERSION

/bin/rm -rf /lib/modules/$PKGVERSION

