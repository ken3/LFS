
# Linux From Scratch Version 8.2
# Chapter 9. The End
# 9.1. The End

[ `whoami` == root ]  || exit 2
[ -d /scripts ]       || exit 2

LFSVERSION=8.2

# /etc/lfs-release
echo $LFSVERSION >/etc/lfs-release

# /etc/lsb-release
cat >/etc/lsb-release << EOF
DISTRIB_ID="Linux From Scratch"
DISTRIB_RELEASE="$LFSVERSION"
DISTRIB_CODENAME="LFS_${LFSVERSION}_2018-03-03"
DISTRIB_DESCRIPTION="Linux From Scratch"
EOF

# UEFI needs /etc/os-release file
cp -p /etc/lsb-release /etc/os-release

