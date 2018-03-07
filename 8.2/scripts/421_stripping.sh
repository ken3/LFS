
# Linux From Scratch - Version 8.2
# Chapter 6. Installing Basic System Software
# 6.72. Stripping Again

[ `whoami` == root ] || exit 2
[ -d /scripts ]      || exit 2
cd /scripts

/tools/bin/find /usr/lib -type f -name \*.a \
	-exec /tools/bin/strip --strip-debug {} ';'
/tools/bin/find /lib /usr/lib -type f -name \*.so* \
	-exec /tools/bin/strip --strip-unneeded {} ';'
/tools/bin/find /{bin,sbin} /usr/{bin,sbin,libexec} -type f \
	-exec /tools/bin/strip --strip-all {} ';'

