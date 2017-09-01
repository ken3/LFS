
# Linux From Scratch - Version 8.1rc2
# Chapter 6. Installing Basic System Software
# 6.5. Creating Directories

#[ `whoami` == root  ] || exit 2
[ -d /scripts ] || exit 2

# It is time to create some structure in the LFS file system. Create a
# standard directory tree by issuing the following commands:
#install -dv -m 0750 /root
#install -dv -m 1777 /tmp /var/tmp
mkdir -pv /{bin,boot,etc/{opt,sysconfig},home,lib/firmware,mnt,opt}
mkdir -pv /{media/{floppy,cdrom},sbin,srv,var}
mkdir -pv /usr/{,local/}{bin,include,lib,sbin,src}
mkdir -pv /usr/{,local/}share/{color,dict,doc,info,locale,man}
mkdir -pv /usr/{,local/}share/{misc,terminfo,zoneinfo}
mkdir -pv /usr/libexec
mkdir -pv /usr/{,local/}share/man/man{1..8}

case $(uname -m) in
     x86_64) mkdir -pv /lib64 ;;
esac

mkdir -pv /var/{log,mail,spool}
mkdir -pv /var/{opt,cache,lib/{color,misc,locate},local}

ln -sv /run /var/run
ln -sv /run/lock /var/lock

exit 0

