#!/bin/bash

# Linux From Scratch - Version 8.1rc2
# Chapter 6. Installing Basic System Software

. buildenv
[ `whoami` == root ] || exit 2
[ "$LFS"   != ""   ] || exit 2

# ホストシステムのカーネルをLFS側に流用コピーする
KVERSION=4.11.0-kali1-amd64
cp -p  /boot/vmlinuz-$KVERSION    $LFS/boot/
cp -p  /boot/initrd.img-$KVERSION $LFS/boot/
cp -p  /boot/config-$KVERSION     $LFS/boot/
cp -p  /boot/System.map-$KVERSION $LFS/boot/
cp -pr /lib/modules/$KVERSION     $LFS/lib/modules/

