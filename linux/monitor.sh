#!/bin/sh
#���ϵͳ��Դ����
monitordisk()
{
    LOOK_OUT=`df | grep /dev/sda1 | awk '{print $5}' | sed 's/%//g'`
    echo $LOOK_OUT
    until [ "$LOOK_OUT" -gt "90" ]
do
    LOOK_OUT=`df | grep /logs | awk '{print $5}' | sed 's/%//g'`
    echo "Filesystem .. logs is nearly full" | mail root
    sleep 5
    exit 0
done     
}

monitorsinglecpu()
{
    CPU_USE=`ps auwx | grep vmstat | awk '{print $4 $5 $6}'`

}
#if FLAG is MEM,monitor the memory,if flag is CPU,monitor the cpu,else is wrong
FLAG=$1
#the process name 
NAME=$2
#��ص�Ƶ��
#��صĴ���
#�жϲ����ĸ����������������1�Ļ��������Ӧ�Ĵ�����Ϣ
#�����ӭ��ʾ��Ϣ
echo "��ӭʹ�ñ���ؽű������ڿ�ʼ���"
if [ $# -lt 1 ]; then
    echo "������������1���������Ĳ���"
else
    #���жϵ�ǰ�û��ǲ���root�û�
    IS_ROOT=`whoami | grep root`
    if [ $IS_ROOT != root ]; then
        echo "��ǰ�û�����root�û�,���л��û�ִ�нű�"
    else
        #���жϵڶ��������ǲ���Ϊ�գ����Ϊ�գ���������ϵͳ��Դ����
        if [ $NAME = '']; then 
            #�������ϵͳ��Դ��ʹ��vmstat����
            #����Ǽ���ڴ�
            if [ $FLAG = MEM ]; then
                vmstat 2 10 | awk '{print $5}' | sed -n '3,13p' > /usr/twf/vmstat_mem.log &
            #����Ǽ��CPU
            elif [ $FLAG = CPU ]; then
                vmstat 2 10 | awk '{print $16}' | sed -n '3,13p' > /usr/twf/vmstat_cpu.log &
            #����Ǽ�ش���������
            elif [ $FLAG = DISK ]; then
                monitordisk
            #�����쳣���
            else
                echo "����1����MEM��CPU��DISK�е�һ�����������������"

                exit 1
            fi           
        else
            #�ڶ���������Ϊ�յ����
            #�����ص����ڴ�
            if [ $FLAG = MEM ]; then
                #���ü�ص��������ڴ溯��
                
            elif [ $FLAG = CPU ]; then
            else

            echo "�������"
        fi
    fi
fi
