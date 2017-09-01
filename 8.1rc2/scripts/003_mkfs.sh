#!/bin/bash

# Linux From Scratch - Version 8.1rc2
# Chapter 4. Final Preparations
# 4.2. Creating the $LFS/tools Directory

. buildenv
[ `whoami` == root ] || exit 2
[ $LFS != ""       ] || exit 2
[ $ROOTDEV != ""   ] || exit 2

# 実行許可を求める
echo "Now going to mkfs on $ROOTDEV."
echo -n "continue? (y/n) "
read answer
case $answer in
y|Y)
    ;;
*)
    exit 1
esac

# フォーマット
mkfs -t ext4 -m 0 $ROOTDEV

