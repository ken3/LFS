#!/bin/bash

# Linux From Scratch - Version 8.1rc2
# Chapter 5. Constructing a Temporary System
# 5.10. GCC-7.2.0 - Pass 2

# �ѿ���������������ǧ����
[ `whoami` == lfs     ] || exit 2
[ "$LFS" != ""        ] || exit 2
[ "$LFS_TGT" != ""    ] || exit 2

cd /tmp
echo 'int main(){}' >dummy.c
cc dummy.c
readelf -l a.out | grep ': /tools'
rm -v dummy.c a.out

