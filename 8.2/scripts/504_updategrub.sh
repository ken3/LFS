#!/bin/bash

# Linux From Scratch - Version 8.2
# Chapter 6. Installing Basic System Software

. buildenv
[ `whoami` == root ] || exit 2
[ "$LFS"   != ""   ] || exit 2

# ホストシステムのGRUBにLFSパーティションを認識させる
which update-grub && update-grub

GRUBCFG=/boot/grub/grub.cfg

#ROOTDEVICE=`echo $ROOTDEV|sed 's@/@\\\\/@g'`
#[ -f $GRUBCFG ] && sed -i "s/root=${ROOTDEVICE}\$/root=${ROOTDEVICE} ro/" $GRUBCFG

ROOTDEVICE=${ROOTDEV//\//\\\/}
COMMAND="s/\\([ \\t]*\\)root=${ROOTDEVICE}\\([ \\t]*\\)/\\1root=${ROOTDEVICE} ro\\2/"
[ -f $GRUBCFG ] && sed -i -e "$COMMAND" $GRUBCFG

