
# Linux From Scratch - Version 8.2
# Chapter 6. Installing Basic System Software
# 6.73. Cleaning Up

[ `whoami` == root ] || exit 2
[ -d /scripts ]      || exit 2

rm -f /usr/lib/lib{bfd,opcodes}.a
rm -f /usr/lib/libbz2.a
rm -f /usr/lib/lib{com_err,e2p,ext2fs,ss}.a
rm -f /usr/lib/libltdl.a
rm -f /usr/lib/libfl.a
rm -f /usr/lib/libfl_pic.a
rm -f /usr/lib/libz.a

find /usr/lib -name '*.la' -delete

rm -rf /tmp/*

