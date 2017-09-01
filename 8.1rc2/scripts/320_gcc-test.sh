
# Linux From Scratch - Version 8.1rc2
# Chapter 6. Installing Basic System Software
# 6.20. GCC-7.2.0

cd /tmp

echo 'int main(){}' > dummy.c
cc dummy.c -v -Wl,--verbose &> dummy.log
readelf -l a.out | grep ': /lib'

grep -o '/usr/lib.*/crt[1in].*succeeded' dummy.log
grep -B4 '^ /usr/include' dummy.log
grep 'SEARCH.*/usr/lib'   dummy.log |sed 's|; |\n|g'
grep "/lib.*/libc.so.6 "  dummy.log
grep found dummy.log

rm -v dummy.c a.out dummy.log

