#!/bin/bash

# [stage2]
# LFSの 200_ownership.sh 〜 205_essential.sh を順次実行する。

. buildenv
[ `whoami` == root ] || exit 2
[ -x $LFS/scripts/dispatch.sh ] || exit 2

# 実行許可を求める
echo "Now going to run the stage 2."
echo -n "continue? (y/n) "
read answer
case $answer in
y|Y)
    ;;
*)
    exit 1
esac

# stage2を実行する
cd $LFS/scripts || exit 1

./dispatch.sh                \
        200_ownership.sh     \
        201_kernelfs.sh      \
        202_mount-lfs.sh
[ $? -eq 0 ] || exit 1

./203_chroot.sh              \
	/scripts/dispatch.sh \
        204_directories.sh   \
        205_essential.sh     \
        __206_execbash.sh    \
        207_fixlink.sh       \
	208_varlog.sh
[ $? -eq 0 ] || exit 1

echo "Stage2 has beed done."
echo "OK, proceed to 250_chroot.sh"

