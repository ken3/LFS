#!/bin/bash

# Linux From Scratch - Version 8.2
# Chapter 6. Installing Basic System Software

. buildenv
[ `whoami` == root ] || exit 2
[ "$LFS"   != ""   ] || exit 2

# �ۥ��ȥ����ƥ�Υ����ͥ��LFS¦��ή�ѥ��ԡ�����
KVERSION=4.14.0-kali3-amd64

#rm -f $LFS/boot/*
#rm -rf $LFS/lib/modules/*

cp -p  /boot/vmlinuz-${KVERSION}    \
       /boot/initr*-${KVERSION}*    \
       /boot/config-${KVERSION}     \
       /boot/System.map-${KVERSION} $LFS/boot/
cp -pr /lib/modules/${KVERSION}     $LFS/lib/modules/$KVERSION

(cd /lib && tar cf - firmware)|(cd $LFS/lib && tar xf -)

