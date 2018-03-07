#!/bin/bash

. buildenv
[ `whoami` == root ] || exit 2

echo "Switch user to lfs."
echo "Change current directory to $LFS/scripts."
su - lfs

