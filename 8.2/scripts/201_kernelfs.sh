#!/bin/bash

# Linux From Scratch - Version 8.2
# Chapter 6. Installing Basic System Software
# 6.2. Preparing Virtual Kernel File Systems

. buildenv
[ `whoami` == root ] || exit 2
[ "$LFS"   != ""   ] || exit 2

# Begin by creating directories onto which the file systems will be mounted:
mkdir -pv $LFS/{dev,proc,sys,run}

# 6.2.1. Creating Initial Device Nodes
mknod -m 600 $LFS/dev/console c 5 1
mknod -m 666 $LFS/dev/null c 1 3

# 6.2.2. Mounting and Populating /dev
#mount -v --bind /dev $LFS/dev

# 6.2.3. Mounting Virtual Kernel File Systems
#mount -vt devpts devpts $LFS/dev/pts -o gid=5,mode=620
#mount -vt proc proc $LFS/proc
#mount -vt sysfs sysfs $LFS/sys
#mount -vt tmpfs tmpfs $LFS/run

# In some host systems, /dev/shm is a symbolic link to /run/shm.  The /run tmpfs
# was mounted above so in this case only a directory needs to be created.
if [ -h $LFS/dev/shm ]; then
  mkdir -pv $LFS/$(readlink $LFS/dev/shm)
fi

