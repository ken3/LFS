
# 変数定義の妥当性を確認する
[ `whoami` == root ] || exit 2

cd /lib && rm -f ld-linux-x86-64.so.2
ln -s ../tools/lib/ld-linux-x86-64.so.2 .

cd /lib64 && rm -f ld-linux-x86-64.so.2
ln -s ../lib/ld-linux-x86-64.so.2 .

