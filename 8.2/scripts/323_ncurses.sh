
# Linux From Scratch - Version 8.2
# Chapter 6. Installing Basic System Software
# 6.23. Ncurses-6.1

#######################################################################
# フレームワークを読み込む                                            #
#######################################################################
. buildlfs || exit 1

#######################################################################
# 対象ソースとビルドディレクトリを指定する                            #
#######################################################################
PKGVERSION=6.1
SOURCEROOT=ncurses-${PKGVERSION}
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

    sed -i '/LIBTOOL_INSTALL/d' c++/Makefile.in

    ./configure --prefix=/usr           \
                --mandir=/usr/share/man \
                --with-shared           \
                --without-debug         \
                --without-normal        \
                --enable-pc-files       \
                --enable-widec
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
    :
}

#######################################################################
# インストール                                                        #
#######################################################################
do_install()
{
    cd $BUILDDIR || exit 1
    make install
    mv -v /usr/lib/libncursesw.so.6* /lib
    ln -sfv ../../lib/$(readlink /usr/lib/libncursesw.so) /usr/lib/libncursesw.so
    for lib in ncurses form panel menu ; do
        rm -vf /usr/lib/lib${lib}.so
        echo "INPUT(-l${lib}w)" > /usr/lib/lib${lib}.so
        ln -sfv ${lib}w.pc /usr/lib/pkgconfig/${lib}.pc
    done
    rm -vf /usr/lib/libcursesw.so
    echo "INPUT(-lncursesw)" > /usr/lib/libcursesw.so
    ln -sfv libncurses.so /usr/lib/libcurses.so
    mkdir -v /usr/share/doc/$SOURCEROOT
    cp -v -R doc/* /usr/share/doc/$SOURCEROOT
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

