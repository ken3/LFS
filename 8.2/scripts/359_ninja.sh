
# Linux From Scratch - Version 8.2
# Chapter 6. Installing Basic System Software
# 6.52. Ninja-1.8.2

#######################################################################
# フレームワークを読み込む                                            #
#######################################################################
. buildlfs || exit 1

#######################################################################
# 対象ソースとビルドディレクトリを指定する                            #
#######################################################################
PKGVERSION=1.8.2
SOURCEROOT=ninja-${PKGVERSION}
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

    #export NINJAJOBS=4
    #patch -Np1 -i ${SOURCEDIR}/ninja-${PKGVERSION}-add_NINJAJOBS_var-1.patch
}

#######################################################################
# コンパイル実行                                                      #
#######################################################################
do_build()
{
    [ -d $BUILDDIR ] || do_setup
    cd $BUILDDIR || exit 1
    python3 configure.py --bootstrap
}

#######################################################################
# テスト実行                                                          #
#######################################################################
do_test()
{
    cd $BUILDDIR || exit 1
    ./ninja ninja_test
    ./ninja_test --gtest_filter=-SubprocessTest.SetWithLots
}

#######################################################################
# インストール                                                        #
#######################################################################
do_install()
{
    cd $BUILDDIR || exit 1
    make install
    chmod -v 755 /usr/lib/libpython3.6m.so
    chmod -v 755 /usr/lib/libpython3.so

    install -vm755 ninja /usr/bin/
    install -vDm644 misc/bash-completion /usr/share/bash-completion/completions/ninja
    install -vDm644 misc/zsh-completion  /usr/share/zsh/site-functions/_ninja
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

