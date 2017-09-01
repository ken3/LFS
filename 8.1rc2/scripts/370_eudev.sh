
# Linux From Scratch - Version 8.1rc2
# Chapter 6. Installing Basic System Software
# 6.65. Eudev-3.2.2

#######################################################################
# �ե졼�������ɤ߹���                                            #
#######################################################################
. buildlfs || exit 1

#######################################################################
# �оݥ������ȥӥ�ɥǥ��쥯�ȥ����ꤹ��                            #
#######################################################################
PKGVERSION=3.2.2
SOURCEROOT=eudev-${PKGVERSION}
BUILDROOT=${SOURCEROOT}
BUILDDIR=${BUILDTOP}/${BUILDROOT}
ARCHIVE=`tarballpath $SOURCEROOT`

#######################################################################
# �¹Բ�ǽ��������å�����                                          #
#######################################################################
lfs_selfcheck || exit 2

#######################################################################
# ������Ÿ��/�ѥå�Ŭ��/configure/Makefile����                        #
#######################################################################
do_setup()
{
    cd $BUILDTOP
    /bin/rm -rf $SOURCEROOT $BUILDROOT
    tar xvf $ARCHIVE
    [ "$SOURCEROOT" == "$BUILDROOT" ] || mv $SOURCEROOT $BUILDROOT
    cd $BUILDDIR || exit 1

    sed -r -i 's|/usr(/bin/test)|\1|' test/udev-test.pl
    sed -i '/keyboard_lookup_key/d' src/udev/udev-builtin-keyboard.c

    cat > config.cache << "EOF"
HAVE_BLKID=1
BLKID_LIBS="-lblkid"
BLKID_CFLAGS="-I/tools/include"
EOF

    ./configure --prefix=/usr          \
	        --bindir=/sbin         \
	        --sbindir=/sbin        \
	        --libdir=/usr/lib      \
	        --sysconfdir=/etc      \
	        --libexecdir=/lib      \
	        --with-rootprefix=     \
	        --with-rootlibdir=/lib \
	        --enable-manpages      \
	        --disable-static       \
	        --config-cache
}

#######################################################################
# ����ѥ���¹�                                                      #
#######################################################################
do_build()
{
    [ -d $BUILDDIR ] || do_setup
    cd $BUILDDIR || exit 1
    LIBRARY_PATH=/tools/lib make
}

#######################################################################
# �ƥ��ȼ¹�                                                          #
#######################################################################
do_test()
{
    cd $BUILDDIR || exit 1
    mkdir -pv /lib/udev/rules.d
    mkdir -pv /etc/udev/rules.d
    make LD_LIBRARY_PATH=/tools/lib check
}

#######################################################################
# ���󥹥ȡ���                                                        #
#######################################################################
do_install()
{
    cd $BUILDDIR || exit 1
    make LD_LIBRARY_PATH=/tools/lib install
    tar -xvf ${SOURCEDIR}/udev-lfs-20140408.tar.bz2
    make -f udev-lfs-20140408/Makefile.lfs install

    LD_LIBRARY_PATH=/tools/lib udevadm hwdb --update
}

#######################################################################
# �ӥ�ɥĥ꡼��������                                              #
#######################################################################
do_clean()
{
    cd $BUILDTOP
    /bin/rm -rf $SOURCEROOT $BUILDROOT
}

#######################################################################
# �����ǻ��ꤷ������������¹Ԥ���                                  #
#######################################################################
do_action $@

