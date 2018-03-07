#!/bin/bash

# Linux From Scratch - Version 8.2
# Chapter 6. Installing Basic System Software

. buildenv
[ `whoami` == root ] || exit 2
[ "$LFS"   != ""   ] || exit 2

# ホストシステムのカーネルをLFS側に流用コピーする
KVERSION=4.14.0-kali3-amd64

rm -f $LFS/boot/*
rm -rf $LFS/lib/modules/*

cp -p  /boot/vmlinuz-$KVERSION    $LFS/boot/
cp -p  /boot/initrd.img-$KVERSION $LFS/boot/
cp -p  /boot/config-$KVERSION     $LFS/boot/
cp -p  /boot/System.map-$KVERSION $LFS/boot/
cp -pr /lib/modules/$KVERSION     $LFS/lib/modules/$KVERSION

