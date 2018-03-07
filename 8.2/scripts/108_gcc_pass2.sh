#!/bin/bash

# Linux From Scratch - Version 8.2
# Chapter 5. Constructing a Temporary System
# 5.10. GCC-7.3.0 - Pass 2

#######################################################################
# �ե졼�������ɤ߹���                                            #
#######################################################################
. buildtools || exit 1

#######################################################################
# �оݥ������ȥӥ�ɥǥ��쥯�ȥ����ꤹ��                            #
#######################################################################
PKGVERSION=7.3.0
SOURCEROOT=gcc-${PKGVERSION}
BUILDROOT=${SOURCEROOT}_pass2
BUILDDIR=${BUILDTOP}/${BUILDROOT}/build
ARCHIVE=`tarballpath $SOURCEROOT`

MPFRROOT=mpfr-4.0.1
MPFRSRC=`tarballpath $MPFRROOT`

GMPROOT=gmp-6.1.2
GMPSRC=`tarballpath $GMPROOT`

MPCROOT=mpc-1.1.0
MPCSRC=`tarballpath $MPCROOT`

#######################################################################
# �¹Բ�ǽ��������å�����                                          #
#######################################################################
lfs_selfcheck || exit 2
[ -e "$MPFRSRC" ] || exit 1
[ -e "$GMPSRC"  ] || exit 1
[ -e "$MPCSRC"  ] || exit 1

#######################################################################
# ������Ÿ��/�ѥå�Ŭ��/configure/Makefile����                        #
#######################################################################
do_setup()
{
    cd $BUILDTOP
    /bin/rm -rf $SOURCEROOT $BUILDROOT
    tar xvf $ARCHIVE
    [ "$SOURCEROOT" == "$BUILDROOT" ] || mv $SOURCEROOT $BUILDROOT
    cd $BUILDROOT

    cat gcc/limitx.h gcc/glimits.h gcc/limity.h > \
        `dirname $($LFS_TGT-gcc -print-libgcc-file-name)`/include-fixed/limits.h

    tar -xf $MPFRSRC
    mv -v $MPFRROOT mpfr

    tar -xf $GMPSRC
    mv -v $GMPROOT gmp

    tar -xf $MPCSRC
    mv -v $MPCROOT mpc

    for file in gcc/config/{linux,i386/linux{,64}}.h
    do
      cp -uv $file{,.orig}
      sed -e 's@/lib\(64\)\?\(32\)\?/ld@/tools&@g' \
          -e 's@/usr@/tools@g' $file.orig > $file
      echo '
#undef STANDARD_STARTFILE_PREFIX_1
#undef STANDARD_STARTFILE_PREFIX_2
#define STANDARD_STARTFILE_PREFIX_1 "/tools/lib/"
#define STANDARD_STARTFILE_PREFIX_2 ""' >> $file
      touch $file.orig
    done

    case $(uname -m) in
    x86_64)
        sed -e '/m64=/s/lib64/lib/' \
            -i.orig gcc/config/i386/t-linux64
        ;;
    esac

    mkdir -pv $BUILDDIR
    cd $BUILDDIR || exit 1

    CC=$LFS_TGT-gcc                                    \
    CXX=$LFS_TGT-g++                                   \
    AR=$LFS_TGT-ar                                     \
    RANLIB=$LFS_TGT-ranlib                             \
    ../configure                                       \
	--prefix=/tools                                \
	--with-local-prefix=/tools                     \
	--with-native-system-header-dir=/tools/include \
	--enable-languages=c,c++                       \
	--disable-libstdcxx-pch                        \
	--disable-multilib                             \
	--disable-bootstrap                            \
	--disable-libgomp
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
    :
}

#######################################################################
# ���󥹥ȡ���                                                        #
#######################################################################
do_install()
{
    cd $BUILDDIR || exit 1
    make install
    ln -sv gcc /tools/bin/cc
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

