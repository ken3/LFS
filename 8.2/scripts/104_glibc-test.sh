#!/bin/bash

# Linux From Scratch - Version 8.2
# Chapter 5. Constructing a Temporary System
# 5.7. Glibc-2.26

cd /tmp

echo 'int main(){}' >dummy.c
${LFS_TGT}-gcc dummy.c
readelf -l a.out | grep ': /tools'
rm -v dummy.c a.out

