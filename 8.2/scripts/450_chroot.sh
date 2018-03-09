
# Linux From Scratch - Version 8.2
# Chapter 6. Installing Basic System Software
# 6.73. Cleaning Up

. buildenv
[ `whoami` == root ] || exit 2
[ "$LFS"   != ""   ] || exit 2

echo "Now chroot to $LFS"
echo "Change current directory to /scripts"

chroot "$LFS" /usr/bin/env -i   \
    MAKEFLAGS='-j 4'            \
    HOME=/root                  \
    TERM="$TERM"                \
    PS1='\u:\w\$ '              \
    PATH=/bin:/usr/bin:/sbin:/usr/sbin \
    /bin/bash --login $*

