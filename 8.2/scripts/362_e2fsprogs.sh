
# Linux From Scratch - Version 8.2
# Chapter 6. Installing Basic System Software
# 6.55. E2fsprogs-1.43.9

#######################################################################
# �ե졼�������ɤ߹���                                            #
#######################################################################
. buildlfs || exit 1

#######################################################################
# �оݥ������ȥӥ�ɥǥ��쥯�ȥ����ꤹ��                            #
#######################################################################
PKGVERSION=1.43.9
SOURCEROOT=e2fsprogs-${PKGVERSION}
BUILDROOT=${SOURCEROOT}
BUILDDIR=${BUILDTOP}/${BUILDROOT}/build
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
    mkdir -pv $BUILDDIR
    cd $BUILDDIR || exit 1
    LIBS=-L/tools/lib                    \
    CFLAGS=-I/tools/include              \
    PKG_CONFIG_PATH=/tools/lib/pkgconfig \
    ../configure --prefix=/usr           \
	         --bindir=/bin           \
	         --with-root-prefix=""   \
	         --enable-elf-shlibs     \
	         --disable-libblkid      \
	         --disable-libuuid       \
	         --disable-uuidd         \
	         --disable-fsck
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
    ln -sfv /tools/lib/lib{blk,uu}id.so.1 lib
    make LD_LIBRARY_PATH=/tools/lib check
}

#######################################################################
# ���󥹥ȡ���                                                        #
#######################################################################
do_install()
{
    cd $BUILDDIR || exit 1
    make install
    make install-libs

    chmod -v u+w /usr/lib/{libcom_err,libe2p,libext2fs,libss}.a
    gunzip -v /usr/share/info/libext2fs.info.gz
    install-info --dir-file=/usr/share/info/dir /usr/share/info/libext2fs.info

    makeinfo -o doc/com_err.info ../lib/et/com_err.texinfo
    install -v -m644 doc/com_err.info /usr/share/info
    install-info --dir-file=/usr/share/info/dir /usr/share/info/com_err.info
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

