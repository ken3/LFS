#!/bin/bash

# Linux From Scratch - Version 8.2
# Chapter 5. Constructing a Temporary System
# 5.9. Binutils-2.30 - Pass 2 (ld-new)

#######################################################################
# フレームワークを読み込む                                            #
#######################################################################
. buildtools || exit 1

#######################################################################
# 対象ソースとビルドディレクトリを指定する                            #
#######################################################################
PKGVERSION=2.30
SOURCEROOT=binutils-${PKGVERSION}
BUILDROOT=${SOURCEROOT}_ldnew
BUILDDIR=${BUILDTOP}/${BUILDROOT}/build
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
    mkdir -pv $BUILDDIR
    cd $BUILDDIR || exit 1

    CC=${LFS_TGT}-gcc                       \
    AR=${LFS_TGT}-ar                        \
    RANLIB=${LFS_TGT}-ranlib                \
    ../configure --prefix=/tools            \
                 --disable-nls              \
                 --disable-werror           \
                 --with-lib-path=/tools/lib \
                 --with-sysroot
}

#######################################################################
# コンパイル実行                                                      #
#######################################################################
do_build()
{
    [ -d $BUILDDIR ] || do_setup
    cd $BUILDDIR || exit 1
    make
    make -C ld clean
    make -C ld LIB_PATH=/usr/lib:/lib
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
    cp -v ld/ld-new /tools/bin/
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

