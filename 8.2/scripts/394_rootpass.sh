
# Linux From Scratch - Version 8.2
# Chapter 6. Installing Basic System Software
# 6.25. Shadow-4.4

[ `whoami` == root ] || exit 2
[ -d /scripts ]      || exit 2

# Choose a password for user root and set it by running:
passwd root

