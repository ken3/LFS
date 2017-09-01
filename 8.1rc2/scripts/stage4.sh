#!/bin/bash

# [stage4]
# LFSの 420_chroot.sh 〜 462_release.sh を順次実行する。

. buildenv
[ `whoami` == root ] || exit 2
[ "$LFS"   != ""   ] || exit 2
[ -x $LFS/scripts/dispatch.sh ] || exit 2

# 実行許可を求める
echo "Now going to run the stage 4."
echo -n "continue? (y/n) "
read answer
case $answer in
y|Y)
    ;;
*)
    exit 1
esac

# stage4を実行する
cd $LFS/scripts || exit 1

./420_chroot.sh /scripts/dispatch.sh    \
                421_stripping.sh
[ $? -eq 0 ] || exit 1

./423_chroot.sh /scripts/dispatch.sh    \
                424_cleanup.sh          \
                425_zaptools.sh         \
                451_networking.sh       \
                452_sysvinit.sh         \
                453_config.sh           \
                454_rc.sh               \
                __460_kernel.sh         \
                __461_kernel-install.sh \
                462_release.sh
[ $? -eq 0 ] || exit 1

echo "Stage4 has beed done."
echo "OK, proceed to 500_copykernel.sh"

