
# �����ǻ��ꤷ���ץ�����缡�¹Ԥ��롣
# ����Ǽ��Ԥ��֤ä��餽�λ��������Ǥ��롣

# �ץ�������֥ѥ��Υ롼��
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

# �¹Ծ�������Ϥ����
STAGELOG=/tmp/lfsbuild.log
echo >$STAGELOG
chmod 0666 $STAGELOG

while [ $# -ne 0 ]
do
    COMMAND=$PLACE/$1
    if [ -x $COMMAND ]
    then
        # ���Υץ�����¹Ԥ���
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

