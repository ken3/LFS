#!/bin/bash

# [stage3]
# LFSの 251_linuxapi.sh 〜 398_rootpass.sh を順次実行する。

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
	301_linuxapi.sh    \
        302_man-pages.sh   \
        303_glibc.sh       \
        304_toolchain.sh   \
        305_zlib.sh        \
        306_file.sh        \
        307_readline.sh    \
        308_m4.sh          \
        309_bc.sh          \
        310_binutils.sh    \
        311_gmp.sh         \
        312_mpfr.sh        \
        313_mpc.sh         \
        314_gcc.sh         \
        315_gcc-test.sh    \
        316_bzip2.sh       \
        317_pkg-config.sh  \
        318_ncurses.sh     \
        319_attr.sh        \
        320_acl.sh         \
        321_libcap.sh      \
        322_sed.sh         \
        323_shadow.sh      \
        324_psmisc.sh      \
        325_iana-etc.sh    \
        326_bison.sh       \
        327_flex.sh        \
        328_grep.sh        \
        329_bash.sh
[ $? -eq 0 ] || exit 1
cp -p /tmp/lfsbuild.log /tmp/stage3-1.log

./340_execbash.sh          \
        ./dispatch.sh      \
        341_libtool.sh     \
        342_gdbm.sh        \
        343_gperf.sh       \
        344_expat.sh       \
        345_inetutils.sh   \
        346_perl.sh        \
        347_xmlparser.sh   \
        348_intltool.sh    \
        349_autoconf.sh    \
        350_automake.sh    \
        351_xz.sh          \
        352_kmod.sh        \
        353_gettext.sh     \
        354_libelf.sh      \
        355_libffi.sh      \
        356_openssl.sh     \
        357_python3.sh     \
        358_python3-doc.sh \
        359_ninja.sh       \
        360_meson.sh       \
        361_procps-ng.sh   \
        362_e2fsprogs.sh   \
        363_coreutils.sh   \
        364_check.sh       \
        365_diffutils.sh   \
        366_gawk.sh        \
        367_findutils.sh   \
        368_groff.sh       \
        369_grub2.sh       \
        370_less.sh        \
        371_gzip.sh        \
        372_iproute2.sh    \
        373_kbd.sh         \
        374_libpipeline.sh \
        375_make.sh        \
        376_patch.sh       \
        377_sysklogd.sh    \
        378_sysvinit.sh    \
        379_eudev.sh       \
        380_util-linux.sh  \
        381_man-db.sh      \
        382_tar.sh         \
        383_texinfo.sh     \
        384_vim.sh         \
        390_kernel.sh         \
        391_kernel-install.sh \
        392_bootscripts.sh    \
        393_savelib.sh
[ $? -eq 0 ] || exit 1
cp -p /tmp/lfsbuild.log /tmp/stage3-2.log

echo "Now change root password:"
./dispatch.sh 394_rootpass.sh
[ $? -eq 0 ] || exit 1

echo "Stage3 has beed done."
echo "OK, proceed to 395_logout.sh"

