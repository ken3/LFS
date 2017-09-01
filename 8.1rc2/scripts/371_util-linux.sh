
# Linux From Scratch - Version 8.1rc2
# Chapter 6. Installing Basic System Software
# 6.66. Util-linux-2.30.1

#######################################################################
# �ե졼�������ɤ߹���                                            #
#######################################################################
. buildlfs || exit 1

#######################################################################
# �оݥ������ȥӥ�ɥǥ��쥯�ȥ����ꤹ��                            #
#######################################################################
PKGVERSION=2.30.1
SOURCEROOT=util-linux-${PKGVERSION}
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

    mkdir -pv /var/lib/hwclock

    ./configure ADJTIME_PATH=/var/lib/hwclock/adjtime \
	    --docdir=/usr/share/doc/$SOURCEROOT       \
	    --disable-chfn-chsh                       \
	    --disable-login                           \
	    --disable-nologin                         \
	    --disable-su                              \
	    --disable-setpriv                         \
	    --disable-runuser                         \
	    --disable-pylibmount                      \
	    --disable-static                          \
	    --without-python                          \
	    --without-systemd                         \
	    --without-systemdsystemunitdir
}

#######################################################################
# ����ѥ���¹�                                                      #
#######################################################################
do_build()
{
    [ -d $BUILDDIR ] || do_setup
    cd $BUILDDIR || exit 1
    make
}

#######################################################################
# �ƥ��ȼ¹�                                                          #
#######################################################################
do_test()
{
    cd $BUILDDIR || exit 1
    chown -Rv nobody .
    su nobody -s /bin/bash -c "PATH=$PATH make -k check"
}

#######################################################################
# ���󥹥ȡ���                                                        #
#######################################################################
do_install()
{
    cd $BUILDDIR || exit 1
    make install
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

