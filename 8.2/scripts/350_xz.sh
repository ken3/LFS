
# Linux From Scratch - Version 8.2
# Chapter 6. Installing Basic System Software
# 6.45. Xz-5.2.3

#######################################################################
# �ե졼�������ɤ߹���                                            #
#######################################################################
. buildlfs || exit 1

#######################################################################
# �оݥ������ȥӥ�ɥǥ��쥯�ȥ����ꤹ��                            #
#######################################################################
PKGVERSION=5.2.3
SOURCEROOT=xz-${PKGVERSION}
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
    ./configure --prefix=/usr \
                --disable-static \
                --docdir=/usr/share/doc/$SOURCEROOT
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
    make check
}

#######################################################################
# ���󥹥ȡ���                                                        #
#######################################################################
do_install()
{
    cd $BUILDDIR || exit 1
    make install
    mv -v /usr/bin/{lzma,unlzma,lzcat,xz,unxz,xzcat} /bin
    mv -v /usr/lib/liblzma.so.* /lib
    ln -svf ../../lib/$(readlink /usr/lib/liblzma.so) /usr/lib/liblzma.so
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
