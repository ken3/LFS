
# Linux From Scratch Version 8.1rc2
# Chapter 8. Making the LFS System Bootable
# 8.3. Linux-4.12.7

#######################################################################
# フレームワークを読み込む                                            #
#######################################################################
. buildlfs || exit 1

#######################################################################
# 対象ソースとビルドディレクトリを指定する                            #
#######################################################################
PKGVERSION=4.12.7
SOURCEROOT=linux-${PKGVERSION}
BUILDROOT=linux-kernel-${PKGVERSION}
BUILDDIR=${BUILDTOP}/${BUILDROOT}
ARCHIVE=`tarballpath $SOURCEROOT`
KVERSION=${PKGVERSION}-lfs-8.1rc2

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

    #cp -p ${SOURCEDIR}/config-4.9.9-lfs-amd64 .config
    cp -p ${SOURCEDIR}/config-4.11.0-kali1-amd64 .config
    make oldconfig
}

#######################################################################
# コンパイル実行                                                      #
#######################################################################
do_build()
{
    [ -d $BUILDDIR ] || do_setup
    cd $BUILDDIR || exit 1
    make
    make modules
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
    #make modules_install
    #cp -v arch/x86/boot/bzImage /boot/vmlinuz-$KVERSION
    #cp -v System.map /boot/System.map-$KVERSION
    #cp -v .config /boot/config-$KVERSION
    #install -d /usr/share/doc/linux-$KVERSION
    #cp -r Documentation/* /usr/share/doc/linux-$KVERSION
    :
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

