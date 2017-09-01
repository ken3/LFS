
# Linux From Scratch - Version 8.1rc2
# Chapter 6. Installing Basic System Software
# 6.66. Util-linux-2.30.1

#######################################################################
# フレームワークを読み込む                                            #
#######################################################################
. buildlfs || exit 1

#######################################################################
# 対象ソースとビルドディレクトリを指定する                            #
#######################################################################
PKGVERSION=2.30.1
SOURCEROOT=util-linux-${PKGVERSION}
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
# コンパイル実行                                                      #
#######################################################################
do_build()
{
    [ -d $BUILDDIR ] || do_setup
    cd $BUILDDIR || exit 1
    make
}

#######################################################################
# テスト実行                                                          #
#######################################################################
do_test()
{
    cd $BUILDDIR || exit 1
    chown -Rv nobody .
    su nobody -s /bin/bash -c "PATH=$PATH make -k check"
}

#######################################################################
# インストール                                                        #
#######################################################################
do_install()
{
    cd $BUILDDIR || exit 1
    make install
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

