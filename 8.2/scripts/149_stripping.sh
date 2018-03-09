#!/bin/bash

# Linux From Scratch - Version 8.2
# Chapter 5. Constructing a Temporary System
# 5.35. Stripping

# 変数定義の妥当性を確認する
[ `/usr/bin/whoami` == lfs ] || exit 2
[ "$LFS" != ""             ] || exit 2
[ "$LFS_TGT" != ""         ] || exit 2

strip --strip-debug /tools/lib/*
/usr/bin/strip --strip-unneeded /tools/{,s}bin/*

/bin/rm -rf /tools/{,share}/{info,man,doc}

