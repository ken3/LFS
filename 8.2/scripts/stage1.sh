#!/bin/bash

# [stage1]
# LFSの 100_binutils_pass1.sh 〜 150_stripping.sh を順次実行する。

. buildtools
[ `/usr/bin/whoami` == lfs ]    || exit 2
[ -x $LFS/scripts/dispatch.sh ] || exit 2

# 実行許可を求める
echo "Now going to run the stage 1."
echo -n "continue? (y/n) "
read answer
case $answer in
y|Y)
    ;;
*)
    exit 1
esac

# stage1を実行する
cd $LFS/scripts || exit 1

./dispatch.sh                 \
        100_binutils_pass1.sh \
        101_gcc_pass1.sh      \
        102_linuxapi.sh       \
        103_glibc.sh          \
        104_glibc-test.sh     \
        105_libstdc++.sh      \
        106_binutils_pass2.sh \
        107_binutils_ldnew.sh \
        108_gcc_pass2.sh      \
        109_cc-test.sh        \
        110_tcl-core.sh       \
        111_expect.sh         \
        112_dejagnu.sh        \
        113_m4.sh          \
        114_ncurses.sh        \
        115_bash.sh           \
        116_bison.sh          \
        117_bzip2.sh          \
        118_coreutils.sh      \
        119_diffutils.sh      \
        120_file.sh           \
        121_findutils.sh      \
        122_gawk.sh           \
        123_gettext.sh        \
        124_grep.sh           \
        125_gzip.sh           \
        127_make.sh           \
        128_patch.sh          \
        129_perl.sh           \
        130_sed.sh            \
        131_tar.sh            \
        132_texinfo.sh        \
        133_util-linux.sh     \
        134_xz.sh             \
        150_stripping.sh
[ $? -eq 0 ] || exit 1

echo "Stage1 has beed done."
echo "OK, proceed to 151_logout.sh"

