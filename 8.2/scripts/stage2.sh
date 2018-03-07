#!/bin/bash

# [stage2]
# LFS�� 200_ownership.sh �� 205_essential.sh ��缡�¹Ԥ��롣

. buildenv
[ `whoami` == root ] || exit 2
[ -x $LFS/scripts/dispatch.sh ] || exit 2

# �¹Ե��Ĥ����
echo "Now going to run the stage 2."
echo -n "continue? (y/n) "
read answer
case $answer in
y|Y)
    ;;
*)
    exit 1
esac

# stage2��¹Ԥ���
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

