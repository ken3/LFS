#!/bin/bash

# Linux From Scratch - Version 8.1rc2
# Chapter 5. Constructing a Temporary System
# 5.37. Changing Ownership

. buildenv
[ `whoami` == root ] || exit 2
[ "$LFS"   != ""   ] || exit 2

chown -R root:root $LFS/tools

install -dv -m 0750 $LFS/root
install -dv -m 1777 $LFS/tmp $LFS/var/tmp

