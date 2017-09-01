
# Linux From Scratch - Version 8.1rc2
# Chapter 6. Installing Basic System Software
# 6.4. Entering the Chroot Environment

. buildenv
[ `whoami` == root ] || exit 2
[ $LFS != ""       ] || exit 2

echo "Now chroot to $LFS"
echo "Change current directory to /scripts"

# It is time to enter the chroot environment to begin building and installing
# the final LFS system. As user root, run the following command to enter the
# realm that is, at the moment, populated with only the temporary tools:
chroot "$LFS" /tools/bin/env -i \
    SOURCEDIR=/sources          \
    BUILDTOP=/build             \
    MAKEFLAGS='-j 4'            \
    HOME=/root                  \
    TERM="$TERM"                \
    PS1='\u:\w\$ '              \
    PATH=/bin:/usr/bin:/sbin:/usr/sbin:/tools/bin:/tools/sbin \
    /tools/bin/bash --login +h

