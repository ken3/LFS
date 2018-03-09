
# Linux From Scratch - Version 8.2
# Chapter 6. Installing Basic System Software
# 6.20. GCC-7.3.0

#######################################################################
# フレームワークを読み込む                                            #
#######################################################################
. buildlfs || exit 1

#######################################################################
# 対象ソースとビルドディレクトリを指定する                            #
#######################################################################
PKGVERSION=7.3.0
SOURCEROOT=gcc-${PKGVERSION}
BUILDROOT=${SOURCEROOT}
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
    cd $BUILDROOT

    case $(uname -m) in
    x86_64)
        sed -e '/m64=/s/lib64/lib/' \
            -i.orig gcc/config/i386/t-linux64
        ;;
    esac

    rm -f /usr/lib/gcc

    mkdir -pv $BUILDDIR
    cd $BUILDDIR || exit 1

    SED=sed ../configure --prefix=/usr \
                         --enable-languages=c,c++ \
                         --disable-multilib \
                         --disable-bootstrap \
                         --with-system-zlib
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
    ulimit -s 32768
    make -k check
    ../contrib/test_summary
}

#######################################################################
# インストール                                                        #
#######################################################################
do_install()
{
    cd $BUILDDIR || exit 1
    make install
    ln -sv ../usr/bin/cpp /lib
    ln -sv gcc /usr/bin/cc
    install -v -dm755 /usr/lib/bfd-plugins
    ln -sfv ../../libexec/gcc/$(gcc -dumpmachine)/$PKGVERSION/liblto_plugin.so \
	    /usr/lib/bfd-plugins/

    mkdir -pv /usr/share/gdb/auto-load/usr/lib
    mv -v /usr/lib/*gdb.py /usr/share/gdb/auto-load/usr/lib
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

