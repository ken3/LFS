#!/bin/bash

# Linux From Scratch - Version 8.2
# Chapter 4. Final Preparations
# 4.2. Creating the $LFS/tools Directory

. buildenv
[ `whoami` == root ] || exit 2
[ $LFS != ""       ] || exit 2

# �ǥ��쥯�ȥ����
mkdir -p $LFS/usr
mkdir -p $LFS/sources
mkdir -p $LFS/tools
mkdir -v $LFS/tools/lib
mkdir -p $LFS/build
mkdir -p $LFS/build_tools

/bin/rm -f /tools
ln -sv   $LFS/tools /

chown -vR lfs:lfs $LFS/tools \
	          $LFS/build \
                  $LFS/build_tools

case $(uname -m) in
  x86_64)
      ln -sv lib $LFS/tools/lib64
      ;;
esac

