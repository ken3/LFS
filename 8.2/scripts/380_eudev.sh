
# Linux From Scratch - Version 8.2
# Chapter 6. Installing Basic System Software
# 6.72. Eudev-3.2.5

#######################################################################
# フレームワークを読み込む                                            #
#######################################################################
. buildlfs || exit 1

#######################################################################
# 対象ソースとビルドディレクトリを指定する                            #
#######################################################################
PKGVERSION=3.2.5
SOURCEROOT=eudev-${PKGVERSION}
BUILDROOT=${SOURCEROOT}
BUILDDIR=${BUILDTOP}/${BUILDROOT}
ARCHIVE=`tarballpath $SOURCEROOT`

#######################################################################
# 実行可能条件をチェックする                                          #
#######################################################################
lfs_selfcheck || exit 2

#######################################################################
# ソース展開/パッチ適用/configure/Makefile生成                        #
#######################################################################
do_setup()
{
    cd $BUILDTOP
    /bin/rm -rf $SOURCEROOT $BUILDROOT
    tar xvf $ARCHIVE
    [ "$SOURCEROOT" == "$BUILDROOT" ] || mv $SOURCEROOT $BUILDROOT
    cd $BUILDDIR || exit 1

    sed -r -i 's|/usr(/bin/test)|\1|' test/udev-test.pl

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
# コンパイル実行                                                      #
#######################################################################
do_build()
{
    [ -d $BUILDDIR ] || do_setup
    cd $BUILDDIR || exit 1
    LIBRARY_PATH=/tools/lib make
}

#######################################################################
# テスト実行                                                          #
#######################################################################
do_test()
{
    cd $BUILDDIR || exit 1
    mkdir -pv /lib/udev/rules.d
    mkdir -pv /etc/udev/rules.d
    make LD_LIBRARY_PATH=/tools/lib check
}

#######################################################################
# インストール                                                        #
#######################################################################
do_install()
{
    cd $BUILDDIR || exit 1
    make LD_LIBRARY_PATH=/tools/lib install
    tar -xvf ${SOURCEDIR}/udev-lfs-20171102.tar.bz2
    make -f udev-lfs-20171102/Makefile.lfs install

    LD_LIBRARY_PATH=/tools/lib udevadm hwdb --update
}

#######################################################################
# ビルドツリーを削除する                                              #
#######################################################################
do_clean()
{
    cd $BUILDTOP
    /bin/rm -rf $SOURCEROOT $BUILDROOT
}

#######################################################################
# 引数で指定したアクションを実行する                                  #
#######################################################################
do_action $@

