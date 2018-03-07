#!/bin/bash

# [stage3]
# LFSの 206_execbash.sh 〜 401_rootpass.sh を順次実行する。

[ `whoami` == root ]        || exit 2
[ -x /scripts/dispatch.sh ] || exit 2

# 実行許可を求める
echo "Now going to run the stage 3."
echo -n "continue? (y/n) "
read answer
case $answer in
y|Y)
    ;;
*)
    exit 1
esac

# stage3を実行する
cd /scripts || exit 1

./dispatch.sh              \
	300_linuxapi.sh    \
        301_man-pages.sh   \
        302_glibc.sh       \
        303_toolchain.sh   \
        310_zlib.sh        \
        311_file.sh        \
        312_readline.sh    \
        313_m4.sh          \
        314_bc.sh          \
        315_binutils.sh    \
        316_gmp.sh         \
        317_mpfr.sh        \
        318_mpc.sh         \
        319_gcc.sh         \
        320_gcc-test.sh    \
        321_bzip2.sh       \
        322_pkg-config.sh  \
        323_ncurses.sh     \
        324_attr.sh        \
        325_acl.sh         \
        326_libcap.sh      \
        327_sed.sh         \
        328_shadow.sh      \
        330_psmisc.sh      \
        331_iana-etc.sh    \
        333_bison.sh       \
        334_flex.sh        \
        335_grep.sh        \
        336_bash.sh
[ $? -eq 0 ] || exit 1

./337_execbash.sh          \
        ./dispatch.sh      \
        340_libtool.sh     \
        341_gdbm.sh        \
        342_gperf.sh       \
        343_expat.sh       \
        344_inetutils.sh   \
        345_perl.sh        \
        346_xmlparser.sh   \
        347_intltool.sh    \
        348_autoconf.sh    \
        349_automake.sh    \
        350_xz.sh          \
        351_kmod.sh        \
        352_gettext.sh     \
        353_libelf.sh      \
        354_libffi.sh      \
        355_openssl.sh     \
        356_python3.sh     \
        357_python3-doc.sh \
        358_ninja.sh       \
        359_meson.sh       \
        360_procps-ng.sh   \
        361_e2fsprogs.sh   \
        362_coreutils.sh   \
        363_check.sh       \
        364_diffutils.sh   \
        365_gawk.sh        \
        366_findutils.sh   \
        367_groff.sh       \
        370_grub2.sh       \
        371_less.sh        \
        372_gzip.sh        \
        373_iproute2.sh    \
        374_kbd.sh         \
        375_libpipeline.sh \
        376_make.sh        \
        377_patch.sh       \
        378_sysklogd.sh    \
        379_sysvinit.sh    \
        380_eudev.sh       \
        381_util-linux.sh  \
        382_man-db.sh      \
        383_tar.sh         \
        384_texinfo.sh     \
        385_vim.sh         \
        400_bootscripts.sh \
        401_savelib.sh
[ $? -eq 0 ] || exit 1

echo "Now change root password:"
./dispatch.sh 402_rootpass.sh
[ $? -eq 0 ] || exit 1

echo "Stage3 has beed done."
echo "OK, proceed to 403_logout.sh"

