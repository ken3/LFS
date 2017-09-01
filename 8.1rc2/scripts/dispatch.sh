
# 引数で指定したプログラムを順次実行する。
# 途中で失敗が返ったらその時点で中断する。

# プログラム配置パスのルール
PLACE=""
if [ -d /scripts ]
then
    PLACE=/scripts
elif [ -d $LFS/scripts ]
then
    PLACE=$LFS/scripts
else
    PLACE=.
fi
PATH=$PLACE:$PATH

# 実行状況を出力するログ
STAGELOG=/tmp/lfsbuild.log
echo >$STAGELOG
chmod 0666 $STAGELOG

while [ $# -ne 0 ]
do
    COMMAND=$PLACE/$1
    if [ -x $COMMAND ]
    then
        # 次のプログラムを実行する
        (date; echo "Spawning $COMMAND:")|tee -a $STAGELOG
        eval $COMMAND
        STATUS=$?
        if [ $STATUS -ne 0 ]
        then
            (date; echo "$COMMAND failed: exit status=$STATUS")|tee -a $STAGELOG
            exit 1
        fi
    else
        (date; echo "Skip $COMMAND:")|tee -a $STAGELOG
    fi
    shift
done
exit 0

