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
        337_bash.sh
[ $? -eq 0 ] || exit 1

./338_execbash.sh          \
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
        353_procps-ng.sh   \
        354_e2fsprogs.sh   \
        355_coreutils.sh   \
        356_diffutils.sh   \
        357_gawk.sh        \
        358_findutils.sh   \
        359_groff.sh       \
        360_grub2.sh       \
        361_less.sh        \
        362_gzip.sh        \
        363_iproute2.sh    \
        364_kbd.sh         \
        365_libpipeline.sh \
        366_make.sh        \
        367_patch.sh       \
        368_sysklogd.sh    \
        369_sysvinit.sh    \
        370_eudev.sh       \
        371_util-linux.sh  \
        372_man-db.sh      \
        373_tar.sh         \
        374_texinfo.sh     \
        375_vim.sh         \
        400_bootscripts.sh \
        401_savelib.sh
[ $? -eq 0 ] || exit 1

echo "Now change root password:"
./dispatch.sh 402_rootpass.sh
[ $? -eq 0 ] || exit 1

echo "Stage3 has beed done."
echo "OK, proceed to 403_logout.sh"

