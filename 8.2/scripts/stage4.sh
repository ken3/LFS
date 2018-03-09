#!/bin/bash

# [stage4]
# LFS�� 400_chroot.sh �� 457_release.sh ��缡�¹Ԥ��롣

. buildenv
[ `whoami` == root ] || exit 2
[ "$LFS"   != ""   ] || exit 2
[ -x $LFS/scripts/dispatch.sh ] || exit 2

# �¹Ե��Ĥ����
echo "Now going to run the stage 4."
echo -n "continue? (y/n) "
read answer
case $answer in
y|Y)
    ;;
*)
    exit 1
esac

# stage4��¹Ԥ���
cd $LFS/scripts || exit 1

./400_chroot.sh /scripts/dispatch.sh    \
                401_stripping.sh
[ $? -eq 0 ] || exit 1

./450_chroot.sh /scripts/dispatch.sh    \
                451_cleanup.sh          \
                452_zaptools.sh         \
                453_networking.sh       \
                454_sysvinit.sh         \
                455_config.sh           \
                456_rc.sh               \
                457_release.sh
[ $? -eq 0 ] || exit 1
cp -p /tmp/lfsbuild.log /tmp/stage4.log

echo "Stage4 has beed done."
echo "OK, proceed to 490_backup.sh"

