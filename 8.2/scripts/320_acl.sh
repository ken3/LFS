
# Linux From Scratch - Version 8.2
# Chapter 6. Installing Basic System Software
# 6.25. Acl-2.2.52

#######################################################################
# フレームワークを読み込む                                            #
#######################################################################
. buildlfs || exit 1

#######################################################################
# 対象ソースとビルドディレクトリを指定する                            #
#######################################################################
PKGVERSION=2.2.52
SOURCEROOT=acl-${PKGVERSION}
BUILDROOT=${SOURCEROOT}
BUILDDIR=${BUILDTOP}/${BUILDROOT}
ARCHIVE=`tarballpath $SOURCEROOT.src`

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

    sed -i -e 's|/@pkg_name@|&-@pkg_version@|' include/builddefs.in
    sed -i "s:| sed.*::g" test/{sbits-restore,cp,misc}.test
    sed -i -e "/TABS-1;/a if (x > (TABS-1)) x = (TABS-1);" libacl/__acl_to_any_text.c

    ./configure --prefix=/usr    \
                --bindir=/bin    \
                --disable-static \
                --libexecdir=/usr/lib
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
    make install install-dev install-lib
    chmod -v 755 /usr/lib/libacl.so
    mv -v /usr/lib/libacl.so.* /lib
    ln -sfv ../../lib/$(readlink /usr/lib/libacl.so) /usr/lib/libacl.so
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

