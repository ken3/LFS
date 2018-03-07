#!/bin/bash

# Linux From Scratch - Version 8.2
# Chapter 4. Final Preparations
# 4.3. Adding the LFS User

. buildenv
[ `whoami` == root ] || exit 2

sg lfs -c : 2>/dev/null || groupadd lfs
su lfs -c : 2>/dev/null || (useradd -s /bin/bash -g lfs -m -k /dev/null lfs && passwd lfs)

cp -p bashrc ~lfs/.bashrc
cp -p bash_profile ~lfs/.bash_profile
chown lfs:lfs ~lfs/.bashrc ~lfs/.bash_profile

